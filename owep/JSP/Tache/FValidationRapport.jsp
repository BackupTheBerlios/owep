<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MTache"%>

<jsp:useBean id="lTache"         class="owep.modele.execution.MTache"         scope="session"/> 

<HEAD>
<SCRIPT LANGUAGE="JavaScript">
  <!--
    /**
    * Variables globales du module javascript.
    */
    var gChampsInvalides = new String ('') ;
    
    // fonction de vérification du bon format de la date
    function test_date(date, pLibelle) {
      expr_reg = /^[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]$/ ;

      if ( expr_reg.test(date.value) ==0 ) 
      {
        gChampsInvalides += 'Le champ \'' + pLibelle + '\' est incorrect.\n' ;
        // ce n'est pas une date valide
        alert ("La date que vous devez saisir doit être de la forme jj/mm/aaaa") ;
      }
    } 
    
    // fonction de vérification du bon format des heures
    function test_heure(heure, pLibelle) {
      expr_reg = /^[0-9]+$/ ;

      if ( expr_reg.test(heure.value) == 0 ) 
      {
        gChampsInvalides += 'Le champ \'' + pLibelle + '\' est incorrect.\n' ;
        // ce n'est pas un nombre entier
        alert ("Vous devez saisir un nombre entier") ;
      }
    }  
    
    // fonction de conversion de la date saisie : jj/mm/aaaa en aaaa-mm-jj
    function valider() { 
      if (gChampsInvalides != '')
		  {
		    alert (gChampsInvalides) ;
		    gChampsInvalides = '' ;
		  }
		  else
		  {
        var madateReelle = document.formValidation.pDateDebutReel.value ; 
        var nouvelleDateReelle = madateReelle.split("\/"); 
        document.formValidation.pDateDebutReel.value = nouvelleDateReelle[2]+"-"+nouvelleDateReelle[1]+"-"+nouvelleDateReelle[0] ; 
        var madateReestimee = document.formValidation.pDateFinReestimee.value ; 
        var nouvelleDateReestimee = madateReestimee.split("\/"); 
        document.formValidation.pDateFinReestimee.value = nouvelleDateReestimee[2]+"-"+nouvelleDateReestimee[1]+"-"+nouvelleDateReestimee[0] ; 
        document.formValidation.submit () ;
      }  
    }
  // -->
  </SCRIPT>
  
  <NOSCRIPT>
  <B>Votre browser ne supporte pas JavaScript et ne peut donc pas exploiter
  les fonctionnalités de cette page Web</B>
  </NOSCRIPT>
</HEAD>

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
      <td class='caseNiveau3'><input class="niveau2" type=text size=<%=CConstante.LNG_CHARGE%> name="<%=CConstante.PAR_TEMPSPASSE%>"   value="<%=((Integer)lTache.getListe("tempsPasse")).intValue()%>" onBlur="test_heure(this, 'Temps passé')"></td>
      <% int bouton = Integer.parseInt(request.getParameter("pIdBoutonClique")) ; 
         if (bouton == 2)
         {
      %>
      <td class='caseNiveau3'><input class="niveau2" type=text size=<%=CConstante.LNG_CHARGE%> name="<%=CConstante.PAR_RESTEAPASSER%>" value="<%=((Double)lTache.getListe("resteAPasser")).intValue()%>" onBlur="test_heure(this, 'Reste à passer')"></td>
      <% } %>
      <% if (bouton == 3) 
        {
      %>
      <td class='caseNiveau3'><%=((Double)lTache.getListe("resteAPasser")).intValue()%></td>
      <% } %>
      <% if (((Integer)lTache.getListe("etat")).intValue() == 2)
       {
       %>
      <td class='caseNiveau3'>Suspendue</td>
      <% } %>
      <% if (((Integer)lTache.getListe("etat")).intValue() == 3)
       {
       %>
      <td class='caseNiveau3'>Terminée</td>
      <% } %>
      <td class='caseNiveau3'><%=lDateFormat.format (lTache.getDateDebutPrevue () )%></td>
      <td class='caseNiveau3'><input class="niveau2" type=text size=<%=CConstante.LNG_DATE%> name="<%=CConstante.PAR_DATEDEBUTREELLE%>"
                               value="<%=lDateFormat.format (lTache.getDateDebutReelle ()) %>" onBlur="test_date(this, 'Date de début réelle')">
      </td>
      <td class='caseNiveau3'><%=lDateFormat.format (lTache.getDateFinPrevue ())%></td>
      <td class='caseNiveau3'><input class="niveau2" type=text size=<%=CConstante.LNG_DATE%> name="<%=CConstante.PAR_DATEFINREELLE%>" 
                               value="<%=lDateFormat.format ((Date)lTache.getListe("dateFinReelle"))%>" onBlur="test_date(this, 'Date de fin réelle')">
      </td>
    </tr>
  </tbody>
  </table>
  <br><br>
  <input type=hidden name="<%=CConstante.PAR_TACHE%>" value=<%=lTache.getId()%>>
  <input type=hidden name="<%=CConstante.PAR_RESTEAPASSER%>" value=<%=((Double)lTache.getListe("resteAPasser")).intValue()%>>
  <input type=hidden name="<%=CConstante.PAR_ETAT%>" value=<%=((Integer)lTache.getListe("etat")).intValue()%>>

<center>
    <table border="0">
      <tr>
        <td>
          <input class="bouton" type="button" value="Valider" OnClick="valider()" onmouseover="tooltipOn(this, event, 'Cliquez pour valider l\'arrêt de la tâche et les données du formulaire.')" onmouseout="tooltipOff(this, event)">
        </td>
        <td>
          <input type="button" value="Annuler" class="bouton" onclick="window.location.href = '/owep/Tache/ListeTacheVisu' ;" onmouseover="tooltipOn(this, event, 'Cliquez pour annuler l\'arrêt de la tâche.')" onmouseout="tooltipOff(this, event)"/>
        </td>
      </tr>
    </table>
</center>

</form>

<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page <b>Rapport d'activité pour la tâche</b> vous permet de saisir, quand vous stoppez une tâche, les charges (<b>temps passé</b> et <b>reste à passer</b>)" ;
pCodeAide += " et les <b>dates de début</b> et de <b>fin prévues</b> pour cette tâche. Cela permet au </b>chef de projet</b> de suivre l'avancement global du projet." ;
pCodeAide += " Les champs sont <b>automatiquement</b> remplis grâce au chronomètre qui mesure le temps en <b>arrière plan</b>. Vous pouvez cependant modifier les données pour être au plus proche de la réalité." ;
</script>
