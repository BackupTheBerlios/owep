<%@page import="java.text.SimpleDateFormat"%>
<%@page import="owep.modele.execution.MCollaborateur"%>
<%@page import="owep.modele.execution.MTache"%>
<%@page import="owep.controle.CConstante"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>

<jsp:useBean id="lCollaborateur" class="owep.modele.execution.MCollaborateur" scope="page"/>

<% lCollaborateur  = (MCollaborateur) request.getAttribute (CConstante.PAR_COLLABORATEUR) ;
   SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
   if (lCollaborateur.getListe().size()==0)
   {
%>
   Le collaborateur <%=lCollaborateur.getNom()%> n'a pas de tâches à réaliser dans cette itération.
<%
   }
   else
   {
%>
  
<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1" rowspan="2">Tâches</td>
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
  <!--Affichage des taches du collaborateur-->
	<%
	for (int i = 0; i < lCollaborateur.getListe().size(); i ++)
	{
	  MTache lTache = (MTache)lCollaborateur.getListe(new Integer(i)) ;
	  %>
	  <tr>      
      <td class="caseNiveau2"><%=lTache.getNom()%></td>
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
</tbody>
</table>
<%
}
%>
  
