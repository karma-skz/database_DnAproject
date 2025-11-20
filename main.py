"""Console interface for the Fullmetal Archive (FMA) database."""

from __future__ import annotations

from dataclasses import dataclass
from getpass import getpass
from typing import Callable, Dict, Optional, Sequence

import mysql.connector
from mysql.connector import MySQLConnection, errorcode


@dataclass
class MenuAction:
    label: str
    handler: Callable[[], Optional[bool]]


class DatabaseGateway:
    """Thin wrapper around raw SQL queries for the FMA schema."""

    def __init__(self, connection: MySQLConnection) -> None:
        self.connection = connection

    def list_missions(self) -> Sequence[Dict[str, object]]:
        query = (
            "SELECT MissionID, MissionCode, MissionType, Status, StartDate, EndDate "
            "FROM Missions ORDER BY StartDate DESC"
        )
        return self._fetch_all(query)

    def search_alchemists_by_specialization(
        self, keyword: str
    ) -> Sequence[Dict[str, object]]:
        query = (
            "SELECT a.AlchemistID, a.FName, a.LName, s.Specialization "
            "FROM Alchemists a "
            "JOIN AlchemistSpecializations s ON a.AlchemistID = s.AlchemistID "
            "WHERE s.Specialization LIKE %s "
            "ORDER BY a.FName"
        )
        return self._fetch_all(query, (f"%{keyword}%",))

    def get_units_in_city(self, city_keyword: str) -> Sequence[Dict[str, object]]:
        query = (
            "SELECT u.UnitID, u.UnitName, c.City, c.Region, u.CommanderID "
            "FROM Units u "
            "JOIN Cities c ON u.CityID = c.CityID "
            "WHERE c.City LIKE %s OR c.Region LIKE %s "
            "ORDER BY c.City, u.UnitName"
        )
        like = f"%{city_keyword}%"
        return self._fetch_all(query, (like, like))

    def get_lab_inventory(self, lab_id: int) -> Sequence[Dict[str, object]]:
        query = (
            "SELECT l.LabName, i.ChemicalName, s.StockQuantity, i.HazardClass "
            "FROM IngredientStock s "
            "JOIN Ingredients i ON s.IngredientID = i.IngredientID "
            "JOIN Labs l ON s.LabID = l.LabID "
            "WHERE s.LabID = %s ORDER BY i.ChemicalName"
        )
        return self._fetch_all(query, (lab_id,))

    def get_artifact_attempts(self, artifact_id: int) -> Sequence[Dict[str, object]]:
        query = (
            "SELECT aa.ArtifactID, a.Name, aa.AttemptNo, aa.AttemptDate, aa.Result, "
            "aa.Casualties, al.FName, al.LName "
            "FROM ArtifactAttempts aa "
            "JOIN Artifacts a ON aa.ArtifactID = a.ArtifactID "
            "JOIN Alchemists al ON aa.PerformerID = al.AlchemistID "
            "WHERE aa.ArtifactID = %s ORDER BY aa.AttemptNo"
        )
        return self._fetch_all(query, (artifact_id,))

    def create_alchemist(
        self,
        first_name: str,
        middle_name: Optional[str],
        last_name: Optional[str],
        school: Optional[str],
        license_number: Optional[str],
        nation_code: Optional[str],
    ) -> int:
        new_id = self._get_next_id("Alchemists", "AlchemistID")
        query = (
            "INSERT INTO Alchemists (AlchemistID, FName, MName, LName, School, LicenseNumber, NationCode) "
            "VALUES (%s, %s, %s, %s, %s, %s, %s)"
        )
        self._execute_write(
            query,
            (
                new_id,
                first_name or None,
                middle_name or None,
                last_name or None,
                school or None,
                license_number or None,
                nation_code or None,
            ),
        )
        return new_id

    def update_mission_status(self, mission_id: int, status: str) -> int:
        query = "UPDATE Missions SET Status = %s WHERE MissionID = %s"
        return self._execute_write(query, (status, mission_id))

    def delete_artifact_attempt(self, artifact_id: int, attempt_no: int) -> int:
        query = "DELETE FROM ArtifactAttempts WHERE ArtifactID = %s AND AttemptNo = %s"
        return self._execute_write(query, (artifact_id, attempt_no))

    def _fetch_all(
        self, query: str, params: Sequence[object] | None = None
    ) -> Sequence[Dict[str, object]]:
        with self.connection.cursor(dictionary=True) as cursor:
            cursor.execute(query, params or tuple())
            return cursor.fetchall()

    def _get_next_id(self, table: str, column: str) -> int:
        query = f"SELECT COALESCE(MAX({column}), 0) + 1 AS next_id FROM {table}"
        with self.connection.cursor(dictionary=True) as cursor:
            cursor.execute(query)
            row = cursor.fetchone()
        return int(row["next_id"]) if row and row["next_id"] is not None else 1

    def _execute_write(self, query: str, params: Sequence[object]) -> int:
        with self.connection.cursor() as cursor:
            cursor.execute(query, params)
            affected = cursor.rowcount
        self.connection.commit()
        return affected


