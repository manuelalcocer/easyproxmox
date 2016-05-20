import os
from bottle import TEMPLATE_PATH

from bottle import route, default_app, template, static_file, request
import json
import requests
import psycopg2

from eproxlib.datacenter import DataCenter as MyDataCenter

@route('/')
def index():
    #dbname = 'easyproxmox'
    #dbuser = 'adminrpqtdpp'
    #dbpassword = 'RY26llyFAWLc'
    #try:
    #    conn = psycopg2.connect("dbname=%s user='dbuser' host='localhost' password='dbpass'")
    #except:
    #    print "I am unable to connect to the database"
    return template('main.html')

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
    longitud2 = str(len(proxhome.creds['header']['CSRFPreventionToken']))
    concatenado = longitud1 + ' : ' + longitud2
    return concatenado

@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root=os.environ['OPENSHIFT_REPO_DIR']+'static/')

# This must be added in order to do correct path lookups for the views

TEMPLATE_PATH.append(os.path.join(os.environ['OPENSHIFT_REPO_DIR'], 'wsgi/views/'))

application=default_app()
