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
   Le collaborateur <%=lCollaborateur.getNom()%> n'a pas de t�ches � r�aliser dans cette it�ration.
<%
   }
   else
   {
%>
  
<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'T�ches � r�aliser par le collaborateur au cours de l\'it�ration.')" onmouseout="tooltipOff(this, event)">T�ches</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Charge affect�e par le chef de projet sur la t�che (en heures).')" onmouseout="tooltipOff(this, event)">Temps pr�vu(h)</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Temps effectivement pass� par le collaborateur sur la t�che.')" onmouseout="tooltipOff(this, event)">Temps pass�(h)</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Temps n�cessaire, estim� par le collaborateur, pour r�aliser la t�che.')" onmouseout="tooltipOff(this, event)">Reste � passer(h)</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event,
       '<b>Cr��e</b> si le collaborateur ne peut lancer la t�che du fait d\'une t�che tierce non termin� ou d�marr�.<br/>' +
       '<b>Non d�marr�</b> si le collaborateur n\'a pas entam� la t�che.<br/>' +
       '<b>En cours</b> si le collaborateur travaille sur la t�che.<br/>' +
       '<b>Suspendu</b> si le collaborateur a entam� la t�che mais n\'y travaille pas actuellement dessus.<br/>' +
       '<b>Termin�</b> si le collbarateur a fini sa t�che.<br/>')" onmouseout="tooltipOff(this, event)">Etat</a>
    </td>
    <td class="caseNiveau1" colspan="4">
      Date
    </td>
    <td class="caseNiveau1" colspan="2">
      D�passement de charge
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Pourcentage de temps effectivement pass� sur la t�che par rapport au temps pr�vu.')" onmouseout="tooltipOff(this, event)">Budget consomm�(%)</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Niveau de r�alisation la t�che (en pourcent).')" onmouseout="tooltipOff(this, event)">Avancement(%)</a>
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle le chef de projet a pr�vue de d�marrer la t�che.')" onmouseout="tooltipOff(this, event)">d�but pr�vue</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle le collaborateur � effectivement d�marr� la t�che.')" onmouseout="tooltipOff(this, event)">d�but r�elle</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle le chef de projet a pr�vue de terminer la t�che.')" onmouseout="tooltipOff(this, event)">fin pr�vue</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle le collaborateur � effectivement termin� la t�che.')" onmouseout="tooltipOff(this, event)">fin r�estim�e</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'D�passement du temps de r�alisation pour la t�che (en pourcent).')" onmouseout="tooltipOff(this, event)">(%)</a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'D�passement du temps de r�alisation pour la t�che (en heures).')" onmouseout="tooltipOff(this, event)">(h)</a>
    </td>
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
          Non pr�te
        <%  
          break ;
          case 0 : 
        %>
          Non d�marr�e
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
          Termin�e
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


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Suivi d'avancement du collaborateur</b> vous permet de visualiser le <b>d�tail du travail</b> que doit r�aliser le collaborateur sur l'it�ration en cours." ;
pCodeAide += " Le tableau suivant d�taille les <b>charges</b>, les <b>dates de r�alisation</b> et l'<b>�tat d'avancement</b> pour chaque t�che." ;
</script>
