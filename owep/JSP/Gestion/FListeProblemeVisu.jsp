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
      Nom
    </td>
    <td class="caseNiveau1">
      Etat
    </td>
    <td class="caseNiveau1">
      Description
    </td>
    <td class="caseNiveau1">
      Date</br>d'identification
    </td>
    <td class="caseNiveau1">
      Date de clôture
    </td>
    <td class="caseNiveau1">
      Tâches à l'origine</br>du problème
    </td>
    <td class="caseNiveau1">
      Tâches de résolution</br>du problème
    </td>
    <td class="caseNiveau1">
      &nbsp;
    </td>
  </tr>
  
  
  <%
  // S'il aucun problème n'est survenu sur le projet,
  if (pListeProblemes.size () == 0)
  {
  %>
  </tr>
    <td class="caseNiveau3" colspan="7">
      Aucun problème n'a été détecté sur  ce projet.
    </td>
  </tr>
  <%
  }
  // Si des problèmes sont survenus sur le projet,
  else
  {
    for (int lIndiceProbleme = 0; lIndiceProbleme < pListeProblemes.size (); lIndiceProbleme ++)
    {
      MProbleme lProbleme = (MProbleme) pListeProblemes.get (lIndiceProbleme) ;
  %>
    </tr>
      <td class="caseNiveau2">
        <a href="/owep/Gestion/ProblemeModif?<%= CConstante.PAR_PROBLEME %>=<%= lProbleme.getId () %>"><%= lProbleme.getNom () %></a>
      </td>
      <td class="caseNiveau3">
        <%= VStringConvertor.getString (lProbleme.getEtat ()) %>
      </td>
      <td class="caseNiveau3">
        <%= VStringConvertor.getString (lProbleme.getDescription ()) %>
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
        <input type="button" value="Modifier"  class="bouton" onclick="window.location.href = '/owep/Gestion/ProblemeModif?<%= CConstante.PAR_PROBLEME %>=<%= lProbleme.getId () %>' ;"/>
        <input type="button" value="Supprimer" class="bouton" onclick="window.location.href = '/owep/Gestion/ProblemeSuppr?<%= CConstante.PAR_PROBLEME %>=<%= lProbleme.getId () %>' ;"/>
      </td>
    </tr>
  <%
    }
  }
  %>
</tbody>
</table>
