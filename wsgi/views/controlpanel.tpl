<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : True , 'url' : '/controlpanel' } ])
    include('header.tpl', title='Configurar EP', menulist = menulist)
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <h3>Inserte los datos del servidor Proxmox:</h3>
    <form action='/createdatacenter' method="post">
            Nombre:<br>
            <input type="text" name="name" autofocus="autofocus"><br>
            URL:<br>
            <input type="text" name="url" value="https://"><br>
            Puerto:<br>
            <input type="text" name="port" value="443"><br>
            Usuario:<br>
            <input type="text" name="username"><br>
            Contraseña:<br>
            <input type="password" name="password"><br>
            <input type="submit" value="Enviar">
    </form>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
