<%@page import="java.text.SimpleDateFormat"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MTache"%>
<%@page import="owep.infrastructure.Session"%>

<jsp:useBean id="lArtefact"  class="owep.modele.execution.MArtefact"  scope="page"/>
<jsp:useBean id="lTache"     class="owep.modele.execution.MTache"     scope="page"/> 
<jsp:useBean id="lSession"   class="owep.infrastructure.Session"      scope="page"/> 
<jsp:useBean id="lCondition" class="owep.modele.execution.MCondition" scope="page"/>

<%
    SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
    lTache = (MTache) request.getAttribute (CConstante.PAR_TACHE) ;
    lSession = (Session) request.getAttribute (CConstante.SES_SESSION) ;
    
    String [] tabEtat = {"Créée", "Prète", "Commencée", "Suspendue", "Terminée"};

	String PATH_ARTEFACT = lSession.getConfiguration().getPathArtefact();
%>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tbody>
<tr>
  <td width="50%">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tbody>
      <tr>
        <td width="30%" class="caseNiveau2SansBordure">Tâche : </td>
        <td align="left" class="caseNiveau3SansBordure"><%= lTache.getNom ()%></td>
      </tr>
      <tr>
        <td width="30%" class="caseNiveau2SansBordure">Etat : </td>
        <td align="left" class="caseNiveau3SansBordure"><%= tabEtat[lTache.getEtat()+1]%></td>
      </tr>
      <%if (lTache.getDescription() != "") {%>
      <tr>
        <td width="30%" class="caseNiveau2SansBordure">Description : </td>
        <td align="left" class="caseNiveau3SansBordure"><%= lTache.getDescription()%></td>
      </tr>
      <%}%>
    </tbody>
    </table> 
  </td>

  <%if (lTache.getNbConditions()>0 && lTache.getEtat()==-1){%>
  <td width="50%">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tbody>
      <tr>
        <td width="50%" valign="top" class="caseNiveau2SansBordure">
          <center>Conditions pour que la tache puisse démarrer</center><br>
	      <table width="100%" class="tableau" border="0" cellpadding="0" cellspacing="0">
	      <tbody>
	        <tr>
	          <td class="caseNiveau1">Tache attendue</td>
	          <td class="caseNiveau1">Etat</td>
	          <td class="caseNiveau1">Condition</td>
	        </tr>
	        <%for (int i = 0; i < lTache.getNbConditions(); i++)
	          {
	            lCondition = lTache.getCondition(i) ;
	        %>
	          <tr>
	            <td class='caseNiveau2'><%= lCondition.getTachePrecedente().getNom()%></td>
	            <td class='caseNiveau2'><%= tabEtat[lCondition.getEtat()]%></td>
	            <td class='caseNiveau2'><%= tabEtat[lCondition.getTachePrecedente().getEtat()]%></td>
	          </tr>
	        <%}%>
	      </tbody>
	      </table>
        </td>	
      </tr>
    </tbody>
    </table> 
  </td>
  <%}%> 
</tr>

</tbody>
</table> 
 
<br>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
	<td width="15%" class="caseNiveau2SansBordure">Temps prévu : </td>
	<td width="20%" class="caseNiveau3SansBordure"><%=lTache.getChargeInitiale ()%></td>
    <td width="15%" class="caseNiveau2SansBordure">Temps passé : </td>
    <td width="20%" class="caseNiveau3SansBordure"><%=lTache.getTempsPasse ()    %></td>
    <td width="15%" class="caseNiveau2SansBordure">Reste à passer : </td>
    <td width="15%" class="caseNiveau3SansBordure"><%=lTache.getResteAPasser ()  %></td>
  </tr>
</tbody>
</table>

<br>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td colspan="4" class="caseNiveau2SansBordure">Dates : </td>
    <td colspan="2" class="caseNiveau2SansBordure">Dépassement de charge : </td>
  </tr>
  <tr>
    <td width="15%" class="caseNiveau2SansBordure">début prévue : </td>
    <td width="20%" class="caseNiveau3SansBordure"><% if (lTache.getDateDebutPrevue () != null)
           {
             out.print (lDateFormat.format (lTache.getDateDebutPrevue ())) ;
           }
           else
           {
             out.print ("X") ;
           } %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">début réelle : </td>
    <td width="20%" class="caseNiveau3SansBordure"><% if (lTache.getDateDebutReelle () != null)
           {
             out.print (lDateFormat.format (lTache.getDateDebutReelle ())) ;
           }
           else
           {
             out.print ("X") ;
           } %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">pourcentage : </td>
    <td width="20%" class="caseNiveau3SansBordure"><%= lTache.getPrcDepassementCharge () * 100 %></td>
  </tr>
  <tr>
    <td width="15%" class="caseNiveau2SansBordure">fin prévue</td>
    <td width="20%" class="caseNiveau3SansBordure"><% if (lTache.getDateFinPrevue () != null)
           {
             out.print (lDateFormat.format (lTache.getDateFinPrevue ())) ;
           }
           else
           {
             out.print ("X") ;
           } %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">fin réestimée : </td>
    <td width="20%" class="caseNiveau3SansBordure"><% if (lTache.getDateFinReelle () != null)
           {
             out.print (lDateFormat.format (lTache.getDateFinReelle ())) ;
           }
           else
           {
             out.print ("X") ;
           } %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">hommes jour : </td>
    <td width="20%" class="caseNiveau3SansBordure"><%= lTache.getHJDepassementCharge ()        %></td>
  </tr>
