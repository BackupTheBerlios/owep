<%@page import="java.util.ArrayList" %>
<%@page import="owep.controle.CConstante" %>
<%@page import="owep.modele.execution.MRisque" %>
<%@page import="owep.modele.execution.MProjet" %>
<%@page import="owep.vue.transfert.convertor.VIntegerConvertor" %>
<%@page import="owep.vue.transfert.convertor.VStringConvertor" %>


<%
  // R�cup�ration des param�tres.
  MProjet pProjet = (MProjet) request.getAttribute (CConstante.PAR_PROJET) ;
%>

<center>
<table width="90%" class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Libell� du risque.')" onmouseout="tooltipOff(this, event)">Nom</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Niveau de gestion du risque (Entam�, R�solu, etc.).')" onmouseout="tooltipOff(this, event)">Etat</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description g�n�rale du risque.')" onmouseout="tooltipOff(this, event)">Description</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description de l\'impact possible du risque sur le projet.')" onmouseout="tooltipOff(this, event)">Impact</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description des actions � mener pour g�rer le risque.')" onmouseout="tooltipOff(this, event)">Actions</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Degr� d\'importance du risque.')" onmouseout="tooltipOff(this, event)">Priorit�</a>
    </td>
    <td class="caseNiveau1">
      &nbsp;
    </td>
  </tr>
  
  
  <%
  for (int lIndiceRisque = 0; lIndiceRisque < pProjet.getNbRisques (); lIndiceRisque ++)
  {
    MRisque lRisque = pProjet.getRisque (lIndiceRisque) ;
  %>
    </tr>
     <td style="text-align: center" class="caseNiveau2">
        <a href="/owep/Gestion/RisqueModif?<%= CConstante.PAR_RISQUE %>=<%= lRisque.getId () %>"><%= VStringConvertor.getString (lRisque.getNom (), false) %></a>
      </td>
      <td class="caseNiveau3">
        <%= VStringConvertor.getString (lRisque.getEtat (), false) %>
      </td>
      <td class="caseNiveau3">
        <%= VStringConvertor.getString (lRisque.getDescription (), false) %>
      </td>
      <td class="caseNiveau3">
        <%= VStringConvertor.getString (lRisque.getImpact (), false) %>
      </td>
      <td class="caseNiveau3">
        <%= VStringConvertor.getString (lRisque.getActions (), false) %>
      </td>
      <td style="text-align: center" class="caseNiveau3">
        <%= lRisque.getPriorite () %>
      </td>
      
            
      <td style="text-align: center" class="caseNiveau3" width="1px">
        <input type="button" value="Modifier"  class="bouton" onclick="window.location.href = '/owep/Gestion/RisqueModif?<%= CConstante.PAR_RISQUE %>=<%= lRisque.getId () %>' ;"
         onmouseover="tooltipOn (this, event, 'Actualiser les donn�es du probl�me.')" onmouseout="tooltipOff(this, event)"/>
        <input type="button" value="Supprimer" class="bouton" onclick="window.location.href = '/owep/Gestion/RisqueSuppr?<%= CConstante.PAR_RISQUE %>=<%= lRisque.getId () %>' ;"
         onmouseover="tooltipOn (this, event, 'Supprimer le probl�me de la liste.')" onmouseout="tooltipOff(this, event)"/>
      </td>
    </tr>
  <%
  }
  %>

  </tr>
    <td class="caseNiveau3Lien" colspan="8">
      <a href="/owep/Gestion/RisqueModif" onmouseover="tooltipOn(this, event, 'Ajoute un nouveau risque survenu sur le projet.')" onmouseout="tooltipOff(this, event)">Ajouter un risque...</a>
    </td>
  </tr>
  
</tbody>
</table>
</center>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>gestion de risques</b> permet de visualiser tout les risques sp�cifi�s par le chef de projet qui pourraient <b>survenir</b> sur le projet." ;
pCodeAide += " Chaque risque comprend une <b>description</b>, le d�tail de son <b>impact</b>, son <b>�tat de r�solution</b> ainsi que sa <b>priorit�</b> (1 pour le plus prioritaire)." ;
</script>
