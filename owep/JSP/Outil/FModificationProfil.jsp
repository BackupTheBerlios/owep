<%@page import="owep.infrastructure.Session"%>
<%@page import="owep.controle.CConstante" %>

<jsp:useBean id="lSession" class="owep.infrastructure.Session" scope="page"/>

<center>

<%
  // Recuperation de la session
  HttpSession httpSession = request.getSession(true);
  lSession = (Session) httpSession.getAttribute("SESSION");
  
  //Récupération du ressource bundle
  java.util.ResourceBundle lMessages = lSession.getMessages();
  
  // Récupération des parametres
  String mErreur = (String) request.getAttribute("mErreur");       // Probleme rencontré lors de la modification du profil
  
  String mNom = (String) request.getAttribute("mNom");                 // Nom du collaborateur
  String mPrenom = (String) request.getAttribute("mPrenom");           // Prenom du collaborateur
  String mLogin = (String) request.getAttribute("mLogin");             // Login du collaborateur
  String mMail = (String) request.getAttribute("mMail");               // Email du collaborateur
  String mAdresse = (String) request.getAttribute("mAdresse");         // Adresse du collaborateur
  String mTelephone = (String) request.getAttribute("mTelephone");     // Numéro du telephone du collaborateur
  String mPortable = (String) request.getAttribute("mPortable");       // Numéro du portable du collaborateur
  String mCommentaire = (String) request.getAttribute("mCommentaire"); // Commentaire du collaborateur
  
%>

<script language="javascript">
function changementMdp(){
  document.modificationProfil.mModifMdp.value = "1";
}
function envoyer(){
  var texte = "";
  
  if(document.modificationProfil.mNom.value == "")
    texte = texte + "<%=lMessages.getString("messageNom")%>\n";
  if(document.modificationProfil.mLogin.value == "")
    texte = texte + "<%=lMessages.getString("messageLogin")%>\n";
  else{
    if(document.modificationProfil.mLogin.value != "<%=mLogin%>")
      document.modificationProfil.mModifLogin.value = 1;
  }
  if(document.modificationProfil.mNouveauMdp.value != document.modificationProfil.mConfirmationMdp.value)
    texte = texte + "<%=lMessages.getString("messageMdp")%>\n";
  
  if(texte == "")
    document.modificationProfil.submit();
  else
    alert(texte);
}
</script>
<%=mErreur%>
<br>
<%
  if(!mErreur.equals(lMessages.getString("profilMessageOk")))
  {
%>
<form action="./ModificationProfil" method="post" name="modificationProfil">
  <table class="tableau" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("collaborateurNom")%> *</td>
      <td class="caseNiveau3"><input type="text" name="mNom" value="<%=mNom%>" size="<%= CConstante.TXT_LOGIN %>" class="niveau2"></td>
    </tr>
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("collaborateurPrenom")%></td>
      <td class="caseNiveau3"><input type="text" name="mPrenom" value="<%=mPrenom%>" size="<%= CConstante.TXT_LOGIN %>" class="niveau2"></td>
    </tr>
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("collaborateurMail")%></td>
      <td class="caseNiveau3"><input type="text" name="mMail" value="<%=mMail%>" size="<%= CConstante.TXT_LOGIN %>" class="niveau2"></td>
    </tr>
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("collaborateurAdresse")%></td>
      <td class="caseNiveau3"><textarea name="mAdresse" rows=3><%=mAdresse%></textarea></td>
    </tr>
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("collaborateurTelephone")%></td>
      <td class="caseNiveau3"><input type="text" name="mTelephone" value="<%=mTelephone%>" size="<%= CConstante.TXT_LOGIN %>" class="niveau2"></td>
    </tr>
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("collaborateurPortable")%></td>
      <td class="caseNiveau3"><input type="text" name="mPortable" value="<%=mPortable%>" size="<%= CConstante.TXT_LOGIN %>" class="niveau2"></td>
    </tr>
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("collaborateurCommentaire")%></td>
      <td class="caseNiveau3"><textarea name="mCommentaire" rows=3><%=mCommentaire%></textarea></td>
    </tr>
  </tbody>
  </table>
  <br><br>
  <table class="tableau" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("collaborateurLogin")%> *</td>
      <td class="caseNiveau3"><input type="text" name="mLogin" value="<%=mLogin%>" size="<%= CConstante.TXT_LOGIN %>" class="niveau2"></td>
    </tr>
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("profilAncienMdp")%></td>
      <td class="caseNiveau3"><input type="PASSWORD" name="mAncienMdp" size="<%= CConstante.TXT_LOGIN %>" class="niveau2" onclick="changementMdp();"></td>
    </tr>
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("profilNouveauMdp")%></td>
      <td class="caseNiveau3"><input type="PASSWORD" name="mNouveauMdp" size="<%= CConstante.TXT_LOGIN %>" class="niveau2" onclick="changementMdp();"></td>
    </tr>
    <tr>
      <td class="caseNiveau1"><%=lMessages.getString("profilConfirmationMdp")%></td>
      <td class="caseNiveau3"><input type="PASSWORD" name="mConfirmationMdp" size="<%= CConstante.TXT_LOGIN %>" class="niveau2" onclick="changementMdp();"></td>
    </tr>
  </table>
  <input type="hidden" name="mModifLogin" value="0">
  <input type="hidden" name="mModifMdp" value="0">
  <br><br>
  <font class="texteSubmit">
    <input type="button" class="bouton" value="<%=lMessages.getString("collaborateurValider")%>" onCLick="envoyer();">
  </font>
  <br><br><br>
  * : Champs obligatoire
</form>
<%
  }
%>
</center>
