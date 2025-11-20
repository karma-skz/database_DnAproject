# Fullmetal Archive CLI

A command-line interface that connects to the Fullmetal Archive (FMA) MySQL schema and exposes required read/write operations for project phase 4.

## Prerequisites

- Python 3.10+
- MySQL Server with credentials that can create/use the `fma` database
- The provided `fma.sql` schema/data file

## Setup

1. **Create and seed the database** (run inside a MySQL shell that has access to create databases):

   ```powershell
   mysql -u <username> -p < fma.sql
   ```

2. **Install Python dependencies** (prefer a virtual environment):

   ```powershell
   pip install -r requirements.txt
   ```

## Running the CLI

Launch the interface and provide your MySQL credentials when prompted:

```powershell
python main.py
```

You will be asked for host, database name (defaults to `fma`), username, and password. After connecting, use the numbered menu to run the required queries and update operations (mission listings, specialization search, lab inventory, artifact attempts, create/update/delete flows, etc.).

## Notes

- All SQL is executed using parameterized queries via `mysql-connector-python` to avoid injection issues.
- The CLI commits each write operation immediately; failures raise MySQL errors that are printed to the console.
- Update the menu handlers or gateway methods if additional project-specific requirements emerge.
