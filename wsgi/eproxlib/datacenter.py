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

    def Actualize(self):
        self.cur.execute("""SELECT * from centros_de_datos""")
        self.datacenter['list'] = self.cur.fetchall()

class DataCenter:
    def __init__(self, id_name):
        self.id_name = id_name
        self.https_url = ''
        self.api_address = ''
        self.api_ticket = ''
        self.creds = {}

    def FetchCreds(self):
        parameters_list = { 'username' : self.creds['username'] + '@pam', 'password' : self.creds['password'] }
        self.api_root = self.https_url + self.api_address
        self.creds_response = requests.post(self.api_root + self.api_ticket, params = parameters_list, verify = False)
        self.json_creds = loads(self.creds_response.text)
        self.creds['cookie'] = { 'PVEAuthCookie' : self.json_creds['data']['ticket'] }
        self.creds['header'] = { 'CSRFPreventionToken' : self.json_creds['data']['CSRFPreventionToken'] }
        self.cookie = dict(PVEAuthCookie=self.json_creds['data']['ticket'])

    def FetchNodeList(self):
        self.NodePath = self.api_root + '/nodes'
        self.json_nodelist = loads(requests.get(self.NodePath, cookies = self.creds['cookie'], verify = False).text)

if __name__ == '__main__':
    Main()
