import psycopg2

def CreateConn(dcdb):
    try:
        conn = psycopg2.connect("dbname=%s user=%s host=%s password=%s" %(dcdb.dbname, dcdb.dbuser, dcdb.dbhost, dcdb.dbpassword))
        cur = conn.cursor()
        return conn, cur
    except:
        pass

def CloseConn(conn, cur):
    cur.close()
    conn.close()

def DataCenterList(dcdb):
    conn, cur = CreateConn(dcdb)
    cur.execute("""SELECT * from centros_de_datos;""")
    datacenterlist = cur.fetchall()
    CloseConn(conn, cur)
    return datacenterlist

def InsertDataCenter(dcdb, **kwargs):
    conn, cur = CreateConn(dcdb)
    cur.execute("""INSERT INTO centros_de_datos (nombre, url, puerto) values (%(centername)s, %(url)s, %(port)s)""", kwargs)
    conn.commit()
    CloseConn(conn, cur)

def InsertUser(dcdb, **kwargs):
    conn, cur = CreateConn(dcdb)
    cur.execute("""INSERT INTO usuarios (nombre, centro) values (%(username)s, %(centername)s)""", kwargs)
    conn.commit()
    CloseConn(conn, cur)

def InfoCenter(dcdb, **kwargs):
    conn, cur = CreateConn(dcdb)
    cur.execute("""select * from centros_de_datos where nombre = %(centername)s;""", kwargs)
    infocenter = cur.fetchone()
    return infocenter
