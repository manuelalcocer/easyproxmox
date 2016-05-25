#!/usr/bin/env python2
# -*- coding: utf-8 -*-

from bottle import route, default_app, template, static_file, request, redirect

from beaker.middleware import SessionMiddleware

import os

from eproxlib.datacenter import DataCenter as MyDataCenter
from eproxlib.datacenter import DataBase as MyDataBase
from eproxlib.datacenter import sset, sget, sdelete, sislogin
import eproxlib.proxdatabase as Mydb

session_opts = {
    'session.type': 'file',
    'session.cookie_expires': 300,
    'session.data_dir': os.environ['OPENSHIFT_DATA_DIR'] + '/beakersessions',
    'session.auto': True
}
app = SessionMiddleware(default_app(), session_opts)

## inicializacion de la web
@route('/')
def index():
    # inicializa al base de datos, con el nombre proxdb
    # la base de datos es la misma para todos los centros de datos 'proxdb'
    proxdb = MyDataBase('easyproxmox')
    sset('db', proxdb)
    return template('main.tpl', dcdb = proxdb)

@route('/login/<centername>')
def login(centername):
    return template('login.tpl', centername = centername)

@route('/FetchCreds/<centername>', method='POST')
def FetchCreds(centername):
    datacenter = Mydb.InfoCenter(sget('db'), centername=centername)
    proxhome = MyDataCenter(datacenter[0])
    proxhome.https_url = datacenter[1]
    proxhome.port = datacenter[2]
    username = request.forms.get('username')
    password = request.forms.get('password')

    proxhome.FetchCreds(username = username, password = password)
    if proxhome.creds['cookie']['PVEAuthCookie']:
        sset('dc', proxhome)
        retpage = sget('returnpage')
        redirect('%s/%s' %(retpage, centername))

## zona de configuracion
@route('/configureEP')
def configureEP():
    return template('configure_ep.tpl')

@route('/controlpanel', method='POST')
def controlpanel():
    password = request.forms.get('password')
    if password == sget('db').dbpassword:
        return template('controlpanel.tpl', dcdb = sget('db'))
    else:
        return 'EENNGG!  xD'

@route('/createdatacenter', method='POST')
def createdatacenter():
    username = request.forms.get('username')
    password = request.forms.get('password')
    port = request.forms.get('port')
    if len(port) < 1:
        port = '443'
    centername = request.forms.get('name')
    createDC = MyDataCenter(centername)
    createDC.https_url = 'https://' + request.forms.get('url')
    createDC.port = port
    createDC.FetchCreds(username = username, password = password)
    proxdb = sget('db')
    if createDC.creds.has_key('cookie'):
        Mydb.InsertDataCenter(proxdb, centername = centername, url = createDC.https_url, port = createDC.port)
        Mydb.InsertUser(proxdb, centername = centername, username = username)
        return template('controlpanel.tpl', dcdb = proxdb)
    else:
        return 'hubo un fallo'

## Zona de acciones
@route('/manage/<centername>')
def manage(centername):
    if sislogin():
        proxhome = sget('dc')
        return template('manage.tpl', dcdc = proxhome)
    else:
        sset('lastpage', '/manage')
        redirect('/login/%s' % centername)

@route('/node/MV/<centername>')
def nodeMV(centername):
    if sislogin():
        proxhome = sget('dc')
        return template('managemv.tpl', dcdc = proxhome)
    else:
        sset('lastpage', '/node/MV')
        redirect('/login/%s' % centername)

@route('/node/createMV/<node>/<centername>')
def createMV(centername, node):
    if sislogin():
        proxhome = sget('dc')
        return template('createmv.tpl', dcdc = proxhome, node = node)
    else:
        sset('lastpage', '/node/createMV')
        redirect('/login/%s' % centername)

@route('/downloadiso/<node>')
def downloadiso(node):
    if sislogin():
        proxhome = sget('dc')
        return tenplate('downloadiso.tpl', dcdc = proxhome, node = node)
    else:
        sset('lastpage', '/downloadiso/%s' % node)
        redirect('/login/%s' % sget('dc').centername)

@route('/downloadnow/<node>', method='POST')
def createdatacenter():
    if sislogin():
        proxhome = sget('dc')
        url = request.forms.get('url')
        if proxhome.CheckURL(url):
            proxhome.DownloadISO(url)
            redirect('/node/createMV/%s/%s' %(node, proxhome.centername))
    else:
        sset('lastpage', '/downloadiso/%s' % node)
        redirect('/login/%s' % sget('dc').centername)


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
