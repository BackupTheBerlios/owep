<%@page import="owep.controle.CConstante" %>
<%@page import="owep.modele.execution.MRisque" %>
<%@page import="owep.modele.execution.MProjet" %>
<%@page import="owep.modele.execution.MIteration" %>
<%@page import="owep.vue.transfert.convertor.VDateConvertor" %>
<%@page import="owep.vue.transfert.convertor.VStringConvertor" %>
<%@page import="owep.vue.transfert.VTransfertConstante" %>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>


<%
  // Utilis� pour stocker le code javascript.
  String lCodeValidation ;
  
  // R�cup�ration des param�tres.
  MRisque pRisque = (MRisque) request.getAttribute (CConstante.PAR_RISQUE) ;
%>

<center>
<form action="./RisqueModif" method="post" name="<%= CConstante.PAR_FORMULAIRE %>">
  <transfert:transfertbean scope="Session" type="owep.modele.execution.MRisque" bean="<%= CConstante.PAR_RISQUE %>" idArbre="<%= CConstante.PAR_ARBRERISQUE %>">
  <%
  if (pRisque.getId () != 0)
  {
  %>
    <input name="<%= CConstante.PAR_RISQUE %>" type="hidden" value="<%= pRisque.getId () %>">
  <%
  }
  %>
   
  <table class="tableau" width="90%" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td class="caseNiveau1" width="20%">
        <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Libell� du risque.')" onmouseout="tooltipOff(this, event)">Nom *</a>
      </td>
      <td class="caseNiveau3" width="80%">
        <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom du risque" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRERISQUE %>"/>
         class="niveau2" type="text" value="<%= VStringConvertor.getString (pRisque.getNom (), true) %>" size="<%= CConstante.LNG_MOYEN %>" maxlength="<%= CConstante.TXT_MOYEN %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Niveau de gestion du risque (Entam�, R�solu, etc.).')" onmouseout="tooltipOff(this, event)">Etat</a>
      </td>
      <td class="caseNiveau3">
        <input <transfert:transfertchamp membre="setEtat" type="java.lang.String" libelle="Etat du risque" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBRERISQUE %>"/>
         class="niveau2" type="text" value="<%= VStringConvertor.getString (pRisque.getEtat (), true) %>" size="<%= CConstante.LNG_MOYEN %>" maxlength="<%= CConstante.TXT_MOYEN %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description g�n�rale du risque.')" onmouseout="tooltipOff(this, event)">Description</a>
      </td>
      <td class="caseNiveau3">
        <textarea <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description du risque" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBRERISQUE %>"/>
         class="niveau2" rows="<%= CConstante.LNG_ROWSCOMMENTAIRE %>" cols="<%= CConstante.LNG_COLSCOMMENTAIRE %>" maxlength="<%= CConstante.LNG_COMMENTAIRE %>"><%= VStringConvertor.getString (pRisque.getDescription (), true) %></textarea>
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description de l\'impact possible du risque sur le projet.')" onmouseout="tooltipOff(this, event)">Impact</a>
      </td>
      <td class="caseNiveau3">
        <textarea <transfert:transfertchamp membre="setImpact" type="java.lang.String" libelle="Impact" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBRERISQUE %>"/>
         class="niveau2" rows="<%= CConstante.LNG_ROWSCOMMENTAIRE %>" cols="<%= CConstante.LNG_COLSCOMMENTAIRE %>" maxlength="<%= CConstante.LNG_COMMENTAIRE %>"><%= VStringConvertor.getString (pRisque.getImpact (), true) %></textarea>
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description des actions � mener pour g�rer le risque.')" onmouseout="tooltipOff(this, event)">Actions</a>
      </td>
      <td class="caseNiveau3">
        <textarea <transfert:transfertchamp membre="setActions" type="java.lang.String" libelle="Actions" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBRERISQUE %>"/>
         class="niveau2" rows="<%= CConstante.LNG_ROWSCOMMENTAIRE %>" cols="<%= CConstante.LNG_COLSCOMMENTAIRE %>" maxlength="<%= CConstante.LNG_COMMENTAIRE %>"><%= VStringConvertor.getString (pRisque.getActions (), true) %></textarea>
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Degr� d\'importance du risque.')" onmouseout="tooltipOff(this, event)">Priorit� *</a>
      </td>
      <td class="caseNiveau3">
        <input <transfert:transfertchamp membre="setPriorite" type="java.lang.Integer" libelle="Priorit�" convertor="VIntegerConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRERISQUE %>"/>
         type="text" class="niveau2" value="<%= pRisque.getPriorite () %>" size="<%= CConstante.LNG_NUMERO %>" maxlength="<%= CConstante.TXT_NUMERO %>">
      </td>
    </tr>
  </tbody>
  </table>
    
  </transfert:transfertbean>
  
  
  <p class="texteObligatoire">Les champs marqu� d'un * sont obligatoires.</p>
  <p class="texteSubmit">
    <% lCodeValidation = VTransfertConstante.getVerification (CConstante.PAR_ARBRERISQUE) + " () ;" ; %>
    <% lCodeValidation += "validerChamps () ;" ; %>
    <transfert:transfertsubmit libelle="Valider" valeur="<%= CConstante.PAR_SUBMIT %>" verification="true" validation="<%= lCodeValidation %>"
     additionnel="onmouseover=\"tooltipOn(this, event, 'Cliquez pour valider toutes les modifications et revenir � la page liste des risques.')\" onmouseout=\"tooltipOff(this, event)\""/>
    <input type="button" value="Annuler" class="bouton" onclick="window.location.href = '/owep/Gestion/ListeRisqueVisu' ;"
     onmouseover="tooltipOn(this, event, 'Cliquez pour annuler toutes les modifications et revenir � la page liste des risques.')" onmouseout="tooltipOff(this, event)"/>
  </p>

</form>
</center>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>D�tail du risque</b> vous permet de sp�cifier ou de modifier un <b>risque</b> qui pourrait survenir sur votre projet." ;
pCodeAide += " Vous pouvez y <b>d�crire</b> votre risque, ses <b>possibles impacts</b> sur le projet, les <b>actions</b> pour tenter de r�soudre ou de limiter le risque," ;
pCodeAide += " son <b>�tat</b>, c'est � dire son niveau de gestion, et enfin sa <b>priorit�</b> (plus le nombre est faible, plus il est important)." ;
</script>
