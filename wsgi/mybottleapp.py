from bottle import route, default_app, template, static_file, request

from eproxlib.datacenter import DataCenter as MyDataCenter
from eproxlib.datacenter import DataBase as MyDataBase

@route('/')
def index():
    proxdb = MyDataBase('easyproxmox')
    proxdb.CreateConn()
    proxdb.Actualize()
    return template('main.tpl', datacenterlist = proxdb.datacenter['list'])

@route('/fetchtoken', method='POST')
def CogerToken():
    proxhome = MyDataCenter('nashgul')
    proxhome.https_url = 'https://proxmox.nashgul.com.es'
    proxhome.api_address = '/api2/json'
    proxhome.api_ticket = '/access/ticket'
    proxhome.creds['username'] = request.forms.get('username')
    proxhome.creds['password'] = request.forms.get('password')

    proxhome.FetchCreds()
    proxhome.FetchNodeList()

    return proxhome.json_nodelist['data'][0]['node']

@route('/configureEP')
def ConfigurarEP:
    return template('configure_ep.tpl')

@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root=os.environ['OPENSHIFT_REPO_DIR']+'static/')

# This must be added in order to do correct path lookups for the views
import os
from bottle import TEMPLATE_PATH

TEMPLATE_PATH.append(os.path.join(os.environ['OPENSHIFT_REPO_DIR'], 'wsgi/views/'))

application=default_app()
