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
   Aucune t�che n'a encore �t� planifi�e pour cette it�ration.<BR><BR>
   
   Date de d�but pr�vue : 
   <% if (lIteration.getDateDebutPrevue () != null)
                         {
                           out.print (lDateFormat.format (lIteration.getDateDebutPrevue ())) ;
                         }
                         else
                         {
                           out.print ("inconnue") ;
                         } %>
   <BR>
   Date de fin pr�vue : 
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
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Libell� de la t�che.')" onmouseout="tooltipOff(this, event)">T�ches</a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Nom du collaborateur qui r�alise la t�che.')" onmouseout="tooltipOff(this, event)">Collaborateurs</a>
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
  <tr>      
      <td class="caseNiveau1" colspan="2">
        <a class="niveau1" href="#" onmouseover="tooltipOn(this, event, 'Bilan des charges et des dates pour toutes les t�ches de l\'it�ration.')" onmouseout="tooltipOff(this, event)">Total de l'it�ration</a>
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
          Termin�e
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
pCodeAide  = "La page de <b>Suivi d'avancement du projet</b> vous permet de visualiser l'ensemble des t�ches <b>� r�aliser</b> pour une it�ration donn�." ;
pCodeAide += " Elle vous offre une vue � la fois g�n�rale et d�taill�e de la r�alisation de l'it�ration." ;
pCodeAide += " Vous pouvez y voir les <b>collaborateurs</b> qui r�alisent chacune des t�ches, les <b>charges</b>, les <b>dates de r�alisation</b> et l'<b>�tat d'avancement</b>." ;
pCodeAide += " Choisissez l'<b>it�ration � visualiser</b> par le biais du s�lecteur d'it�ration." ;
</script>
