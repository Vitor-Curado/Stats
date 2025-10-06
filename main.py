import db

try:
    db = db.DB()

    db.run_script('sql/DDL.sql')

    db.run_script('sql/DML.sql')

    db.display(db.fetch_all('SELECT * FROM PortfolioSummary;'))
    
except Exception as e:
    print("Error:", e)
