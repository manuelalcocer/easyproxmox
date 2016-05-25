<%
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : False, 'url' : '/node/MV/%s' % dcdc.centername },
                    { 'name' : 'Crear MV' , 'active' : True , 'url' : '/node/createMV/%s/%s' % (node, dcdc.centername) } ])
    include('header.tpl', title='Crear Máquina virtual')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    % dcdc.FetchInfoNode(node)
    <table style="width:100%">
        <tr>
            <th colspan="3">{{dcdc.centername}}</th>
        </tr>
        <tr>
            <th rowspan="2">CPU</th>
            <th>Cant.</th>
            <td>4</td>
        </tr>
        <tr>
            <th>Modelo</th>
            <td>AMD FX8</td>
        </tr>
        <tr>
            <th colspan="3">UPTIME</th>
        </tr>
    </table>

    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
