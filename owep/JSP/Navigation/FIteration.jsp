<center>
	<form id="navigation">
    Choisissez l'itération : 
	  <select name="pNumIteration" size=1 onChange="navigationIteration (this.form.pNumIteration)">
      <option selected value="<%= request.getAttribute ("pNumIteration") %>">Itération <%= request.getAttribute ("pNumIteration") %></option>
	  </select>
	</form>
</center>