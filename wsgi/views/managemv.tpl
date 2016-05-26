<%
    # -*- coding: utf-8 -*-
    menulist = ([   { 'name' : 'Home' , 'active' : False , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' },
                    { 'name' : 'Administrar Nodo', 'active' : True, 'url' : '/node/MV/%s' % dcdc.centername } ])
    include('header.tpl', title='Administrar Nodo')
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    %  dcdc.FetchNodeList()
    %   for node in dcdc.nodedict['data']:
    %       dcdc.FetchNodeMvs(node['node'])
    <table style="width:100%">
        <tr>
            <th colspan="4"><a href="/node/createMV/{{node['node']}}/{{dcdc.centername}}">
                                <img src="/static/proyecto/style/icon-new.png" alt="Crear Máquina" title="Crear Máquina Virtual"/></a>
                            &nbsp{{node['node']}}
            </th>
        </tr>
        <tr>
            <th>VMID</th>
            <th>Nombre</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    %       for key in dcdc.mvdict.keys():
                <tr>
                    <td>{{dcdc.mvdict[key]['vmid']}}</td>
                    <td>{{dcdc.mvdict[key]['name']}}</td>
                    <td>{{dcdc.mvdict[key]['status']}}</td>
                    <td align="center">
                        &nbsp;
                        % if dcdc.mvdict[key]['status'] == 'stopped':
                            <a href="/node/action/poweron/{{node['node']}}/{{dcdc.mvdict[key]['vmid']}}">
                                <img src="/static/proyecto/style/icon-poweron.png" alt="Encender" title="Encender"/></a>
                            &nbsp;&nbsp;
                            <a href="/node/convert2tpl/{{dcdc.centername}}/{{dcdc.mvdict[key]['vmid']}}">
                                <img src="/static/proyecto/style/icon-conv2tpl.png" alt="Convertir a plantilla" title="Convertir a plantilla"/></a>
                        % else:
                            <a href="/node/action/reset/{{node['node']}}/{{dcdc.mvdict[key]['vmid']}}">
                                <img src="/static/proyecto/style/icon-reset.png" alt="Resetear" title="Resetear"/></a>
                            &nbsp;&nbsp;
                            <a href="/node/action/poweroff/{{node['node']}}/{{dcdc.mvdict[key]['vmid']}}">
                                <img src="/static/proyecto/style/icon-poweroff.png" alt="Apagado brusco" title="Apagado brusco"/></a>
                        % end
                        &nbsp;
                        <a href="/node/action/remove/{{node['node']}}/{{dcdc.mvdict[key]['vmid']}}">
                                <img src="/static/proyecto/style/icon-remove.png" alt="Eliminar Máquina" title="Eliminar Máquina"/></a>
                    </td>
                </tr>
    %       end
    </table>
    %   end
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
