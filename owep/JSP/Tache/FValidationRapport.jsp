<%@page import="java.text.SimpleDateFormat"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MTache"%>

<jsp:useBean id="lTache"         class="owep.modele.execution.MTache"         scope="session"/> 


<form action="./ValidationRapport" method="post" name="formValidation">
  <table class="tableau" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td class="caseNiveau1" rowspan="2">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Tâche que vous venez de stopper.')" onmouseout="tooltipOff(this, event)">
          Tâche
        </a>
      </td>
      <td class="caseNiveau1" rowspan="2">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Artefact qui doivent être produit au cours de la tâche.')" onmouseout="tooltipOff(this, event)">
          Artefacts
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
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Temps nécessaire que vous estimez pour terminer la tâche.')" onmouseout="tooltipOff(this, event)">
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
    </tr>
   
    <tr>
      <% lTache = (MTache) request.getAttribute (CConstante.PAR_TACHE) ; %>
      <td class='caseNiveau2'><%= lTache.getNom ()%></td>
      <!--
      <!-- Affiche la liste des artefacts -->
      <td class='caseNiveau2'>
        <%
          SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
          out.print (lTache.getArtefactSortie (0).getNom ()) ;
          for (int j = 1; j < lTache.getNbArtefactsSorties (); j ++)
          {
            out.print ("<br/>" + lTache.getArtefactSortie (j).getNom ()) ;
          }
        %>
      </td>
      
      <!-- Affiche les propriétés de la tâche -->
      <td class='caseNiveau3'><%=(int)lTache.getChargeInitiale ()%></td>
      <td class='caseNiveau3'><input type=text size=1 name="<%=CConstante.PAR_TEMPSPASSE%>"   value="<%=(int)lTache.getTempsPasse()%>" onBlur="test_heure(this)"></td>
      <% int bouton = Integer.parseInt(request.getParameter("pIdBoutonClique")) ; 
         if (bouton == 2)
         {
      %>
      <td class='caseNiveau3'><input type=text size=1 name="<%=CConstante.PAR_RESTEAPASSER%>" value="<%=(int)lTache.getResteAPasser()%>" onBlur="test_heure(this)"></td>
      <% } %>
      <% if (bouton == 3) 
        {
      %>
      <td class='caseNiveau3'><%=(int)lTache.getResteAPasser()%></td>
      <% } %>
      <% if (lTache.getEtat () == 2)
       {
       %>
      <td class='caseNiveau3'>Suspendue</td>
      <% } %>
      <% if (lTache.getEtat () == 3)
       {
       %>
      <td class='caseNiveau3'>Terminée</td>
      <% } %>
      <td class='caseNiveau3'><%=lDateFormat.format (lTache.getDateDebutPrevue () )%></td>
      <td class='caseNiveau3'><input type=text size=8 name="<%=CConstante.PAR_DATEDEBUTREELLE%>"
                               value="<%=lDateFormat.format (lTache.getDateDebutReelle ()) %>" onBlur="test_date(this)">
      </td>
      <td class='caseNiveau3'><%=lDateFormat.format (lTache.getDateFinPrevue ())%></td>
      <td class='caseNiveau3'><input type=text size=8 name="<%=CConstante.PAR_DATEFINREELLE%>" 
                               value="<%=lDateFormat.format (lTache.getDateFinReelle())%>" onBlur="test_date(this)">
      </td>
    </tr>
  </tbody>
  </table>
  <br><br>
  <input type=hidden name="<%=CConstante.PAR_TACHE%>" value=<%=lTache.getId()%>>
  <input type=hidden name="<%=CConstante.PAR_RESTEAPASSER%>" value=<%=lTache.getResteAPasser()%>>
  <input type=hidden name="<%=CConstante.PAR_ETAT%>" value=<%=lTache.getEtat()%>>
<center>


<p class="texteSubmit">
    <input class="bouton" type="submit" value="Valider" OnClick="valider()"
     onmouseover="tooltipOn(this, event, 'Cliquez l\'arrêt de la tâche et les données du formulaire.')" onmouseout="tooltipOff(this, event)">
  </form>
  <input type="button" value="Annuler" class="bouton" onclick="window.location.href = '/owep/Tache/ListeTacheVisu' ;"
   onmouseover="tooltipOn(this, event, 'Cliquez pour annuler l\'arrêt de la tâche.')" onmouseout="tooltipOff(this, event)"/>
</p>

<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page <b>Rapport d'activité pour la tâche</b> vous permet de saisir, quand vous stoppez une tâche, les charges (<b>temps passé</b> et <b>reste à passer</b>)" ;
pCodeAide += " et les <b>dates de début</b> et de <b>fin prévues</b> pour cette tâche. Cela permet au </b>chef de projet</b> de suivre l'avancement global du projet." ;
pCodeAide += " Les champs sont <b>automatiquement</b> remplis grâce au chronomètre qui mesure le temps en <b>arrière plan</b>. Vous pouvez cependant modifier les données pour être au plus proche de la réalité." ;
</script>
