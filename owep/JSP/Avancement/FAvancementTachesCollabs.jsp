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
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'T�ches que le collaborateur a r�alis� ou devra r�aliser.')" onmouseout="tooltipOff(this, event)">T�ches</a>
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
      <td class="caseNiveau3" colspan="13"><center>Aucune t�che pr�vue pour cette it�ration</center></td>
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
pCodeAide  = "La page de <b>Suivi d'avancement des collaborateurs</b> vous permet de visualiser le travail que r�alise chaque collaborateur pour les it�rations pass�s, futures ou en cours." ;
pCodeAide += " Si vous avez choisi <b>l'it�ration en cours</b>, vous visualiserez la t�che qu'est en train d'effectuer chaque <b>collaborateur</b>" ;
pCodeAide += " En cliquant sur le nom d'un collaborateur, vous pourrez visualiser le <b>d�tail des t�ches</b> qu'il doit r�aliser sur une it�ration." ;
pCodeAide += " Pour les <b>it�rations pass�s</b> et <b>futures</b>, la liste des t�ches � r�aliser, par collaborateur, sera affich�." ;
</script>
