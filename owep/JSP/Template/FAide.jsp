<%@ page language="java" %>
<%@ taglib uri='/WEB-INF/tld/template.tld' prefix='template' %>

<!-- en-tête de la page -->
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
  <meta name="author" content="OWEP Team">
  <meta name="description" content="Outil de Workflow pour une équipe de Projet">
  <title>OWEP</title>
  <link rel="stylesheet" href="/owep/CSS/Red.css" type="text/css">
  <script language="javascript" src="/owep/JavaScript/AideEnLigne.js"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<!-- corps de la page -->
<body>
  <table cellpadding="0" cellspacing="0" height="100%" width="100%">
  <tbody>
    <tr>
      <td class="regionAidePrincipal" height="100%">
        <table width="100%">
        <tbody>
          <tr>
            <td class="titre">
              <template:region nom="RegionTitre"/>
            </td>
          </tr>
        </table>
        <br/>
        <br/>
        <template:region nom="RegionPrincipal"/>
      </td>
    </tr>
    
    <!-- pied de page -->
    <tr>
      <td class="regionPied" colspan="2">
        <p class="pied">IUP ISI 2004/2005</p>
      </td>
    </tr>
  </tbody>
  </table>
</body>
</html>