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
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Tâches que vous devez réaliser.')" onmouseout="tooltipOff(this, event)">
        Tâches
      </a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Charge affectée par le chef de projet sur la tâche (en heures).')" onmouseout="tooltipOff(this, event)">
        Temps prévu(h)
      </a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Temps que vous avez effectivement passé sur la tâche.')" onmouseout="tooltipOff(this, event)">
        Temps passé(h)
      </a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Temps nécessaire que vous avez estimé pour terminer la tâche.')" onmouseout="tooltipOff(this, event)">
        Reste à passer(h)
      </a>
    </td>
    <td class="caseNiveau1" rowspan="2">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event,
       '<b>Créée</b> si vous ne pouvez lancer la tâche du fait d\'une tâche tierce non terminé ou démarré.<br/>' +
       '<b>Non démarré</b> si vous n\'avez pas entamé la tâche.<br/>' +
       '<b>En cours</b> si vous travaillez actuellement sur la tâche.<br/>' +
       '<b>Suspendu</b> si vous avez entamé la tâche mais n\'y travaillez pas actuellement dessus.<br/>' +
       '<b>Terminé</b> si vous avez fini votre tâche.<br/>')" onmouseout="tooltipOff(this, event)">Etat
      </a>
    </td>
    <td class="caseNiveau1" colspan="4">
      Date
    </td>
    <td class="caseNiveau1" colspan="2">
      Dépassement de charge
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date à laquelle le chef de projet a prévue de démarrer la tâche.')" onmouseout="tooltipOff(this, event)">
        début prévue
      </a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date à laquelle vous avez effectivement démarré la tâche.')" onmouseout="tooltipOff(this, event)">
        début réelle
      </a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date à laquelle le chef de projet a prévue de terminer la tâche.')" onmouseout="tooltipOff(this, event)">
        fin prévue
      </a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Date à laquelle vous avez effectivement terminé la tâche.')" onmouseout="tooltipOff(this, event)">
        fin réestimée
      </a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Dépassement du temps de réalisation pour la tâche (en pourcent).')" onmouseout="tooltipOff(this, event)">
        (%)
      </a>
    </td>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Dépassement du temps de réalisation pour la tâche (en heures).')" onmouseout="tooltipOff(this, event)">
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
            
      <!-- Affiche les propriétés de la tâche -->
      <td class='caseNiveau3'><%=(int)lTache.getChargeInitiale ()%></td>
      <td class='caseNiveau3'><%=(int)lTache.getTempsPasse ()    %></td>
      <td class='caseNiveau3'><%=(int)lTache.getResteAPasser ()  %></td>
      <!-- On passe l id du bouton cliqué et l id de la tache en parametre de la requete -->      
      <td class='caseNiveau3'>
      
      <!-- Si l'itération visualisée correspond à l'itération en cours -->
      <% if (lSession.getIteration().getEtat() >= 1) {%>
      
      <!-- Si le collaborateur n'a pas de taches en état démarré, on peut commencer ou reprendre n'importe quelle tâche -->  
      <% if(lCollaborateur.getTacheEnCours()==-1)
           {
            switch (lTache.getEtat())
             { 
               case -1 : %>
                 <%-- Pour etat créé --%>
                 Tâche non prête
            <%  break ;
               case 0 : %>
                 <%-- Affichage boutons pour etat non commencé --%>
                 <a href="/owep/Tache/Etat?pBoutonClique=1&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY%>"></a><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>">
            <%  break ; 
               case 1 : %>
                 <%-- Affichage boutons pour etat commencé --%>
                 <IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAYACTIF%>"><a href="/owep/Tache/Etat?pBoutonClique=2&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"></a><a href="/owep/Tache/Etat?pBoutonClique=3&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>"></a>
            <% break ; 
               case 2 : %>
                 <%-- Affichage boutons pour etat suspendu --%>
                 <a href="/owep/Tache/Etat?pBoutonClique=1&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY%>"></a><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSEACTIF%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>">
            <% break ;
               case 3 : %>
                 <!-- Affichage boutons pour etat terminé -->
                 Terminée
            <!-- Si le collaborateur a une tache en état démarré, on ne peut modifier l'état que de cette tâche -->
            <% }
           } 
          else if(lCollaborateur.getTacheEnCours()!=-1)
           {
            switch (lTache.getEtat())
             { 
               case -1 : 
                 %>
                 <%-- Pour etat créé --%>
                 Tâche non prête
            <%  break ;
               case 0 : 
                 %>
                 <%-- Affichage boutons non clicables pour etat non commencé --%>
                 <IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>">
            <%   break ; 
               case 1 : 
                 %>
                 
									<%-- Affichage boutons pour etat commencé --%>
                 <IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAYACTIF%>"><a href="/owep/Tache/Etat?pBoutonClique=2&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"></a><a href="/owep/Tache/Etat?pBoutonClique=3&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>"></a>
               
            <%   break ;  
               case 2 : 
                 %>
                 <%-- Affichage boutons non clicables pour etat suspendu --%>
                 <IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSEACTIF%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>">
            <%   break ; 
               case 3 : %>
                 <!-- Affichage boutons pour etat terminé -->
                 Terminée
          <% }
           } %>

		<!-- Si on ne visualise pas l'itération en cours -->
		<%} else {%>
		Tâche non prête	
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
    Vous n'avez pas de tâches à réaliser dans cette itération.
<%
    }
  }
  else
  {
%>
    Aucune itération.
<%
  }
%>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Liste des tâches</b> permet de visualiser l\'ensemble des tâches que voud devez réaliser." ;
pCodeAide += " Lorsque vous choisissez l\'<b>itération courante</b>, vous avez la possibilité de <b>démarrer</b> le chronomètre." ;
pCodeAide += " Celui-ci s\'active en cliquant sur le bouton <b>Play</b> et permet de mesurer le temps que vous passer sur une seule <b>tâche</b>." ;
pCodeAide += " Pour lancer ensuite une nouvelle tâche, vous devez <b>stopper</b> celle qui est en cours." ;
pCodeAide += " Certaines tâches ne peuvent être démarrer que si les <b>conditions</b> définies par le chef de projet sont respectées (tâche tierces terminées, etc.)." ;
</script>
