<%@page import="owep.controle.CConstante"%>
<%@page import="owep.vue.transfert.VTransfert"%>
<%@page import="owep.vue.transfert.VTransfertConstante"%>
<%@page import="owep.infrastructure.Session"%>
<%@page import="owep.modele.execution.MProjet"%>
<%@page import="owep.modele.execution.MActiviteImprevue"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>

<%
  Session    lSession   = (Session) session.getAttribute (CConstante.SES_SESSION) ;
  MProjet    lProjet    = lSession.getProjet() ;
  
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
         onchange="selectActiviteImprevue (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>.selectedIndex)"
         onmouseover="tooltipOn (this, event, 'Liste des activit�s impr�vues existantes.')" onmouseout="tooltipOff(this, event)">
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
               type="text" size="48" class="niveau2" value="" maxlength="<%= CConstante.TXT_MOYEN %>"
               onmouseover="tooltipOn (this, event, 'Saisissez le nouveau nom de l\'activit�.')" onmouseout="tooltipOff(this, event)">
              <% lChampActiviteImprevueNom = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          <tr>
            <td class="caseNiveau3SansBordure">
             Description :
            </td>
            <td>
              <input <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREACTIVITE %>"/> 
               type="text" size="48" class="niveau2" value=""  maxlength="<%= CConstante.TXT_MOYEN %>"
               onmouseover="tooltipOn (this, event, 'Saisissez la description de l\'activit�.')" onmouseout="tooltipOff(this, event)">
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
    <transfert:transfertsubmit libelle="Valider" valeur="<%= CConstante.PAR_SUBMIT %>" verification="true" validation="validerFormulaire () ;"/>
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

  function validerFormulaire () 
  {
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREACTIVITE) %> () ;
    validerChamps () ;
  }
</script>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Activit� impr�vue</b> offre la possibilit� de d�finir des activit�s (c'est � dire des regroupements de t�ches) <b>non pr�vues</b> dans le processus." ;
pCodeAide += " Ces activit�s impr�vues doivent donc �tre utilis�s en conjonction avec des <b>t�ches impr�vues</b> (accessibles depuis le menu)." ;
</script>
