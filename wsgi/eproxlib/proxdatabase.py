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

def DataCenterList(conn, cur):
    cur.execute("""SELECT * from centros_de_datos;""")
    datacenterlist = cur.fetchall()
    return datacenterlist

def InsertDataCenter(**kwargs):
    centername = kwargs['centername']
    url = kwargs['url']
    port = kwargs['port']
    cur.execute("""INSERT INTO centros_de_datos (nombre, url, puerto) values (%s, %s, %s)""", (centername, url, port))
    conn.commit()
    CloseConn(conn, cur)

def InsertUser(**kwargs):
    username = kwargs['username']
    centername = kwargs['centername']
    cur.execute("""INSERT INTO usuarios (nombre, centro) values (%s, %s)""", (username, centername))
    conn.commit()

def InfoCenter(**kwargs):
    centername = kwargs['centername']
    cur.execute("""select * from centros_de_datos where nombre = %s;""", centername)
    infocenter = cur.fetchone()
    return infocenter
