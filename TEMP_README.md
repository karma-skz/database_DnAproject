# Temporary Guide: How to Run FMA Database Commands

This guide explains how to set up the environment and run all 13 commands available in the updated CLI application.

## 1. Setup & Installation

### Prerequisites
- Python 3.x
- MySQL Server

### Step 1: Initialize Database
Open your terminal and run the following commands to create the schema and populate it with data.
*Note: Replace `root` with your MySQL username if different.*

```bash
# Create tables
mysql -u root -p < schema.sql

# Insert sample data
mysql -u root -p < populate.sql
```

### Step 2: Install Dependencies
Install the required Python MySQL connector.

```bash
pip install -r requirements.txt
```
*(Or manually: `pip install mysql-connector-python`)*

### Step 3: Run the Application
Start the CLI application.

```bash
python3 main_app.py
```
You will be prompted to enter your MySQL credentials (host, database name, username, password).
- Default Host: `localhost`
- Default Database: `fma`

---

## 2. Available Commands

Once the application is running, you will see a menu with the following options. Enter the number to execute the command.

### **READ Operations (Data Retrieval)**

**1. List missions**
- **Description:** Lists all missions with their code, type, status, and dates.
- **Input:** None.

**2. Search alchemists by specialization**
- **Description:** Finds alchemists matching a specialization keyword.
- **Input:** Keyword (e.g., `Fire`, `Bio`).

**3. Show units in a city/region**
- **Description:** Lists military units located in a specific city or region.
- **Input:** City or Region keyword (e.g., `Central`, `East`).

**4. Show lab ingredient inventory**
- **Description:** Displays chemical stock and hazard classes for a specific lab.
- **Input:** Lab ID (e.g., `1`).

**5. View artifact attempts**
- **Description:** Shows the history of transmutation attempts for a specific artifact.
- **Input:** Artifact ID (e.g., `1`).

**6. List active mission alchemists**
- **Description:** Lists all alchemists who have a history of participating in missions.
- **Input:** None.

**7. Find high-danger artifacts**
- **Description:** Lists artifacts with a danger level at or above a specified threshold.
- **Input:** Danger Threshold (integer, e.g., `5`).

**8. Summarize ingredient stock**
- **Description:** Shows the total stock quantity of a specific ingredient across all labs.
- **Input:** Ingredient Name (e.g., `Sulfur`).

**9. Show alchemist rank history**
- **Description:** Displays the career progression (rank changes) for a specific alchemist.
- **Input:** Alchemist ID (e.g., `1`).

**10. List labs in region**
- **Description:** Lists all laboratories in a specific region, ordered by security level.
- **Input:** Region Name (e.g., `East`).

---

### **WRITE Operations (Data Modification)**

**11. Register a new alchemist**
- **Description:** Adds a new alchemist record to the database.
- **Input:** First Name, Middle Name, Last Name, School, License Number, Nation Code.

**12. Update mission status**
- **Description:** Updates the status of an existing mission.
- **Input:** Mission ID, New Status (e.g., `Completed`, `Failed`).

**13. Delete an artifact attempt**
- **Description:** Removes a specific transmutation attempt record.
- **Input:** Artifact ID, Attempt Number.

---

### **Other**

**q. Quit**
- **Description:** Exits the application.
