<%@page import="owep.infrastructure.Session"%>
<%@page import="owep.modele.execution.MProjet"%>
<%@page import="owep.controle.CConstante"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>

<form name="projetVisu" action="../Processus/IterationModif">
  <input type="hidden" name="<%= CConstante.PAR_ITERATION %>" value="">
<%
  Session lSession = (Session) session.getAttribute (CConstante.SES_SESSION) ;
  MProjet lProjet  = lSession.getProjet () ;%>
  <%
  for (int i = 0; i < lProjet.getNbIterations (); i ++)
  {
  %>
    Iteration <%= lProjet.getIteration (i).getNumero () %>&nbsp;&nbsp;
    <input class="bouton" type="submit" name="<%= CConstante.PAR_MODIFIER %>" value="Modifier"
     onclick="document.projetVisu.<%= CConstante.PAR_ITERATION %>.value = <%= lProjet.getIteration (i).getId () %>"><br/>
  <%
  }
%>
</form>
<a href="../Processus/IterationModif">Ajouter une itération...</a>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Gestion du projet</b> vous offre la possibilité d'accéder à une itération pour la <b>modifier</b> ou d'en <b>créer</b> une nouvelle." ;
pCodeAide += " Choisissez pour cela une itération (bouton \"<b>Modifier</b>\" ou cliquez sur le lien \"<b>Ajouter une itération...</b>\"." ;
</script>
