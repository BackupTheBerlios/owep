<%@page import="owep.controle.CConstante"%>
<%@page import="owep.vue.transfert.VTransfert"%>
<%@page import="owep.vue.transfert.VTransfertConstante"%>
<%@page import="owep.infrastructure.Session"%>
<%@page import="owep.modele.execution.MProjet"%>
<%@page import="owep.modele.execution.MActiviteImprevue"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>

<%
  MProjet lProjet = (MProjet) request.getAttribute (CConstante.PAR_PROJET) ;
  
  // Liste des champs transf�r�s.
  String lChampActiviteImprevueNom             = "" ;
  String lChampActiviteImprevueDescription     = "" ;
%>


<p class="titre1">PROJET : <%= lProjet.getNom () %></p>
<p class="texte"><%= lProjet.getDescription () %></p>
<br/><br/>
 
<form action="./ActiviteImprevue" method="post" name="<%= CConstante.PAR_FORMULAIRE%>">

      <%
        for (int lIndiceActiviteImp = 0; lIndiceActiviteImp < lProjet.getNbActivitesImprevues () ; lIndiceActiviteImp ++)
        {
          MActiviteImprevue lActiviteImprevue = lProjet.getActiviteImprevue (lIndiceActiviteImp) ;
      %>
        <transfert:transfertbean scope="Session" type="owep.modele.processus.MActiviteImprevue" bean="pActiviteImprevue" idArbre="<%= CConstante.PAR_ARBREACTIVITEIMPREVUE %>">
          <!-- Ajoute le champ "Nom" � la liste -->
          <input <transfert:transfertchamp membre="setNom" type="" libelle="Nom de l\\'activit� impr�vue" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREACTIVITEIMPREVUE %>"/>
           type="hidden" value="<%= lActiviteImprevue.getNom () %>">
        
          <!-- Ajoute le champ "Description" � la liste -->
          <input <transfert:transfertchamp membre="setDescription" type="" libelle="Description de l'activit� impr�vue" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREACTIVITEIMPREVUE %>"/>
           type="hidden" value="<%= lActiviteImprevue.getDescription () %>">
       </transfert:transfertbean>
      <%
        }
      %>  
        


  <table class="tableau" width="100%" cellpadding="0" cellspacing="0">
  <tbody>
  
    <!-- Champs de l'activit� impr�vue -->
    <tr> 
      <td class="caseNiveau1" colspan="2">Activit� impr�vue :</td>
    </tr>
    <tr>
      <td>
        <select name="<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>" class="niveau2" style="width: 200" size="5"
        onchange="selectActiviteImprevue (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>.selectedIndex)">
          <% for (int lIndiceActiviteImprevue = 0; lIndiceActiviteImprevue < lProjet.getNbActivitesImprevues (); lIndiceActiviteImprevue++)
             {
          %>
               <option value="<%= lIndiceActiviteImprevue %>"> <%= lProjet.getActiviteImprevue (lIndiceActiviteImprevue).getNom () %> </option>
          <%
             }
          %>
        </select>
      </td>
      <td>
        <transfert:transfertbean scope="Session" type="owep.modele.processus.MActiviteImprevue" bean="pActiviteImprevue" idArbre="<%= CConstante.PAR_ARBREACTIVITE %>">
        <table width="100%" cellpadding="0" cellspacing="0" valign="top">
          <tr>
            <td class="caseNiveau3SansBordure">
              Nom de l'activit� * :
            </td>
            <td>
              <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom de l\\'activit�" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREACTIVITE %>"/>
               type="text" size="48" class="niveau2"
               value="" maxlength="<%= CConstante.TXT_MOYEN %>">
              <% lChampActiviteImprevueNom = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          <tr>
            <td class="caseNiveau3SansBordure">
             Description :
            </td>
            <td>
              <input <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREACTIVITE %>"/> 
               type="text" size="48" class="niveau2"
               value=""  maxlength="<%= CConstante.TXT_MOYEN %>">
              <% lChampActiviteImprevueDescription = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

  </transfert:transfertbean>

  <br>
  <p class="paragrapheSubmit">
    <transfert:transfertsubmit libelle="Ajouter" valeur="<%= CConstante.PAR_SUBMIT %>" verification="true" validation="validerFormulaireAjouter () ;"/>
    <transfert:transfertsubmit libelle="Modifier" valeur="<%= CConstante.PAR_SUBMITMODIFIER %>" verification="true" validation="validerFormulaireModifier () ;"/>
    <transfert:transfertsubmit libelle="Supprimer" valeur="<%= CConstante.PAR_SUBMITSUPPRIMER %>" verification="true" validation="validerFormulaireSupprimer () ;"/>
  </p>

</form>


<script>
  <!-------------------------------------------------->
  <!-- Ensemble des donn�es des activit�s impr�vues -->
  <!-------------------------------------------------->
  var gListeActivitesImprevues = new Array () ;
  <%
    for (int lIndiceActiviteImprevue = 0; lIndiceActiviteImprevue < lProjet.getNbActivitesImprevues (); lIndiceActiviteImprevue ++)
    {
      MActiviteImprevue lActiviteImprevueTmp = lProjet.getActiviteImprevue (lIndiceActiviteImprevue) ;
  %>
      gListeActivitesImprevues.push (new Array ("<%= lIndiceActiviteImprevue %>", "<%= lActiviteImprevueTmp.getNom () %>", "<%= lActiviteImprevueTmp.getDescription () %>")) ;
  <%
    }
  %>

  <!------------------------------------------------------->
  <!-- Fonctions de gestion des composants du formulaire -->
  <!------------------------------------------------------->
  function selectActiviteImprevue (pIndiceActiviteImprevue)
  {
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampActiviteImprevueNom %>.value = gListeActivitesImprevues[pIndiceActiviteImprevue][1] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampActiviteImprevueDescription %>.value = gListeActivitesImprevues[pIndiceActiviteImprevue][2] ;
  }
  
  <!------------------------------------------->
  <!-- Fonctions de validation du formulaire -->
  <!------------------------------------------->

  function validerFormulaireAjouter () 
  {
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREACTIVITE) %> () ;
    validerChamps () ;
  }
  
  function validerFormulaireModifier () 
  {
    if (confirm("Certaines t�ches impr�vues peuvent d�pendre de cette activit�. Etes vous s�r de vouloir la modifier ?"))
    {
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREACTIVITE) %> () ;
      validerChamps () ;
    }
  }
  
  function validerFormulaireSupprimer () 
  {
    if (confirm("Certaines t�ches impr�vues peuvent d�pendre de cette activit�. Etes vous s�r de vouloir la supprimer car cela entrainnera la suppression des t�ches impr�vues et de leurs artefacts ?"))
    {
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREACTIVITE) %> () ;
      validerChamps () ;
    }
  }
</script>