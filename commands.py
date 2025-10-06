import psycopg2

conn = psycopg2.connect(dbname="stats", user="bucko", password="bananas", host="127.0.0.1")
cur = conn.cursor()

cur.execute("SELECT * FROM holdings LIMIT 20;")
for row in cur.fetchall():
    print(row)

cur.close()
conn.close()

