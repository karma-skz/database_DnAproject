import mysql.connector
from mysql.connector import errorcode
from getpass import getpass

# -------------------------------------------------------------
# Database Gateway (all raw SQL lives here)
# -------------------------------------------------------------
class DatabaseGateway:
    def __init__(self, 
    connection):
        self.connection = connection

    # -------------------- READ OPERATIONS --------------------
    def list_missions(self):
        query = """
            SELECT MissionID, MissionCode, MissionType, Status, StartDate, EndDate
            FROM Missions
            ORDER BY StartDate DESC
        """
        return self._fetch_all(query)

    def search_alchemists_by_specialization(self, keyword):
        query = """
            SELECT a.AlchemistID, a.FName, a.LName, s.Specialization
            FROM Alchemists a
            JOIN AlchemistSpecializations s ON a.AlchemistID = s.AlchemistID
            WHERE s.Specialization LIKE %s
        """
        return self._fetch_all(query, (f"%{keyword}%",))

    def get_units_in_city(self, keyword):
        query = """
            SELECT u.UnitID, u.UnitName, c.City, c.Region, u.CommanderID
            FROM Units u
            JOIN Cities c ON u.CityID = c.CityID
            WHERE c.City LIKE %s OR c.Region LIKE %s
        """
        like = f"%{keyword}%"
        return self._fetch_all(query, (like, like))

    def get_lab_inventory(self, lab_id):
        query = """
            SELECT l.LabName, i.ChemicalName, s.StockQuantity, i.HazardClass
            FROM IngredientStock s
            JOIN Ingredients i ON s.IngredientID = i.IngredientID
            JOIN Labs l ON s.LabID = l.LabID
            WHERE s.LabID = %s
        """
        return self._fetch_all(query, (lab_id,))

    def get_artifact_attempts(self, artifact_id):
        query = """
            SELECT t.ArtifactID, a.Name, t.AttemptNo, t.AttemptDate,
                   t.Result, t.Casualties, al.FName, al.LName
            FROM TransmutationAttempts t
            JOIN Artifacts a ON t.ArtifactID = a.ArtifactID
            JOIN Alchemists al ON t.PerformerID = al.AlchemistID
            WHERE t.ArtifactID = %s
            ORDER BY t.AttemptNo
        """
        return self._fetch_all(query, (artifact_id,))

    def get_active_mission_alchemists(self):
        query = """
            SELECT DISTINCT a.AlchemistID, a.FName, a.LName
            FROM Alchemists a
            JOIN AlchemistMissionHistory h ON a.AlchemistID = h.AlchemistID
            JOIN Missions m ON h.MissionID = m.MissionID
            WHERE m.Status = 'Ongoing'
        """
        return self._fetch_all(query)

    def get_high_danger_artifacts(self, threshold):
        query = """
            SELECT ArtifactID, Name, DangerLevel, LabID
            FROM Artifacts
            WHERE DangerLevel >= %s
            ORDER BY DangerLevel DESC
        """
        return self._fetch_all(query, (threshold,))

    def get_ingredient_stock_summary(self, ingredient_name):
        query = """
            SELECT i.ChemicalName, SUM(s.StockQuantity) AS TotalStock
            FROM IngredientStock s
            JOIN Ingredients i ON s.IngredientID = i.IngredientID
            WHERE i.ChemicalName = %s
            GROUP BY i.ChemicalName
        """
        return self._fetch_all(query, (ingredient_name,))

    def get_alchemist_rank_history(self, alchemist_id):
        query = """
            SELECT AlchemistID, `Rank`, FromDate, ToDate
            FROM AlchemistRankHistory
            WHERE AlchemistID = %s
            ORDER BY FromDate
        """
        return self._fetch_all(query, (alchemist_id,))

    def get_labs_by_region(self, region):
        query = """
            SELECT l.LabID, l.LabName, c.City, c.Region, l.SecurityLevel
            FROM Labs l
            JOIN Cities c ON l.CityID = c.CityID
            WHERE c.Region = %s
            ORDER BY l.SecurityLevel DESC
        """
        return self._fetch_all(query, (region,))

    # -------------------- WRITE OPERATIONS --------------------
    def register_alchemist(self, fname, mname, lname, school, lic, nation):
        new_id = self._next_id("Alchemists", "AlchemistID")
        query = """
            INSERT INTO Alchemists (AlchemistID, FName, MName, LName, School, LicenseNumber, NationCode)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        self._execute(query, (new_id, fname, mname, lname, school, lic, nation))
        return new_id

    def update_mission_status(self, mission_id, status):
        query = "UPDATE Missions SET Status = %s WHERE MissionID = %s"
        return self._execute(query, (status, mission_id))

    def delete_artifact_attempt(self, artifact_id, attempt_no):
        query = "DELETE FROM TransmutationAttempts WHERE ArtifactID = %s AND AttemptNo = %s"
        return self._execute(query, (artifact_id, attempt_no))

    # -------------------- Internal Helpers --------------------
    def _fetch_all(self, query, params=()):
        with self.connection.cursor(dictionary=True) as cursor:
            cursor.execute(query, params)
            return cursor.fetchall()

    def _execute(self, query, params):
        with self.connection.cursor() as cursor:
            cursor.execute(query, params)
            affected = cursor.rowcount
        self.connection.commit()
        return affected

    def _next_id(self, table, column):
        query = f"SELECT COALESCE(MAX({column}), 0) + 1 AS next_id FROM {table}"
        with self.connection.cursor(dictionary=True) as cursor:
            cursor.execute(query)
            row = cursor.fetchone()
        return int(row['next_id'])

# -------------------------------------------------------------
# CLI Interface
# -------------------------------------------------------------
class FMACLI:
    def __init__(self, gateway):
        self.gateway = gateway
        self.actions = {
            "1": ("List missions", self.action_list_missions),
            "2": ("Search alchemists by specialization", self.action_search_alchemists),
            "3": ("Show units in a city/region", self.action_units_city),
            "4": ("Show lab ingredient inventory", self.action_lab_inventory),
            "5": ("View artifact attempts", self.action_artifact_attempts),
            "6": ("List active mission alchemists", self.action_active_mission_alchemists),
            "7": ("Find high-danger artifacts", self.action_high_danger_artifacts),
            "8": ("Summarize ingredient stock", self.action_ingredient_stock_summary),
            "9": ("Show alchemist rank history", self.action_alchemist_rank_history),
            "10": ("List labs in region", self.action_labs_by_region),
            "11": ("Register a new alchemist", self.action_register_alchemist),
            "12": ("Update mission status", self.action_update_status),
            "13": ("Delete an artifact attempt", self.action_delete_attempt),
            "q": ("Quit", self.action_quit),
        }

    def run(self):
        print("\n=== FMA Operations Console ===\n")
        while True:
            self.print_menu()
            choice = input("Select an option: ").strip().lower()

            if choice not in self.actions:
                print("Invalid choice. Try again.\n")
                continue

            # Unpack the tuple: (label, function)
            _, func = self.actions[choice]
            quit_flag = func()
            if quit_flag:
                break

    def print_menu(self):
        print("\n" + "="*40)
        print(f"{'FMA DATABASE MENU':^40}")
        print("="*40)
        for key, (label, _) in self.actions.items():
            print(f" {key}. {label}")
        print("="*40)

    # ---------------- ACTIONS ----------------
    def _print_table(self, columns, rows):
        if not rows:
            print("\nNo results found.\n")
            return

        processed_rows = []
        for r in rows:
            new_row = []
            for _, accessor in columns:
                val = accessor(r) if callable(accessor) else r.get(accessor)
                new_row.append(str(val) if val is not None else "")
            processed_rows.append(new_row)

        headers = [c[0] for c in columns]
        widths = [len(h) for h in headers]
        for row in processed_rows:
            for i, val in enumerate(row):
                widths[i] = max(widths[i], len(val))

        row_fmt = "| " + " | ".join(f"{{:<{w}}}" for w in widths) + " |"
        sep = "+-" + "-+-".join("-" * w for w in widths) + "-+"

        print("\n" + sep)
        print(row_fmt.format(*headers))
        print(sep)
        for row in processed_rows:
            print(row_fmt.format(*row))
        print(sep + "\n")

    def action_list_missions(self):
        rows = self.gateway.list_missions()
        columns = [
            ("ID", "MissionID"),
            ("Code", "MissionCode"),
            ("Type", "MissionType"),
            ("Status", "Status"),
            ("Start", "StartDate"),
            ("End", lambda r: str(r['EndDate']) if r['EndDate'] else "Ongoing")
        ]
        self._print_table(columns, rows)

    def action_search_alchemists(self):
        kw = input("Keyword: ")
        rows = self.gateway.search_alchemists_by_specialization(kw)
        columns = [
            ("ID", "AlchemistID"),
            ("Name", lambda r: f"{r['FName']} {r['LName']}"),
            ("Specialization", "Specialization")
        ]
        self._print_table(columns, rows)

    def action_units_city(self):
        kw = input("City/Region keyword: ")
        rows = self.gateway.get_units_in_city(kw)
        columns = [
            ("Unit", "UnitName"),
            ("City", "City"),
            ("Region", "Region"),
            ("Cmdr ID", "CommanderID")
        ]
        self._print_table(columns, rows)

    def action_lab_inventory(self):
        lab = int(input("Lab ID: "))
        rows = self.gateway.get_lab_inventory(lab)
        columns = [
            ("Lab Name", "LabName"),
            ("Chemical", "ChemicalName"),
            ("Qty", "StockQuantity"),
            ("Hazard", "HazardClass")
        ]
        self._print_table(columns, rows)

    def action_artifact_attempts(self):
        aid = int(input("Artifact ID: "))
        rows = self.gateway.get_artifact_attempts(aid)
        columns = [
            ("No.", "AttemptNo"),
            ("Date", "AttemptDate"),
            ("Result", "Result"),
            ("Casualties", "Casualties"),
            ("Alchemist", lambda r: f"{r['FName']} {r['LName']}")
        ]
        self._print_table(columns, rows)

    def action_active_mission_alchemists(self):
        rows = self.gateway.get_active_mission_alchemists()
        columns = [
            ("ID", "AlchemistID"),
            ("Name", lambda r: f"{r['FName']} {r['LName']}")
        ]
        self._print_table(columns, rows)

    def action_high_danger_artifacts(self):
        try:
            threshold = int(input("Danger Threshold: "))
            rows = self.gateway.get_high_danger_artifacts(threshold)
            columns = [
                ("ID", "ArtifactID"),
                ("Name", "Name"),
                ("Danger", "DangerLevel"),
                ("Lab ID", "LabID")
            ]
            self._print_table(columns, rows)
        except ValueError:
            print("Invalid threshold.\n")

    def action_ingredient_stock_summary(self):
        name = input("Ingredient Name: ")
        rows = self.gateway.get_ingredient_stock_summary(name)
        columns = [
            ("Chemical", "ChemicalName"),
            ("Total Stock", "TotalStock")
        ]
        self._print_table(columns, rows)

    def action_alchemist_rank_history(self):
        try:
            aid = int(input("Alchemist ID: "))
            rows = self.gateway.get_alchemist_rank_history(aid)
            columns = [
                ("ID", "AlchemistID"),
                ("Rank", "Rank"),
                ("From", "FromDate"),
                ("To", lambda r: str(r['ToDate']) if r['ToDate'] else "Current")
            ]
            self._print_table(columns, rows)
        except ValueError:
            print("Invalid ID.\n")

    def action_labs_by_region(self):
        region = input("Region: ")
        rows = self.gateway.get_labs_by_region(region)
        columns = [
            ("ID", "LabID"),
            ("Lab Name", "LabName"),
            ("City", "City"),
            ("Region", "Region"),
            ("Security", "SecurityLevel")
        ]
        self._print_table(columns, rows)

    def action_register_alchemist(self):
        print("-- Register New Alchemist --")
        fname = input("First name: ")
        mname = input("Middle name (optional): ") or None
        lname = input("Last name (optional): ") or None
        school = input("School (optional): ") or None
        lic = input("License number (optional): ") or None
        nation = input("Nation code (optional): ") or None
        new_id = self.gateway.register_alchemist(fname, mname, lname, school, lic, nation)
        print(f"Alchemist registered with ID {new_id}.\n")

    def action_update_status(self):
        mid = int(input("Mission ID: "))
        new_status = input("New status: ")
        affected = self.gateway.update_mission_status(mid, new_status)
        if affected:
            print("Mission status updated.\n")
        else:
            print("Mission not found.\n")

    def action_delete_attempt(self):
        aid = int(input("Artifact ID: "))
        no = int(input("Attempt No: "))
        affected = self.gateway.delete_artifact_attempt(aid, no)
        if affected:
            print("Attempt deleted.\n")
        else:
            print("No such attempt.\n")

    def action_quit(self):
        print("Exiting... Goodbye!")
        return True

# -------------------------------------------------------------
# CONNECTION
# -------------------------------------------------------------
def get_db_connection():
    print("FMA Database Setup")
    host = input("Host [localhost]: ") or "localhost"
    db = input("Database [fma]: ") or "fma"
    user = input("Username: ")
    pwd = getpass("Password: ")

    try:
        conn = mysql.connector.connect(
            host=host,
            user=user,
            password=pwd,
            database=db,
            autocommit=False
        )
        print("Connected successfully.\n")
        return conn
    except mysql.connector.Error as exc:
        if exc.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Invalid credentials.")
        elif exc.errno == errorcode.ER_BAD_DB_ERROR:
            print(f"Database '{db}' does not exist.")
        else:
            print(exc)
        return None

# -------------------------------------------------------------
# MAIN
# -------------------------------------------------------------
def main():
    conn = get_db_connection()
    if not conn:
        print("Cannot start application.")
        return

    try:
        gateway = DatabaseGateway(conn)
        cli = FMACLI(gateway)
        cli.run()
    finally:
        conn.close()
        print("Database connection closed.")


if __name__ == "__main__":
    main()
