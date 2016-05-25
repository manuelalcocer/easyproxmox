<%
    # -*- coding: utf-8 -*-
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : True, 'url' : '/node/MV/%s' % dcdc.centername },
                    { 'name' : 'Descargar ISO' , 'active' : True, 'url' : '/downloadiso/%s' % node }])
    include('header.tpl', title='Descargar ISO')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <form action='/downloadnow/{{node}}' method="post">
    <b>URL de la ISO:</b><br>
            <input type="text" name="URL" autofocus="autofocus"><br>
            <input type="submit" value="Descargar Ahora">
    </form>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
