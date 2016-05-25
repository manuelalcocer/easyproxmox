<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : True, 'url' : '/node/MV/%s' % dcdc.centername } ])
    include('header.tpl', title='Administrar Nodo')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <ul>
        <li><a href="/node/createMV/{{dcdc.centername}}">Crear máquina</a></li>
    </ul>
    <%  dcdc.FetchNodeList()
        <ul>
        for node in dcdc.nodedict['data']:
            dcdc.FetchNodeMvs(node['node'])
            for mv in dcdc.mvdict['data']:
    %>
                <li>{{mv['vmid']}} : {{mv['name']}} - Status: {{mv['status']}}</li>
    %   end
    % end
    </ul>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
