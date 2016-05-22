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
        <li><a href="/manage/MV/{{name}}"></a>Máquinas virtuales</li>
        <li><a href="/manage/LXC/{{name}}"></a>Contenedores</li>
        <li><a href="/manage/TPL/{{name}}"></a>Plantillas</li>
    </ul>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
