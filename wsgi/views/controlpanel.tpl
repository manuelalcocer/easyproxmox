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
            <b>Nombre:</b><br>
            <input type="text" name="name" autofocus="autofocus"><br>
            https://<input type="text" name="url"><br>
            <b>Puerto:</b><br>
            <input type="text" name="port" value="443"><br>
            <b>Usuario:</b><br>
            <input type="text" name="username"><br>
            <b>Contraseña:</b><br>
            <input type="password" name="password"><br>
            <input type="submit" value="Crear">
    </form>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
