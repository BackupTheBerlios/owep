<%@ page language="java" %>
<%@ taglib uri='/WEB-INF/tld/template.tld' prefix='template' %>
<%@page import="owep.controle.CConstante"%>

<!-- en-t�te de la page -->
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
  <meta name="author" content="OWEP Team">
  <meta name="description" content="Outil de Workflow pour une �quipe de Projet">
  <title>OWEP</title>
  <link rel="stylesheet" href="../CSS/Red.css" type="text/css">
  <script language="javascript" src="/owep/JavaScript/VerificationChamp.js"></script>
  <script language="javascript" src="/owep/JavaScript/AideEnLigne.js"></script>
  <script language="javascript" src="/owep/JavaScript/DomTT/domLib.js"></script>
  <script language="javascript" src="/owep/JavaScript/DomTT/alphaAPI.js"></script>
  <script language="javascript" src="/owep/JavaScript/DomTT/domTT.js"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<!-- corps de la page -->
<body>
  <table cellpadding="0" height="100%" cellspacing="0">
  <tbody>
    <tr>
    
      <!-- colonne de gauche -->
      <td class="regionGauche" height="100%">
        <table class="regionIdentificationGauche" cellpadding="0" cellspacing="0">
        <tbody>
        
          <!-- logo de l'application -->
          <tr>
            <td class="regionIdentificationPrincipal">
              <img src="/owep/Image/Vide.gif" class="logoIdentification">
            </td>
          </tr>
          
        </tbody>
        </table>
      </td>
      
      
      
      <!-- colonne principale -->
      <td height="100%" width="100%">
        <table class="regionIdentificationDroite" cellpadding="0" cellspacing="0">
        <tbody>
                
          <tr>
            <td class="regionIdentificationPrincipal">
              <table>
                <tr>
                  <td class="titre" width="100%">
                    <template:region nom="RegionTitre"/>
                  </td>
                  <td>
                    <a onclick="afficherAide (pCodeAide)">
                      <img src="/owep/Image/Vide.gif" class="iconeAide" onmouseout="tooltipOff(this, event)"
                       onmouseover="tooltipTitreOn(this, event, 'Aide en ligne', 'Cliquez pour afficher de l\'aide sur cette page.')"/>
                    </a>
                  </td>
                </tr>
                <tr>
                  <td class="caseAide" colspan="2">
                    <div id="regionAide">
                    </div>
                  </td>
                </tr>
              <%
                String lMessage = (String) request.getAttribute (CConstante.PAR_MESSAGE) ;
                if (lMessage != null)
                {
              %>
                <tr>
                  <td class="texteMessage" width="100%">
                      <%= lMessage %>
                  </td>
                </tr>
              <%
                }
              %>
              </table>
              <br/>
              <template:region nom="RegionNavigation"/>
              <template:region nom="RegionPrincipal"/>
            </td>
          </tr>
          
          
        </tbody>
        </table>
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