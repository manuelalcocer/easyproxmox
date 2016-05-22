#!/usr/bin/env python2
# -*- coding: utf-8 -*-
from bottle import route, default_app, template, static_file, request

from eproxlib.datacenter import DataCenter as MyDataCenter
from eproxlib.datacenter import DataBase as MyDataBase

## inicializacion de la web
global proxdb
global proxhome

@route('/')
def index():
    # inicializa al base de datos, con el nombre proxdb
    # la base de datos es la misma para todos los centros de datos 'proxdb'
    global proxdb
    proxdb = MyDataBase('easyproxmox')
    proxdb.Actualize()
    return template('main.tpl', dcdb = proxdb)

@route('/login/<centername>', method='POST')
def login(centername):
    global proxdb
    proxdb.InfoCenter(centername=centername)
    proxhome = MyDataCenter(proxdb.infocenter[0])
    proxhome.https_url = proxdb.infocenter[1]
    proxhome.port = proxdb.infocenter[2]
    proxhome.creds['username'] = request.forms.get('username')
    proxhome.creds['password'] = request.forms.get('password')

    proxhome.FetchCreds()
    if proxhome.creds['cookie']:
        source_site = request.forms.get('source')
        redirect('/manage/MV/%s' % proxdb.infocenter[0])
    #proxhome.FetchNodeList()

    #return proxhome.json_nodelist['data'][0]['node']


## zona de configuracion
@route('/configureEP')
def configureEP():
    global proxdb
    return template('configure_ep.tpl', dcdb = proxdb)

@route('/controlpanel', method='POST')
def controlpanel():
    global proxdb
    password = request.forms.get('password')
    if password == proxdb.dbpassword:
        return template('controlpanel.tpl', dcdb = proxdb)
    else:
        return 'EENNGG!  xD'

@route('/createdatacenter', method='POST')
def createdatacenter():
    global proxdb
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
@route('/manage/<name>')
def manage(name):
    # name es el nombre del centro de datos en la BBDD
    global proxdb
    return template('manage.tpl', name = name, dcdb = proxdb)

@route('/manage/MV/<centername>')
def manageMV(centername):
    global proxdb
    global proxhome
    try:
        if proxhome.creds['cookie']:
            return template('manage_mv.tpl', centername = centername)
    except:
        return template('login.tpl', source = '/manage/MV/%s' % centername, centername = centername)

## Zona de bottle
@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root=os.environ['OPENSHIFT_REPO_DIR']+'static/')

# This must be added in order to do correct path lookups for the views
import os
from bottle import TEMPLATE_PATH

TEMPLATE_PATH.append(os.path.join(os.environ['OPENSHIFT_REPO_DIR'], 'wsgi/views/'))

application=default_app()
