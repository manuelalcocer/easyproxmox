from bottle import route, default_app, template, static_file, request
import json
import requests

from eproxlib.datacenter import DataCenter as MyDataCenter

@route('/')
def index():
    return template('login.html')

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

    #return proxhome.json_nodelist['data'][0]['node']
    longitud1 = str(len(proxhome.creds['cookie']['PVEAuthCookie']))
    longitud2 = str(len(proxhome.creds['cookie']['CSRFPreventionToken']))
    concatenado = longitud1 + ' : ' + longitud2
    return concatenado

@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root=os.environ['OPENSHIFT_REPO_DIR']+'static/')

# This must be added in order to do correct path lookups for the views
import os
from bottle import TEMPLATE_PATH
TEMPLATE_PATH.append(os.path.join(os.environ['OPENSHIFT_REPO_DIR'], 'wsgi/views/'))

application=default_app()
