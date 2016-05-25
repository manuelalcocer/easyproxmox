<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : True, 'url' : '/manage/%s' % dcdc.centername}])
    include('header.tpl', title='Administrar Nodo')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <ul>
        <li><a href="/node/MV/{{dcdc.centername}}">Máquinas virtuales</a></li>
        <li><a href="/node/LXC/{{dcdc.centername}}">Contenedores</a></li>
        <li><a href="/node/TPL/{{dcdc.centername}}">Plantillas</a></li>
    </ul>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
