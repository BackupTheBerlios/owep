<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="owep.modele.execution.MCollaborateur"%>

<jsp:useBean id="lCollaborateur" class="owep.modele.execution.MCollaborateur" scope="page"/>

<%@ page language="java" %>

<%
  ArrayList listCollaborateur = (ArrayList) request.getAttribute("mListCollaborateur");
%>


<center>
<form name="formCreerProjet" method="post" action="/owep/Processus/GererProjet" enctype="multipart/form-data">
<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Nom du projet.')" onmouseout="tooltipOff(this, event)">Nom *</a>
    </td>
    <td class="caseNiveau3">
      <input type="text" name="mNom" value="">
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Date prévue à laquelle doit commencer le projet.')" onmouseout="tooltipOff(this, event)">Date de début *</a>
    </td>
    <td class="caseNiveau3">
      <input type="text" name="mDateDebut" value="">
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Date prévue à laquelle doit se terminer le projet.')" onmouseout="tooltipOff(this, event)">Date de fin *</a>
    </td>
    <td class="caseNiveau3">
      <input type="text" name="mDateFin" value="">
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Description de ce qui doit être réalisé au cours du projet.')" onmouseout="tooltipOff(this, event)">Description</a>
    </td>
    <td class="caseNiveau3">
      <textarea name="mDescription"></textarea>
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Choisissez le fichier <b>.DPE</b> qui définit le processus à appliquer sur le projet.')" onmouseout="tooltipOff(this, event)">Processus *</a>
    </td>
    <td class="caseNiveau3">
      <input type="file" name="mFichierProcessus" value="">
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Superviseur qui s\'occupe du projet.')" onmouseout="tooltipOff(this, event)">Responsable *</a>
    </td>
    <td class="caseNiveau3">
<%
  Iterator it = listCollaborateur.iterator();
  while(it.hasNext())
  {
    lCollaborateur = (MCollaborateur) it.next();
%>
      <input name="mResponsable" type="radio" value="<%=lCollaborateur.getId()%>">
      <%= lCollaborateur.getPrenom()+"&nbsp;"+lCollaborateur.getNom()%>
      <br>
<%
  }
%>
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <center><input class="bouton" type="button" value="Valider" onclick="envoyer();"></center>
    </td>
  </tr>
</tbody>
</table>
</form>
</center>


<script language="javascript">
function envoyer()
{
  var texte = "";
  if(document.formCreerProjet.mNom.value == "")
  {
    //alert("Veuillez saisir un nom.");
    texte = texte + "Veuillez saisir un nom.\n";
  }
  if(document.formCreerProjet.mDateDebut.value == "")
    texte = texte + "Veuillez saisir une date de début.\n";
  if(document.formCreerProjet.mDateFin.value == "")
    texte = texte + "Veuillez saisir une date de fin.\n";
  if(document.formCreerProjet.mFichierProcessus.value == "")
    texte = texte + "Veuillez selectionner un processus.\n";
  if(!(
<%
  for(int i = 0 ; i < listCollaborateur.size() ; i++)
  {
%>
      document.formCreerProjet.mResponsable[<%=i%>].checked
<%
    if(i < listCollaborateur.size()-1)
    {
%>
      ||
<%
    }
  }
%>
      ))
    texte = texte + "Veuillez selectionner un responsable.\n";
  
  if(texte == "")
    document.formCreerProjet.submit();
  else
    alert(texte);
}
</script>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Création d\'un projet</b> permet, comme son nom l\'indique, à un chef de projet de créer un nouveau projet accessible par <b>OWEP</b>." ;
pCodeAide += " Vous devez pour cela définir les <b>caractéristiques</b> du projet (nom, dates, etc.), le <b>processus</b> appliqué sur le projet (fichier au format .DPE exporté depuis <b>IEPP</b>)" ;
pCodeAide += " et enfin le <b>superviseur</b> responsable du projet. La personne qui crée le projet est considérée comme <b>chef</b> de ce projet." ;
</script>
