<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MArtefact"%>
<%@page import="owep.infrastructure.Session"%>

<jsp:useBean id="lArtefact" class="owep.modele.execution.MArtefact" scope="page"/>
<jsp:useBean id="lSession"  class="owep.infrastructure.Session"     scope="page"/> 

<%
    lArtefact = (MArtefact) request.getAttribute (CConstante.PAR_ARTEFACT) ;
%>

<table width="100%">
<tr>
<td width="100%">
  <form action="./ArtefactAjout" method="post" enctype="multipart/form-data">
      
    <%if (lArtefact.getNomFichier() != null) {%>
    <p class="texteImportant">
      Attention il existe déjà un fichier pour l'artefact <%=lArtefact.getNom()%> : <%=lArtefact.getNomFichier()%> !! 
      <br>
      Si vous continuez vous remplacerez l'ancien fichier par le nouveau. 
    </p>
    <br>
    <%}%>

    <center>
      <font class="titre3">Nouveau fichier : </font>
      <input class="niveau2" size="<%= CConstante.LNG_FICHIER %>" maxlength="<%= CConstante.TXT_FICHIER %>" type="file" name="fichierArtefact"
       onmouseover="tooltipOn(this, event, 'Choisissez le fichier à ajouter comme artefact.')" onmouseout="tooltipOff(this, event)">
      <input type="hidden" name="pArtefact" value="<%= lArtefact.getId () %>">
    </center>
  <br>
  
</td>
</tr> 
    
<tr>
<td width="100%">    
  <table border="0" width="100%">
    <tr>
      <td align="right" width="50%">
        <font class="texteSubmit">
          <input class="bouton" type="submit" value="Valider"
           onmouseover="tooltipOn(this, event, 'Ajouter le nouvel artefact.')" onmouseout="tooltipOff(this, event)">
          </form>
        </font>
      </td>
      <td align="left" width="50%">
        <form action="../Tache/TacheVisu" method="get">
          <input class="bouton" type="submit" value="Annuler"
           onmouseover="tooltipOn(this, event, 'Revenir au détail de la tâche.')" onmouseout="tooltipOff(this, event)">
          <input type="hidden" name="pTacheAVisualiser" value="<%= lArtefact.getTacheSortie ().getId () %>">
        </form>
      </td>
    </tr>
  </table>
</td>
</tr>
</table>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page <b>Ajout d'un artefact</b> vous permet d'ajouter un nouvel artefact (fichier) et de le <b>mettre à disposition</b> de toutes tâches et personnes la nécessitant." ;
pCodeAide += " L'artefact sera ajouté au référentiel. Si une version précédente avait déjà été ajouté, celle-ci sera écrasé." ;
</script>
