<%@ page import="java.text.SimpleDateFormat" %> 
<%@ page import="owep.modele.execution.MCollaborateur" %> 

<jsp:useBean id="pCollaborateur" class="owep.modele.execution.MCollaborateur" scope="page"/>
<jsp:useBean id="lTache"         class="owep.modele.execution.MTache"         scope="page"/> 

<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr class='titre'>
    <td class='titre' rowspan=2>T�ches</td>
    <td class='titre' rowspan=2>Artefact</td>
    <td class='titre' rowspan=2>Charge pr�vue</td>
    <td class='titre' rowspan=2>Temps pass�</td>
    <td class='titre' rowspan=2>Reste � passer</td>
    <td class='titre' rowspan=2>Etat</td>
    <td class='titre' colspan=4>Date</td>
    <td class='titre' rowspan=2>% Avancement</td>
    <td class='titre' rowspan=2>Budget consomm�</td>
    <td class='titre' colspan=2>D�passement de charge</td>
    <td class='titre' rowspan=2>Description du produit</td>
  </tr>
  <tr class='titre'>
    <td class='titre'>d�but pr�vue</td>
    <td class='titre'>d�but r�elle</td>
    <td class='titre'>fin pr�vue</td>
    <td class='titre'>fin r�estim�e</td>
    <td class='titre'>(%)</td>
    <td class='titre'>(h x j)</td>
  </tr>
  <%
    pCollaborateur = (MCollaborateur) request.getAttribute ("pCollaborateur") ;
    for (int i = 0; i < pCollaborateur.getNbTache (); i ++)
    {
      lTache = pCollaborateur.getTache (i) ;
  %>
  <tr>
    <td class='Clair'><%= lTache.getNom ()%></td>

    <!-- Affiche la liste des artefacts -->
	  <td class='Clair'>
	    <%
	      SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
        out.print (lTache.getArtefactSortie (lTache.getNbArtefactSortie () - 1).getNom ()) ;
	      for (int j = 0; j < lTache.getNbArtefactSortie () - 1; j ++)
  	    {
	        out.print ("<br/>" + lTache.getArtefactSortie (j).getNom ()) ;
	      }
	    %>
	  </td>
	  
	  <!-- Affiche les propri�t�s de la t�che -->
	  <td class='Clair'><%= lTache.getChargeInitiale ()                       %></td>
	  <td class='Clair'><%= lTache.getTempsPasse ()                           %></td>
	  <td class='Clair'><%= lTache.getResteAPasser ()                         %></td>
	  <td class='Clair'><%= lTache.getEtat ()                                 %></td>
	  <td class='Clair'><% if (lTache.getDateDebutPrevue () != null)
	                       {
	                         out.print (lDateFormat.format (lTache.getDateDebutPrevue ())) ;
	                       }
	                       else
	                       {
	                         out.print ("X") ;
	                       } %></td>
	  <td class='Clair'><% if (lTache.getDateDebutReelle () != null)
	                       {
	                         out.print (lDateFormat.format (lTache.getDateDebutReelle ())) ;
	                       }
	                       else
	                       {
	                         out.print ("X") ;
	                       } %></td>
	  <td class='Clair'><% if (lTache.getDateFinPrevue () != null)
	                       {
	                         out.print (lDateFormat.format (lTache.getDateFinPrevue ())) ;
	                       }
	                       else
	                       {
	                         out.print ("X") ;
	                       } %></td>
	  <td class='Clair'><% if (lTache.getDateFinReelle () != null)
	                       {
	                         out.print (lDateFormat.format (lTache.getDateFinReelle ())) ;
	                       }
	                       else
	                       {
	                         out.print ("X") ;
	                       } %></td>
	  <td class='Clair'><%= lTache.getPrcAvancement ()                        %></td>
	  <td class='Clair'><%= lTache.getBudgetConsomme ()                       %></td>
	  <td class='Clair'><%= lTache.getPrcDepassementCharge ()                 %></td>
	  <td class='Clair'><%= lTache.getHJDepassementCharge ()                  %></td>
	  <td class='Clair'><%= lTache.getDescription ()                          %></td>
  </tr>
  <%
    }
  %>
</tbody>
</table>
