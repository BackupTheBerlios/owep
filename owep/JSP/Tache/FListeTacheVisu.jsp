<%@page import="java.text.SimpleDateFormat"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MCollaborateur"%>
<%@page import="owep.infrastructure.Session"%>

<jsp:useBean id="lSession" class="owep.infrastructure.Session" scope="page"/>
<jsp:useBean id="lCollaborateur" class="owep.modele.execution.MCollaborateur" scope="page"/>
<jsp:useBean id="lTache"         class="owep.modele.execution.MTache"         scope="page"/> 

<%
    // Recuperation de la session
    HttpSession httpSession = request.getSession(true);
    lSession = (Session) httpSession.getAttribute("SESSION");

    SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
    lCollaborateur = (MCollaborateur) request.getAttribute (CConstante.PAR_COLLABORATEUR) ;
  if(lSession.getIteration() != null)
  {
    if(lCollaborateur.getNbTaches()>0)
    {
%>

<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'T�ches que vous devez r�aliser.')" onmouseout="tooltipOff(this, event)">
        T�ches
      </a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Charge affect�e par le chef de projet sur la t�che (en heures).')" onmouseout="tooltipOff(this, event)">
        Temps pr�vu(h)
      </a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Temps que vous avez effectivement pass� sur la t�che.')" onmouseout="tooltipOff(this, event)">
        Temps pass�(h)
      </a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Temps n�cessaire que vous avez estim� pour terminer la t�che.')" onmouseout="tooltipOff(this, event)">
        Reste � passer(h)
      </a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event,
       '<b>Cr��e</b> si vous ne pouvez lancer la t�che du fait d\'une t�che tierce non termin� ou d�marr�.<br/>' +
       '<b>Non d�marr�</b> si vous n\'avez pas entam� la t�che.<br/>' +
       '<b>En cours</b> si vous travaillez actuellement sur la t�che.<br/>' +
       '<b>Suspendu</b> si vous avez entam� la t�che mais n\'y travaillez pas actuellement dessus.<br/>' +
       '<b>Termin�</b> si vous avez fini votre t�che.<br/>')" onmouseout="tooltipOff(this, event)">Etat
      </a>
    </td>
    <td class="caseNiveau1" colspan="4">
      Date
    </td>
    <td class="caseNiveau1" colspan="2">
      D�passement de charge
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle le chef de projet a pr�vue de d�marrer la t�che.')" onmouseout="tooltipOff(this, event)">
        d�but pr�vue
      </a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle vous avez effectivement d�marr� la t�che.')" onmouseout="tooltipOff(this, event)">
        d�but r�elle
      </a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle le chef de projet a pr�vue de terminer la t�che.')" onmouseout="tooltipOff(this, event)">
        fin pr�vue
      </a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date � laquelle vous avez effectivement termin� la t�che.')" onmouseout="tooltipOff(this, event)">
        fin r�estim�e
      </a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'D�passement du temps de r�alisation pour la t�che (en pourcent).')" onmouseout="tooltipOff(this, event)">
        (%)
      </a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'D�passement du temps de r�alisation pour la t�che (en heures).')" onmouseout="tooltipOff(this, event)">
        (h)
      </a>
    </td>
  </tr>
  
  <%
    for (int i = 0; i < lCollaborateur.getNbTaches(); i ++)
    {
      lTache = lCollaborateur.getTache (i) ;
  %>
    <tr>
      <td class='caseNiveau2'><a href="/owep/Tache/TacheVisu?pTacheAVisualiser=<%= lTache.getId()%>"><%= lTache.getNom ()%></a></td>
  
      <!-- Affiche la liste des artefacts -->
            
      <!-- Affiche les propri�t�s de la t�che -->
      <td class='caseNiveau3'><%=(int)lTache.getChargeInitiale ()%></td>
      <td class='caseNiveau3'><%=(int)lTache.getTempsPasse ()    %></td>
      <td class='caseNiveau3'><%=(int)lTache.getResteAPasser ()  %></td>
      <!-- On passe l id du bouton cliqu� et l id de la tache en parametre de la requete -->      
      <td class='caseNiveau3'>
      
      <!-- Si l'it�ration visualis�e correspond � l'it�ration en cours -->
      <% if (lSession.getIteration().getEtat() >= 1) {%>
      
      <!-- Si le collaborateur n'a pas de taches en �tat d�marr�, on peut commencer ou reprendre n'importe quelle t�che -->  
      <% if(lCollaborateur.getTacheEnCours()==-1)
           {
            switch (lTache.getEtat())
             { 
               case -1 : %>
                 <%-- Pour etat cr�� --%>
                 T�che non pr�te
            <%  break ;
               case 0 : %>
                 <%-- Affichage boutons pour etat non commenc� --%>
                 <a href="/owep/Tache/Etat?pBoutonClique=1&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY%>"></a><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>">
            <%  break ; 
               case 1 : %>
                 <%-- Affichage boutons pour etat commenc� --%>
                 <IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAYACTIF%>"><a href="/owep/Tache/Etat?pBoutonClique=2&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"></a><a href="/owep/Tache/Etat?pBoutonClique=3&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>"></a>
            <% break ; 
               case 2 : %>
                 <%-- Affichage boutons pour etat suspendu --%>
                 <a href="/owep/Tache/Etat?pBoutonClique=1&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY%>"></a><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSEACTIF%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>">
            <% break ;
               case 3 : %>
                 <!-- Affichage boutons pour etat termin� -->
                 Termin�e
            <!-- Si le collaborateur a une tache en �tat d�marr�, on ne peut modifier l'�tat que de cette t�che -->
            <% }
           } 
          else if(lCollaborateur.getTacheEnCours()!=-1)
           {
            switch (lTache.getEtat())
             { 
               case -1 : 
                 %>
                 <%-- Pour etat cr�� --%>
                 T�che non pr�te
            <%  break ;
               case 0 : 
                 %>
                 <%-- Affichage boutons non clicables pour etat non commenc� --%>
                 <IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>">
            <%   break ; 
               case 1 : 
                 %>
                 
									<%-- Affichage boutons pour etat commenc� --%>
                 <IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAYACTIF%>"><a href="/owep/Tache/Etat?pBoutonClique=2&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"></a><a href="/owep/Tache/Etat?pBoutonClique=3&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>"></a>
               
            <%   break ;  
               case 2 : 
                 %>
                 <%-- Affichage boutons non clicables pour etat suspendu --%>
                 <IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSEACTIF%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>">
            <%   break ; 
               case 3 : %>
                 <!-- Affichage boutons pour etat termin� -->
                 Termin�e
          <% }
           } %>

		<!-- Si on ne visualise pas l'it�ration en cours -->
		<%} else {%>
		T�che non pr�te	
        <%}%>

      </td>
      <td class='caseNiveau3'><% if (lTache.getDateDebutPrevue () != null)
                                 {
                                   out.print (lDateFormat.format (lTache.getDateDebutPrevue ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } %>
      </td>
      <td class='caseNiveau3'><% if (lTache.getDateDebutReelle () != null)
                                 {
                                   out.print (lDateFormat.format (lTache.getDateDebutReelle ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } %>
      </td>
      <td class='caseNiveau3'><% if (lTache.getDateFinPrevue () != null)
                              {
                                out.print (lDateFormat.format (lTache.getDateFinPrevue ())) ;
                              }
                           else
                           {
                             out.print ("X") ;
                           } %>
      </td>
      <td class='caseNiveau3'><% if (lTache.getDateFinReelle () != null)
                                 {
                                   out.print (lDateFormat.format (lTache.getDateFinReelle ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } %>
      </td>
      <td class='caseNiveau3'><%= (int)(lTache.getPrcDepassementCharge () * 100) %></td>
      <td class='caseNiveau3'><%= (int)lTache.getHJDepassementCharge ()        %></td>
    </tr>
  <%
    }
  %>
</tbody>
</table>

<%
    }
    else
    {    
%>
    Vous n'avez pas de t�ches � r�aliser dans cette it�ration.
<%
    }
  }
  else
  {
%>
    Aucune it�ration.
<%
  }
%>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Liste des t�ches</b> permet de visualiser l\'ensemble des t�ches que voud devez r�aliser." ;
pCodeAide += " Lorsque vous choisissez l\'<b>it�ration courante</b>, vous avez la possibilit� de <b>d�marrer</b> le chronom�tre." ;
pCodeAide += " Celui-ci s\'active en cliquant sur le bouton <b>Play</b> et permet de mesurer le temps que vous passer sur une seule <b>t�che</b>." ;
pCodeAide += " Pour lancer ensuite une nouvelle t�che, vous devez <b>stopper</b> celle qui est en cours." ;
pCodeAide += " Certaines t�ches ne peuvent �tre d�marrer que si les <b>conditions</b> d�finies par le chef de projet sont respect�es (t�che tierces termin�es, etc.)." ;
</script>
