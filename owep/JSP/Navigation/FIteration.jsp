<%@page import="owep.controle.CConstante"%>

<center>
	<form id="navigation">
    Choisissez l'it�ration : 	    
    
       <select name="pNumIteration" size=1 onChange="navigationIteration (this.form.pNumIteration)">   
      <%
      	//r�cup�ration de la liste des it�rations � partir du projet s�lectionn� dans la session
        java.util.ArrayList listeIteration = ((owep.infrastructure.Session)(request.getSession().getAttribute("SESSION"))).getProjet().getListeIterations(); 
        for(int i=0; i<listeIteration.size(); i++)
        {
      %>
        <option
          <%if (((owep.modele.execution.MIteration)listeIteration.get(i)).equals(((owep.infrastructure.Session)(request.getSession().getAttribute("SESSION"))).getIteration())){%>
            selected
          <%}%>
          value="<%=((owep.modele.execution.MIteration)listeIteration.get(i)).getId()%>">It�ration <%=((owep.modele.execution.MIteration)listeIteration.get(i)).getNumero()%>
        </option>
	  <%}%>  
	    </select>
	</form>
</center>