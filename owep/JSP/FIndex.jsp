<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<center>

<%
  // Récupération des parametres
  String mProbleme = (String) request.getAttribute("mProbleme"); // Probleme rencontré lors de l'enregistrement du collaborateur
  
  // Si l'attribut mProbleme existe alors un probleme est survenu lors de l'dentification
  if(mProbleme != null)
  {
%>
Le login et le mot de passe saisi ne sont pas valide<BR>
<%
  }
%>

<form action="../Outil/Connexion" method="post">
  <table class="tableauInvisible" border="0" cellpadding="1" cellspacing="1">
    <tr>
      <td class="caseInvisible" rowspan="2" align="right">Login&nbsp<br>Mot de passe&nbsp</td>
      <td class="caseInvisible" rowspan="2"><input type=text size=10 name="login"><br><input type="PASSWORD" size=10 name="pwd"></td>
    </tr>
  </table>
  <br><br>
  <font class="texteSubmit">
    <input type="submit" value="Valider">
  </font>
</form>
</center>
