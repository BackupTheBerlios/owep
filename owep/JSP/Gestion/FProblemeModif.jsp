<%@page import="owep.controle.CConstante" %>
<%@page import="owep.modele.execution.MProbleme" %>
<%@page import="owep.modele.execution.MProjet" %>
<%@page import="owep.modele.execution.MIteration" %>
<%@page import="owep.modele.execution.MTache" %>
<%@page import="owep.vue.transfert.convertor.VDateConvertor" %>
<%@page import="owep.vue.transfert.convertor.VStringConvertor" %>
<%@page import="owep.vue.transfert.VTransfertConstante" %>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>


<%
  // Utilis� pour stocker le code javascript.
  String lCodeValidation ;
  
  // R�cup�ration des param�tres.
  MProbleme pProbleme = (MProbleme) request.getAttribute (CConstante.PAR_PROBLEME) ;
  MProjet   pProjet   = (MProjet)   request.getAttribute (CConstante.PAR_PROJET) ;
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
        <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom du probl�me" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" type="text" value="<%= VStringConvertor.getString (pProbleme.getNom (), true) %>" size="<%= CConstante.LNG_MOYEN %>" maxlength="<%= CConstante.TXT_MOYEN %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        Etat
      </td>
      <td class="caseNiveau3" colspan="3">
        <input <transfert:transfertchamp membre="setEtat" type="java.lang.String" libelle="Etat du probl�me" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" type="text" value="<%= VStringConvertor.getString (pProbleme.getEtat (), true) %>" size="<%= CConstante.LNG_MOYEN %>" maxlength="<%= CConstante.TXT_MOYEN %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        Description
      </td>
      <td class="caseNiveau3" colspan="3">
        <textarea  <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description du probl�me" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" rows="4" cols="<%= CConstante.LNG_LARGE %>" maxlength="<%= CConstante.TXT_LARGE %>"><%= VStringConvertor.getString (pProbleme.getDescription (), true) %></textarea>
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
        Date de cl�ture
      </td>
      <td class="caseNiveau3" colspan="3">
        <input <transfert:transfertchamp membre="setDateCloture" type="java.lang.Date" libelle="Date de cl�ture" convertor="VDateConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         type="text" class="niveau2" value="<%= VDateConvertor.getString (pProbleme.getDateCloture (), true) %>" size="<%= CConstante.LNG_DATE %>" maxlength="<%= CConstante.TXT_DATE %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        T�ches � l'origine<br/>du probl�me *
      </td>
      <td class="caseNiveau3">
        <font class="titre3">T�ches choisies :</font><br/>
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
        <font class="titre3">T�ches possibles :</font><br/>
        <select name="pSelectTachesProvoquePossible" class="niveau2" style="width: 250" size="6">
        <%
        // Parcours l'ensemble des t�ches du projet.
        for (int lIndiceIteration = 0; lIndiceIteration < pProjet.getNbIterations (); lIndiceIteration ++)
        {
          MIteration lIteration = pProjet.getIteration (lIndiceIteration) ;
          for (int lIndiceTache = 0; lIndiceTache < lIteration.getNbTaches (); lIndiceTache ++)
          {
            MTache lTache = lIteration.getTache (lIndiceTache) ;
            
            // V�rifie que la t�che n'appartient pas au probl�me.
            boolean lTrouve = false ;
            for (int lIndicePbTache = 0; lIndicePbTache < pProbleme.getNbTachesProvoque (); lIndicePbTache ++)
            {
              if (pProbleme.getTacheProvoque (lIndicePbTache).getId () == lTache.getId ())
              {
                lTrouve = true ;
              }
            }
            
            // Si la t�che n'appartient pas au probleme.
            if (! lTrouve)
            {
        %>
          <option value="<%= lTache.getId () %>"> <%= lTache.getNom () %> </option>
        <%
            }
          }
        }
        %>
        </select>
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        T�ches de r�solution<br/>du probl�me
      </td>
      <td class="caseNiveau3">
        <font class="titre3">T�ches choisies :</font><br/>
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
        <font class="titre3">T�ches possibles :</font><br/>
        <select name="pSelectTachesResoutPossible" class="niveau2" style="width: 250" size="6">
        <%
        // Parcours l'ensemble des t�ches du projet.
        for (int lIndiceIteration = 0; lIndiceIteration < pProjet.getNbIterations (); lIndiceIteration ++)
        {
          MIteration lIteration = pProjet.getIteration (lIndiceIteration) ;
          for (int lIndiceTache = 0; lIndiceTache < lIteration.getNbTaches (); lIndiceTache ++)
          {
            MTache lTache = lIteration.getTache (lIndiceTache) ;
            
            // V�rifie que la t�che n'appartient pas au probl�me.
            boolean lTrouve = false ;
            for (int lIndicePbTache = 0; lIndicePbTache < pProbleme.getNbTachesResout (); lIndicePbTache ++)
            {
              if (pProbleme.getTacheResout (lIndicePbTache).getId () == lTache.getId ())
              {
                lTrouve = true ;
              }
            }
            
            // Si la t�che n'appartient pas au probleme.
            if (! lTrouve)
            {
        %>
          <option value="<%= lTache.getId () %>"> <%= lTache.getNom () %> </option>
        <%
            }
          }
        }
        %>
        </select>
      </td>
    </tr>
  </tbody>
  </table>
  </transfert:transfertbean>
  
  <p class="texteObligatoire">Les champs marqu� d'un * sont obligatoires.</p>
  <p class="texteSubmit">
    <input name="<%= CConstante.PAR_LISTETACHESPROVOQUE %>" type="hidden" value=""/>
    <input name="<%= CConstante.PAR_LISTETACHESRESOUT %>" type="hidden" value=""/>
    
    <input type="button" value="Annuler" class="bouton" onclick="window.location.href = '/owep/Gestion/ListeProblemeVisu' ;"/>
    <% lCodeValidation = VTransfertConstante.getVerification (CConstante.PAR_ARBREPROBLEME)+ " () ;" ; %>
    <% lCodeValidation += "isSelectVide (document." + CConstante.PAR_FORMULAIRE + ".pSelectTachesProvoque, 'liste des t�ches � l\\'origine du probl�me') ;" ; %>
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
  <!-- Fonctions de validation des boutons d'ajout/suppression de t�ches -->
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