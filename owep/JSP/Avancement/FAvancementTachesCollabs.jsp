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
    <td class="caseNiveau1" rowspan="2">Collaborateurs</td>
    <td class="caseNiveau1" rowspan="2">T�ches</td>
    <td class="caseNiveau1" rowspan="2">Temps pr�vu(h)</td>
    <td class="caseNiveau1" rowspan="2">Temps pass�(h)</td>
    <td class="caseNiveau1" rowspan="2">Reste � passer(h)</td>
    <td class="caseNiveau1" rowspan="2">Etat</td>
    <td class="caseNiveau1" colspan="4">Date</td>
    <td class="caseNiveau1" colspan="2">D�passement de charge</td>
    <td class="caseNiveau1" rowspan="2">Budget consomm�(%)</td>
    <td class="caseNiveau1" rowspan="2">Avancement(%)</td>
  </tr>
  <tr>
    <td class="caseNiveau1">d�but pr�vue</td>
    <td class="caseNiveau1">d�but r�elle</td>
    <td class="caseNiveau1">fin pr�vue</td>
    <td class="caseNiveau1">fin r�estim�e</td>
    <td class="caseNiveau1">(%)</td>
    <td class="caseNiveau1">(h)</td>
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
  
  
