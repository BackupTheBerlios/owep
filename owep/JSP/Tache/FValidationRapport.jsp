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
    
    // fonction de v�rification du bon format de la date
    function test_date(date, pLibelle) {
      expr_reg = /^[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]$/ ;

      if ( expr_reg.test(date.value) ==0 ) 
      {
        gChampsInvalides += 'Le champ \'' + pLibelle + '\' est incorrect.\n' ;
        // ce n'est pas une date valide
        alert ("La date que vous devez saisir doit �tre de la forme jj/mm/aaaa") ;
      }
    } 
    
    // fonction de v�rification du bon format des heures
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
  les fonctionnalit�s de cette page Web</B>
  </NOSCRIPT>
</HEAD>

<form action="./ValidationRapport" method="post" name="formValidation">
  <table class="tableau" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td class="caseNiveau1" rowspan="2">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'T�che que vous venez de stopper.')" onmouseout="tooltipOff(this, event)">
          T�che
        </a>
      </td>
      <td class="caseNiveau1" rowspan="2">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Artefact qui doivent �tre produit au cours de la t�che.')" onmouseout="tooltipOff(this, event)">
          Artefacts
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
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Temps n�cessaire que vous estimez pour terminer la t�che.')" onmouseout="tooltipOff(this, event)">
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
      
      <!-- Affiche les propri�t�s de la t�che -->
      <td class='caseNiveau3'><%=(int)lTache.getChargeInitiale ()%></td>
      <td class='caseNiveau3'><input class="niveau2" type=text size=<%=CConstante.LNG_CHARGE%> name="<%=CConstante.PAR_TEMPSPASSE%>"   value="<%=((Integer)lTache.getListe("tempsPasse")).intValue()%>" onBlur="test_heure(this, 'Temps pass�')"></td>
      <% int bouton = Integer.parseInt(request.getParameter("pIdBoutonClique")) ; 
         if (bouton == 2)
         {
      %>
      <td class='caseNiveau3'><input class="niveau2" type=text size=<%=CConstante.LNG_CHARGE%> name="<%=CConstante.PAR_RESTEAPASSER%>" value="<%=((Double)lTache.getListe("resteAPasser")).intValue()%>" onBlur="test_heure(this, 'Reste � passer')"></td>
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
      <td class='caseNiveau3'>Termin�e</td>
      <% } %>
      <td class='caseNiveau3'><%=lDateFormat.format (lTache.getDateDebutPrevue () )%></td>
      <td class='caseNiveau3'><input class="niveau2" type=text size=<%=CConstante.LNG_DATE%> name="<%=CConstante.PAR_DATEDEBUTREELLE%>"
                               value="<%=lDateFormat.format (lTache.getDateDebutReelle ()) %>" onBlur="test_date(this, 'Date de d�but r�elle')">
      </td>
      <td class='caseNiveau3'><%=lDateFormat.format (lTache.getDateFinPrevue ())%></td>
      <td class='caseNiveau3'><input class="niveau2" type=text size=<%=CConstante.LNG_DATE%> name="<%=CConstante.PAR_DATEFINREELLE%>" 
                               value="<%=lDateFormat.format ((Date)lTache.getListe("dateFinReelle"))%>" onBlur="test_date(this, 'Date de fin r�elle')">
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
          <input class="bouton" type="button" value="Valider" OnClick="valider()" onmouseover="tooltipOn(this, event, 'Cliquez pour valider l\'arr�t de la t�che et les donn�es du formulaire.')" onmouseout="tooltipOff(this, event)">
        </td>
        <td>
          <input type="button" value="Annuler" class="bouton" onclick="window.location.href = '/owep/Tache/ListeTacheVisu' ;" onmouseover="tooltipOn(this, event, 'Cliquez pour annuler l\'arr�t de la t�che.')" onmouseout="tooltipOff(this, event)"/>
        </td>
      </tr>
    </table>
</center>

</form>

<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page <b>Rapport d'activit� pour la t�che</b> vous permet de saisir, quand vous stoppez une t�che, les charges (<b>temps pass�</b> et <b>reste � passer</b>)" ;
pCodeAide += " et les <b>dates de d�but</b> et de <b>fin pr�vues</b> pour cette t�che. Cela permet au </b>chef de projet</b> de suivre l'avancement global du projet." ;
pCodeAide += " Les champs sont <b>automatiquement</b> remplis gr�ce au chronom�tre qui mesure le temps en <b>arri�re plan</b>. Vous pouvez cependant modifier les donn�es pour �tre au plus proche de la r�alit�." ;
</script>
