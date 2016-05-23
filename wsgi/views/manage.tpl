<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : True, 'url' : '/manage/%s' % centername}])
    include('header.tpl', title='Administrar Nodo')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <ul>
        <li><a href="/node/MV/{{centername}}">Máquinas virtuales</a></li>
        <li><a href="/node/LXC/{{centername}}">Contenedores</a></li>
        <li><a href="/node/TPL/{{centername}}">Plantillas</a></li>
    </ul>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
