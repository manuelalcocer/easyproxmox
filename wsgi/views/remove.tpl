<%
    import eproxlib.proxdatabase as Mydb
    from eproxlib.datacenter import sset, sget, sdelete, sislogin

    menulist = ([   { 'name' : 'Home' , 'active' : True , 'url' : '/' },
                    { 'name' : 'Configurar EP' , 'active' : False , 'url' : '/configureEP' } ])
    include('header.tpl', title='Home', menulist = menulist)
    include('sidebar.tpl', title='sidebar')
%>
    <div id="content">
    <!-- insert the page content here -->
    <h1>Está seguro de querer borrar: <br>
    <b>MV: {{vmid}} Nodo: {{node}}</b><br>
    % mvname = dcdc.mvdict[int(vmid)]['name']
    <b>Nombre: {{mvname}}</b></h1>
    <br>
    <form action='/deletenow' method="post">
        <input type="hidden" name="node" value="{{node}}" />
        <input type="hidden" name="vmid" value="{{vmid}}" />
        <button type="submit" value="delete">Eliminar</button>
    <form>
    <!-- to here -->
    </div>
</div>
% include('footer.tpl')
