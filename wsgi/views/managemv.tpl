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
    %       if len(dcdc.mvdict['data']) > 0:
    <table style="width:100%">
        <tr>
            <th colspan="3">{{node['node']}}</th>
        </tr>
        <tr>
            <th>VMID</th>
            <th>Nombre</th>
            <th>Estado</th>
        </tr>
        <tr>
            <td colspan="3"><a href="/node/createMV/{{dcdc.centername}}">Crear máquina</a></td>
        </tr>
    %       for mv in dcdc.mvdict['data']:
                <tr>
                    <td>{{mv['vmid']}}</td>
                    <td>{{mv['name']}}</td>
                    <td>{{mv['status']}}</td>
                </tr>
    %       end
    </table>
    %   end
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')


    <td>Eve</td>
    <td>Jackson</td>
    <td>94</td>
