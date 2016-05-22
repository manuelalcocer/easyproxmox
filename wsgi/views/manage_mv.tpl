<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : True, 'url' : '/manage/%s' % name}])
    include('header.tpl', title='Administrar Nodo')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <h1>Máquinas virtuales</h1>
    <ul>
        <li><a href="/manage/MV/create/{{name}}">Crear Máquina</a></li>
    </ul>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
