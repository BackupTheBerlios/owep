<%@page import="java.text.SimpleDateFormat"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MProjet"%>
<%@page import="owep.modele.execution.MTache"%>
<%@page import="owep.controle.CConstante"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>

<jsp:useBean id="lProjet" class="owep.modele.execution.MProjet" scope="page"/>
<jsp:useBean id="lTacheEnCours" class="owep.modele.execution.MTache" scope="page"/>

<% lProjet  = (MProjet) request.getAttribute (CConstante.PAR_PROJET) ;
   SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
%>
  
<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1" rowspan="2">Collaborateurs</td>
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
  <!--Affichage des taches en cours des collaborateurs-->
	<%
	// pour chaque collaborateur
	for (int i = 0; i < lProjet.getNbCollaborateurs(); i ++)
	{
	  %>
	  <tr>      
      <td class="caseNiveau2"><a href="/owep/Avancement/DetailAvancementCollab?<%=CConstante.PAR_COLLABORATEUR%>=<%= lProjet.getCollaborateur(i).getId()%>"><%=lProjet.getCollaborateur(i).getNom()%></a></td>
      <%
        lTacheEnCours = (MTache) lProjet.getListe(new Integer(i)) ;
        if (lTacheEnCours == null)
        {
      %>
          <td class="caseNiveau3" colspan="13"><center>Aucune tâche en cours</center></td>
      <%  
        }
        else
        {
      %>
		      <td class="caseNiveau3"><%=lTacheEnCours.getNom()%></td>
		      <td class="caseNiveau3"><%=(int)lTacheEnCours.getChargeInitiale()%></td>
		      <td class="caseNiveau3"><%=(int)lTacheEnCours.getTempsPasse()%></td>
		      <td class="caseNiveau3"><%=(int)lTacheEnCours.getResteAPasser()%></td>
		      <td class="caseNiveau3">En cours</td>
		      <td class="caseNiveau3"><% if (lTacheEnCours.getDateDebutPrevue () != null)
                                 {
                                   out.print (lDateFormat.format (lTacheEnCours.getDateDebutPrevue ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } %></td>
		      <td class="caseNiveau3"><% if (lTacheEnCours.getDateDebutReelle () != null)
                                 {
                                   out.print (lDateFormat.format (lTacheEnCours.getDateDebutReelle ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } %></td>
		      <td class="caseNiveau3"><% if (lTacheEnCours.getDateFinPrevue () != null)
                                 {
                                   out.print (lDateFormat.format (lTacheEnCours.getDateFinPrevue ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } %></td>
		      <td class="caseNiveau3"><% if (lTacheEnCours.getDateFinReelle () != null)
                                 {
                                   out.print (lDateFormat.format (lTacheEnCours.getDateFinReelle ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } %></td>
		      <td class="caseNiveau3"><%=(int)(lTacheEnCours.getPrcDepassementCharge () * 100)%></td>
		      <td class="caseNiveau3"><%=(int)lTacheEnCours.getHJDepassementCharge ()%></td>
          <td class="caseNiveau3"><%=(int)(lTacheEnCours.getBudgetConsomme() * 100)%></td>
          <td class="caseNiveau3"><%=(int)(lTacheEnCours.getPrcAvancement() * 100)%></td>
      <%
        }
      %>
	  </tr>
	  <%
	}
	%> 
</tbody>
</table>
  
  
