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
    % dcdc.FetchNodeList()
    % dcdc.FetchNodeMvs(dcdc.nodedict['data']['node'])
    % for key in dcdc.mvdict.keys():
        <p>{{key}} : {{dcdc.nodedict[key]}}</p>
    % end
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
