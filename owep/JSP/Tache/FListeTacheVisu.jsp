<%@page import="java.text.SimpleDateFormat"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MCollaborateur"%>

<jsp:useBean id="lCollaborateur" class="owep.modele.execution.MCollaborateur" scope="page"/>
<jsp:useBean id="lTache"         class="owep.modele.execution.MTache"         scope="page"/> 

<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1" rowspan="2">T�ches</td>
    <td class="caseNiveau1" rowspan="2">Temps pr�vu</td>
    <td class="caseNiveau1" rowspan="2">Temps pass�</td>
    <td class="caseNiveau1" rowspan="2">Reste � passer</td>
    <td class="caseNiveau1" rowspan="2">Etat</td>
    <td class="caseNiveau1" colspan="4">Date</td>
    <td class="caseNiveau1" colspan="2">D�passement de charge</td>
  </tr>
  <tr>
    <td class="caseNiveau1">d�but pr�vue</td>
    <td class="caseNiveau1">d�but r�elle</td>
    <td class="caseNiveau1">fin pr�vue</td>
    <td class="caseNiveau1">fin r�estim�e</td>
    <td class="caseNiveau1">(%)</td>
    <td class="caseNiveau1">(h x j)</td>
  </tr>
  
  <%
    SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
    lCollaborateur = (MCollaborateur) request.getAttribute (CConstante.PAR_COLLABORATEUR) ;
    for (int i = 0; i < lCollaborateur.getNbTaches(); i ++)
    {
      lTache = lCollaborateur.getTache (i) ;
  %>
    <tr>
      <td class='caseNiveau2'><a href="./TacheVisu?pTacheAVisualiser=<%= lTache.getId()%>"><%= lTache.getNom ()%></a></td>
  
      <!-- Affiche la liste des artefacts -->
            
      <!-- Affiche les propri�t�s de la t�che -->
      <td class='caseNiveau3'><%=lTache.getChargeInitiale ()%></td>
      <td class='caseNiveau3'><%=lTache.getTempsPasse ()    %></td>
      <td class='caseNiveau3'><%=lTache.getResteAPasser ()  %></td>
      <!-- On passe l id du bouton cliqu� et l id de la tache en parametre de la requete -->      
      <td class='caseNiveau3'>
      <!-- Si le collaborateur n'a pas de taches en �tat d�marr�, on peut commencer ou reprendre n'importe quelle t�che -->  
      <% if(lCollaborateur.getTacheEnCours()==0)
           {
            switch (lTache.getEtat())
             { 
               case -1 : %>
                 <%-- Pour etat cr�� --%>
                 T�che non pr�te
            <%  break ;
               case 0 : %>
                 <%-- Affichage boutons pour etat non commenc� --%>
                 <a href="./Etat?pBoutonClique=1&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY%>"></a><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>">
            <%  break ; 
               case 1 : %>
                 <%-- Affichage boutons pour etat commenc� --%>
                 <IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAYACTIF%>"><a href="./Etat?pBoutonClique=2&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"></a><a href="./Etat?pBoutonClique=3&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>"></a>
            <% break ; 
               case 2 : %>
                 <%-- Affichage boutons pour etat suspendu --%>
                 <a href="./Etat?pBoutonClique=1&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY%>"></a><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSEACTIF%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>">
            <% break ;
               case 3 : %>
                 <!-- Affichage boutons pour etat termin� -->
                 Termin�e
            <!-- Si le collaborateur a une tache en �tat d�marr�, on ne peut modifier l'�tat que de cette t�che -->
            <% }
           } 
          else if(lCollaborateur.getTacheEnCours()==1)
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
                 <IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAYACTIF%>"><a href="./Etat?pBoutonClique=2&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE%>"></a><a href="./Etat?pBoutonClique=3&<%=CConstante.PAR_TACHE%>=<%=lTache.getId()%>"><IMG SRC="<%=owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP%>"></a>
               
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
      <td class='caseNiveau3'><%= lTache.getPrcDepassementCharge () * 100 %></td>
      <td class='caseNiveau3'><%= lTache.getHJDepassementCharge ()        %></td>
    </tr>
  <%
    }
  %>
</tbody>
</table>
