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
        % dcdb.Actualize()
    % if len(dcdb.datacenter['list']) >= 1:
            <ul>
    %   for linea in dcdb.datacenter['list']:
            <li><a href="/manage/{{linea[0]}}">{{linea[0]}}</a></li>
    %   end
            </ul>
    % else:
            <h3>No Hay ningún <b>Centro de Datos</b> configurado.</h3>
            <p>Vaya a <a href="/configureEP">Configurar EP</a>.</p>
    % end
    </div>
</div>
% include('footer.tpl')
