<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : True , 'url' : '/controlpanel' } ])
    include('header.tpl', title='Configurar EP', menulist = menulist)
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <h3>Inserte la contraseña de la base de datos:</h3>
    <form action='/createdatacenter' method="post">
            Nombre:<br>
            <input type="text" name="name" autofocus="autofocus">
            URL:<br>
            <input type="text" name="url">
            Usuario:<br>
            <input type="text" name="username">
            Contraseña:<br>
            <input type="password" name="password">
            <input type="submit" value="Enviar">
    </form>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
