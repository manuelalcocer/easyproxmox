<%
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
            <th colspan="4">{{node['node']}}</th>
        </tr>
        <tr>
            <th>VMID</th>
            <th>Nombre</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        <tr>
            <td colspan="4"><a href="/node/createMV/{{dcdc.centername}}">Crear máquina</a></td>
        </tr>
    %       for key in dcdc.mvdict.keys():
                <tr>
                    <td>{{dcdc.mvdict[key]['vmid']}}</td>
                    <td>{{dcdc.mvdict[key]['name']}}</td>
                    <td>{{dcdc.mvdict[key]['status']}}</td>
                    <td align="center">
                        &nbsp&nbsp
                        % if dcdc.mvdict[key]['status'] == 'stopped':
                            <a href="/node/power/on/{{dcdc.centername}}/{{dcdc.mvdict[key]['vmid']}}">
                                <img src="/static/proyecto/style/icon-poweron.png" alt="Encender" title="Encender"/></a>
                            <a href="/node/convert2tpl/{{dcdc.centername}}/{{dcdc.mvdict[key]['vmid']}}">
                                <img src="/static/proyecto/style/icon-conv2tpl.png" alt="Convertir a plantilla" title="Convertir a plantilla"/></a>
                        % else:
                            <a href="/node/reset/{{dcdc.centername}}/{{dcdc.mvdict[key]['vmid']}}">
                                <img src="/static/proyecto/style/icon-reset.png" alt="Resetear" title="Resetear"/></a>
                            <a href="/node/power/off/{{dcdc.centername}}/{{dcdc.mvdict[key]['vmid']}}">
                                <img src="/static/proyecto/style/icon-poweroff.png" alt="Apagado brusco" title="Apagado brusco"/></a>
                        % end
                        &nbsp&nbsp
                        <a href="/node/deleteMV/{{dcdc.centername}}/{{dcdc.mvdict[key]['vmid']}}">
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
