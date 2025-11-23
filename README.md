# Fullmetal Alchemist Database System — Phase 4

This project implements the final phase of a relational database system inspired by the Fullmetal Alchemist universe. Phase 4 focuses on transforming the 3NF relational schema into an executable MySQL database, populating it with coherent data, and building a Python-based CLI application to interact with it.

---

## 1. Project Overview

### **Database Theme**

A military–research world modeled on "Fullmetal Alchemist", containing:

* Alchemists, labs, missions, artifacts
* Homunculi, devices, ingredients
* Mission logs, transmutation attempts
* Normalized multivalued attributes and split tables

### **schema.sql**

Creates the full database structure:

* 20+ normalized tables
* All primary keys, foreign keys, constraints
* Weak entities, subclass tables, multivalued attributes
* Relationship tables in 3NF (MissionAssignment splits)

### **populate.sql**

Populates the database with realistic, coherent data:

* Cities, labs, alchemists
* Missions, artifacts, devices
* Mission logs and attempts
* Ingredient stock and experiment usage
* Rank history, specializations, forensic analysis links

Data is inserted in a correct FK-respecting order.

### **main_app.py**

Implements a full command‑line interface (CLI) using raw parameterized SQL:

* 10 READ operations
* 3 WRITE operations (INSERT, UPDATE, DELETE)
* Fully parameterized, no ORM or abstraction
* Uses mysql‑connector‑python

---

## 2. How to Run the Project

### **Step 1 — Create the database and run schema.sql**

```sh
mysql -u <username> -p < schema.sql
```

This creates the database `fma` and all tables.

### **Step 2 — Populate the database**

```sh
mysql -u <username> -p < populate.sql
```

This inserts all the sample data.

### **Step 3 — Install Python dependencies**

```sh
pip install mysql-connector-python
```

### **Step 4 — Run the CLI application**

```sh
python3 main_app.py
```

You will be prompted for MySQL credentials.

---

## 3. Complete List of CLI Commands

Commands appear **in the exact order of the program menu**.

### **1. List missions**

Shows all missions with type, status, and dates.

### **2. Search alchemists by specialization**

Searches for alchemists based on specialization keywords.

### **3. Show units in a city/region**

Filters military units by matching city or region.

### **4. Show lab ingredient inventory**

Displays ingredient stock and hazard levels for a lab.

### **5. View artifact attempts**

Shows all transmutation attempts for a given artifact.

### **6. List active mission alchemists**

Lists alchemists currently assigned to ongoing missions.

### **7. Find high-danger artifacts**

Lists artifacts with a danger level above a user-specified threshold.

### **8. Summarize ingredient stock**

Shows the total stock quantity of a specific ingredient across all labs.

### **9. Show alchemist rank history**

Displays the promotion history for a specific alchemist.

### **10. List labs in region**

Lists all laboratories within a specific region, ordered by security level.

### **11. Register a new alchemist (INSERT)**

Adds a new alchemist to the database.

### **12. Update mission status (UPDATE)**

Modifies the status of a mission.

### **13. Delete an artifact attempt (DELETE)**

Deletes a specific transmutation attempt.

### **q. Quit**

Exits the program.

---
