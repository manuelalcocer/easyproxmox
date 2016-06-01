<%
    from os import environ

    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Login' , 'active' : True , 'url' : '/login' } ])
    include('header.tpl', title='Login', menulist = menulist)
    include('sidebar.tpl', title='sidebar')

    googleapikey=environ['GOOGLEAPI']
%>
    <div id="content">
    <!-- insert the page content here -->
    <h2>Ingrese datos del Centro de Datos: {{centername}}</h2>
    <form action='/FetchCreds/{{centername}}' method="post">
        <b>Usuario:</b><br>
        <input type="text" name="username" autofocus="autofocus"><br>
        <b>Contraseña:</b><br>
            <input type="password" name="password">
            <input type="submit" value="Enviar">
    </form>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <div class="g-signin2" data-onsuccess="onSignIn"></div>
    </div>
</div>

% include('footer.tpl')
