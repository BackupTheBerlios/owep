<%@page import="owep.controle.CConstante"%>
<%@page import="owep.infrastructure.Session"%>
<%@page import="owep.modele.execution.MIteration"%>
<%@page import="java.util.ArrayList"%>

<jsp:useBean id="lSession"   class="owep.infrastructure.Session"      scope="page"/> 
<jsp:useBean id="lIteration" class="owep.modele.execution.MIteration"        scope="page"/> 

<center>

	<form action="/owep/Navigation/NavigationIteration" id="navigation" name="formulaireIteration">
    Choisissez l'it�ration : 	    
       <select name="<%=CConstante.PAR_ITERATION%>" size=1 onChange="formulaireIteration.submit();">   
      <%
      	MIteration iteration;
      	lSession = (Session)(request.getSession().getAttribute("SESSION"));
      
      	//r�cup�ration de la liste des it�rations � partir du projet s�lectionn� dans la session
        ArrayList listeIteration = lSession.getProjet().getListeIterations(); 
        for(int i=0; i<listeIteration.size(); i++)
        {
          iteration = (MIteration)listeIteration.get(i);
      %>
        <option
          <%if (iteration.getId() == lSession.getIteration().getId()){%>
            selected
          <%}%>
          value="<%=iteration.getId()%>">It�ration <%=iteration.getNumero()%>
		  <%if (iteration.getEtat() == 1) {%> X <%}%>            	
        </option>
	  <%}%>  
	    </select>
	</form>
</center>