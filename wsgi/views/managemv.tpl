<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : True, 'url' : '/node/MV/%s' % dcdc.centername } ])
    include('header.tpl', title='Administrar Nodo')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    %  dcdc.FetchNodeList()
    %   for node in dcdc.nodedict['data']:
    %       dcdc.FetchNodeMvs(node['node'])
    <table style="width:100%">
        <tr>
            <th colspan="4">{{node['node']}}</th>
        </tr>
        <tr>
            <th>VMID</th>
            <th>Nombre</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        <tr>
            <td colspan="4"><a href="/node/createMV/{{dcdc.centername}}">Crear máquina</a></td>
        </tr>
    %       for key in dcdc.mvdict.keys():
                <tr>
                    <td>{{dcdc.mvdict[key]['vmid']}}</td>
                    <td>{{dcdc.mvdict[key]['name']}}</td>
                    <td>{{dcdc.mvdict[key]['status']}}</td>
                    <td><img src="/static/proyecto/style/icon-remove.png"/></td>
                </tr>
    %       end
    </table>
    %   end
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
