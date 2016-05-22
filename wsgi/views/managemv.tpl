<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : True, 'url' : '/node/MV/%s' % name}])
    include('header.tpl', title='Administrar Nodo', menulist = menulist)
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <h1>Máquinas virtuales</h1>
    <ul>
        <li><a href="/node/MV/create/{{name}}">Crear Máquina</a></li>
    </ul>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
