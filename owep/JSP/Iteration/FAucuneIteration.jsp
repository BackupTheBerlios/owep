<%
    //localisation
    java.util.ResourceBundle messages;
    messages = java.util.ResourceBundle.getBundle("MessagesBundle"); 
%>
    <%=messages.getString("aucuneIterationCree")%>

 <BR><BR>
 <a href="/owep/Processus/IterationModif"><B><%=messages.getString("listeTacheAjouterIteration")%></B></a>
