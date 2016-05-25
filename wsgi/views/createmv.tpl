<%
    # -*- coding: utf-8 -*-
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : False, 'url' : '/node/MV/%s' % dcdc.centername },
                    { 'name' : 'Crear MV' , 'active' : True , 'url' : '/node/createMV/%s/%s' % (node, dcdc.centername) } ])
    include('header.tpl', title='Crear Maquina virtual')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    % dcdc.FetchInfoNode(node)
    % for item in dcdc.nodestatusdict.keys():
        <p>{{item}}</p>
    % end
    <%
    '''<table style="width:100%">
        <tr>
            <th colspan="3">{{dcdc.centername}}</th>
        </tr>
        <tr>
            <th rowspan="2">CPU</th>
            <th>Hilos/Núcleos</th>
            <td>{{dcdc.nodestatusdict['cpuinfo']['cpus']}}</td>
        </tr>
        <tr>
            <th>Modelo</th>
            <td>{{dcdc.nodestatusdict['cpuinfo']['model']}}</td>
        </tr>
        <tr>
            <th rowspan="3">Memoria</th>
            <th>Total</th>
            <td>{{dcdc.nodestatusdict['memory']['total']}}</td>
        </tr>
        <tr>
            <th>Usada</th>
            <td>{{dcdc.nodestatusdict['memory']['used']}}</td>
        </tr>
        <tr>
            <th>Libre</th>
            <td>{{dcdc.nodestatusdict['memory']['free']}}</td>
        </tr>
        <tr>
            <th colspan="3">UPTIME</th>
        </tr>
    </table>'''
    %>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
