from bottle import route, default_app, template, static_file, request
import json
import requests

#from eproxlib.datacenter import DataCenter as MyDataCenter

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
        self.creds_response = requests.post('https://proxmox.nashgul.com.es/api2/json/access/ticket', params = parameters_list)
        #self.json_creds = json.loads(self.creds_response.text)
        #self.creds['cookie'] = { 'PVEAuthCookie' : self.json_creds['data']['ticket'] }
        #self.creds['header'] = { 'CSRFPreventionToken' : self.json_creds['data']['CSRFPreventionToken'] }
        #self.cookie = dict(PVEAuthCookie=self.json_creds['data']['ticket'])

    def FetchNodeList(self):
        self.NodePath = self.api_root + '/nodes'
        self.json_nodelist = json.loads(requests.get(self.NodePath, cookies = self.creds['cookie']).text)

@route('/')
def index():
    return template('login.html')

@route('/fetchtoken', method='POST')
def CogerToken():
    proxhome = DataCenter('nashgul')
    proxhome.https_url = 'https://proxmox.nashgul.com.es'
    proxhome.api_address = '/api2/json'
    proxhome.api_ticket = '/access/ticket'
    proxhome.creds['username'] = request.forms.get('username')
    proxhome.creds['password'] = request.forms.get('password')

    proxhome.FetchCreds()
    #proxhome.FetchNodeList()

    return variable

@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root=os.environ['OPENSHIFT_REPO_DIR']+'static/')

# This must be added in order to do correct path lookups for the views
import os
from bottle import TEMPLATE_PATH
TEMPLATE_PATH.append(os.path.join(os.environ['OPENSHIFT_REPO_DIR'], 'wsgi/views/'))

application=default_app()
