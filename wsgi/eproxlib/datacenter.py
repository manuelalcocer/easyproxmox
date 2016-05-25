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

class DataCenter:
    def __init__(self, centername):
        self.centername = centername
        self.https_url = ''
        self.port = ''
        self.api_address = '/api2/json'
        self.api_ticket = '/access/ticket'
        self.creds = {}

    def FetchCreds(self, **kwargs):
        parameters_list = { 'username' : kwargs['username'] + '@pam', 'password' : kwargs['password'] }
        self.api_root = self.https_url + ':' + str(self.port) + self.api_address
        self.creds_response = requests.post(self.api_root + self.api_ticket, params = parameters_list, verify = False)
        self.json_creds = loads(self.creds_response.text)
        self.creds['cookie'] = { 'PVEAuthCookie' : self.json_creds['data']['ticket'] }
        self.creds['header'] = { 'CSRFPreventionToken' : self.json_creds['data']['CSRFPreventionToken'] }
        self.cookie = dict(PVEAuthCookie=self.json_creds['data']['ticket'])

    def FetchNodeList(self):
        self.NodePath = self.api_root + '/nodes'
        self.nodedict = loads(requests.get(self.NodePath, cookies = self.creds['cookie'], verify = False).text)

    def FetchNodeMvs(self, node):
        self.MvPath = self.api_root + '/nodes/' + node + '/qemu'
        self.json_mvdict = loads(requests.get(self.MvPath, cookies = self.creds['cookie'], verify = False).text)
        self.mvdict = {}
        for mv in self.json_mvdict['data']:
            self.mvdict[mv['vmid']] = mv

def sset(key,value):
    s = request.environ.get('beaker.session')
    s[key] = value

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
    try:
        return s['dc'].creds['cookie']['PVEAuthCookie']
    except:
        return None

if __name__ == '__main__':
    Main()
