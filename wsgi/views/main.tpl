<%
    import eproxlib.proxdatabase as Mydb

    menulist = ([   { 'name' : 'Home' , 'active' : True , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' } ])
    include('header.tpl', title='Home', menulist = menulist)
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    % conn, cur = Mydb.CreateConn(dcdb)
    % datacenterlist = Mydb.DataCenterList(conn, cur)
    % if len(datacenterlist) >= 1:
            <ul>
    %   for linea in dcdb.datacenter['list']:
            <li><a href="/login/{{linea[0]}}">{{linea[0]}}</a></li>
    %   end
            </ul>
    % else:
            <h3>No Hay ningún <b>Centro de Datos</b> configurado.</h3>
            <p>Vaya a <a href="/configureEP">Configurar EP</a>.</p>
    % end
    % Mydb.CloseConn(conn, cur)
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
