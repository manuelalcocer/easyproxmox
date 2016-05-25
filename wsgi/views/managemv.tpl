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
    % for indice in dcdc.nodedict['data']:
    %   dcdc.FetchNodeMvs(dcdc.nodedict['data'][indice]['node'])
    %       for key in dcdc.mvdict.keys():
                <p>{{key}} : {{dcdc.mvdict[key]}}</p>
    %       end
    % end
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
