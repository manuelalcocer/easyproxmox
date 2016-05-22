from bottle import route, default_app, template, static_file, request

from eproxlib.datacenter import DataCenter as MyDataCenter
from eproxlib.datacenter import DataBase as MyDataBase

@route('/')
def index():
    # inicializa al base de datos, con el nombre proxdb
    # la base de datos es la misma para todos los centros de datos 'proxdb'
    global proxdb
    proxdb = MyDataBase('easyproxmox')
    proxdb.Actualize()
    return template('main.tpl', dcdb = proxdb)

@route('/fetchtoken', method='POST')
def fetchtoken():
    global proxhome
    proxhome = MyDataCenter('nashgul')
    proxhome.https_url = 'https://proxmox.nashgul.com.es'
    proxhome.creds['username'] = request.forms.get('username')
    proxhome.creds['password'] = request.forms.get('password')

    proxhome.FetchCreds()
    proxhome.FetchNodeList()

    return proxhome.json_nodelist['data'][0]['node']

@route('/configureEP')
def configureEP():
    return template('configure_ep.tpl')

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
    nameondb = request.forms.get('name')
    createDC = MyDataCenter(nameondb)
    createDC.SetParams(username = username, password = password, url = url, port = port)
    createDC.FetchCreds()
    if createDC.creds.has_key('cookie'):
        proxdb.InsertDataCenter(name = nameondb,url = url)
        proxdb.InsertUser(nameondb = centername, username = name)
        return template('controlpanel.tpl', dcdb = proxdb)
    else:
        return 'hubo un fallo'

@route('/manage/<name>')
def manage(name):
    # name es el nombre del centro de datos en la BBDD
    pass

@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root=os.environ['OPENSHIFT_REPO_DIR']+'static/')

# This must be added in order to do correct path lookups for the views
import os
from bottle import TEMPLATE_PATH

global proxdb
global proxhome

TEMPLATE_PATH.append(os.path.join(os.environ['OPENSHIFT_REPO_DIR'], 'wsgi/views/'))

application=default_app()
