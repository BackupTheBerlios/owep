<%@ page language="java" %>
<%@ taglib uri='/WEB-INF/tld/template.tld' prefix='template' %>
<!DOCTYPE HTML PUBLIC "-//w3c//dtd html 4.0 transitional//en">

<!-- en-tête de la page -->
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
  <meta name="author" content="OWEP Team">
  <meta name="description" content="Outil de Workflow pour une équipe de Projet">
  <title>OWEP</title>
  <link rel="stylesheet" href="../../CSS/Standard.css" type="text/css">
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<!-- corps de la page -->
<body>
  <table style="width : 100%" cellpadding="0" cellspacing="0">
  <tbody>
    <tr style="height : 100%">
    
      <!-- colonne de gauche -->
      <td style="width : 170px">
        <table class="panneauGauche" style="width : 100%; height : 100%" cellpadding="0" cellspacing="0">
        <tbody>
        
          <!-- logo de l'application -->
          <tr>
            <td>
              <template:region nom="RegionLogo"/>
            </td>
          </tr>
          
          
          <!-- menu Avancement -->
          <tr>
            <td class="caseMenuListe">
              <template:region nom="RegionMenu"/>
            </td>
          </tr>
        </tbody>
        </table>
      </td>
      
      
      
      <!-- colonne principale -->
      <td style="width : 100%">
        <table class="panneauDroit" style="width : 100%; height : 100%" cellpadding="0" cellspacing="0">
        <tbody style="text-align : left; vertical-align : top">
                
          <!-- messagerie -->
          <tr>
            <td>
              <template:region nom="RegionMessagerie"/>
            </td>
          </tr>
          
          
          <!-- case contenu de la page -->
          <tr style="height: 100%">
            <td class="panneauPrincipal">
              <!-- titre de la page -->
              <center>
                <font class='titrepage'><template:region nom="RegionTitre"/></font>
                <br><br><br><br>
              </center>

              <template:region nom="RegionPrincipal"/>
            </td>
          </tr>
          
          
        </tbody>
        </table>
      </td>
    </tr>
    
    
    <!-- pied de page -->
    <tr>
      <td colspan="2">
        <template:region nom="RegionPied"/>
      </td>
    </tr>
  </tbody>
  </table>
</body>
</html>