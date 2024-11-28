import pyodbc

from src.settings import settings

if __name__ == "__main__":
    print(settings.connection_string())
    conn = pyodbc.connect(settings.connection_string())
    print("Connected to SQL Server successfully!")

    # check connection with SQL Server database
    cursor = conn.cursor()
    cursor.execute("SELECT @@VERSION;")
    row = cursor.fetchone()
    if row is not None:
        print("SQL Server Version:", row[0])

    conn.close()
