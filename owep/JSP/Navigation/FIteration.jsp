<center>
	<form id="navigation">
    Choisissez l'it�ration : 
	  <select name="pNumIteration" size=1 onChange="navigationIteration (this.form.pNumIteration)">
      <option selected value="<%= request.getAttribute ("pNumIteration") %>">It�ration <%= request.getAttribute ("pNumIteration") %></option>
	  </select>
	</form>
</center>