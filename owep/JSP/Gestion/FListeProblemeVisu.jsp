<%@page import="java.util.ArrayList" %>
<%@page import="owep.controle.CConstante" %>
<%@page import="owep.modele.execution.MProbleme" %>
<%@page import="owep.modele.execution.MTache" %>
<%@page import="owep.vue.transfert.convertor.VDateConvertor" %>
<%@page import="owep.vue.transfert.convertor.VStringConvertor" %>


<%
  // R�cup�ration des param�tres.
  ArrayList pListeProblemes = (ArrayList) request.getAttribute (CConstante.PAR_LISTEPROBLEMES) ;
%>

<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Libell� du probl�me.')" onmouseout="tooltipOff(this, event)">Nom</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Degr� de r�solution du probl�me (Entam�, R�solu, etc.).')" onmouseout="tooltipOff(this, event)">Etat</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description des causes et impacts du probl�me.')" onmouseout="tooltipOff(this, event)">Description</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle le probl�me a �t� d�tect�.')" onmouseout="tooltipOff(this, event)">Date</br>d'identification</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle le probl�me a �t� r�solu.')" onmouseout="tooltipOff(this, event)">Date de cl�ture</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'T�ches au cours desquelles est apparu le probl�me.')" onmouseout="tooltipOff(this, event)">T�ches � l'origine</br>du probl�me</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'T�ches au cours desquelles sera r�solu le probl�me.')" onmouseout="tooltipOff(this, event)">T�ches de r�solution</br>du probl�me</a>
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
          // S'il ne s'agit pas du dernier probl�me de la liste, ajouter un retour ligne.
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
            // S'il ne s'agit pas du dernier probl�me de la liste, ajouter un retour ligne.
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
         onmouseover="tooltipOn (this, event, 'Actualiser les donn�es du probl�me.')" onmouseout="tooltipOff(this, event)"/>
        <input type="button" value="Supprimer" class="bouton" onclick="window.location.href = '/owep/Gestion/ProblemeSuppr?<%= CConstante.PAR_PROBLEME %>=<%= lProbleme.getId () %>' ;"
         onmouseover="tooltipOn (this, event, 'Supprimer le probl�me de la liste.')" onmouseout="tooltipOff(this, event)"/>
      </td>
    </tr>
  <%
  }
  %>

  </tr>
    <td class="caseNiveau3Lien" colspan="8">
      <a href="/owep/Gestion/ProblemeModif" onmouseover="tooltipOn(this, event, 'Ajoute un nouveau probl�me survenu sur le projet.')" onmouseout="tooltipOff(this, event)">Ajouter un probl�me...</a>
    </td>
  </tr>
  
</tbody>
</table>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>gestion de probl�me</b> permet de visualiser tout les probl�mes qui sont <b>survenus</b> sur votre projet." ;
pCodeAide += " Chaque probl�me est reli� aux t�ches qui l'ont <b>engendr�</b>" ;
pCodeAide += " et �ventuellement au t�ches durant lesquelles le probl�me sera <b>r�solu</b>." ;
</script>
