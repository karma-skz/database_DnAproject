# Fullmetal Alchemist Database System — Concise Overview

## Project Phases Summary

### Phase 1 — Analysis & Design
- Chose the mini‑world (FMA); defined users, purpose, and constraints
- Authored requirements and conceptual ERD (entities, weak entities, subclasses, keys)
- Modeled 4‑ary relationships

### Phase 2 — ER Diagram & Quality
- Produced Chen‑notation ERD with clear cardinalities and participation
- Refined multi‑valued attributes; expanded 4‑ary relationships
- Analyzed redundancy and update/insert/delete anomalies with mitigations

### Phase 3 — Relational Modeling & Normalization
- Mapped ER → relational; confirmed 1NF; removed partial FDs for 2NF
- Achieved 3NF: separated IngredientStock; moved Rank to AlchemistRankHistory; replaced LabAffiliation with LabID; split MissionAssignment into unit/lab tables; introduced City to remove City - Region

### Phase 4 — Implementation & App
- Implemented MySQL DDL and populated coherent data
- Built Python CLI (parameterized SQL: 10 READ, 3 WRITE)
- See sections below for schema, data, and CLI usage

---

## How to Run

Follow the same steps as the main README.

1) Create the database and run schema.sql:
```sh
mysql -u <username> -p < schema.sql
```

2) Populate the database:
```sh
mysql -u <username> -p < populate.sql
```

3) Install Python dependencies:
```sh
pip install mysql-connector-python
```

4) Run the CLI application:
```sh
python3 main_app.py
```

Notes:
- If running from the repository root, use `src/` paths:
  - `mysql -u <username> -p < src/schema.sql`
  - `mysql -u <username> -p < src/populate.sql`
  - `python3 src/main_app.py`
- Alternatively, `cd src` and run the commands exactly as shown above.
