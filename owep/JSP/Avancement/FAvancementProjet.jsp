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
    <td class="caseNiveau1" rowspan="2">Tâches</td>
    <td class="caseNiveau1" rowspan="2">Collaborateurs</td>
    <td class="caseNiveau1" rowspan="2">Temps prévu(h)</td>
    <td class="caseNiveau1" rowspan="2">Temps passé(h)</td>
    <td class="caseNiveau1" rowspan="2">Reste à passer(h)</td>
    <td class="caseNiveau1" rowspan="2">Etat</td>
    <td class="caseNiveau1" colspan="4">Date</td>
    <td class="caseNiveau1" colspan="2">Dépassement de charge</td>
    <td class="caseNiveau1" rowspan="2">Budget consommé(%)</td>
    <td class="caseNiveau1" rowspan="2">Avancement(%)</td>
  </tr>
  <tr>
    <td class="caseNiveau1">début prévue</td>
    <td class="caseNiveau1">début réelle</td>
    <td class="caseNiveau1">fin prévue</td>
    <td class="caseNiveau1">fin réestimée</td>
    <td class="caseNiveau1">(%)</td>
    <td class="caseNiveau1">(h)</td>
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
      <td class="caseNiveau1" colspan="2">Total de l'itération</td>
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
  
  
