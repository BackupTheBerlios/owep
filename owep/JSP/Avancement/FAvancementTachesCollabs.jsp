<%@page import="java.text.SimpleDateFormat"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MProjet"%>
<%@page import="owep.modele.execution.MTache"%>
<%@page import="owep.modele.execution.MCollaborateur"%>
<%@page import="owep.controle.CConstante"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>

<jsp:useBean id="lProjet" class="owep.modele.execution.MProjet" scope="page"/>
<jsp:useBean id="lTache" class="owep.modele.execution.MTache" scope="page"/>
<jsp:useBean id="lCollaborateur" class="owep.modele.execution.MCollaborateur" scope="page"/>

<% lProjet  = (MProjet) request.getAttribute (CConstante.PAR_PROJET) ;
   SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
%>
  
<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Nom du collaborateur.')" onmouseout="tooltipOff(this, event)">Collaborateurs</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Tâches que le collaborateur a réalisé ou devra réaliser.')" onmouseout="tooltipOff(this, event)">Tâches</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Charge affectée par le chef de projet sur la tâche (en heures).')" onmouseout="tooltipOff(this, event)">Temps prévu(h)</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Temps effectivement passé par le collaborateur sur la tâche.')" onmouseout="tooltipOff(this, event)">Temps passé(h)</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Temps nécessaire, estimé par le collaborateur, pour réaliser la tâche.')" onmouseout="tooltipOff(this, event)">Reste à passer(h)</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event,
       '<b>Créée</b> si le collaborateur ne peut lancer la tâche du fait d\'une tâche tierce non terminé ou démarré.<br/>' +
       '<b>Non démarré</b> si le collaborateur n\'a pas entamé la tâche.<br/>' +
       '<b>En cours</b> si le collaborateur travaille sur la tâche.<br/>' +
       '<b>Suspendu</b> si le collaborateur a entamé la tâche mais n\'y travaille pas actuellement dessus.<br/>' +
       '<b>Terminé</b> si le collbarateur a fini sa tâche.<br/>')" onmouseout="tooltipOff(this, event)">Etat</a>
    </td>
    <td class="caseNiveau1" colspan="4">
      Date
    </td>
    <td class="caseNiveau1" colspan="2">
      Dépassement de charge
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Pourcentage de temps effectivement passé sur la tâche par rapport au temps prévu.')" onmouseout="tooltipOff(this, event)">Budget consommé(%)</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Niveau de réalisation la tâche (en pourcent).')" onmouseout="tooltipOff(this, event)">Avancement(%)</a>
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date à laquelle le chef de projet a prévue de démarrer la tâche.')" onmouseout="tooltipOff(this, event)">début prévue</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date à laquelle le collaborateur à effectivement démarré la tâche.')" onmouseout="tooltipOff(this, event)">début réelle</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date à laquelle le chef de projet a prévue de terminer la tâche.')" onmouseout="tooltipOff(this, event)">fin prévue</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date à laquelle le collaborateur à effectivement terminé la tâche.')" onmouseout="tooltipOff(this, event)">fin réestimée</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Dépassement du temps de réalisation pour la tâche (en pourcent).')" onmouseout="tooltipOff(this, event)">(%)</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Dépassement du temps de réalisation pour la tâche (en heures).')" onmouseout="tooltipOff(this, event)">(h)</a>
    </td>
  </tr>
  
  
  <!--Pour chaque collaborateur-->
	<%
	for (int i = 0; i < lProjet.getNbCollaborateurs(); i ++)
	{
	  lCollaborateur = (MCollaborateur)lProjet.getListe(new Integer(i));
	  %>
	  <tr>      
      <td class="caseNiveau2" rowspan="<%=lCollaborateur.getNbTaches()%>">
        <%=lProjet.getCollaborateur(i).getNom()%>
      </td>
      <%if (lCollaborateur.getNbTaches() == 0)
        {
      %>
      <td class="caseNiveau3" colspan="13"><center>Aucune tâche prévue pour cette itération</center></td>
      <%  
        }
        else
        {
	        //Pour chaque tache
	        for (int j = 0 ; j < lCollaborateur.getNbTaches() ; j++)
	        {
	        lTache = lCollaborateur.getTache(j) ;
	        // si on affiche au moins la 2eme tache du collab, on passe a la ligne
	        if (j > 0)
	        {
	      %>
			    <tr>
			  <%
			    }
			  %>
				    <td class="caseNiveau3"><%=lTache.getNom()%></td>
				    <td class="caseNiveau3"><%=(int)lTache.getChargeInitiale()%></td>
            <td class="caseNiveau3"><%=(int)lTache.getTempsPasse()%></td>
            <td class="caseNiveau3"><%=(int)lTache.getResteAPasser()%></td>
            <td class="caseNiveau3">
			      <%
			        switch (lTache.getEtat())
			        {
			          case -1 : 
			        %>
			          Non prête
			        <%  
			          break ;
			          case 0 : 
			        %>
			          Non démarrée
			        <%  
			          break ;
			          case 1 : 
			        %>
			          En cours
			        <%  
			          break ;
			          case 2 : 
			        %>
			          Suspendue
			        <%  
			          break ;
			          case 3 : 
			        %>
			          Terminée
			        <%
			          break ;
			        }
			        %>
			      </td>
            <td class="caseNiveau3"><% if (lTache.getDateDebutPrevue () != null)
                               {
                                 out.print (lDateFormat.format (lTache.getDateDebutPrevue ())) ;
                               }
                               else
                               {
                                 out.print ("X") ;
                               } %></td>
            <td class="caseNiveau3"><% if (lTache.getDateDebutReelle () != null)
                               {
                                 out.print (lDateFormat.format (lTache.getDateDebutReelle ())) ;
                               }
                               else
                               {
                                 out.print ("X") ;
                               } %></td>
            <td class="caseNiveau3"><% if (lTache.getDateFinPrevue () != null)
                               {
                                 out.print (lDateFormat.format (lTache.getDateFinPrevue ())) ;
                               }
                               else
                               {
                                 out.print ("X") ;
                               } %></td>
            <td class="caseNiveau3"><% if (lTache.getDateFinReelle () != null)
                               {
                                 out.print (lDateFormat.format (lTache.getDateFinReelle ())) ;
                               }
                               else
                               {
                                 out.print ("X") ;
                               } %></td>
            <td class="caseNiveau3"><%=(int)(lTache.getPrcDepassementCharge () * 100)%></td>
            <td class="caseNiveau3"><%=(int)lTache.getHJDepassementCharge ()%></td>
            <td class="caseNiveau3"><%=(int)(lTache.getBudgetConsomme() * 100)%></td>
            <td class="caseNiveau3"><%=(int)(lTache.getPrcAvancement() * 100)%></td>
	      <% 
	       // si on affiche au moins la 2eme tache du collab, on passe a la ligne
	       if (j > 0)
          {
        %>
          </tr>
        <%
          }
        %>
			  <%
			    }
			  %>
	    <%
	      }
	    %>
	  </tr>
	  <%
	}
	%> 
</tbody>
</table>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Suivi d'avancement des collaborateurs</b> vous permet de visualiser le travail que réalise chaque collaborateur pour les itérations passés, futures ou en cours." ;
pCodeAide += " Si vous avez choisi <b>l'itération en cours</b>, vous visualiserez la tâche qu'est en train d'effectuer chaque <b>collaborateur</b>" ;
pCodeAide += " En cliquant sur le nom d'un collaborateur, vous pourrez visualiser le <b>détail des tâches</b> qu'il doit réaliser sur une itération." ;
pCodeAide += " Pour les <b>itérations passés</b> et <b>futures</b>, la liste des tâches à réaliser, par collaborateur, sera affiché." ;
</script>
