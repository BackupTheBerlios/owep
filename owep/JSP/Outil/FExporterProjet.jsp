<%
  String mFichier = (String) request.getAttribute("mFichierExport");
%>
<center>
  Cliquez sur le lien ci-dessous pour accéder au <b>projet exporté :</b><br>
  <a href="../Processus/Export/<%=mFichier%>"><%=mFichier%></a>
</center>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Exportation du projet</b> contient un lien vers le<b>fichier XML</b> avec toutes les données du projet actuellement ouvert." ;
pCodeAide += " Cliquez sur ce lien pour ouvrir le fichier dans votre naviguateur ou faites un <b>clic-droit</b> puis <b>\"Enregistrez-sous\"</b> pour enregistrer le fichier votre ordinateur." ;
</script>