class FMACLI:
    """Handles user interactions for the FMA console application."""

    def __init__(self, gateway: DatabaseGateway) -> None:
        self.gateway = gateway
        self.actions: Dict[str, MenuAction] = {
            "1": MenuAction("List missions", self._action_list_missions),
            "2": MenuAction(
                "Find alchemists by specialization", self._action_find_alchemists
            ),
            "3": MenuAction("Show units by city/region", self._action_units_by_city),
            "4": MenuAction(
                "View lab ingredient inventory", self._action_lab_inventory
            ),
            "5": MenuAction("View artifact attempts", self._action_artifact_attempts),
            "6": MenuAction(
                "Register a new alchemist", self._action_register_alchemist
            ),
            "7": MenuAction(
                "Update mission status", self._action_update_mission_status
            ),
            "8": MenuAction(
                "Delete an artifact attempt", self._action_delete_artifact_attempt
            ),
            "q": MenuAction("Quit", self._action_quit),
        }

    def run(self) -> None:
        print("\nWelcome to the FMA Operations Console!\n")
        while True:
            self._print_menu()
            choice = input("Select an option: ").strip().lower()
            action = self.actions.get(choice)
            if not action:
                print("Invalid selection. Please choose a listed option.\n")
                continue
            should_quit = action.handler()
            if should_quit:
                break

    def _print_menu(self) -> None:
        print("========== Main Menu ==========")
        for key, action in self.actions.items():
            print(f"{key}: {action.label}")
        print("===============================")

    def _action_list_missions(self) -> None:
        missions = self.gateway.list_missions()
        if not missions:
            print("No missions found.\n")
            return None
        print("\n-- Missions --")
        for mission in missions:
            print(
                f"#{mission['MissionID']:03d} {mission['MissionCode']} | {mission['MissionType']} | "
                f"Status: {mission['Status']} | {mission['StartDate']} -> {mission['EndDate']}"
            )
        print()
        return None

    def _action_find_alchemists(self) -> None:
        keyword = input("Specialization keyword: ").strip()
        if not keyword:
            print("Keyword cannot be empty.\n")
            return None
        rows = self.gateway.search_alchemists_by_specialization(keyword)
        if not rows:
            print("No matching alchemists found.\n")
            return None
        print("\n-- Matching Alchemists --")
        for row in rows:
            name = " ".join(filter(None, [row.get("FName"), row.get("LName")]))
            print(f"ID {row['AlchemistID']}: {name} | {row['Specialization']}")
        print()
        return None

    def _action_units_by_city(self) -> None:
        keyword = input("City or region keyword: ").strip()
        if not keyword:
            print("Keyword cannot be empty.\n")
            return None
        rows = self.gateway.get_units_in_city(keyword)
        if not rows:
            print("No units found for that location.\n")
            return None
        print("\n-- Units --")
        for row in rows:
            print(
                f"Unit {row['UnitName']} (#{row['UnitID']}) | City: {row['City']} ({row['Region']}) | "
                f"Commander ID: {row['CommanderID']}"
            )
        print()
        return None

    def _action_lab_inventory(self) -> None:
        lab_id_str = input("Lab ID: ").strip()
        if not lab_id_str.isdigit():
            print("Lab ID must be numeric.\n")
            return None
        lab_id = int(lab_id_str)
        rows = self.gateway.get_lab_inventory(lab_id)
        if not rows:
            print("No inventory records for that lab.\n")
            return None
        lab_name = rows[0]["LabName"]
        print(f"\n-- Inventory for {lab_name} --")
        for row in rows:
            print(
                f"{row['ChemicalName']}: {row['StockQuantity']} units | Hazard: {row['HazardClass']}"
            )
        print()
        return None

    def _action_artifact_attempts(self) -> None:
        artifact_id_str = input("Artifact ID: ").strip()
        if not artifact_id_str.isdigit():
            print("Artifact ID must be numeric.\n")
            return None
        artifact_id = int(artifact_id_str)
        rows = self.gateway.get_artifact_attempts(artifact_id)
        if not rows:
            print("No attempts recorded for that artifact.\n")
            return None
        print(f"\n-- Attempts for {rows[0]['Name']} --")
        for row in rows:
            performer = " ".join(filter(None, [row.get("FName"), row.get("LName")]))
            print(
                f"Attempt {row['AttemptNo']} on {row['AttemptDate']}: {row['Result']} | "
                f"Casualties: {row['Casualties']} | Performer: {performer}"
            )
        print()
        return None

    def _action_register_alchemist(self) -> None:
        print("\n-- Register New Alchemist --")
        first_name = input("First name (required): ").strip()
        if not first_name:
            print("First name is required.\n")
            return None
        middle_name = input("Middle name (optional): ").strip() or None
        last_name = input("Last name (optional): ").strip() or None
        school = input("School / Discipline (optional): ").strip() or None
        license_number = input("License number (optional): ").strip() or None
        nation_code = input("Nation code (e.g., AM, XG): ").strip() or None
        new_id = self.gateway.create_alchemist(
            first_name, middle_name, last_name, school, license_number, nation_code
        )
        print(f"Alchemist registered with ID {new_id}.\n")
        return None

    def _action_update_mission_status(self) -> None:
        mission_id_str = input("Mission ID: ").strip()
        if not mission_id_str.isdigit():
            print("Mission ID must be numeric.\n")
            return None
        mission_id = int(mission_id_str)
        status = input("New status: ").strip()
        if not status:
            print("Status cannot be empty.\n")
            return None
        affected = self.gateway.update_mission_status(mission_id, status)
        if affected:
            print("Mission status updated.\n")
        else:
            print("Mission not found or no change made.\n")
        return None

    def _action_delete_artifact_attempt(self) -> None:
        artifact_id_str = input("Artifact ID: ").strip()
        attempt_no_str = input("Attempt number: ").strip()
        if not (artifact_id_str.isdigit() and attempt_no_str.isdigit()):
            print("Both Artifact ID and Attempt number must be numeric.\n")
            return None
        affected = self.gateway.delete_artifact_attempt(
            int(artifact_id_str), int(attempt_no_str)
        )
        if affected:
            print("Artifact attempt deleted.\n")
        else:
            print("No matching artifact attempt found.\n")
        return None

    def _action_quit(self) -> bool:
        print("Exiting FMA console. Goodbye!")
        return True


def get_db_connection(
    host: str, user: str, password: str, database: str
) -> Optional[MySQLConnection]:
    try:
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database,
            autocommit=False,
        )
        print("Database connection successful.\n")
        return connection
    except mysql.connector.Error as exc:  # type: ignore[attr-defined]
        if exc.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Invalid credentials. Please try again.")
        elif exc.errno == errorcode.ER_BAD_DB_ERROR:
            print(f"Database '{database}' does not exist.")
        else:
            print(f"Error connecting to MySQL: {exc}")
        return None


def main() -> None:
    print("FMA database connector setup")
    host = input("MySQL host [localhost]: ").strip() or "localhost"
    database = input("Database name [fma]: ").strip() or "fma"
    user = input("Username: ").strip()
    password = getpass("Password: ")

    connection = get_db_connection(host, user, password, database)
    if not connection:
        print("Unable to start CLI without a database connection.")
        return

    try:
        gateway = DatabaseGateway(connection)
        cli = FMACLI(gateway)
        cli.run()
    finally:
        connection.close()
        print("Database connection closed.")


if __name__ == "__main__":
    main()
