<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tbody>

  <!-- menu G�n�ral -->
  <tr>
    <td class="caseMenuProjet">
      <select class="menuProjet" name="LDProjet" size ="1">
        <option value="Projet1">Projet 1</option>
      </select>
    </td>
  </tr>
  <tr>
    <td class="caseMenuConnexion">
      <a class="menuConnexion" href="../Outil/Deconnexion">D�connexion</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuSeparation">
      &nbsp;
    </td>
  </tr>
  
  
  <!-- menu avancement -->
  <tr>
    <td class="caseMenuNiveau1">
      <p class="menuNiveau1">Avancement :</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Tache/ListeTacheVisu">Liste des t�ches</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuSeparation">
      &nbsp;
    </td>
  </tr>


<%//Test droit : partie chef de projet
  if (((owep.infrastructure.Session)(request.getSession().getAttribute("SESSION"))).getCollaborateur().getDroit() == 1) {%>

  <!-- menu projet -->
  <tr>
    <td class="caseMenuNiveau1">
      <p class="menuNiveau1">Projet :</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Processus/ProjetVisu">Suivi du projet</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <p class="menuNiveau2">Suivi des collaborateurs</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <p class="menuNiveau2">Gestion des risques</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <p class="menuNiveau2">Gestion des probl�mes</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">

      <a class="menuNiveau2" href="../Processus/CreationCollaborateur">Gestion des collaborateurs</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      T�che impr�vues

    </td>
  </tr>
  <tr>
    <td class="caseMenuSeparation">
      &nbsp;
    </td>
  </tr>
  
  <%}%>
  
  <!-- menu configuration -->
  <tr>
    <td class="caseMenuNiveau1">
      <p class="menuNiveau1">Configuration :</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">

      Modifier son profil
    </td>
  </tr>
  
<%//Test droit : partie chef de projet
  if (((owep.infrastructure.Session)(request.getSession().getAttribute("SESSION"))).getCollaborateur().getDroit() == 1) {%>  
  <tr>
    <td class="caseMenuNiveau2">
      Option de l'application
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <p class="menuNiveau2">Option de projet</p>
    </td>
  </tr>
<%}%>  
  <tr>
    <td height="100%" class="caseMenuSeparation2">
      &nbsp;
    </td>
  </tr>
  <tr>
    <td class="caseMenuSeparation">
      &nbsp;
    </td>
  </tr>
</tbody>
</table>