</tbody>
</table>
<!--
<br>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td colspan="5" class="caseNiveau2SansBordure">Dépassement de charge : </td>
  </tr>
  <tr>
    <td width="15%" class="caseNiveau2SansBordure">pourcentage : </td>
    <td width="20%" class="caseNiveau3SansBordure"><%= lTache.getPrcDepassementCharge () * 100 %></td>
    <td width="15%" class="caseNiveau2SansBordure">hommes jour : </td>
    <td width="20%" class="caseNiveau3SansBordure"><%= lTache.getHJDepassementCharge ()        %></td>
    <td width="30%"></td>
  </tr>
</tbody>
</table>
-->
<br><br>

<table width="100%">
  <tr>
<%if (lTache.getNbArtefactsEntrees()>0){%>
  <td width="50%" valign="top" class="caseNiveau2SansBordure">
    <center>Artefacts en entrée de la tache</center><br>
	<table width="100%" class="tableau" border="0" cellpadding="0" cellspacing="0">
	<tbody>
	  <tr>
	    <td class="caseNiveau1">Artefact</td>
	    <td class="caseNiveau1">Disponibilité</td>
	    <td class="caseNiveau1">Responsable</td>
	  </tr>
	  <%for (int i = 0; i < lTache.getNbArtefactsEntrees(); i ++)
	    {
	      lArtefact = lTache.getArtefactEntree(i) ;  
	  %>
	    <tr>
	      <td class='caseNiveau2'><%= lArtefact.getNom()%></td>
	      <%if (lArtefact.getNomFichier() != null){%>
	        <td class='caseNiveau2'><a href=<%= "/owep/"+PATH_ARTEFACT+lArtefact.getPathFichier()+lArtefact.getNomFichier()%>><%= lArtefact.getNomFichier()%></a></td>
	      <%}else{%>
            <td class='caseNiveau2'>Non disponible</td>
          <%}%>
	      <td class='caseNiveau2'><%= lArtefact.getResponsable().getPrenom()+" "+lArtefact.getResponsable().getNom()%></td>
	    </tr>
	  <%}%>
	</tbody>
	</table>
  </td>	
<%}%>

<%if (lTache.getNbArtefactsSorties()>0){%>
  <td width="50%" valign="top" class="caseNiveau2SansBordure">
    <center>Artefacts en sortie de la tache</center><br>
	<table width="100%" class="tableau" border="0" cellpadding="0" cellspacing="0">
	<tbody>
	  <tr>
	    <td class="caseNiveau1">Artefact</td>
	    <td class="caseNiveau1">Disponibilité</td>
	    <td class="caseNiveau1">Upload</td>
	  </tr>
	  <%for (int i = 0; i < lTache.getNbArtefactsSorties(); i ++)
	    {
	      lArtefact = lTache.getArtefactSortie(i) ;
	  %>
	    <tr>
	      <td class='caseNiveau2'><%= lArtefact.getNom()%></td>
	      <%if (lArtefact.getNomFichier() != null){%>
	        <td class='caseNiveau2'><a href=<%= "/owep/"+PATH_ARTEFACT+lArtefact.getPathFichier()+lArtefact.getNomFichier()%>><%= lArtefact.getNomFichier()%></a></td>
	      <%}else{%>
            <td class='caseNiveau2'>Non disponible</td>
          <%}%>
	        <td class='caseNiveau2'><a href=<%= "/owep/Artefact/ArtefactAjout?pArtefact="+ Integer.toString(lArtefact.getId())+"&pTacheAVisualiser="+lTache.getId()%>><%= "Ajouter"%></a></td>
	    </tr>
	  <%}%>
	</tbody>
	</table>
  </td>	
<%}%>

  </tr>
  
</table>