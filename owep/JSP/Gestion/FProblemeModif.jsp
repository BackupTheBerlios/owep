<%@page import="owep.controle.CConstante" %>
<%@page import="owep.modele.execution.MProbleme" %>
<%@page import="owep.modele.execution.MProjet" %>
<%@page import="owep.modele.execution.MIteration" %>
<%@page import="owep.modele.execution.MTache" %>
<%@page import="owep.modele.execution.MTacheImprevue" %>
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
        <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Libell� du probl�me.')" onmouseout="tooltipOff(this, event)">Nom *</a>
      </td>
      <td class="caseNiveau3" width="80%" colspan="3">
        <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom du probl�me" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" type="text" value="<%= VStringConvertor.getString (pProbleme.getNom (), true) %>" size="<%= CConstante.LNG_MOYEN %>" maxlength="<%= CConstante.TXT_MOYEN %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Degr� de r�solution du probl�me (Entam�, R�solu, etc.).')" onmouseout="tooltipOff(this, event)">Etat</a>
      </td>
      <td class="caseNiveau3" colspan="3">
        <input <transfert:transfertchamp membre="setEtat" type="java.lang.String" libelle="Etat du probl�me" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" type="text" value="<%= VStringConvertor.getString (pProbleme.getEtat (), true) %>" size="<%= CConstante.LNG_MOYEN %>" maxlength="<%= CConstante.TXT_MOYEN %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description des causes et impacts du probl�me.')" onmouseout="tooltipOff(this, event)">Description</a>
      </td>
      <td class="caseNiveau3" colspan="3">
        <textarea  <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description du probl�me" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" rows="<%= CConstante.LNG_ROWSCOMMENTAIRE %>" cols="<%= CConstante.LNG_COLSCOMMENTAIRE %>" maxlength="<%= CConstante.LNG_COMMENTAIRE %>"><%= VStringConvertor.getString (pProbleme.getDescription (), true) %></textarea>
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Date � laquelle le probl�me a �t� d�tect�.')" onmouseout="tooltipOff(this, event)">Date</br>d'identification *</a>
      </td>
      <td class="caseNiveau3" colspan="3">
        <input <transfert:transfertchamp membre="setDateIdentification" type="java.lang.Date" libelle="Date d\\'identification" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         class="niveau2" type="text" value="<%= VDateConvertor.getString (pProbleme.getDateIdentification (), true) %>" size="<%= CConstante.LNG_DATE %>" maxlength="<%= CConstante.TXT_DATE %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle le probl�me a �t� r�solu.')" onmouseout="tooltipOff(this, event)">Date de cl�ture</a>
      </td>
      <td class="caseNiveau3" colspan="3">
        <input <transfert:transfertchamp membre="setDateCloture" type="java.lang.Date" libelle="Date de cl�ture" convertor="VDateConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREPROBLEME %>"/>
         type="text" class="niveau2" value="<%= VDateConvertor.getString (pProbleme.getDateCloture (), true) %>" size="<%= CConstante.LNG_DATE %>" maxlength="<%= CConstante.TXT_DATE %>">
      </td>
    </tr>
    
    
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'T�ches au cours desquelles est apparu le probl�me.')" onmouseout="tooltipOff(this, event)">T�ches � l'origine</br>du probl�me *</a>
      </td>
      
      <td class="caseNiveau3" style="border-width : 0px 0px 1px 1px ;">
        <font class="titre3">T�ches possibles :</font><br/>
        <select name="pSelectTachesProvoquePossible" class="niveau2" style="width: 250" size="6"
         onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'T�ches qui peuvent �tre indiqu�s comme provoquant le probl�me.')" onmouseout="tooltipOff(this, event)">
        <%
        // Parcours l'ensemble des t�ches du projet.
        for (int lIndiceIteration = 0; lIndiceIteration < pProjet.getNbIterations (); lIndiceIteration ++)
        {
          MIteration lIteration = pProjet.getIteration (lIndiceIteration) ;
          
          // Affichage de la liste des t�ches pr�vues.
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
          <option value="p-<%= lTache.getId () %>"><%= lTache.getNom () %></option>
        <%
            }
          }
          
          // Affichage de la liste des t�ches impr�vues.
          for (int lIndiceTache = 0; lIndiceTache < lIteration.getNbTachesImprevues (); lIndiceTache ++)
          {
            MTacheImprevue lTache = lIteration.getTacheImprevue (lIndiceTache) ;
            
            // V�rifie que la t�che n'appartient pas au probl�me.
            boolean lTrouve = false ;
            for (int lIndicePbTache = 0; lIndicePbTache < pProbleme.getNbTachesImprevuesProvoque (); lIndicePbTache ++)
            {
              if (pProbleme.getTacheImprevueProvoque (lIndicePbTache).getId () == lTache.getId ())
              {
                lTrouve = true ;
              }
            }
            
            // Si la t�che n'appartient pas au probleme.
            if (! lTrouve)
            {
        %>
          <option value="i-<%= lTache.getId () %>"><%= lTache.getNom () %></option>
        <%
            }
          }
        }
        %>
        </select>
      </td>
      
      <td class="caseNiveau3" align="center" valign="middle" width="0" style="border-width : 0px 0px 1px 0px ;">
        <font class="titre3">&nbsp;</font><br/>
        <center>
          <input type="button" value="    Ajouter >  " class="bouton" onclick="transfererItem (document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesProvoquePossible, document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesProvoque) ;"
           onmouseover="tooltipOn(this, event, 'Cliquez pour ajouter la t�che de la liste de gauche � la liste des t�ches choisies.')" onmouseout="tooltipOff(this, event)"/>
          <br/>
          <input type="button" value="< Supprimer" class="bouton" onclick="transfererItem (document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesProvoque, document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesProvoquePossible) ;"
           onmouseover="tooltipOn(this, event, 'Cliquez pour supprimer la t�che de la liste des t�ches choisies.')" onmouseout="tooltipOff(this, event)"/>
        </center>
      </td>
      
      <td class="caseNiveau3" style="border-width : 0px 0px 1px 0px ;">
        <font class="titre3">T�ches choisies :</font><br/>
        <select name="pSelectTachesProvoque" class="niveau2" style="width: 250" size="6"
         onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'T�ches qui provoquent le probl�me.')" onmouseout="tooltipOff(this, event)">
        <%
        for (int lIndiceTache = 0; lIndiceTache < pProbleme.getNbTachesProvoque (); lIndiceTache ++)
        {
          MTache lTache = pProbleme.getTacheProvoque (lIndiceTache) ;
        %>
          <option value="p-<%= lTache.getId () %>"> <%= lTache.getNom () %> </option>
        <%
        }
        %>
        <%
        for (int lIndiceTache = 0; lIndiceTache < pProbleme.getNbTachesImprevuesProvoque (); lIndiceTache ++)
        {
          MTacheImprevue lTache = pProbleme.getTacheImprevueProvoque (lIndiceTache) ;
        %>
          <option value="i-<%= lTache.getId () %>"> <%= lTache.getNom () %> </option>
        <%
        }
        %>
        </select>
      </td>
    </tr>
    
    
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'T�ches au cours desquelles sera r�solu le probl�me.')" onmouseout="tooltipOff(this, event)">T�ches de r�solution</br>du probl�me</a>
      </td>
      
      <td class="caseNiveau3" style="border-width : 0px 0px 1px 1px ;">
        <font class="titre3">T�ches possibles :</font><br/>
        <select name="pSelectTachesResoutPossible" class="niveau2" style="width: 250" size="6"
         onmouseover="tooltipOn(this, event, 'T�ches au cours desquelles sera r�solu le probl�me.')" onmouseout="tooltipOff(this, event)">
        <%
        // Parcours l'ensemble des t�ches du projet.
        for (int lIndiceIteration = 0; lIndiceIteration < pProjet.getNbIterations (); lIndiceIteration ++)
        {
          MIteration lIteration = pProjet.getIteration (lIndiceIteration) ;
          
          // Affichage de la liste des t�ches pr�vues.
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
          <option value="p-<%= lTache.getId () %>"> <%= lTache.getNom () %> </option>
        <%
            }
          }
          
          // Affichage de la liste des t�ches impr�vues.
          for (int lIndiceTache = 0; lIndiceTache < lIteration.getNbTachesImprevues (); lIndiceTache ++)
          {
            MTacheImprevue lTache = lIteration.getTacheImprevue (lIndiceTache) ;
            
            // V�rifie que la t�che n'appartient pas au probl�me.
            boolean lTrouve = false ;
            for (int lIndicePbTache = 0; lIndicePbTache < pProbleme.getNbTachesImprevuesResout (); lIndicePbTache ++)
            {
              if (pProbleme.getTacheImprevueResout (lIndicePbTache).getId () == lTache.getId ())
              {
                lTrouve = true ;
              }
            }
            
            // Si la t�che n'appartient pas au probleme.
            if (! lTrouve)
            {
        %>
          <option value="i-<%= lTache.getId () %>"> <%= lTache.getNom () %> </option>
        <%
            }
          }
        }
        %>
        </select>
      </td>
      
      <td class="caseNiveau3" align="center" valign="middle" width="0" style="border-width : 0px 0px 1px 0px ;">
        <font class="titre3">&nbsp;</font><br/>
        <center>
          <input type="button" value="   < Ajouter   " class="bouton" onclick="transfererItem (document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesResoutPossible, document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesResout)"
           onmouseover="tooltipOn(this, event, 'Cliquez pour ajouter la t�che de la liste de gauche � la liste des t�ches choisies.')" onmouseout="tooltipOff(this, event)"/>
          <br/>
          <input type="button" value="Supprimer >" class="bouton" onclick="transfererItem (document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesResout, document.<%= CConstante.PAR_FORMULAIRE %>.pSelectTachesResoutPossible)"
           onmouseover="tooltipOn(this, event, 'Cliquez pour supprimer la t�che de la liste des t�ches choisies.')" onmouseout="tooltipOff(this, event)"/>
        </center>
      </td>
      
      <td class="caseNiveau3" style="border-width : 0px 0px 1px 0px ;">
        <font class="titre3">T�ches choisies :</font><br/>
        <select name="pSelectTachesResout" class="niveau2" style="width: 250" size="6"
         onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'T�ches qui peuvent �tre indiqu�s comme r�solvant le probl�me.')" onmouseout="tooltipOff(this, event)">
        <%
        for (int lIndiceTache = 0; lIndiceTache < pProbleme.getNbTachesResout (); lIndiceTache ++)
        {
          MTache lTache = pProbleme.getTacheResout (lIndiceTache) ;
        %>
          <option value="p-<%= lTache.getId () %>"> <%= lTache.getNom () %> </option>
        <%
        }
        %>
        <%
        for (int lIndiceTache = 0; lIndiceTache < pProbleme.getNbTachesImprevuesResout (); lIndiceTache ++)
        {
          MTacheImprevue lTache = pProbleme.getTacheImprevueResout (lIndiceTache) ;
        %>
          <option value="i-<%= lTache.getId () %>"> <%= lTache.getNom () %> </option>
        <%
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
    <input name="<%= CConstante.PAR_LISTETACHESRESOUT %>"   type="hidden" value=""/>
    
    <% lCodeValidation = VTransfertConstante.getVerification (CConstante.PAR_ARBREPROBLEME)+ " () ;" ; %>
    <% lCodeValidation += "isSelectVide (document." + CConstante.PAR_FORMULAIRE + ".pSelectTachesProvoque, 'liste des t�ches � l\\'origine du probl�me') ;" ; %>
    <% lCodeValidation += "submitListesTaches (pSelectTachesProvoque, " + CConstante.PAR_LISTETACHESPROVOQUE + ") ;" ; %>
    <% lCodeValidation += "submitListesTaches (pSelectTachesResout, " + CConstante.PAR_LISTETACHESRESOUT + ") ;" ; %>
    <% lCodeValidation += "validerChamps () ;" ; %>
    <transfert:transfertsubmit libelle="Valider" valeur="<%= CConstante.PAR_SUBMIT %>" verification="true" validation="<%= lCodeValidation %>"
     additionnel="onmouseover=\"tooltipOn(this, event, 'Cliquez pour valider toutes les modifications et revenir � la page liste des probl�mes.')\" onmouseout=\"tooltipOff(this, event)\""/>
    <input type="button" value="Annuler" class="bouton" onclick="window.location.href = '/owep/Gestion/ListeProblemeVisu' ;"
     onmouseover="tooltipOn(this, event, 'Cliquez pour annuler toutes les modifications et revenir � la page liste des probl�mes.')" onmouseout="tooltipOff(this, event)"/>
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


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>D�tail du probl�me</b> vous permet de sp�cifier ou de modifier un <b>probl�me</b>." ;
pCodeAide += " Vous pouvez y d�crire votre probl�me (<b>�tat</b> de r�solution, date � laquelle celui-ci a �t� <b>d�couvert</b>, date � laquelle il a �t� <b>r�solu</b>)" ;
pCodeAide += " et le relier aux t�ches qui ont <b>provoqu�</b> le probl�me et celles au cours desquelles il sera <b>r�solu</b>." ;
</script>
