
<%
  String mFichier = (String) request.getAttribute("mFichierExport");
%>
<center>
Projet exporter.<br>
<a href="../Processus/Export/<%=mFichier%>"><%=mFichier%></a>
</center>
