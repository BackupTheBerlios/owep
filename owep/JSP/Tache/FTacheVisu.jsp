<%@page import="java.text.SimpleDateFormat"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MTache"%>

<jsp:useBean id="lArtefact" class="owep.modele.execution.MArtefact" scope="page"/>
<jsp:useBean id="lTache"         class="owep.modele.execution.MTache"         scope="page"/> 

<%
    SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
    lTache = (MTache) request.getAttribute (CConstante.PAR_TACHE) ;
  %>

<table border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td>T�che : </td>
    <td><%= lTache.getNom ()%></td>
  </tr>
  <tr>
    <td>Etat : </td>
    <td><%= lTache.getEtat()%></td>
  </tr>
  <tr>
    <td>Description : </td>
    <td><%= lTache.getDescription()%></td>
  </tr>
</tbody>
</table>  

<table border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
	  <td>Temps pr�vu : </td>
	  <td><%=lTache.getChargeInitiale ()%></td>
    <td>Temps pass� : </td>
    <td><%=lTache.getTempsPasse ()    %></td>
    <td>Reste � passer : </td>
    <td><%=lTache.getResteAPasser ()  %></td>
  </tr>
</tbody>
</table>
<table border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td colspan="4">Date : </td>
  </tr>
  <tr>
    <td>d�but pr�vue : </td>
    <td><% if (lTache.getDateDebutPrevue () != null)
                                 {
                                   out.print (lDateFormat.format (lTache.getDateDebutPrevue ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } %>
    </td>
    <td>d�but r�elle : </td>
    <td><% if (lTache.getDateDebutReelle () != null)
                                 {
                                   out.print (lDateFormat.format (lTache.getDateDebutReelle ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } %>
    </td>
  </tr>
  <tr>
    <td>fin pr�vue</td>
    <td><% if (lTache.getDateFinPrevue () != null)
                              {
                                out.print (lDateFormat.format (lTache.getDateFinPrevue ())) ;
                              }
                           else
                           {
                             out.print ("X") ;
                           } %>
    </td>
    <td>fin r�estim�e : </td>
    <td><% if (lTache.getDateFinReelle () != null)
                                 {
                                   out.print (lDateFormat.format (lTache.getDateFinReelle ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } %>
    </td>
  </tr>
</tbody>
</table>

<table border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td colspan="4">D�passement de charge : </td>
  </tr>
  <tr>
    <td>pourcentage : </td>
    <td><%= lTache.getPrcDepassementCharge () * 100 %></td>
    <td>hommes jour : </td>
    <td><%= lTache.getHJDepassementCharge ()        %></td>
  </tr>
</tbody>
</table>

<%if (lTache.getNbArtefactsEntrees()>0){%>
	<table class="tableau" border="0" cellpadding="0" cellspacing="0">
	<tbody>
	  <tr>
	    <td class="caseNiveau1">Artefact</td>
	    <td class="caseNiveau1">Disponibilit�</td>
	    <td class="caseNiveau1">Responsable</td>
	  </tr>
	  <%for (int i = 0; i < lTache.getNbArtefactsEntrees(); i ++)
	    {
	      lArtefact = lTache.getArtefact(i) ;
	  %>
	    <tr>
	      <td class='caseNiveau2'><%= lArtefact.getNom()%></td>
	      <td class='caseNiveau2'><%= lArtefact.estDisponible()%></td>
	      <td class='caseNiveau2'><%= lArtefact.getTacheEntree().getCollaborateur()%></td>
	    </tr>
	  <%}%>
	</tbody>
	</table>
<%}%>

<%if (lTache.getNbArtefactsSorties()>0){%>
	<table class="tableau" border="0" cellpadding="0" cellspacing="0">
	<tbody>
	  <tr>
	    <td class="caseNiveau1">Artefact</td>
	    <td class="caseNiveau1">Disponibilit�</td>
	    <td class="caseNiveau1">Upload</td>
	  </tr>
	  <%for (int i = 0; i < lTache.getNbArtefactsSorties(); i ++)
	    {
	      lArtefact = lTache.getArtefactSortie(i) ;
	  %>
	    <tr>
	      <td class='caseNiveau2'><%= lArtefact.getNom()%></td>
	      <td class='caseNiveau2'><%= lArtefact.estDisponible()%></td>
	      <td class='caseNiveau2'><%= "Upload"%></td>
	    </tr>
	  <%}%>
	</tbody>
	</table>
<%}%>