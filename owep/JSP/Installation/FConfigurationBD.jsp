<%@page import="owep.controle.CConstante"%>

<%
  // R�cup�ration parametre
  String mErreur = (String) request.getAttribute("mErreur");
  if(mErreur == null)
    mErreur = "";
  
%>
<br><br>
<center>
  <%=mErreur%>
  <form method="post" action="/owep/Installation/ConfigurationBD" name="formConfigurationBD">
    <table class="tableauInvisible" border="0" cellpadding="1" cellspacing="1">
      <tr>
        <td class="caseInvisible" align="right">
          URL de connexion � la base de donn�es : 
        </td>
        <td class="caseInvisible">
          <input class="niveau2" type="text" name="url" value="jdbc:mysql://localhost:3306/" size="<%=CConstante.LNG_PETIT%>">
        </td>
      </tr>
      <tr>
        <td class="caseInvisible" align="right">
          Nom d'utilisateur base de donn�es : 
        </td>
        <td class="caseInvisible">
          <input class="niveau2" type="text" name="login" value="root" size="<%=CConstante.LNG_LOGIN%>">
        </td>
      </tr>
      <tr>
        <td class="caseInvisible" align="right">
          Mot de passe base de donn�es : 
        </td>
        <td class="caseInvisible">
          <input class="niveau2" type="PASSWORD" name="mdp" value="" size="<%=CConstante.LNG_LOGIN%>">
        </td>
      </tr>
    </table>
    <br>
    <input type="submit" class="bouton" value="Suivant  &gt">
  </form>
</center>
