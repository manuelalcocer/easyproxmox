import json
import requests

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
        self.creds_response = requests.post(self.api_root + self.api_ticket, params = parameters_list)
        #self.json_creds = json.loads(self.creds_response.text)
        #self.creds['cookie'] = { 'PVEAuthCookie' : self.json_creds['data']['ticket'] }
        #self.creds['header'] = { 'CSRFPreventionToken' : self.json_creds['data']['CSRFPreventionToken'] }
        #self.cookie = dict(PVEAuthCookie=self.json_creds['data']['ticket'])

    def FetchNodeList(self):
        self.NodePath = self.api_root + '/nodes'
        self.json_nodelist = json.loads(requests.get(self.NodePath, cookies = self.creds['cookie']).text)

    def Prueba(self):
        return 'holahola'

if __name__ == '__main__':
    Main()
