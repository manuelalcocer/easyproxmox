<!DOCTYPE HTML>
<html>

<head>
  <title>EasyProxmox</title>
  <meta name="description" content="Recursos web de proxmox" />
  <meta name="keywords" content="proxmox,web,api" />
  <meta charset="UTF-8">
  <link rel="stylesheet" type="text/css" href="/static/proyecto/style/style.css" title="style" />
</head>

<body>
  <div id="main">
    <div id="header">
      <div id="logo">
        <div id="logo_text">
          <!-- class="logo_colour", allows you to change the colour of the text -->
          <h1><a href="/">Easy<span class="logo_colour">Proxmox</span></a></h1>
          <h2>Interfaz amigable para Proxmox.</h2>
        </div>
      </div>
      <div id="menubar">
        <ul id="menu">
          <!-- put class="selected" in the li tag for the selected page - to highlight which page you're on -->
            % for element in menulist:
            %   if element['active']:
                    <li class="selected"><a href="{{element['url']}}">{{element['name']}}</a></li>
            %   else:
                    <li><a href="{{element['url']}}">{{element['name']}}</a></li>
            %   end
            % end
        </ul>
      </div>
    </div>
    <div id="site_content">
