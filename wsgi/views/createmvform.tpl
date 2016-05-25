% newvmid = 100
% while newvmid in dcdc.mvdict.keys() and newvmid in dcdc.tpldict.keys():
%   newvmid = newvmid + 1
% end
<form action='/createdatacenter' method="post">
        <fieldset>
            <legend>General</legend>
            <br><b>vmid</b><br>
            <input type="text" name="vmid" value="{{newvmid}}" disabled><br>
            <br><b>Nombre</b><br>
            <input type="text" name="name" autofocus="autofocus"><br>
            <br><b>Conjunto de recursos</b><br>
            <input type="text" name="pool" value="easyproxmox" disabled><br>
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
                <input type="radio" name="ossytem" value="{{key}}">{{ossys[key]}}</input><br>
            % end
            <br>
        </fieldset>
        <br>
        <fieldset>
            <legend>Unidad de CD</legend>
            <label for='isoimage'>Imagen ISO</label>
            <select id="isoimage" name="isoimage">
            <%
                dcdc.FetchIsoList(node)
                for iso in dcdc.isoslist:
                    if iso['content'] == 'iso' and iso['format'] == 'iso':
            %>
                <option value="{{iso['volid']}}">{{iso['volid'].lstrip(':iso/')}}</option>
            %       end
            %   end
            </select>
        </fieldset>
</form>
