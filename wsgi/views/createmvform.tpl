% newvmid = 100
% while newvmid in dcdc.mvdict.keys() and newvmid in dcdc.tpldict.keys():
%   newvmid = newvmid + 1
% end
<form action='/createnow' method="post">
    <input type="hidden" name="node" value="{{node}}" />
    <input type="hidden" name="datacenter" value="{{dcdc.datacenter}}" />
    <input type="hidden" name="pool" value="easyproxmox" />
        <fieldset>
            <legend>General</legend>
            <br>
                &nbsp;<b>vmid</b><br>
                &nbsp;<input type="text" name="vmid" value="{{newvmid}}" disabled><br>
                <br>&nbsp;<b>Nombre</b><br>
                &nbsp;<input type="text" name="name" autofocus="autofocus"><br>
                <br>&nbsp;<b>Conjunto de recursos</b><br>
                &nbsp;<input type="text" name="pooldisable" value="easyproxmox" disabled><br>
            <br>
        </fieldset>
        <br>
        <fieldset>
            <legend>Sistema Operativo</legend>
            <%  ossytems = ([   { 'win8' : 'Windows 8/10/2012' },
                                { 'win7' : 'Windows 7' },
                                { 'l24' : 'Linux 2.4' },
                                { 'l26' : 'Linux 2.6' },
                                { 'other' : 'Sin especificar' }])
                for ossys in ossytems:
                    key = ossys.keys()[0]
            %>
                <br>
                &nbsp;<input type="radio" name="ossytem" value="{{key}}">{{ossys[key]}}</input><br>
            % end
            <br>
        </fieldset>
        <br>
        <fieldset>
            <legend>Unidad de CD</legend>
            <br>
                &nbsp;<label for='isoimage'>Imagen ISO</label><br>
                &nbsp;<select id="isoimage" name="isoimage">
                        <option value="none">CD-Rom Vacío</option>
                <%
                    dcdc.FetchIsoList(node, 'isos_rapidas')
                    for iso in dcdc.isoslist:
                        if iso['content'] == 'iso' and iso['format'] == 'iso':
                %>
                        <option value="{{iso['volid']}}">{{iso['volid'][len('isos_rapidas:iso'):]}}</option>
                %       end
                %   end
                </select><br>
            <br>
        </fieldset>
        <br>
        <fieldset>
            <legend>Disco Duro</legend>
            <br>
                &nbsp;<select id="harddisk" name="harddisk">
                        <option value="virtio">Virtio</option>
                        <option value="sata">SATA</option>
                </select><br>
            <br>
                &nbsp;<b>Tamaño (GB)</b><br>
                &nbsp;<input type="text" name="hddsize"><br>
            <br>
        </fieldset>
        <br>
        <fieldset>
            <legend>CPU</legend>
            <br>
                &nbsp;<label for="cpu">Núcleos</label><br>
                &nbsp;<select id="cpu" name="harddisk">
                % for ncore in xrange(int(dcdc.nodestatusdict['cpuinfo']['cpus']) + 1):
                    <option value="ncore">{{ncore}}</option>
                % end
                </select><br>
            <br>
        </fieldset>
        <br>
        <fieldset>
            <legend>Memoria</legend>
            <br>
                &nbsp;<b>Tamaño (GB)</b><br>
                &nbsp;<input type="text" name="memsize"><br>
            <br>
        </fieldset>
</form>
