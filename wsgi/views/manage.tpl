<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : True, 'url' : '/manage/%s' % name}])
    include('header.tpl', title='Administrar Nodo')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <ul>
        <li><a href="/manage/MV/{{name}}">Máquinas virtuales</a></li>
        <li><a href="/manage/LXC/{{name}}">Contenedores</a></li>
        <li><a href="/manage/TPL/{{name}}">Plantillas</a></li>
    </ul>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
