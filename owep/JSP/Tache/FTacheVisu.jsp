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
        <td width="30%" class="caseNiveau2SansBordure" onmouseover="tooltipOn(this, event, 'Temps nécessaire, estimé par le collaborateur, pour réaliser la tâche.')" onmouseout="tooltipOff(this, event)">
          <a href="#" class="niveau2" onmouseover="tooltipOn(this, event,
           '<b>Créée</b> si le collaborateur ne peut lancer la tâche du fait d\'une tâche tierce non terminé ou démarré.<br/>' +
           '<b>Non démarré</b> si le collaborateur n\'a pas entamé la tâche.<br/>' +
           '<b>En cours</b> si le collaborateur travaille sur la tâche.<br/>' +
           '<b>Suspendu</b> si le collaborateur a entamé la tâche mais n\'y travaille pas actuellement dessus.<br/>' +
           '<b>Terminé</b> si le collaborateur a fini sa tâche.<br/>')" onmouseout="tooltipOff(this, event)">
            Etat : 
          </a>
        </td>
        <td align="left" class="caseNiveau3SansBordure">
          <%= tabEtat[lTache.getEtat()+1]%>
        </td>
      </tr>
      <%if (lTache.getDescription() != "") {%>
      <tr>
        <td width="30%" class="caseNiveau2SansBordure">
          <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Description de ce qui doit être réalisé au cours de la tâche.')" onmouseout="tooltipOff(this, event)">
            Description :
          </a>
        </td>
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
            <td class="caseNiveau1">
              <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Tâche vers laquelle il y\'a une dépendance.')" onmouseout="tooltipOff(this, event)">
                Tache attendue
              </a>
            </td>
            <td class="caseNiveau1">
              <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Etat dans lequel doit être la tâche pour que la tâche puisse être démarrée.')" onmouseout="tooltipOff(this, event)">
                Etat
              </a>
            </td>
            <td class="caseNiveau1">
              <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Etat dans lequel doit être la tâche pour que la tâche courante puisse être démarrée.')" onmouseout="tooltipOff(this, event)">
                Condition
              </a>
            </td>
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
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Charge affectée par le chef de projet sur la tâche (en heures).')" onmouseout="tooltipOff(this, event)">
        Temps prévu :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure">
      <%=lTache.getChargeInitiale ()%>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Temps que vous avez effectivement passé sur la tâche.')" onmouseout="tooltipOff(this, event)">
        Temps passé :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure">
      <%=lTache.getTempsPasse ()    %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Temps nécessaire que vous avez estimé pour terminer la tâche.')" onmouseout="tooltipOff(this, event)">
        Reste à passer :
      </a>
    </td>
    <td width="15%" class="caseNiveau3SansBordure">
      <%=lTache.getResteAPasser ()  %>
    </td>
  </tr>
</tbody>
</table>

<br>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td colspan="4" class="caseNiveau2SansBordure">
      Dates :
    </td>
    <td colspan="2" class="caseNiveau2SansBordure">
      Dépassement de charge :
    </td>
  </tr>
  <tr>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Date à laquelle le chef de projet a prévue de démarrer la tâche.')" onmouseout="tooltipOff(this, event)">
        début prévue :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure"><% if (lTache.getDateDebutPrevue () != null)
           {
             out.print (lDateFormat.format (lTache.getDateDebutPrevue ())) ;
           }
           else
           {
             out.print ("X") ;
           } %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Date à laquelle vous avez effectivement démarré la tâche.')" onmouseout="tooltipOff(this, event)">
        début réelle :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure"><% if (lTache.getDateDebutReelle () != null)
           {
             out.print (lDateFormat.format (lTache.getDateDebutReelle ())) ;
           }
           else
           {
             out.print ("X") ;
           } %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Dépassement du temps de réalisation pour la tâche (en pourcent).')" onmouseout="tooltipOff(this, event)">
        pourcentage :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure">
      <%= lTache.getPrcDepassementCharge () * 100 %>
    </td>
  </tr>
  <tr>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Date à laquelle le chef de projet a prévue de terminer la tâche.')" onmouseout="tooltipOff(this, event)">
        fin prévue
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure">
      <% if (lTache.getDateFinPrevue () != null)
         {
           out.print (lDateFormat.format (lTache.getDateFinPrevue ())) ;
         }
         else
         {
           out.print ("X") ;
         }
       %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Date à laquelle vous avez effectivement terminé la tâche.')" onmouseout="tooltipOff(this, event)">
        fin réestimée :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure"><% if (lTache.getDateFinReelle () != null)
           {
             out.print (lDateFormat.format (lTache.getDateFinReelle ())) ;
           }
           else
           {
             out.print ("X") ;
           } %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Dépassement du temps de réalisation pour la tâche (en heures).')" onmouseout="tooltipOff(this, event)">
        hommes / jour :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure">
      <%= lTache.getHJDepassementCharge () %>
    </td>
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


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Détail de la tâche</b> vous permet de visualiser précisément les <b>caractéristiques</b> de la tâche et de ce qui doit être réalisé." ;
pCodeAide += " Vous pouvez en particulier savoir quelles sont les <b>conditions nécessaires</b> pour que la tâche puisse démarrer," ;
pCodeAide += " quels sont les <b>artefacts nécessaires</b> et ceux que vous devez <b>produire</b>." ;
pCodeAide += " Vous pouvez de plus ajouter les artefacts que vous <b>produisez</b> dans le référentiel pour les mettre à disposition de tout le monde (lien \"<b>Ajouter</b>\")." ;
</script>
