<%
  // Récupération des paramétres
  String mErreur = (String) request.getAttribute("mErreur");
  if(mErreur == null)
    mErreur = "";
%>

<br><br>
<center>
<%=mErreur%>
<form action="/owep/Installation/Site" method="post">
<table class="tableauInvisible" border="0" cellpadding="1" cellspacing="1">
<tr>
    <td class="caseInvisible">Langue : </td>
	<td>
      <select class="niveau1" name="mLangue" size ="1">
         <option VALUE="fr_FR" selected>Francais</option>
         <option VALUE="en_US" >Anglais</option>
      </select>
    </td>  
  </tr>
  
  <tr>
    <td class="caseInvisible">Apparence : </td>
	<td>
      <select class="niveau1" name="mApparence" size ="1">
         <option VALUE="Blue.css" >Bleue</option>
         <option VALUE="Red.css" selected>Rouge</option>
      </select>
    </td>
  </tr>
</table>  
</center>
    <br>
  <center>  
    <input class="bouton" type="submit" value="Suivant  &gt"
     onmouseover="tooltipOn(this, event, 'Cliquez pour valider le formulaires.')" onmouseout="tooltipOff(this, event)">
  </center>

</form>









