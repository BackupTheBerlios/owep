<%@page import="java.text.SimpleDateFormat"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MTache"%>

<jsp:useBean id="lTache"         class="owep.modele.execution.MTache"         scope="session"/> 


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
      <td class='caseNiveau3'>Termin�e</td>
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
     onmouseover="tooltipOn(this, event, 'Cliquez l\'arr�t de la t�che et les donn�es du formulaire.')" onmouseout="tooltipOff(this, event)">
  </form>
  <input type="button" value="Annuler" class="bouton" onclick="window.location.href = '/owep/Tache/ListeTacheVisu' ;"
   onmouseover="tooltipOn(this, event, 'Cliquez pour annuler l\'arr�t de la t�che.')" onmouseout="tooltipOff(this, event)"/>
</p>

<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page <b>Rapport d'activit� pour la t�che</b> vous permet de saisir, quand vous stoppez une t�che, les charges (<b>temps pass�</b> et <b>reste � passer</b>)" ;
pCodeAide += " et les <b>dates de d�but</b> et de <b>fin pr�vues</b> pour cette t�che. Cela permet au </b>chef de projet</b> de suivre l'avancement global du projet." ;
pCodeAide += " Les champs sont <b>automatiquement</b> remplis gr�ce au chronom�tre qui mesure le temps en <b>arri�re plan</b>. Vous pouvez cependant modifier les donn�es pour �tre au plus proche de la r�alit�." ;
</script>
