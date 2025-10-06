import psycopg2
from decimal import Decimal
from psycopg2.extras import RealDictCursor

class DB: 
    
    # Constructeur: initialise les attributs de l'objet
    def __init__(self):
        self.conn = psycopg2.connect(
            dbname="stats",
            user="bucko",
            password="bananas",
            host="localhost",
            port="5432"
        )

        self.cur = self.conn.cursor(cursor_factory=RealDictCursor)
    
    def disconnect(self):
        if self.conn:
            self.conn.close()

    # Execute a script (DDL or DML)
    def execute(self, query):
        self.cur.execute(query)
        self.conn.commit()

    def run_script(self, script_path):
        with open(script_path, 'r') as file:
            script = file.read()
            self.cur.execute(script)
            self.conn.commit()

    def fetch_all(self, query):
        self.cur.execute(query)
        return self.cur.fetchall()
        
    def fetch(self, query):
        self.cur.execute(query)
        return self.cur.fetchone()
    
    def __del__(self):
        try:
            if hasattr(self, "cur"):
                self.cur.close()
            if hasattr(self, "conn"):
                self.conn.close()
        except Exception:
            pass

    def display(self, rows):
        if not rows:
            print("Aucune donnée.")
            return

        # extraire les noms de colonnes
        headers = list(rows[0].keys())

        # construire les lignes formatées
        table = []
        for row in rows:
            formatted = []
            for v in row.values():
                if isinstance(v, Decimal):
                    formatted.append(f"{float(v):.2f}")
                else:
                    formatted.append(str(v))
            table.append(formatted)

        # calcul de la largeur max de chaque colonne
        widths = [max(len(str(x)) for x in col) for col in zip(*([headers] + table))]

        # fonction d’impression alignée
        def print_row(row):
            print(" | ".join(str(x).ljust(w) for x, w in zip(row, widths)))

        # affichage
        print_row(headers)
        print("-+-".join("-" * w for w in widths))
        for r in table:
            print_row(r)


