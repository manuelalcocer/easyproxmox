% newvmid = 100
% while newvmid in dcdc.mvdict.keys() and newvmid in dcdc.tpldict.keys():
%   newvmid = newvmid + 1
% end
<form action='/createdatacenter' method="post">
        <fieldset>
            <legend>General</legend>
            <b>vmid</b><br>
            <input type="text" name="vmid" value="{{newvmid}}" disabled><br>
            <b>Nombre</b><br>
            <input type="text" name="name" autofocus="autofocus"><br>
            <b>Conjunto de recursos</b><br>
            <input type="text" name="pool" value="easyproxmox" disabled><br>
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
                <input type="radio" name="ossytem" value="{{key}}">{{ossys[key]}}</input><br>
            % end
        </fieldset>
</form>
