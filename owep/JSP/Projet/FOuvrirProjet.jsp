<%@page import="java.util.ArrayList"%>
<%@page import="owep.modele.execution.MProjet"%>

<jsp:useBean id="lProjet" class="owep.modele.execution.MProjet" scope="page"/>

<center>
  Choisissez le projet que vous voulez visualiser :<br/><br/>
  <%
    // Récupération des paramétres
    ArrayList lListProjet = (ArrayList) request.getAttribute ("listProjetPossible") ;       // Probleme rencontré lors de l'enregistrement du collaborateur
    
    int i;
    for(i = 0 ; i < lListProjet.size() ; i++)
    {
      lProjet = (MProjet) lListProjet.get(i);
  %>
    <a class="niveau2" href="../Projet/OuvrirProjet?mIdProjet=<%=lProjet.getId ()%>"
     onmouseover="tooltipOn(this, event, 'Cliquez pour ouvrir ce projet.')" onmouseout="tooltipOff(this, event)">
      <%=lProjet.getNom ()%>
    </a><br>
  <%
    }
  %>
</center>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Ouverture d\'un projet</b> vous permet, quand vous travaillez sur <b>plusieurs projets</b>, de choisir celui que vous voulez visualiser." ;
pCodeAide += " <b>OWEP</b> ne permet en effet de visualiser qu\'un seul projet à la fois." ;
pCodeAide += " Par la suite, si vous voulez <b>changer</b> de projet, selectionnez le dans le <b>sélecteur de projet</b> en haut à gauche de l'écran." ;
</script>
