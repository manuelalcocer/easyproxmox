# -*- coding: utf-8 -*-

from bottle import request
from json import loads, dumps
import os
import psycopg2
import requests

import httplib
from urlparse import urlparse

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
        self.mvdatadict = {}
        self.hdddatadict = {}

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

    def Getjson(self, path):
        json_dict = loads(requests.get(path, cookies = self.creds['cookie'], verify = False).text)
        return json_dict

    def MakePost(self, path, datadict):
        r = requests.post(path, cookies = self.creds['cookie'], headers = self.creds['header'], data = datadict , verify = False)
        return r.text

    def FetchNodeMvs(self, node):
        self.MvPath = self.api_root + '/nodes/' + node + '/qemu'
        self.json_mvdict = loads(requests.get(self.MvPath, cookies = self.creds['cookie'], verify = False).text)
        self.mvdict = {}
        self.tpldict = {}
        for mv in self.json_mvdict['data']:
            if mv['template'] != 1:
                self.mvdict[mv['vmid']] = mv
            else:
                self.tpldict[mv['vmid']] = mv

    def FetchInfoNode(self, node):
        self.NodeStatusPath = self.api_root + '/nodes/' + node + '/status'
        self.nodestatusdict = self.Getjson(self.NodeStatusPath)
        self.nodestatusdict = self.nodestatusdict['data']
        self.nodestatusdict['memory']['total'] = self.Convert(self.nodestatusdict['memory']['total'],'B', 'GB')
        self.nodestatusdict['memory']['free'] = self.Convert(self.nodestatusdict['memory']['free'],'B', 'GB')
        self.nodestatusdict['memory']['used'] = self.Convert(self.nodestatusdict['memory']['used'],'B', 'GB')
        self.nodestatusdict['uptime'] = self.Convert(self.nodestatusdict['uptime'], 'secs', 'days')

    def FetchIsoList(self, node, volume):
        self.IsoListPath = self.api_root + '/nodes/' + node + '/storage/' + volume + '/content'
        self.isoslist = self.Getjson(self.IsoListPath)['data']

    def Convert(self, size, s_unit, t_unit):
        if s_unit == 'B':
            if t_unit == 'GB':
                ret = str(round(float(size) / 1024**3, 2)) + ' ' + t_unit
                return ret
        elif s_unit == 'secs':
            if t_unit == 'days':
                ret = str(round(float(size) / (24*3600),1)) + ' días'
                return ret

    def CreateMV(self, node):
        self.CreateMVPath = self.api_root + '/nodes/' + node + '/qemu'
        r = self.MakePost(self.CreateMVPath, self.mvdatadict)
        return r

    def CreateHDD(self, node):
        hddcreatepath = self.api_root + '/nodes/' + node + '/storage/' + self.hdddatadict['storage'] + '/content'
        self.MakePost(hddcreatepath, self.hdddatadict)

    def Poweroff(self, node, vmid):
        self.PoweroffPath = self.api_root + '/nodes/' + node + '/qemu/' + vmid + '/status/stop'
        r = self.MakePost(self.PoweroffPath, None)
        return r

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
