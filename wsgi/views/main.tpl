<%
    menulist = ([   { 'name' : 'Home' , 'active' : True , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' } ])
    include('header.tpl', title='Configurar EP', menulist = menulist)
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
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
