<%@page import="java.util.ArrayList"%>
<%@page import="owep.infrastructure.Session"%>
<%@page import="owep.modele.execution.MProjet"%>
<%@page import="java.util.ResourceBundle"%>

<jsp:useBean id="lSession" class="owep.infrastructure.Session" scope="page"/>
<jsp:useBean id="lProjet" class="owep.modele.execution.MProjet" scope="page"/>

<%
    // Recuperation de la session
  HttpSession httpSession = request.getSession(true);
  lSession = (Session) httpSession.getAttribute("SESSION");
  
  //R�cup�ration du ressource bundle
  ResourceBundle messages = lSession.getMessages();
%>  

<%
  // D�claration des variables
  int idProjetOuvert ;
  
  // Recuperation de la liste de projet possible
  ArrayList lListProjet = lSession.getListProjetPossible();
  
  // Recuperation du projet ouvert
  lProjet = lSession.getProjet();
  
  // Si aucun projet n'est ouvert
  if(lProjet == null)
  {
    // Alors  la variable idProjetOuvert prend pour valeur -1
    idProjetOuvert = -1;
  }
  else
  {
    // Sinon la variable prend pour valeur l'id du projet
    idProjetOuvert = lProjet.getId();
  }
%>

<table class="regionMenu" style="width : 100%; height : 100%" cellpadding="0" cellspacing="0">
<!-- <table width="100%" height="100%" cellpadding="0" cellspacing="0"> -->
<tbody>

  <!-- menu Avancement -->
  <form name="changerProjet" action="../Projet/OuvrirProjet" method="post">
  <tr>
    <td class="caseMenuProjet">
      <!-- Le formulaire ayant pour nom changerProjet est envoy� d�s qu'un changement sur la s�lection de la liste a �t� constat� -->
      <select class="menuProjet" name="mIdProjet" size ="1" onchange="changerProjet.submit()">
<%
  // Affichage de la liste des projets possibles
  // Le projet ouvert est s�lectionn� par d�faut
  for(int i = 0 ; i<lListProjet.size() ; i++)
  {
    lProjet = (MProjet) lListProjet.get(i);
%>
        <option VALUE="<%=lProjet.getId()%>" <%=(idProjetOuvert == lProjet.getId())?"selected":""%>>
          <%=lProjet.getNom()%>
        </option>
<%
  }
%>
      </select>
    </td>
  </tr>
  </form>
  
  <tr>
    <td class="caseMenuConnexion">
      <a class="menuConnexion" href="../Outil/Deconnexion"><%=messages.getString("menuDeconnexion")%></a>
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
      <a class="menuNiveau2" href="../Tache/ListeTacheVisu?menu=clique">Liste des t�ches</a>
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
      <a class="menuNiveau2" href="../Avancement/AvancementProjet?menu=clique">Suivi du projet</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Avancement/AvancementCollaborateur?menu=clique">Suivi des collaborateurs</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <p class="menuNiveau2">Gestion des risques</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Gestion/ListeProblemeVisu">Probl�mes</a>
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