<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : False, 'url' : '/node/MV/%s' % dcdc.centername },
                    { 'name' : 'Crear MV' , 'active' : True , 'url' : '/node/createMV/%s' % dcdc.centername } ])
    include('header.tpl', title='Administrar Nodo')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <h3>{{dcdc.centername}} Info:</h3>

    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
