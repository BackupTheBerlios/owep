<%@page import="java.util.ArrayList" %>
<%@page import="owep.controle.CConstante" %>
<%@page import="owep.modele.execution.MProbleme" %>
<%@page import="owep.modele.execution.MTache" %>
<%@page import="owep.vue.transfert.convertor.VDateConvertor" %>
<%@page import="owep.vue.transfert.convertor.VStringConvertor" %>


<%
  // Récupération des paramètres.
  ArrayList pListeProblemes = (ArrayList) request.getAttribute (CConstante.PAR_LISTEPROBLEMES) ;
%>

<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Libellé du problème.')" onmouseout="tooltipOff(this, event)">Nom</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Degré de résolution du problème (Entamé, Résolu, etc.).')" onmouseout="tooltipOff(this, event)">Etat</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description des causes et impacts du problème.')" onmouseout="tooltipOff(this, event)">Description</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date à laquelle le problème a été détecté.')" onmouseout="tooltipOff(this, event)">Date</br>d'identification</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date à laquelle le problème a été résolu.')" onmouseout="tooltipOff(this, event)">Date de clôture</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Tâches au cours desquelles est apparu le problème.')" onmouseout="tooltipOff(this, event)">Tâches à l'origine</br>du problème</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Tâches au cours desquelles sera résolu le problème.')" onmouseout="tooltipOff(this, event)">Tâches de résolution</br>du problème</a>
    </td>
    <td class="caseNiveau1">
      &nbsp;
    </td>
  </tr>
  
  
  <%
  for (int lIndiceProbleme = 0; lIndiceProbleme < pListeProblemes.size (); lIndiceProbleme ++)
  {
    MProbleme lProbleme = (MProbleme) pListeProblemes.get (lIndiceProbleme) ;
  %>
    </tr>
     <td class="caseNiveau2">
        <a href="/owep/Gestion/ProblemeModif?<%= CConstante.PAR_PROBLEME %>=<%= lProbleme.getId () %>"><%= VStringConvertor.getString (lProbleme.getNom (), false) %></a>
      </td>
      <td class="caseNiveau3">
        <%= VStringConvertor.getString (lProbleme.getEtat (), false) %>
      </td>
      <td class="caseNiveau3">
        <%= VStringConvertor.getString (lProbleme.getDescription (), false) %>
      </td>
      <td style="text-align: center" class="caseNiveau3">
        <%= VDateConvertor.getString (lProbleme.getDateIdentification (), false) %>
      </td>
      <td style="text-align: center" class="caseNiveau3">
        <%= VDateConvertor.getString (lProbleme.getDateCloture (), false) %>
      </td>
      <td class="caseNiveau3Lien">
        <%
        for (int lIndiceTache = 0; lIndiceTache < lProbleme.getNbTachesProvoque (); lIndiceTache ++)
        {
          MTache lTache = lProbleme.getTacheProvoque (lIndiceTache) ;
        %>
          <a href="/owep/Tache/TacheVisu?pTacheAVisualiser=<%= lTache.getId () %>"><%= lTache.getNom () %></a>
          <%
          // S'il ne s'agit pas du dernier problème de la liste, ajouter un retour ligne.
          if (lIndiceTache != lProbleme.getNbTachesProvoque ())
          {
          %>
          <br/>
        <%
          }
        }
        %>
      </td>
      <td class="caseNiveau3Lien">
        <%
        if (lProbleme.getNbTachesResout () == 0)
        {
        %>
          &nbsp;
        <%
        }
        else
        {
          for (int lIndiceTache = 0; lIndiceTache < lProbleme.getNbTachesResout (); lIndiceTache ++)
          {
            MTache lTache = lProbleme.getTacheResout (lIndiceTache) ;
        %>
            <a href="/owep/Tache/TacheVisu?pTacheAVisualiser=<%= lTache.getId () %>"><%= lTache.getNom () %></a>
            <%
            // S'il ne s'agit pas du dernier problème de la liste, ajouter un retour ligne.
            if (lIndiceTache != lProbleme.getNbTachesResout ())
            {
            %>
            <br/>
        <%
            }
          }
        }
        %>
      </td>
      <td style="text-align: center" class="caseNiveau3" width="1px">
        <input type="button" value="Modifier"  class="bouton" onclick="window.location.href = '/owep/Gestion/ProblemeModif?<%= CConstante.PAR_PROBLEME %>=<%= lProbleme.getId () %>' ;"
         onmouseover="tooltipOn (this, event, 'Actualiser les données du problème.')" onmouseout="tooltipOff(this, event)"/>
        <input type="button" value="Supprimer" class="bouton" onclick="window.location.href = '/owep/Gestion/ProblemeSuppr?<%= CConstante.PAR_PROBLEME %>=<%= lProbleme.getId () %>' ;"
         onmouseover="tooltipOn (this, event, 'Supprimer le problème de la liste.')" onmouseout="tooltipOff(this, event)"/>
      </td>
    </tr>
  <%
  }
  %>

  </tr>
    <td class="caseNiveau3Lien" colspan="8">
      <a href="/owep/Gestion/ProblemeModif" onmouseover="tooltipOn(this, event, 'Ajoute un nouveau problème survenu sur le projet.')" onmouseout="tooltipOff(this, event)">Ajouter un problème...</a>
    </td>
  </tr>
  
</tbody>
</table>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>gestion de problème</b> permet de visualiser tout les problèmes qui sont <b>survenus</b> sur votre projet." ;
pCodeAide += " Chaque problème est relié aux tâches qui l'ont <b>engendré</b>" ;
pCodeAide += " et éventuellement au tâches durant lesquelles le problème sera <b>résolu</b>." ;
</script>
