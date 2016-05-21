<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : True , 'url' : '/configureEP' } ])
    include('header.tpl', title='Configurar EP', menulist = menulist)
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <h3>Inserte la contraseña de la base de datos:</h3>
    <form action='/controlpanel' method="post">
        Contraseña:<br>
            <input type="password" name="password" autofocus="autofocus">
            <input type="submit" value="Enviar">
    </form>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
