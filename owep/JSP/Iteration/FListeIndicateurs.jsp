<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MProjet"%>
<%@page import="owep.modele.execution.MMesureIndicateur"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>

<jsp:useBean id="lProjet" class="owep.modele.execution.MProjet" scope="page"/>

<% lProjet  = (MProjet) request.getAttribute (CConstante.PAR_PROJET) ; %>
<HEAD>
<SCRIPT LANGUAGE="JavaScript">  
  <!--
// fonction de vérification du bon format des valeurs
    function test_valeur(valeur) {
      expr_reg = /^[0-9]+$/ ;

      if ( expr_reg.test(valeur.value) == 0 ) 
      {
        // ce n'est pas un nombre entier
        alert ("Vous devez saisir un nombre entier") ;
      }
    } 
  // --> 
  </SCRIPT>
  
  <NOSCRIPT>
  <B>Votre browser ne supporte pas JavaScript et ne peut donc pas exploiter
  les fonctionnalités de cette page Web</B>
  </NOSCRIPT>
</HEAD>

<%
  if (lProjet.getNbIndicateurs()==0)
  {
%>
    <center>Vous n'avez aucun indicateur à renseigner pour cette itération.</center>
<%
  }
  else
  {
%>
	<form action="./ValidationIndicateurs" method="post" name="formValidation">
	<center>
	<table class="tableau" border="0" cellpadding="0" cellspacing="0">
	<tbody>
	  <tr>
	    <td class="caseNiveau1">
	      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Nom de l\'indicateur.')" onmouseout="tooltipOff(this, event)">Indicateur</a>
	    </td>
	    <td class="caseNiveau1">
	      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description de l\'indicateur.')" onmouseout="tooltipOff(this, event)">Description</a>
	    </td>
	    <td class="caseNiveau1">
	      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Valeur associée à l\'indicateur.')" onmouseout="tooltipOff(this, event)">Valeur</a>
	    </td>
	    <td class="caseNiveau1">
	      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Unité de mesure de l\'indicateur.')" onmouseout="tooltipOff(this, event)">Unité</a>
	    </td>
	    <td class="caseNiveau1">
	      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Commentaires associés à l\'indicateur.')" onmouseout="tooltipOff(this, event)">Commentaires</a>
	    </td>
	  </tr>
	  
	  
	  <!--Affichage des taches en cours des collaborateurs-->
		<%
		// pour chaque collaborateur
		for (int i = 0; i < lProjet.getNbIndicateurs(); i ++)
		{
		  %>
		  <tr>      
	      <td class="caseNiveau3"><%=lProjet.getIndicateur(i).getNom()%></td>
	      <td class="caseNiveau3"><%=lProjet.getIndicateur(i).getDescription()%></td>
		    <%MMesureIndicateur lMesureIndicateur = (MMesureIndicateur)lProjet.getListe(new Integer(i)); %>
		    <%if (lProjet.getIndicateur(i).getUnite()==null)
		      {%>
          <td class="caseNiveau3">X</td>
          <td class="caseNiveau3">X</td>
          <input type=hidden name="<%=CConstante.PAR_TYPEINDICATEUR+i%>" value="commentaire">
        <%}
          else
          {
          %>
          <input type=hidden name="<%=CConstante.PAR_TYPEINDICATEUR+i%>" value="valeur">
          <td class="caseNiveau3"><input type=text size=<%=CConstante.LNG_VALEUR%> name="<%=CConstante.PAR_VALEURMESURE+i%>"   value="<%=(int)lMesureIndicateur.getValeur()%>" onBlur="test_valeur(this)"></td>
		      <td class="caseNiveau3"><%=lProjet.getIndicateur(i).getUnite()%></td>
		    <%}%>
		    <%if (lMesureIndicateur.getCommentaire()==null){
		      lMesureIndicateur.setCommentaire("") ;
		    }%>
		    <td class="caseNiveau3"><TEXTAREA COLS="<%=CConstante.LNG_COLSCOMMENTAIRE%>" WRAP="VIRTUAL" name="<%=CConstante.PAR_COMMENTAIREMESURE+i%>"><%=lMesureIndicateur.getCommentaire()%></TEXTAREA>
        </td>
		  </tr>
		  <%
		}
		%> 
	</tbody>
	</table>  </center>
	<BR>
	
	<center>
	  <table border="0">
	    <tr>
	      <td>
	        <font class="texteSubmit">
	        <input type="submit" value="Valider" OnClick="valider()">
	        </font>
	        </form>
	      </td>
	      <td>
	        <form action="/Tache/ListeTacheVisu" method="post">
	        <input type="submit" value="Annuler">
	        </form>
	      </td>
	    </tr>
	  </table>
	</center>
	
<%
  }
%>

<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page des <b>Indicateurs de l'itération</b> vous permet de saisir les mesures pour les indicateurs de l'itération en cours." ;
pCodeAide += " Pour chaque <b>indicateur</b>, vous pouvez saisir une <b>valeur</b> (en faisant attention de rester cohérent avec l'<b>unité</b>) et/ou un <b>commentaire</b>." ;
</script>
