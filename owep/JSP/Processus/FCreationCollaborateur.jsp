<%@page import="java.util.ArrayList"%>
<%@page import="owep.modele.processus.MRole"%>


<center>
<%
  // Récupération des parametres
  String mProbleme = (String) request.getAttribute("mProbleme");       // Probleme rencontré lors de l'enregistrement du collaborateur
  String mPageSource = (String) request.getAttribute("mPageSource");   // Page qui a appellé la servlet création d'un collaborateur à l'origine
  ArrayList mListeRole = (ArrayList) request.getAttribute("listeRole");// Liste des roles possibles
  
  String mNom = (String) request.getAttribute("mNom");                 // Nom du collaborateur
  String mPrenom = (String) request.getAttribute("mPrenom");           // Prenom du collaborateur
  String mLogin = (String) request.getAttribute("mLogin");             // Login du collaborateur
  String mMail = (String) request.getAttribute("mMail");               // Email du collaborateur
  String mAdresse = (String) request.getAttribute("mAdresse");         // Adresse du collaborateur
  String mTelephone = (String) request.getAttribute("mTelephone");     // Numéro du telephone du collaborateur
  String mPortable = (String) request.getAttribute("mPortable");       // Numéro du portable du collaborateur
  String mCommentaire = (String) request.getAttribute("mCommentaire"); // Commentaire du collaborateur
  
  // Définit si c'est le premier appel de la page
  if(mProbleme == null)
  {
    mProbleme = "nouveau";
  }
  
  // Définition du poblème rencontré
  if(mProbleme.equals("unique"))
  {
%>
Veuillez choisir un autre login.<br>
<%
  }
  
  if(mProbleme.equals("login"))
  {
%>
Veuillez saisir un login.<br>
<%
  }
  
  if(mProbleme.equals("mail"))
  {
%>
Veuillez saisir une adresse eMail.<br>
<%
  }

  if(mProbleme.equals("nom"))
  {
%>
Veuillez saisir un nom.<br>
<%
  }
  
  // Aucun probleme n'a été rencontré
  if(mProbleme.equals("false"))
  {
   // Auncun probléme n'a été rencontré
%>
L'utilisateur a bien été enregistré<br>
<a href="<%=mPageSource%>">Ok</a>
<%
  }
  else
  {
    // Affichage du formulaire
%>
<br>
<form action="./CreationCollaborateur" method="post">
  <table class="tableau" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Nom du collaborateur.')" onmouseout="tooltipOff(this, event)">Nom *</a>
      </td>
      <td class="caseNiveau3"><input type="text" name="mNom" value=<%=(!mProbleme.equals("nouveau"))?mNom:""%>></td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Prénom du collaborateur.')" onmouseout="tooltipOff(this, event)">Prénom</a>
      </td>
      <td class="caseNiveau3"><input type="text" name="mPrenom" value=<%=(!mProbleme.equals("nouveau"))?mPrenom:""%>></td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Nom que le collaborateur utilisera pour se connecter. Ce login doit être unique.')" onmouseout="tooltipOff(this, event)">Login *</a>
      </td>
      <td class="caseNiveau3"><input type="text" name="mLogin" value=<%=(!mProbleme.equals("nouveau"))?mLogin:""%>></td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Adresse mail du collaborateur. Cette adresse sera utilisée par <b>OWEP</b> pour transmettre des messages.')" onmouseout="tooltipOff(this, event)">E-Mail *</a>
      </td>
      <td class="caseNiveau3"><input type="text" name="mMail" value=<%=(!mProbleme.equals("nouveau"))?mMail:""%>></td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Domicile du collaborateur.')" onmouseout="tooltipOff(this, event)">Adresse</a>
      </td>
      <td class="caseNiveau3"><textarea name="mAdresse" rows=3><%=(!mProbleme.equals("nouveau"))?mAdresse:""%></textarea></td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Numéro de téléphone fixe du collaborateur.')" onmouseout="tooltipOff(this, event)">Numéro de téléphone</a>
      </td>
      <td class="caseNiveau3"><input type="text" name="mTelephone" value=<%=(!mProbleme.equals("nouveau"))?mTelephone:""%>></td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Numéro de portable du collaborateur.')" onmouseout="tooltipOff(this, event)">Numéro de portable</a>
      </td>
      <td class="caseNiveau3"><input type="text" name="mPortable" value=<%=(!mProbleme.equals("nouveau"))?mPortable:""%>></td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Commentaires et précisions sur le collaborateur. Ces informations ne sont visibles que par les chefs de projets.')" onmouseout="tooltipOff(this, event)">Commentaires</a>
      </td>
      <td class="caseNiveau3"><textarea name="mCommentaire" rows=3><%=(!mProbleme.equals("nouveau"))?mCommentaire:""%></textarea></td>
    </tr>
    <tr>
      <td class="caseNiveau1">
        <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Rôles (définis dans le processus) que le collaborateur tient sur le projet.')" onmouseout="tooltipOff(this, event)">Rôles</a>
      </td>
      <td class="caseNiveau3">
<!--        <table border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td rowspan="2">
              <select name="mListeRole" size="4" multiple> -->
<%
    for(int i = 0 ; i<mListeRole.size() ; i++)
    {
%>
              <input type="checkbox" name="mRoleSelect<%=((MRole) mListeRole.get(i)).getId()%>" value="<%=((MRole) mListeRole.get(i)).getId()%>"><%=((MRole) mListeRole.get(i)).getNom()%><br>
<%
    }
%>
<!--                <option value="">
                  
                </option>
              <select>
            </td>
            <td><input type="button" value="->" onclick="ajout(mListeRole,mListeRoleChoisi);enlever(mListeRole)"></td>
            <td rowspan="2">
              <select name="mListeRoleChoisi" size="4" multiple>
              <select>
            </td>
          </tr>
          <tr>
            <td><input type="button" value="<-" onclick="ajout(mListeRoleChoisi,mListeRole);enlever(mListeRoleChoisi)"></td>
          </tr>
        </tbody>
        </table> -->
      </td>
    </tr>
  </tbody>
  </table>
  <p class="texteObligatoire">Les champs marqué d'un * sont obligatoires.</p>
  <input type="hidden" name="mPageSource" value="<%=mPageSource%>">
  <p class="texteSubmit">
    <input class="bouton" type="submit" value="Valider"
     onmouseover="tooltipOn(this, event, 'Cliquez pour valider le formulaires.')" onmouseout="tooltipOff(this, event)">
  </p>
</form>
</center>

<%
  }
%>


<script language="javascript">
function ajout(listeDep, listeArr)
{
  var option = new Option(listeDep.options[listeDep.selectedIndex].text,listeDep.options[listeDep.selectedIndex].value); 
  listeArr.options[listeArr.length] = option; 
  listeDep.options[listeDep.selectedIndex] = null ;
}

function enleve(listeArr)
{ 
  if(listeArr.options[listeArr.selectedIndex].value == 0){ } 
  else
  { 
    listeArr.options[listeArr.selectedIndex] = null; 
  }
}
</script>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Création d'un collaborateur</b> permet de créer un nouveau <b>compte utilisateur</b> pour une personne." ;
pCodeAide += " Vous devez pour cela saisir ses informations personnelles et préciser les rôles (définis dans le processus) qu'il peut tenir." ;
</script>
