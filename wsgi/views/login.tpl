<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Login' , 'active' : True , 'url' : '/login' } ])
    include('header.tpl', title='Login', menulist = menulist)
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <h2>Ingrese datos del Centro de Datos: {{centername}}</h2>
    <form action='/login/{{centername}}' method="post">
        Usuario:<br>
        <input type="text" name="username" autofocus="autofocus"><br>
        Contraseña:<br>
            <input type="password" name="password">
            <input type="submit" value="Enviar">
    </form>
    </div>
</div>

% include('footer.tpl')
