<%@page import="owep.modele.execution.MIteration"%>
<%@page import="owep.modele.execution.MTache"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>

<jsp:useBean id="lIteration" class="owep.modele.execution.MIteration" scope="page"/>

<% lIteration  = (MIteration) request.getAttribute (CConstante.PAR_ITERATION) ;%>
  
<% SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
   // si l iteration ne comporte aucune tache
   if (lIteration.getNbTaches()==0)
   {
%>
   Aucune tâche n'a encore été planifiée pour cette itération.<BR><BR>
   
   Date de début prévue : 
   <% if (lIteration.getDateDebutPrevue () != null)
                         {
                           out.print (lDateFormat.format (lIteration.getDateDebutPrevue ())) ;
                         }
                         else
                         {
                           out.print ("inconnue") ;
                         } %>
   <BR>
   Date de fin prévue : 
   <% if (lIteration.getDateFinPrevue () != null)
                         {
                           out.print (lDateFormat.format (lIteration.getDateFinPrevue ())) ;
                         }
                         else
                         {
                           out.print ("inconnue") ;
                         } %>
<%
   }
   // si l iteration comporte au moins un tache
   else
   {
%>
  
<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Libellé de la tâche.')" onmouseout="tooltipOff(this, event)">Tâches</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Nom du collaborateur qui réalise la tâche.')" onmouseout="tooltipOff(this, event)">Collaborateurs</a>
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
  <!--Affichage des taches de l iteration-->
  <%
  for (int i = 0; i < lIteration.getNbTaches() ; i ++)
  {
    MTache lTache = (MTache)lIteration.getTache(i) ;
    %>
    <tr>      
      <td class="caseNiveau2"><%=lTache.getNom()%></td>
      <td class="caseNiveau3"><%=lTache.getCollaborateur().getNom()%></td>
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
    </tr>
    <%
  }
  %> 
  <tr>      
      <td class="caseNiveau1" colspan="2">
        <a class="niveau1" href="#" onmouseover="tooltipOn(this, event, 'Bilan des charges et des dates pour toutes les tâches de l\'itération.')" onmouseout="tooltipOff(this, event)">Total de l'itération</a>
      </td>
      <td class="caseNiveau2"><%=(int)lIteration.getChargeInitiale()%></td>
      <td class="caseNiveau2"><%=(int)lIteration.getTempsPasse()%></td>
      <td class="caseNiveau2"><%=(int)lIteration.getResteAPasser()%></td>
      <td class="caseNiveau2">
      <%
        switch (lIteration.getEtat())
        {
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
          Terminée
        <%  
          break ;
        }
        %>
      </td>
      <td class="caseNiveau2"><% if (lIteration.getDateDebutPrevue () != null)
                         {
                           out.print (lDateFormat.format (lIteration.getDateDebutPrevue ())) ;
                         }
                         else
                         {
                           out.print ("X") ;
                         } %></td>
      <td class="caseNiveau2"><% if (lIteration.getDateDebutReelle () != null)
                         {
                           out.print (lDateFormat.format (lIteration.getDateDebutReelle ())) ;
                         }
                         else
                         {
                           out.print ("X") ;
                         } %></td>
      <td class="caseNiveau2"><% if (lIteration.getDateFinPrevue () != null)
                         {
                           out.print (lDateFormat.format (lIteration.getDateFinPrevue ())) ;
                         }
                         else
                         {
                           out.print ("X") ;
                         } %></td>
      <td class="caseNiveau2"><% if (lIteration.getDateFinReelle () != null)
                         {
                           out.print (lDateFormat.format (lIteration.getDateFinReelle ())) ;
                         }
                         else
                         {
                           out.print ("X") ;
                         } %></td>
      <td class="caseNiveau2"><%=(int)(lIteration.getPrcDepassementCharge() * 100)%></td>
      <td class="caseNiveau2"><%=(int)lIteration.getHJDepassementCharge()%></td>
      <td class="caseNiveau2"><%=(int)(lIteration.getBudgetConsomme() * 100)%></td>
      <td class="caseNiveau2"><%=(int)(lIteration.getPrcAvancement() * 100)%></td>
    </tr>
</tbody>
</table>
<%
}
%>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Suivi d'avancement du projet</b> vous permet de visualiser l'ensemble des tâches <b>à réaliser</b> pour une itération donné." ;
pCodeAide += " Elle vous offre une vue à la fois générale et détaillée de la réalisation de l'itération." ;
pCodeAide += " Vous pouvez y voir les <b>collaborateurs</b> qui réalisent chacune des tâches, les <b>charges</b>, les <b>dates de réalisation</b> et l'<b>état d'avancement</b>." ;
pCodeAide += " Choisissez l'<b>itération à visualiser</b> par le biais du sélecteur d'itération." ;
</script>
