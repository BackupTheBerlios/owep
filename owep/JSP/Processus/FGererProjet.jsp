<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="owep.modele.execution.MCollaborateur"%>

<jsp:useBean id="lCollaborateur" class="owep.modele.execution.MCollaborateur" scope="page"/>

<%@ page language="java" %>

<%
  ArrayList listCollaborateur = (ArrayList) request.getAttribute("mListCollaborateur");
%>

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

<center>
<form name="formCreerProjet" method="post" action="/owep/Processus/GererProjet" enctype="multipart/form-data">
<table class="tableau" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td class="caseNiveau1">
      Nom *
    </td>
    <td class="caseNiveau3">
      <input type="text" name="mNom" value="">
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      Date de début *
    </td>
    <td class="caseNiveau3">
      <input type="text" name="mDateDebut" value="">
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      Date de fin *
    </td>
    <td class="caseNiveau3">
      <input type="text" name="mDateFin" value="">
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      Description
    </td>
    <td class="caseNiveau3">
      <textarea name="mDescription"></textarea>
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      Processus *
    </td>
    <td class="caseNiveau3">
      <input type="file" name="mFichierProcessus" value="">
    </td>
  </tr>
  <tr>
    <td class="caseNiveau1">
      Responsable *
    </td>
    <td class="caseNiveau3">
<%
  Iterator it = listCollaborateur.iterator();
  while(it.hasNext())
  {
    lCollaborateur = (MCollaborateur) it.next();
%>
      <input name="mResponsable" type="radio" value="<%=lCollaborateur.getId()%>">
      <%=lCollaborateur.getPrenom()+"&nbsp;"+lCollaborateur.getNom()%>
      <br>
<%
  }
%>
    </td>
  </tr>
  <tr>
    <td colspan=2>
      <center><input class="bouton" type="button" value="Créer" onclick="envoyer();"></center>
    </td>
  </tr>
</tbody>
</table>
</form>
</center>
