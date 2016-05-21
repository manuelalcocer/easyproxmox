<%
    menulist = ([   { 'name' : 'Home' , 'active' : True , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' } ])
    include('header.tpl', title='Configurar EP', menulist = menulist)
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <form action='/fetchtoken' method="post">
        Usuario:<br>
            <input type="text" name="username" autofocus="autofocus"><br>
        Contraseña:<br>
            <input type="password" name="password">
            <input type="submit" value="Enviar">
    </form>
    </div>
</div>

% include('footer.tpl')
