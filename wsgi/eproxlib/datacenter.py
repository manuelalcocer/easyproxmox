from bottle import request
from json import loads, dumps
import os
import psycopg2
import requests

class DataBase:
    def __init__(self, dbname):
        self.dbname = dbname
        self.dbuser = os.environ['OPENSHIFT_POSTGRESQL_DB_USERNAME']
        self.dbpassword = os.environ['OPENSHIFT_POSTGRESQL_DB_PASSWORD']
        self.dbhost = os.environ['OPENSHIFT_POSTGRESQL_DB_HOST']
        self.datacenter = {}

    def CreateConn(self):
        try:
            self.conn = psycopg2.connect("dbname=%s user=%s host=%s password=%s" %(self.dbname, self.dbuser, self.dbhost, self.dbpassword))
            self.cur = self.conn.cursor()
        except:
            pass

    def CloseConn(self):
        self.cur.close()
        self.conn.close()

    def Actualize(self):
        self.CreateConn()
        self.cur.execute("""SELECT * from centros_de_datos;""")
        self.datacenter['list'] = self.cur.fetchall()
        self.CloseConn()

    def InsertDataCenter(self, **kwargs):
        self.CreateConn()
        self.cur.execute("""INSERT INTO centros_de_datos (nombre, url, puerto) values (%(centername)s, %(url)s, %(port)s)""", kwargs)
        self.conn.commit()
        self.CloseConn()

    def InsertUser(self, **kwargs):
        self.CreateConn()
        self.cur.execute("""INSERT INTO usuarios (nombre, centro) values (%(username)s, %(centername)s)""", kwargs)
        self.conn.commit()
        self.CloseConn()

    def InfoCenter(self, **kwargs):
        self.CreateConn()
        self.cur.execute("""select * from centros_de_datos where nombre = %(centername)s;""", kwargs)
        self.infocenter = self.cur.fetchone()
        self.CloseConn()

class DataCenter:
    def __init__(self, centername):
        self.centername = centername
        self.https_url = ''
        self.port = ''
        self.api_address = '/api2/json'
        self.api_ticket = '/access/ticket'
        self.creds = {}

    def SetParams(self, **kwargs):
        self.https_url = kwargs['url']
        self.port = kwargs['port']
        self.creds['username'] = kwargs['username']
        self.creds['password'] = kwargs['password']

    def FetchCreds(self):
        parameters_list = { 'username' : self.creds['username'] + '@pam', 'password' : self.creds['password'] }
        self.api_root = self.https_url + ':' + str(self.port) + self.api_address
        self.creds_response = requests.post(self.api_root + self.api_ticket, params = parameters_list, verify = False)
        self.json_creds = loads(self.creds_response.text)
        self.creds['cookie'] = { 'PVEAuthCookie' : self.json_creds['data']['ticket'] }
        self.creds['header'] = { 'CSRFPreventionToken' : self.json_creds['data']['CSRFPreventionToken'] }
        self.cookie = dict(PVEAuthCookie=self.json_creds['data']['ticket'])

    def FetchNodeList(self):
        self.NodePath = self.api_root + '/nodes'
        self.json_nodelist = loads(requests.get(self.NodePath, cookies = self.creds['cookie'], verify = False).text)

def sset(key,value):
    s = request.environ.get('beaker.session')
    s[key]=value

def sget(key):
    s = request.environ.get('beaker.session')
    if key in s:
        return s[key]
    else:
        return ""

def sdelete():
    s = request.environ.get('beaker.session')
    s.delete()

def sislogin():
    s = request.environ.get('beaker.session')
    return 'user' in s

if __name__ == '__main__':
    Main()
