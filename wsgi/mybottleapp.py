#!/usr/bin/env python2
# -*- coding: utf-8 -*-
from bottle import route, default_app, template, static_file, request, redirect

from beaker.middleware import SessionMiddleware

import os

from eproxlib.datacenter import DataCenter as MyDataCenter
from eproxlib.datacenter import DataBase as MyDataBase
from eproxlib.datacenter import sset, sget, sdelete, sislogin


session_opts = {
    'session.type': 'file',
    'session.cookie_expires': 300,
    'session.data_dir': os.environ['OPENSHIFT_DATA_DIR'],
    'session.auto': True
}
app = SessionMiddleware(default_app(), session_opts)

## inicializacion de la web
@route('/')
def index():
    # inicializa al base de datos, con el nombre proxdb
    # la base de datos es la misma para todos los centros de datos 'proxdb'
    global proxdb
    proxdb = MyDataBase('easyproxmox')
    proxdb.Actualize()
    return template('main.tpl', dcdb = proxdb)

@route('/login/<centername>')
def login(centername):
    return template('login.tpl', centername = centername)

@route('/FetchCreds/<centername>', method='POST')
def FetchCreds(centername):
    global proxhome
    proxdb.InfoCenter(centername=centername)
    proxhome = MyDataCenter(proxdb.infocenter[0])
    proxhome.https_url = proxdb.infocenter[1]
    proxhome.port = proxdb.infocenter[2]
    proxhome.creds['username'] = request.forms.get('username')
    proxhome.creds['password'] = request.forms.get('password')

    proxhome.FetchCreds()
    if proxhome.creds['cookie']['PVEAuthCookie']:
        sset('user', proxhome.creds['username'])
        sset('password', proxhome.creds['password'])
        sset('ticket', proxhome.creds['cookie']['PVEAuthCookie'])
        sset('csfr', proxhome.creds['header']['CSRFPreventionToken'])
        redirect('/manage/%s' % centername)
    #proxhome.FetchNodeList()

    #return proxhome.json_nodelist['data'][0]['node']

## zona de configuracion
@route('/configureEP')
def configureEP():
    return template('configure_ep.tpl', dcdb = proxdb)

@route('/controlpanel', method='POST')
def controlpanel():
    password = request.forms.get('password')
    if password == proxdb.dbpassword:
        return template('controlpanel.tpl', dcdb = proxdb)
    else:
        return 'EENNGG!  xD'

@route('/createdatacenter', method='POST')
def createdatacenter():
    username = request.forms.get('username')
    password = request.forms.get('password')
    url = request.forms.get('url')
    port = request.forms.get('port')
    if len(port) < 1:
        port = '443'
    centername = request.forms.get('name')
    createDC = MyDataCenter(centername)
    createDC.SetParams(username = username, password = password, url = 'https://' + url, port = port)
    createDC.FetchCreds()
    if createDC.creds.has_key('cookie'):
        proxdb.InsertDataCenter(centername = centername, url = 'https://' + url, port = port)
        proxdb.InsertUser(centername = centername, username = username)
        return template('controlpanel.tpl', dcdb = proxdb)
    else:
        return 'hubo un fallo'

## Zona de acciones
@route('/manage/<centername>')
def manage(centername):
    return template('manage.tpl', centername = centername)

@route('/node/MV/<centername>')
def nodeMV(centername):
    try:
        if sislogin():
            return template('managemv.tpl', centername = centername)
    except:
        redirect('/login/%s' % centername)

## Zona de bottle
@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root=os.environ['OPENSHIFT_REPO_DIR']+'static/')

# This must be added in order to do correct path lookups for the views
import os
from bottle import TEMPLATE_PATH

TEMPLATE_PATH.append(os.path.join(os.environ['OPENSHIFT_REPO_DIR'], 'wsgi/views/'))

#application=default_app()
application=app
