<form>
  <select name="numIT" size=1 onChange="chgpage(this.form)">
    <option selected value="">It�ration <%= request.getAttribute ("pNumIteration") %></option>
  </select>
</form>
<br><br><br>
<table class="tableau" border="0" cellpadding="0" cellspacing="0">
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
    <td class='titre'>de d�but pr�vue</td>
    <td class='titre'>de d�but r�elle</td>
    <td class='titre'>de fin pr�vue</td>
    <td class='titre'>de fin r�estim�e</td>
    <td class='titre'>(%)</td>
    <td class='titre'>(hommes jour)</td>
  </tr>
  <jsp:useBean id="pCollaborateur" class="owep.modele.execution.MCollaborateur" scope="page"/>
  <jsp:useBean id="lTache"         class="owep.modele.execution.MTache"         scope="page"/> 
  <% pCollaborateur = (owep.modele.execution.MCollaborateur) request.getAttribute("pCollaborateur");
    out.print ("<tr>" + pCollaborateur) ;
    out.print ("<td class='Clair' rowspan=" + pCollaborateur.getNom () + ">");
    for (int i = 0; i < pCollaborateur.getNbTache (); i ++)
    {
      lTache = pCollaborateur.getTache (i) ;
      out.print ("<td>" + lTache.getNom () + "</td>") ;
      
      // Affiche la liste des artefacts
      out.print ("<td>") ;
      out.print (lTache.getArtefactSortie (lTache.getNbArtefactSortie () - 1).getNom ()) ;
      for (int j = 0; j < lTache.getNbArtefactSortie () - 1; j ++)
      {
        out.print (lTache.getArtefactSortie (j).getNom () + "<br/>") ;
      }
      out.print ("<td/>") ;
      
      // Affiche les propri�t�s de la t�che
      out.print ("<td>" + lTache.getChargeInitiale ()       + "</td>") ;
      out.print ("<td>" + lTache.getTempsPasse ()           + "</td>") ;
      out.print ("<td>" + lTache.getResteAPasser ()         + "</td>") ;
      out.print ("<td>" + lTache.getEtat ()                 + "</td>") ;
      out.print ("<td>" + lTache.getDateDebutPrevue ()      + "</td>") ;
      out.print ("<td>" + lTache.getDateDebutReelle ()      + "</td>") ;
      out.print ("<td>" + lTache.getDateFinPrevue ()        + "</td>") ;
      out.print ("<td>" + lTache.getDateFinReelle ()        + "</td>") ;
      out.print ("<td>" + lTache.getPrcAvancement ()        + "</td>") ;
      out.print ("<td>" + lTache.getBudgetConsomme( )       + "</td>") ;
      out.print ("<td>" + lTache.getPrcDepassementCharge () + "</td>") ;
      out.print ("<td>" + lTache.getHJDepassementCharge ()  + "</td>") ;
      out.print ("<td>" + lTache.getDescription ()          + "</td>") ;
      out.print ("</tr>") ;
    }
  %>
</table>
