% newvmid = 200
% while str(newvmid) in dcdc.mvdict.keys() and str(newvmid) in dcdc.tpldict.keys():
%   newvmid = newvmid + 1
% end
<form action='/createnow' method="post">
    <input type="hidden" name="node" value="{{node}}" />
    <input type="hidden" name="pool" value="easyproxmox" />
    <input type="hidden" name="vmid" value="{{newvmid}}" />
    <fieldset>
        <legend><b>General</b></legend>
        <br>
            &nbsp;<b>vmid</b><br>
            &nbsp;<input type="text" name="vmiddisable" value="{{newvmid}}" disabled><br>
            <br>&nbsp;<b>Nombre</b><br>
            &nbsp;<input type="text" name="name" autofocus="autofocus"><br>
            <br>&nbsp;<b>Conjunto de recursos</b><br>
            &nbsp;<input type="text" name="pooldisable" value="easyproxmox" disabled><br>
        <br>
    </fieldset>
        <br>
    <fieldset>
        <legend><b>Sistema Operativo</b></legend>
        <%  ossytems = ([   { '8' : 'Linux <=2.4' },
                            { '9' : 'Linux >=2.6' },
                            { '6' : 'Windows 7' },
                            { '7' : 'Windows 8/10/2012' },
                            { '0' : 'Sin especificar' } ])
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
        <legend><b>Unidad de CD</b></legend>
        <br>
            &nbsp;<label for='volume'><b>Imagen ISO</b></label><br>
            &nbsp;<select id="volume" name="volume">
                    <option value="none">CD-Rom Vacío</option>
            <%
                dcdc.FetchIsoList(node, 'isos_rapidas')
                for iso in dcdc.isoslist:
                    if iso['content'] == 'iso' and iso['format'] == 'iso':
            %>
                    <option value="{{iso['volid']}}">{{iso['volid'][(len('isos_rapidas:iso')+1):]}}</option>
            %       end
            %   end
            </select><br>
        <br>
    </fieldset>
        <br>
    <fieldset>
        <legend><b>Disco Duro</b></legend>
        <br>
            &nbsp;<label for="hddtype"><b>Tipo de bus</b></label><br>
            &nbsp;<select id="hddtype" name="hddtype">
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
        <legend><b>CPU</b></legend>
        <br>
            &nbsp;<label for="cpu"><b>Núcleos</b></label><br>
            &nbsp;<select id="cpu" name="cores">
            % for ncore in xrange(1,int(dcdc.nodestatusdict['cpuinfo']['cpus']) + 1):
                <option value="{{ncore}}">{{ncore}}</option>
            % end
            </select><br>
        <br>
    </fieldset>
        <br>
    <fieldset>
        <legend><b>Memoria</b></legend>
        <br>
            &nbsp;<b>Tamaño (MB)</b><br>
            &nbsp;<input type="text" name="memsize"><br>
        <br>
    </fieldset>
    <br>
    <br>
    <input type="submit" value="Crear">
</form>
