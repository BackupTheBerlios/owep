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
  
  //Récupération du ressource bundle
  ResourceBundle messages = lSession.getMessages();
  
  // Variable de la page
  boolean mProjetOuvert = (lSession.getProjet() != null);
  boolean mEstChefProjet = false;
  if(mProjetOuvert)
  {
    mEstChefProjet = (lSession.getProjet().getChefProjet().getId() == lSession.getCollaborateur().getId());
  }
%>  

<%
  // Déclaration des variables
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
      <!-- Le formulaire ayant pour nom changerProjet est envoyé dés qu'un changement sur la sélection de la liste a été constaté -->
      <select class="menuProjet" name="mIdProjet" size ="1" onchange="changerProjet.submit()">
<%
  // Affichage de la liste des projets possibles
  // Le projet ouvert est sélectionné par défaut
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
  
<%
  if(mProjetOuvert){
%>  
  <!-- menu avancement -->
  <tr>
    <td class="caseMenuNiveau1">
      <p class="menuNiveau1">Avancement :</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Tache/ListeTacheVisu?menu=clique">Liste des tâches</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuSeparation">
      &nbsp;
    </td>
  </tr>
<%
  }
  
  // Test si un projet est ouvert et si le collaborateur connecté est le responsale du projet ouvert
  if(mProjetOuvert && mEstChefProjet)
  {
%>
  <!-- menu Suivi de projet -->
  <tr>
    <td class="caseMenuNiveau1">
      <p class="menuNiveau1">Suivi de Projet :</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Avancement/AvancementProjet?menu=clique">Projet</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Avancement/AvancementCollaborateur?menu=clique">Collaborateurs</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <p class="menuNiveau2">Risques</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Gestion/ListeProblemeVisu">Problèmes</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuSeparation">
      &nbsp;
    </td>
  </tr>
  
  <!-- menu Gestion de projet -->
  <tr>
    <td class="caseMenuNiveau1">
      <p class="menuNiveau1">Gestion de Projet :</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Processus/ProjetVisu">Itérations</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Processus/CreationCollaborateur">Collaborateurs</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Processus/ActiviteImprevue">Activités imprévues</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Processus/TacheImprevue">Tâches imprévues</a>
    </td>
  </tr>
<%
    // Test si le collaborateur connecté a le droit de créer un projet
    if(lSession.getCollaborateur().getDroit() == 1)
    {
%>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Processus/GererProjet">Création d'un projet</a><br>
    </td>
  </tr>
<%
    }
%>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Outil/ExporterProjet">Exporter le projet</a><br>
    </td>
  </tr>
  <tr>
    <td class="caseMenuSeparation">
      &nbsp;
    </td>
  </tr>
  
<%
  }
  
  // Si aucun projet n'est ouvert le collaborateur peut créer un projet si il en a le droit
  if(!mProjetOuvert && lSession.getCollaborateur().getDroit() == 1)
  {
%>
  <!-- menu projet -->
  <tr>
    <td class="caseMenuNiveau1">
      <p class="menuNiveau1">Projet :</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Processus/CreationCollaborateur">Collaborateurs</a>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <a class="menuNiveau2" href="../Processus/GererProjet">Création d'un projet</a><br>
    </td>
  </tr>
  <tr>
    <td class="caseMenuSeparation">
      &nbsp;
    </td>
  </tr>
<%
  }
%>
  
  <!-- menu configuration -->
  <tr>
    <td class="caseMenuNiveau1">
      <p class="menuNiveau1">Configuration :</p>
    </td>
  </tr>
  <tr>
    <td class="caseMenuNiveau2">
      <p class="menuNiveau2">Modifier son profil</p>
    </td>
  </tr>
  
<%//Test si l'utilisateur connecté est le chef de projet
  if (mProjetOuvert && mEstChefProjet) {%>  
  <tr>
    <td class="caseMenuNiveau2">
      <p class="menuNiveau2">Option de l'application</p>
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