<%
    menulist = ([   { 'name' : 'Home' , 'active' : True , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' } ])
    include('header.tpl', title='Configurar EP', menulist = menulist)
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    % if len(datacenterlist) >= 1:
            <ul>
    %   for linea in datacenterlist:
            <il> {{linea}} </il>
    %   end
            </ul>
    % else:
            <h2>No Hay ningún <b>Centro de Datos</b> configurado.</h2>
            <h3>Vaya a <a href="/configureEP">Configurar EP</a>.</h3>
    % end
    </div>
</div>
% include('footer.tpl')