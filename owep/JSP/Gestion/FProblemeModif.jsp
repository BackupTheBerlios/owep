<%@page import="owep.controle.CConstante" %>
<%@page import="owep.modele.execution.MProbleme" %>
<%@page import="owep.modele.execution.MTache" %>
<%@page import="owep.vue.transfert.convertor.VDateConvertor" %>
<%@page import="owep.vue.transfert.VTransfertConstante" %>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>


<%
  // Utilisé pour stocker le code javascript.
  String lCodeValidation ;
  
  // Récupération des paramètres.
  MProbleme pProbleme = (MProbleme) request.getAttribute (CConstante.PAR_PROBLEME) ;
%>

<center>
<form action="./ProblemeModif" method="post" name="<%= CConstante.PAR_FORMULAIRE %>">
  <transfert:transfertbean scope="Session" type="owep.modele.execution.MProbleme" bean="<%= CConstante.PAR_PROBLEME %>" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>">
  <%
  if (pProbleme.getId () != 0)
  {
  %>
    <input name="<%= CConstante.PAR_PROBLEME %>" type="hidden" value="<%= pProbleme.getId () %>">
  <%
  }
  %>
   
  <table class="tableau" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td class="caseNiveau1" width="20%">
        Nom *
      </td>
      <td class="caseNiveau3" width="80%" colspan="3">
        <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom du problème" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" type="text" value="<%= pProbleme.getNom () %>" size="<%= CConstante.LNG_MOYEN %>" maxlength="<%= CConstante.TXT_MOYEN %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        Etat
      </td>
      <td class="caseNiveau3" colspan="3">
        <input <transfert:transfertchamp membre="setEtat" type="java.lang.String" libelle="Etat du problème" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" type="text" value="<%= pProbleme.getEtat () %>" size="<%= CConstante.LNG_MOYEN %>" maxlength="<%= CConstante.TXT_MOYEN %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        Description
      </td>
      <td class="caseNiveau3" colspan="3">
        <textarea  <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description du problème" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" rows="4" cols="<%= CConstante.LNG_LARGE %>" maxlength="<%= CConstante.TXT_LARGE %>"><%= pProbleme.getDescription () %></textarea>
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        Date<br/>d'identification *
      </td>
      <td class="caseNiveau3" colspan="3">
        <input <transfert:transfertchamp membre="setDateIdentification" type="java.lang.Date" libelle="Date d\\'identification" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" type="text" value="<%= VDateConvertor.getString (pProbleme.getDateIdentification (), true) %>" size="<%= CConstante.LNG_DATE %>" maxlength="<%= CConstante.TXT_DATE %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        Date de clôture
      </td>
      <td class="caseNiveau3" colspan="3">
        <input <transfert:transfertchamp membre="setDateCloture" type="java.lang.Date" libelle="Date de clôture" convertor="VDateConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         type="text" class="niveau2" value="<%= VDateConvertor.getString (pProbleme.getDateCloture (), true) %>" size="<%= CConstante.LNG_DATE %>" maxlength="<%= CConstante.TXT_DATE %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        Tâches à l'origine<br/>du problème *
      </td>
      <td class="caseNiveau3">
        <font class="titre3">Tâches choisies :</font><br/>
        <select name="pSelectTachesProvoque" class="niveau2" style="width: 250" size="6">
        <%
        for (int lIndiceTache = 0; lIndiceTache < pProbleme.getNbTachesProvoque (); lIndiceTache ++)
        {
          MTache lTache = pProbleme.getTacheProvoque (lIndiceTache) ;
        %>
          <option value="<%= lTache.getId () %>"> <%= lTache.getNom () %> </option>
        <%
        }
        %>
        </select>
      </td>
      <td class="caseNiveau3" align="center" valign="middle" width="0" style="border-width : 0px 0px 1px 0px ;">
        <font class="titre3">&nbsp;</font><br/>
        <input type="button" value="    < Ajouter    " class="bouton" onclick="transfererItem (document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesProvoquePossible, document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesProvoque) ;"/>
        <br/>
        <input type="button" value="Supprimer >" class="bouton" onclick="transfererItem (document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesProvoque, document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesProvoquePossible) ;"/>
      </td>
      <td class="caseNiveau3" style="border-width : 0px 0px 1px 0px ;">
        <font class="titre3">Tâches possibles :</font><br/>
        <select name="pSelectTachesProvoquePossible" class="niveau2" style="width: 250" size="6">
        </select>
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        Tâches de résolution<br/>du problème
      </td>
      <td class="caseNiveau3">
        <font class="titre3">Tâches choisies :</font><br/>
        <select name="pSelectTachesResout" class="niveau2" style="width: 250" size="6">
        <%
        for (int lIndiceTache = 0; lIndiceTache < pProbleme.getNbTachesResout (); lIndiceTache ++)
        {
          MTache lTache = pProbleme.getTacheResout (lIndiceTache) ;
        %>
          <option value="<%= lTache.getId () %>"> <%= lTache.getNom () %> </option>
        <%
        }
        %>
        </select>
      </td>
      <td class="caseNiveau3" align="center" valign="middle" width="0" style="border-width : 0px 0px 1px 0px ;">
        <font class="titre3">&nbsp;</font><br/>
        <input type="button" value="    < Ajouter    " class="bouton" onclick="transfererItem (document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesResoutPossible, document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesResout)"/>
        <br/>
        <input type="button" value="Supprimer >" class="bouton" onclick="transfererItem (document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesResout, document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesResoutPossible)"/>
      </td>
      <td class="caseNiveau3" style="border-width : 0px 0px 1px 0px ;">
        <font class="titre3">Tâches possibles :</font><br/>
        <select name="pSelectTachesResoutPossible" class="niveau2" style="width: 250" size="6">
        </select>
      </td>
    </tr>
  </tbody>
  </table>
  </transfert:transfertbean>
  
  <p class="texteObligatoire">Les champs marqué d'un * sont obligatoires.</p>
  <p class="texteSubmit">
    <input name="<%= CConstante.PAR_LISTETACHESPROVOQUE %>" type="hidden" value=""/>
    <input name="<%= CConstante.PAR_LISTETACHESRESOUT %>" type="hidden" value=""/>
    
    <input type="button" value="Annuler" class="bouton" onclick="window.location.href = '/owep/Gestion/ListeProblemeVisu' ;"/>
    <% lCodeValidation = VTransfertConstante.getVerification (CConstante.PAR_ARBREPROBLEME)+ " () ;" ; %>
    <% lCodeValidation += "submitListesTaches (pSelectTachesProvoque, " + CConstante.PAR_LISTETACHESPROVOQUE + ") ;" ; %>
    <% lCodeValidation += "submitListesTaches (pSelectTachesResout, " + CConstante.PAR_LISTETACHESRESOUT + ") ;" ; %>
    <% lCodeValidation += "validerChamps () ;" ; %>
    <transfert:transfertsubmit libelle="Valider" valeur="<%= CConstante.PAR_SUBMIT %>" verification="true" validation="<%= lCodeValidation %>"/>
  </p>

</form>
</center>




<!-- Code javascript -->
<script type="text/javascript" language="JavaScript">

  <!----------------------------------------------------------------------->
  <!-- Fonctions de validation des boutons d'ajout/suppression de tâches -->
  <!----------------------------------------------------------------------->
  function validerAjoutSupprTache (pIndice, pMessage)
  {
    if (pIndice != -1)
    {
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREPROBLEME) %> () ;
      validerChamps () ;
    }
    else
    {
      alert (pMessage) ;
    }
  }
  
  function submitListesTaches (pSelect, pHidden)
  {
    pHidden.value = "" ;
    for (i = 0; i < pSelect.length; i ++)
    {
      pHidden.value = pHidden.value + "-" + pSelect[i].value ;
    }
  }
  
</script>