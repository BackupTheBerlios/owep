<%@page import="owep.controle.CConstante"%>
<%@page import="owep.infrastructure.Session"%>
<%@page import="owep.modele.processus.MComposant"%>
<%@page import="owep.modele.processus.MProcessus"%>
<%@page import="owep.modele.processus.MDefinitionTravail"%>
<%@page import="owep.modele.processus.MActivite"%>
<%@page import="owep.modele.processus.MProduit"%>
<%@page import="owep.modele.processus.MRole"%>
<%@page import="owep.modele.execution.MIteration"%>
<%@page import="owep.modele.execution.MTache"%>
<%@page import="owep.modele.execution.MProjet"%>
<%@page import="owep.modele.execution.MCollaborateur"%>
<%@page import="owep.modele.execution.MArtefact"%>
<%@page import="owep.vue.transfert.VTransfert"%>
<%@page import="owep.vue.transfert.VTransfertConstante"%>
<%@page import="owep.vue.transfert.convertor.VDateConvertor"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>


<!-- Déclaration des variables locales -->
<%
  boolean lModif = request.getParameter (CConstante.PAR_SUBMIT) != null ;
  Session lSession      = (Session) session.getAttribute (CConstante.SES_SESSION) ;
  MIteration lIteration = (MIteration) session.getAttribute (CConstante.SES_ITERATION) ;
  MProjet lProjet       = lIteration.getProjet () ;
  MProcessus lProcessus = lProjet.getProcessus () ;

  // Code javascript permettant de gérer la liste de tâche
  String lCodeScript          = "<script type=\"text/javascript\" language=\"JavaScript\">\n" ;
  String lCodeScriptActivite  = "<script type=\"text/javascript\" language=\"JavaScript\">\n" ;
  String lCodeScriptArtefact  = "<script type=\"text/javascript\" language=\"JavaScript\">\n" ;
  String lCodeScriptProduit   = "<script type=\"text/javascript\" language=\"JavaScript\">\n" ;
  String lCodeScriptArtEntree = "<script type=\"text/javascript\" language=\"JavaScript\">\n" ;
  String lCodeValidation = "" ;
%>


<p class="titre1">PROJET : <%= lProjet.getNom () %></p>
<p class="texte"><%= lProjet.getDescription () %></p>
<br/><br/>
 
<form action="./IterationModif" method="post">

  <transfert:transfertbean scope="Session" type="owep.modele.execution.MIteration" bean="pIteration" idArbre="<%= CConstante.PAR_ARBREITERATION %>">
    <input <transfert:transfertchamp membre="setNumero" type="java.lang.Integer" libelle="Numéro de l\\'itération" convertor="VIntegerConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
     type="hidden" value="<%= lIteration.getNumero () %>" maxlength="<%= CConstante.TXT_MOYEN %>">

  <table class="tableau" width="100%" cellpadding="0" cellspacing="0">
  <tbody>
    <tr> 
      <td class="caseNiveau1" colspan="2">Itération <%= lIteration.getNumero () %> :</td>
    </tr>
    <tr> 
      <td class="caseNiveau3" colspan="2">
        Nom de l'itération : <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom de l\\'itération" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
                              type="text" size="48" class="niveau2"
                              value="<%= lIteration.getNom () %>" maxlength="<%= CConstante.TXT_MOYEN %>">
      </td>
    </tr>
    <tr> 
      <td class="caseNiveau3" width="50%">
        Date de début prévue : <input <transfert:transfertchamp membre="setDateDebutPrevue" type="java.util.Date" libelle="Date de début prévue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/> 
                                type="text" size="8" class="niveau2"
                                value="<%= VDateConvertor.getString (lIteration.getDateDebutPrevue ()) %>"  maxlength="<%= CConstante.TXT_DATE %>">
      </td>
      <td class="caseNiveau3" width="50%">
        Date de fin prévue : <input <transfert:transfertchamp membre="setDateFinPrevue" type="java.util.Date" libelle="Date de fin prévue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>  
                              type="text" size="8" class="niveau2"
                              value="<%= VDateConvertor.getString (lIteration.getDateFinPrevue ()) %>" 
                              maxlength="<%= CConstante.TXT_DATE %>">
      </td>
    </tr>
    <tr> 
      <td class="caseNiveau3" width="50%">
        Date de début réelle : <input <transfert:transfertchamp membre="setDateDebutReelle" type="java.util.Date" libelle="Date de début réelle" convertor="VDateConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>  
                                type="text" size="8"  class="niveau2"
                                value="<%= VDateConvertor.getString (lIteration.getDateDebutReelle ()) %>" 
                                maxlength="<%= CConstante.TXT_DATE %>">
      </td>
      <td class="caseNiveau3" width="50%">
        Date de fin réelle : <input <transfert:transfertchamp membre="setDateFinReelle" type="java.util.Date" libelle="Date de fin réelle" convertor="VDateConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>  
                              type="text" size="8" class="niveau2"
                              value="<%= VDateConvertor.getString (lIteration.getDateFinReelle ()) %>" 
                              maxlength="<%= CConstante.TXT_DATE %>">
      </td>
    </tr>
  </tbody>
  </table>

  <br/><br/><br/>

  <table class="tableau" width="100%" cellpadding="0" cellspacing="0">
  <tbody>
    <tr> 
      <td class="caseNiveau1" colspan="2">Liste des tâches à réaliser :</td>
    </tr>
    <tr> 
      
      
      <!-- Liste des champs cachés contenant les données des tâches -->
      <%
        lCodeScript += "var gListeTaches = new Array () ;\n" ;
        
        for (int i = 0; i < lIteration.getNbTaches (); i++)
        {
          MTache lTache = lIteration.getTache (i) ;
      %>
        <transfert:transfertbean scope="Session" type="owep.modele.execution.MTache" bean="getTache" idArbre="<%= CConstante.PAR_ARBREITERATION %>">
        <!-- Ajoute le champ "Nom" à la liste -->
        <input <transfert:transfertchamp membre="setNom" type="" libelle="Nom de la tâche" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= lTache.getNom () %>">
        <%
          lCodeScript += "gListeTaches.push (new Array (\"" + lTache.getNom () + "\", " ;
        %>
        
        <!-- Ajoute le champ "Description" à la liste -->
        <input <transfert:transfertchamp membre="setDescription" type="" libelle="Description de la tâche" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= lTache.getDescription () %>">
        <%
          lCodeScript += "\"" + lTache.getDescription () + "\", " ;
        %>
        
        <!-- Ajoute le champ "ChargeInitiale" à la liste -->
        <input <transfert:transfertchamp membre="setChargeInitiale" type="" libelle="Charge initiale de la tâche" convertor="VDoubleConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= lTache.getChargeInitiale () %>">
        <%
          lCodeScript += "\"" + lTache.getChargeInitiale () + "\", " ;
        %>
        
        <!-- Ajoute le champ "DateDebutPrevu" à la liste -->
        <input <transfert:transfertchamp membre="setDateDebutPrevue" type="" libelle="Date de début prévue de la tâche" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= VDateConvertor.getString (lTache.getDateDebutPrevue ()) %>">
        <%
          lCodeScript += "\"" + VDateConvertor.getString (lTache.getDateDebutPrevue ()) + "\", " ;
        %>
        
        <!-- Ajoute le champ "DateFinPrevue" à la liste -->
        <input <transfert:transfertchamp membre="setDateFinPrevue" type="" libelle="Date de fin prévue de la tâche" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= VDateConvertor.getString (lTache.getDateFinPrevue ()) %>">
        <%
          lCodeScript += "\"" + VDateConvertor.getString (lTache.getDateFinPrevue ()) + "\", " ;
        %>
        
        <!-- Ajoute les champs Disciplines, activités et collaborateurs -->
        <!-- TODO A optimiser en utilisant une méthode générale de recherche (cf. TODO controleur) -->
        <% 
           MActivite lActTmp = null ;
           int lIndiceDefTravail = 0 ;
           for (int l = 0; (lActTmp == null) && (l < lProcessus.getNbComposants ()); l ++)             
           {
             MComposant lComposant ;
             lComposant = lProcessus.getComposant (l) ;
             
             /* Recherche la position de la définition de travail dans la liste si présente */
             for (int j = 0; (lActTmp == null) && (j < lComposant.getNbDefinitionsTravail ()); j ++)
             {
               /* Recherche la position de l'activité dans la liste si présente */
               for (int k = 0; (lActTmp == null) && (k < lComposant.getDefinitionTravail (j).getNbActivites ()); k ++) 
               {
                 /* On a trouvé l'activité dans la liste, on sort des boucles */
                 if (lComposant.getDefinitionTravail (j).getActivite (k).getId () == lTache.getActivite ().getId ())
                 {
                   lActTmp = lComposant.getDefinitionTravail (j).getActivite (k) ;
                   lCodeScript += "\"" + lIndiceDefTravail + "\", " ;
                   lCodeScript += "\"" + k + "\", " ;
                 }
               }
               
               lIndiceDefTravail ++ ;
             } 
          }
          
          /* Cherche l'indice du collaborateur dans la liste */
          for (int l = 0; l < lProjet.getNbCollaborateurs (); l ++) 
          {
            if (lProjet.getCollaborateur (l).getId () == lTache.getCollaborateur ().getId ())
            {
              lCodeScript += "\"" + l + "\", new Array (), new Array())) ;\n" ;
              break ;
            }
          }
          
          for (int a = 0; a < lTache.getNbArtefactsEntrees (); a ++)
          {
            MArtefact lArtEntree = lTache.getArtefactEntree (a) ;
            lCodeScript += "gListeTaches[" + i + "][9].push (new Array (\"" + lTache.getArtefactEntree (a).getId () + "\", \"" + lTache.getArtefactEntree (a).getNom () + "\")) ;\n" ;
          }
          
          
          /* Liste des champs cachés contenant les données des artefacts en sorties */ 
          for (int ai = 0 ; ai < lTache.getNbArtefactsSorties () ; ai ++)
          {
          %>
            <transfert:transfertbean scope="Session" type="owep.modele.execution.MArtefact" bean="getArtefactSortie" idArbre="<%= CConstante.PAR_ARBREITERATION %>">
            <!-- Ajoute le champ "Nom" à la liste -->
            <input <transfert:transfertchamp membre="setNom" type="" libelle="Nom de l\\'artefact en sortie" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
             type="hidden" value="<%= lTache.getArtefactSortie (ai).getNom () %>">
            <!-- Ajoute le champ "Description" à la liste -->
            <input <transfert:transfertchamp membre="setDescription" type="" libelle="Description de l\\'artefact en sortie" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
             type="hidden" value="<%= lTache.getArtefactSortie (ai).getDescription () %>">
            </transfert:transfertbean>
            <%
              for (int w  = 0; w < lTache.getActivite ().getNbProduitsSorties (); w ++) 
              {
                MProduit lProduitTmp = lTache.getActivite ().getProduitSortie (w) ;
                if (lProduitTmp.getId () == lTache.getArtefactSortie (ai).getProduit ().getId ()) 
                {
                  lCodeScript += "gListeTaches[" + i + "][8].push (new Array (\"" + ai + "\", \"" + lTache.getArtefactSortie (ai).getNom () +
                             "\", \"" + lTache.getArtefactSortie (ai).getDescription () + "\", \"" +
                             w + "\"" ;
boolean passe = false ; // MODIF YANN
                  for (int x = 0; x < lProduitTmp.getResponsable ().getNbCollaborateurs (); x ++)
                  {
                    MCollaborateur lRespTmp = lProduitTmp.getResponsable ().getCollaborateur (x) ;
                    if (lRespTmp.getId ()  == lTache.getArtefactSortie (ai).getResponsable ().getId ()) 
                    {
                      lCodeScript += ", " + x + ")) ;\n" ;
passe = true ;
                    }
                  }
if (! passe) {
  lCodeScript += ")) ;\n" ;
}
                }
              }
              
            %>
        <%
          }
        %>
        
      <!-- Fin boucle for -->
      </transfert:transfertbean>
      <%    
        }
      %>
      
      
      <!-- Liste des tâches -->
      <td class="caseNiveau3">
        <select name="<%= CConstante.PAR_LISTETACHES %>" class="niveau2" style="width: 200" size="15"
         onchange="selectTache (document.forms[0].<%= CConstante.PAR_LISTETACHES %>.selectedIndex)">
          <%
            for (int i = 0; i < lIteration.getNbTaches (); i++)
            {
          %>
          <option value="<%= i %>"> <%= lIteration.getTache (i).getNom () %> </option>
          <%    
            } 
          %>
        </select>
      </td>
      
      
     
          <!-- Détail de la tâche -->
          <transfert:transfertbean scope="Session" type="owep.modele.execution.MTache" bean="getTache" idArbre="<%= CConstante.PAR_ARBRETACHES %>">
        <%
          /* Créé la fonction javascript qui permet de choisir et afficher le détail d'une tâche. */
          lCodeScript += "function selectTache(pIndice) {" ;
        %>

      <td class="caseNiveau3" valign="top" align="left" width="100%" rowspan="2">
<table width="100%" cellpadding="0" cellspacing="0" valign="top">
<tr>
 <td colspan="2">
        <p class="titre2">Détail de la tâche :</p>
</td>        
</tr>
<tr>
    <td width="50%" class="caseNiveau3SansBordure">    
        Nom : </td><td><input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHES %>"/>
               type="text" size="8" class="niveau2" value=""
               maxlength="<%= CConstante.TXT_MOYEN %>"><br/>
        <% lCodeScript += "document.forms[0]." + VTransfert.getDernierChamp () + ".value = gListeTaches[pIndice][0] ;\n" ; %>
        </td></tr><tr><td class="caseNiveau3SansBordure">
        Description : </td><td><input <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBRETACHES %>"/>
                       type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_LARGE %>"><br/>
        <% lCodeScript += "document.forms[0]." + VTransfert.getDernierChamp () + ".value = gListeTaches[pIndice][1] ;\n" ; %>
        
        </td></tr><tr><td class="caseNiveau3SansBordure">
        Charge initiale : </td><td><input <transfert:transfertchamp membre="setChargeInitiale" type="java.lang.Double" libelle="Charge initiale" convertor="VDoubleConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHES %>"/>
                           type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_CHARGE %>"><br/>
        <% lCodeScript += "document.forms[0]." + VTransfert.getDernierChamp () + ".value = gListeTaches[pIndice][2] ;\n" ; %>
        
        </td></tr><tr><td class="caseNiveau3SansBordure">
        Date de début prévue : </td><td><input <transfert:transfertchamp membre="setDateDebutPrevue" type="java.util.Date" libelle="Date de début prévue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHES %>"/>
                             type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_DATE %>"><br/>
        <% lCodeScript += "document.forms[0]." + VTransfert.getDernierChamp () + ".value = gListeTaches[pIndice][3] ;\n" ; %>
        
        </td></tr><tr><td class="caseNiveau3SansBordure">
        Date de fin prévue : </td><td><input <transfert:transfertchamp membre="setDateFinPrevue" type="java.lang.Date" libelle="Date de fin prévue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHES %>"/>
                           type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_DATE %>"><br/>
        <% lCodeScript += "document.forms[0]." + VTransfert.getDernierChamp () + ".value = gListeTaches[pIndice][4] ;\n" ; %>

        <% lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEDISCIPLINES    + ".selectedIndex = gListeTaches[pIndice][5] ;\n" ; %>
        <% lCodeScript += "selectDiscipline (document.forms[0]." + CConstante.PAR_LISTEDISCIPLINES + ".selectedIndex) ;\n" ; %>
        <% lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEACTIVITES      + ".selectedIndex = gListeTaches[pIndice][6] ;\n" ; %>
        <% lCodeScript += "document.forms[0]." + CConstante.PAR_LISTECOLLABORATEURS + ".selectedIndex = gListeTaches[pIndice][7] ;\n" ; %>
        <% lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEARTEFACTSSORTIES + ".length = 0 ;\n" ; %>

      </transfert:transfertbean>
        </td></tr>
        <tr>
          <td colspan="2"> &nbsp;
          </td>
        </tr>
        <br/>
        <tr>
          <td class="caseNiveau3SansBordure">
        <!-- Activités et collaborateurs -->
        Discpline :
        <select class="niveau2" name="<%= CConstante.PAR_LISTEDISCIPLINES %>" onchange="selectDiscipline (document.forms[0].<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex) ;
                                                                                        selectActivite (document.forms[0].<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.forms[0].<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex);
                                                                                        selectProduit (document.forms[0].<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.forms[0].<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex, document.forms[0].<%= CConstante.PAR_LISTEPRODUITS %>.selectedIndex);">
          <% 
             lCodeScriptActivite += "var gListeActivites = new Array () ; \n" ;
             MComposant lComposant ;
             int lDisciplineCourante = 0 ;
             for (int i = 0; i < lProcessus.getNbComposants (); i++)             
             {
               lComposant = lProcessus.getComposant(i);
               
               for (int j = 0; j < lComposant.getNbDefinitionsTravail (); j++)
               {
                 lCodeScriptActivite += "gListeActivites.push (new Array ()) ; \n" ;
                 for (int k = 0; k < lComposant.getDefinitionTravail (j).getNbActivites(); k++) 
                 {
                   MActivite lActTmp = lComposant.getDefinitionTravail (j).getActivite(k) ;
                   lCodeScriptActivite += "gListeActivites[" + lDisciplineCourante + "].push (new Array ( \"" + lActTmp.getId () + "\", \"" + lActTmp.getNom () + "\", new Array (), new Array ())) ; \n" ;
                   /* Sauvegarde des produits de sorties de l'activite */
                   for (int pl = 0 ; pl < lActTmp.getNbProduitsSorties() ; pl++) 
                   {
                     MProduit lProdTmp = lActTmp.getProduitSortie(pl) ;
                     lCodeScriptActivite += "gListeActivites[" + lDisciplineCourante + "][" + k + "][2].push (new Array ( \"" + pl + "\", \"" + lProdTmp.getNom () + "\", new Array ())) ; \n" ;
                     /* Sauvegarde des collaborateurs suceptible d'être responsables du produits*/
                     MRole lRole = lProdTmp.getResponsable () ;
                     for (int m = 0 ; m < lRole.getNbCollaborateurs () ; m++)
                     {
                       MCollaborateur lCollaborateurTmp = lRole.getCollaborateur (m) ;
                       lCodeScriptActivite += "gListeActivites[" + lDisciplineCourante + "][" + k + "][2][" + pl +"][2].push (new Array ( \"" + m + "\", \"" + lCollaborateurTmp.getNom () + "\", \"" + lCollaborateurTmp.getPrenom () + "\")) ; \n" ;
                     }
                   }
                   for (int pk = 0 ; pk < lActTmp.getNbProduitsEntrees (); pk ++)
                   {
                     MProduit lProdEntTmp = lActTmp.getProduitEntree (pk) ;
                     for (int ll = 0 ; ll < lProdEntTmp.getNbArtefacts (); ll ++)
                     {
                       MArtefact lArtEntreeTmp = lProdEntTmp.getArtefact (ll) ;
                       lCodeScriptActivite += "gListeActivites[" + lDisciplineCourante + "][" + k + "][3].push (new Array ( \"" + lArtEntreeTmp.getId () + "\", \"" + lArtEntreeTmp.getNom () + "\")) ; \n" ;
                     }
                     
                   }
                 }
          %> <option value="<%= lDisciplineCourante ++ %>"> <%= lComposant.getDefinitionTravail (j).getNom () %> </option>
          <%   
               } 
            }
          %>
        </select>
        </td>
        <td class="caseNiveau3SansBordure">
        <%
          lCodeScriptActivite += "function selectDiscipline (pIndice) { \n" ;
          lCodeScriptActivite += "document.forms[0]." + CConstante.PAR_LISTEACTIVITES + ".length = 0 ;" ;
          lCodeScriptActivite += "for (i = 0 ; i <  gListeActivites[pIndice].length ; i++) { \n" ; 
          lCodeScriptActivite += "var option = new Option(gListeActivites [pIndice][i][1],gListeActivites [pIndice][i][0]); \n" ; 
          lCodeScriptActivite += "document.forms[0]." + CConstante.PAR_LISTEACTIVITES + ".options[i] = option; " ;
          lCodeScriptActivite += "} } \n" ;
          
          
          
        %>
        Activité :
        <select class="niveau2" name="<%= CConstante.PAR_LISTEACTIVITES %>" onchange="selectActivite (document.forms[0].<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.forms[0].<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex) ;
                                                                                      selectProduit (document.forms[0].<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.forms[0].<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex, document.forms[0].<%= CConstante.PAR_LISTEPRODUITS %>.selectedIndex);">
          <%
            MDefinitionTravail lDefTravTmp = lProcessus.getComposant(0).getDefinitionTravail(0) ;
            for (int i = 0 ; i < lDefTravTmp.getNbActivites() ; i++)
            {
          %> 
            <option value="<%= lDefTravTmp.getActivite(i).getId() %>"> <%= lDefTravTmp.getActivite(i).getNom () %> </option>
          <%
            }
          %>
        </select>
        </td>
        </tr>
        <tr>
        <td colspan="2" class="caseNiveau3SansBordure">
        Collaborateur affecté :
        <select class="niveau2" name="<%= CConstante.PAR_LISTECOLLABORATEURS %>">
          <%
            for (int i = 0; i < lProjet.getNbCollaborateurs (); i++) 
            {
          %>
          <option value="<%= lProjet.getCollaborateur (i).getId () %>"> <%= lProjet.getCollaborateur (i).getNom () %> &nbsp; <%= lProjet.getCollaborateur (i).getPrenom () %> </option>
          <%
            }
          %>
        </select>
        </td>
        </tr>
        <br/><br/><br/><br/>
        </td>
      </tr>
      <tr>
          <td colspan="2"> &nbsp;
          </td>
        </tr>
        <tr>
          <td colspan="2"> &nbsp;
          </td>
        </tr>
        <tr>
          <td colspan="2"> &nbsp;
          </td>
        </tr>
        <tr>
          <td colspan="2"> &nbsp;
          </td>
        </tr>
        
      <tr>
        <td>
        <!-- Liste des artefacts en sorties -->
        <transfert:transfertbean scope="Session" type="owep.modele.execution.MArtefact" bean="getArtefactSortie" idArbre="<%= CConstante.PAR_ARBREARTEFACTSORTIES %>">
        <%
          /* Créé la fonction javascript qui permet de choisir et afficher le détail d'une tâche. */
          lCodeScriptArtefact += "function selectArtefact(pIndiceTache, pIndiceArtefact) {" ;
        %>
        
        <p class="titre2">Artefacts en Sorties :</p>
       </td>
       <td>
       <p class="titre2">Artefacts en Entrées :</p>
       </td>
       <tr>
       <td>
<table width="100%" cellpadding="0" cellspacing="0" valign="top">
<tr>       
<td colspan="2" align="center">
        <select class="niveau2" name="<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>" style="width: 80%" onchange="selectArtefact (document.forms[0].<%= CConstante.PAR_LISTETACHES %>.selectedIndex, document.forms[0].<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.selectedIndex)" size="4">
        </select>
</td>
<tr>
<td width="50%" class="caseNiveau3SansBordure">     
        Nom : </td><td><input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREARTEFACTSORTIES %>"/>
               type="text" size="8" class="niveau2" value=""
               maxlength="<%= CConstante.TXT_MOYEN %>"><br/>
        <% lCodeScriptArtefact += "document.forms[0]." + VTransfert.getDernierChamp () + ".value = gListeTaches[pIndiceTache][8][pIndiceArtefact][1] ;\n" ; %>
        <% lCodeScript += "document.forms[0]." + VTransfert.getDernierChamp () + ".value = '' ;\n" ; %>
        
</td>
<tr>
<td class="caseNiveau3SansBordure">
        Description : </td><td><input <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREARTEFACTSORTIES %>"/>
                       type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_LARGE %>"><br/>
        <% lCodeScript += "document.forms[0]." + VTransfert.getDernierChamp () + ".value = '' ;\n" ; %>
        <% lCodeScript += "selectActivite (document.forms[0]." + CConstante.PAR_LISTEDISCIPLINES + ".selectedIndex, document.forms[0]." + CConstante.PAR_LISTEACTIVITES + ".selectedIndex) ;\n" ; %>
        <%
          lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEARTEFACTSSORTIES + ".length = 0 ; " ; 
          lCodeScript += "for (i = 0 ; i <  gListeTaches[pIndice][8].length ; i++) { \n" ; 
          lCodeScript += "var option = new Option(gListeTaches [pIndice][8][i][1],gListeTaches [pIndice][8][i][0]); " ; 
          lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEARTEFACTSSORTIES + ".options[i] = option; " ;
          lCodeScript += "} \n" ;
        %>
        <%
          lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEARTEFACTSENTREES + ".length = 0 ; " ; 
          lCodeScript += "for (i = 0 ; i <  gListeTaches[pIndice][9].length ; i++) { \n" ; 
          lCodeScript += "var option = new Option(gListeTaches [pIndice][9][i][1],gListeTaches [pIndice][9][i][0]); " ; 
          lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEARTEFACTSENTREES + ".options[i] = option; " ;
          lCodeScript += "} \n" ;
        %>

        <% lCodeScript += "alert(" + CConstante.PAR_LISTEDISCIPLINES + ".disabled) ;\n" ; %>
        <% lCodeScript += "if (document.forms[0]." + CConstante.PAR_LISTEARTEFACTSSORTIES + ".length > 0) {\n" ; %>
        <% lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEARTEFACTSSORTIES + ".selectedIndex = 0 ;\n" ; %>
        <% lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEDISCIPLINES + ".disabled = true ;\n" ; %>
        <% lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEACTIVITES + ".disabled = true ;\n" ; %>
        <% lCodeScript += "selectArtefact (document.forms[0]." + CConstante.PAR_LISTETACHES + ".selectedIndex, 0) ; } else {\n" ; %>
        <% lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEDISCIPLINES + ".disabled = false ;\n" ; %>
        <% lCodeScript += "document.forms[0]." + CConstante.PAR_LISTEACTIVITES + ".disabled = false ; } }\n" ; %>
        

        <% lCodeScriptArtefact += "document.forms[0]." + VTransfert.getDernierChamp () + ".value = gListeTaches[pIndiceTache][8][pIndiceArtefact][2] ;\n" ; %>
        <% lCodeScriptArtefact += "selectActivite (document.forms[0]." + CConstante.PAR_LISTEDISCIPLINES + ".selectedIndex, document.forms[0]." + CConstante.PAR_LISTEACTIVITES + ".selectedIndex) ;\n" ; %>
        <% lCodeScriptArtefact += "document.forms[0]." + CConstante.PAR_LISTEPRODUITS     + ".selectedIndex = gListeTaches[pIndiceTache][8][pIndiceArtefact][3] ;\n" ; %>
        <% lCodeScriptArtefact += "selectProduit (document.forms[0]." + CConstante.PAR_LISTEDISCIPLINES + ".selectedIndex, document.forms[0]." + CConstante.PAR_LISTEACTIVITES + ".selectedIndex, document.forms[0]." + CConstante.PAR_LISTEPRODUITS + ".selectedIndex) ;\n" ; %>
        <% lCodeScriptArtefact += "document.forms[0]." + CConstante.PAR_LISTERESPONSABLES + ".selectedIndex = gListeTaches[pIndiceTache][8][pIndiceArtefact][4] ;\n" ; %>
        <% lCodeScriptArtefact += "}\n" ; %>
</td>
<tr>
<td class="caseNiveau3SansBordure">
        Produit :</td><td>
        <select class="niveau2" name="<%= CConstante.PAR_LISTEPRODUITS %>" onchange="selectProduit (document.forms[0].<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.forms[0].<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex, document.forms[0].<%= CConstante.PAR_LISTEPRODUITS %>.selectedIndex)">
          <%
            MActivite lActivite = lProcessus.getComposant(0).getDefinitionTravail(0).getActivite (0) ;
            for (int i = 0 ; i < lActivite.getNbProduitsSorties () ; i++)
            {
          %> 
            <option value="<%= i %>"> <%= lActivite.getProduitSortie (i).getNom () %> </option>
          <%
            }
          %>
        </select><br/>
        <%
          lCodeScriptActivite += "function selectActivite (pIndiceDiscipline, pIndiceActivite) \n" ;
          lCodeScriptActivite += "{ \n " ;
          lCodeScriptActivite += "  document.forms[0]." + CConstante.PAR_LISTEPRODUITS + ".length = 0 ; \n" ;
          lCodeScriptActivite += "  for (i = 0 ; i <  gListeActivites[pIndiceDiscipline][pIndiceActivite][2].length ; i++) \n" ; 
          lCodeScriptActivite += "  { \n" ;
          lCodeScriptActivite += "    var option = new Option(gListeActivites [pIndiceDiscipline][pIndiceActivite][2][i][1],gListeActivites [pIndiceDiscipline][pIndiceActivite][2][i][0]) ; \n" ; 
          lCodeScriptActivite += "    document.forms[0]." + CConstante.PAR_LISTEPRODUITS + ".options[i] = option; \n" ;
          lCodeScriptActivite += "  } \n";
          lCodeScriptActivite += "  document.forms[0]." + CConstante.PAR_LISTEARTEFACTSPOSSIBLES + ".length = 0 ; \n" ;          
          lCodeScriptActivite += "  if (document.forms[0]." + CConstante.PAR_LISTETACHES + ".selectedIndex != -1) \n" ;
          lCodeScriptActivite += "  { \n" ;
          lCodeScriptActivite += "    var present ;\n" ;
          lCodeScriptActivite += "    for (j = 0 ; j < gListeActivites[pIndiceDiscipline][pIndiceActivite][3].length ; j++) \n" ;
          lCodeScriptActivite += "    { \n" ;
          lCodeScriptActivite += "      present = 0 ; \n" ;
          lCodeScriptActivite += "      for (a = 0 ; a <  gListeTaches[document.forms[0]." + CConstante.PAR_LISTETACHES + ".selectedIndex][9].length ; a++) \n" ;
          lCodeScriptActivite += "      { \n" ;
          lCodeScriptActivite += "        if (gListeActivites [pIndiceDiscipline][pIndiceActivite][3][j][0] == gListeTaches[document.forms[0]." + CConstante.PAR_LISTETACHES + ".selectedIndex][9][a][0] ) \n" ;
          lCodeScriptActivite += "        { \n" ;
          lCodeScriptActivite += "           present = 1 ; \n" ;
          lCodeScriptActivite += "        } \n";
          lCodeScriptActivite += "      } \n" ;
          lCodeScriptActivite += "      if (present == 0) {\n" ;
          lCodeScriptActivite += "      var option = new Option(gListeActivites [pIndiceDiscipline][pIndiceActivite][3][j][1],gListeActivites [pIndiceDiscipline][pIndiceActivite][3][j][0]) ; \n" ; 
          lCodeScriptActivite += "      document.forms[0]." + CConstante.PAR_LISTEARTEFACTSPOSSIBLES + ".options[document.forms[0]." + CConstante.PAR_LISTEARTEFACTSPOSSIBLES + ".length] = option; \n" ;
          lCodeScriptActivite += "      }\n";
          lCodeScriptActivite += "    } \n" ;
          lCodeScriptActivite += "  } \n" ;
          lCodeScriptActivite += "  else \n" ;
          lCodeScriptActivite += "  { \n" ;
          lCodeScriptActivite += "    for (j = 0 ; j < gListeActivites[pIndiceDiscipline][pIndiceActivite][3].length ; j++)  { \n" ;
          lCodeScriptActivite += "      var option = new Option(gListeActivites [pIndiceDiscipline][pIndiceActivite][3][j][1],gListeActivites [pIndiceDiscipline][pIndiceActivite][3][j][0]) ; \n" ; 
          lCodeScriptActivite += "      document.forms[0]." + CConstante.PAR_LISTEARTEFACTSPOSSIBLES + ".options[document.forms[0]." + CConstante.PAR_LISTEARTEFACTSPOSSIBLES + ".length] = option; \n" ;
          lCodeScriptActivite += "    } \n" ;
          lCodeScriptActivite += "  } \n" ;
          lCodeScriptActivite += "} \n" ;
        %>
</td>
<tr>
<td class="caseNiveau3SansBordure">
        Responsable :</td><td>
        <select class="niveau2" name="<%= CConstante.PAR_LISTERESPONSABLES %>">
          <%
            MRole lRole = lProcessus.getComposant(0).getDefinitionTravail(0).getActivite (0).getProduitSortie (0).getResponsable () ;
            for (int i = 0 ; i < lRole.getNbCollaborateurs () ; i++)
            {
          %> 
            <option value="<%= i %>"> <%= lRole.getCollaborateur (i).getNom () + " &nbsp; " + lRole.getCollaborateur (i).getPrenom () %> </option>
          <%
            }
          %>
        </select><br/>
        
        <%
          lCodeScriptActivite += "function selectProduit (pIndiceDiscipline, pIndiceActivite, pIndiceProduit) { \n" ;
          lCodeScriptActivite += "document.forms[0]." + CConstante.PAR_LISTERESPONSABLES + ".length = 0 ;" ;
          lCodeScriptActivite += "for (i = 0 ; i <  gListeActivites[pIndiceDiscipline][pIndiceActivite][2][pIndiceProduit][2].length ; i++) { \n" ; 
          lCodeScriptActivite += "var option = new Option(gListeActivites [pIndiceDiscipline][pIndiceActivite][2][pIndiceProduit][2][i][1] + ' ' + gListeActivites [pIndiceDiscipline][pIndiceActivite][2][pIndiceProduit][2][i][2], gListeActivites [pIndiceDiscipline][pIndiceActivite][2][pIndiceProduit][2][i][0]) ; \n" ; 
          lCodeScriptActivite += "document.forms[0]." + CConstante.PAR_LISTERESPONSABLES + ".options[i] = option; " ;
          lCodeScriptActivite += "}\n} \n" ;
        %>
</td>
<tr>
<td colspan="2">        
        <!-- Barre d'outils d'artefacts -->
        <% lCodeValidation  = "function validerSelect (pSelect, pMessage)\n" ;
           lCodeValidation += "{ if (pSelect.selectedIndex == -1)\n" ;
           lCodeValidation += "{ alert (pMessage) ;\n" ;
           lCodeValidation += "} else {\n" ;
           lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) + " () ;\n" ;
           lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBREARTEFACTSORTIES) + " () ;\n" ;
           lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES)     + " () ; validerChamps () ;} }\n" ;
           lCodeValidation += "validerSelect (document.forms[0]." + CConstante.PAR_LISTETACHES + ", 'Attention aucune tâche n\\'a été sélectionnée.' ) ;" ; %>
        <transfert:transfertsubmit libelle="Ajouter"   valeur="<%= CConstante.PAR_SUBMITAJOUTER_ARTSORTIES %>" verification="true" validation="<%= lCodeValidation %>"/>
        <% lCodeValidation  = "function validerSelect (pSelect, pMessage)\n" ;
           lCodeValidation += "{ if (pSelect.selectedIndex == -1)\n" ;
           lCodeValidation += "{ alert (pMessage) ;\n" ;
           lCodeValidation += "} else {\n" ;
           lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) + " () ;\n" ;
           lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBREARTEFACTSORTIES) + " () ;\n" ;
           lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES)     + " () ; validerChamps () ;} }\n" ;
           lCodeValidation += "validerSelect (document.forms[0]." + CConstante.PAR_LISTEARTEFACTSSORTIES + ", 'Attention aucun artefact en sortie n\\'a été sélectionné.' ) ;" ; %>
        <transfert:transfertsubmit libelle="Modifier"  valeur="<%= CConstante.PAR_SUBMITMODIFIER_ARTSORTIES %>" verification="true" validation="<%= lCodeValidation %>"/>
        <!-- FIXME Le code de la fonction javascript a été placé ici car elle n'été pas trouvé par le navigateur dans le script -->
        <%
          lCodeValidation  = "function validerSelect (pSelect, pMessage)\n" ;
          lCodeValidation += "{ if (pSelect.selectedIndex == -1)\n" ;
          lCodeValidation += "{ alert (pMessage) ;\n" ;
          lCodeValidation += "} else {\n" ;
          lCodeValidation += "document.forms[0].submit () ; } }\n" ;
          lCodeValidation += "validerSelect (document.forms[0]." + CConstante.PAR_LISTEARTEFACTSSORTIES + ", 'Attention aucun artefact en sortie n\\'a été sélectionné.' ) ;" ; %>
        <transfert:transfertsubmit libelle="Supprimer" valeur="<%= CConstante.PAR_SUBMITSUPPRIMER_ARTSORTIES %>" verification="true" validation="<%= lCodeValidation %>"/>

</td>
</tr>
</table>    
        </transfert:transfertbean>
      
        </td>
        <td>
        
        <!-- Liste des artefacts en entrées -->
<table width="100%" cellpadding="0" cellspacing="0" valign="top">
<tr>
  <td width="50%" align="center">        
        <select class="niveau2" name="<%= CConstante.PAR_LISTEARTEFACTSPOSSIBLES %>" style="width: 90%" size="4">
        </select>
  </td>
  <td align="center">       
        <select class="niveau2" name="<%= CConstante.PAR_LISTEARTEFACTSENTREES %>" style="width: 90%" size="4">
        </select>
    </td>
 <tr>
    <td align="center">
        <%
          lCodeValidation  = "function validerSelect (pSelect, pMessage)\n" ;
          lCodeValidation += "{ if (pSelect.selectedIndex == -1)\n" ;
          lCodeValidation += "{ alert (pMessage) ;\n" ;
          lCodeValidation += "} else {\n" ;
          lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) + " () ;\n" ;
          lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES) + " () ;\n" ; 
          lCodeValidation += "validerChamps () ; } }\n" ; 
          lCodeValidation += "validerSelect (document.forms[0]." + CConstante.PAR_LISTEARTEFACTSPOSSIBLES + ", 'Attention aucun artefact en entrée n\\'a été sélectionné.' ) ;" ; %>
        <transfert:transfertsubmit libelle="Ajouter"  valeur="<%= CConstante.PAR_SUBMITAJOUTER_ARTENTREES %>" verification="true" validation="<%= lCodeValidation %>"/>
   </td>

   <td align="center">     
       <%
          lCodeValidation  = "function validerSelect (pSelect, pMessage)\n" ;
          lCodeValidation += "{ if (pSelect.selectedIndex == -1)\n" ;
          lCodeValidation += "{ alert (pMessage) ;\n" ;
          lCodeValidation += "} else {\n" ;
          lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) + " () ;\n" ;
          lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES) + " () ;\n" ; 
          lCodeValidation += "validerChamps () ; } }\n" ; 
          lCodeValidation += "validerSelect (document.forms[0]." + CConstante.PAR_LISTEARTEFACTSENTREES + ", 'Attention aucun artefact en entrée n\\'a été sélectionné.' ) ;" ; %>
        <transfert:transfertsubmit libelle="Supprimer"  valeur="<%= CConstante.PAR_SUBMITSUPPRIMER_ARTENTREES %>" verification="true" validation="<%= lCodeValidation %>"/>
   </td>
 </tr>
</table>
      </td>
      </tr>
      </table>
      
      
      </td>
        
      
    </tr>
    <tr> 
      <!-- Barre d'outils de tâches -->
      <td class="caseNiveau3">
        <% lCodeValidation  = VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) + " () ;\n" ;
           lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES)     + " () ; validerChamps () ;" ; %>
        <transfert:transfertsubmit libelle="Ajouter" valeur="<%= CConstante.PAR_SUBMITAJOUTER %>" verification="true" validation="<%= lCodeValidation %>"/>
        <% lCodeValidation  = "function validerSelect (pSelect, pMessage)\n" ;
           lCodeValidation += "{ if (pSelect.selectedIndex == -1)\n" ;
           lCodeValidation += "{ alert (pMessage) ;\n" ;
           lCodeValidation += "} else {\n" ;
           lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) + " () ;\n" ;
           lCodeValidation += VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES)     + " () ; validerChamps () ; } }\n" ;
           lCodeValidation += "validerSelect (document.forms[0]." + CConstante.PAR_LISTETACHES + ", 'Attention aucune tâche n\\'a été sélectionnée.' ) ;" ; %>
        <transfert:transfertsubmit libelle="Modifier" valeur="<%= CConstante.PAR_SUBMITMODIFIER %>" verification="true" validation="<%= lCodeValidation %>"/>
        <!-- FIXME Le code de la fonction javascript a été placé ici car elle n'été pas trouvé par le navigateur dans le script -->
        <%
          lCodeValidation  = "function validerSelect (pSelect, pMessage)\n" ;
          lCodeValidation += "{ if (pSelect.selectedIndex == -1)\n" ;
          lCodeValidation += "{ alert (pMessage) ;\n" ;
          lCodeValidation += "} else {\n" ;
          lCodeValidation += "document.forms[0].submit () ; } }\n" ;
          lCodeValidation += "validerSelect (document.forms[0]." + CConstante.PAR_LISTETACHES + ", 'Attention aucune tâche n\\'a été sélectionnée.' ) ;" ; %>
        <transfert:transfertsubmit libelle="Supprimer" valeur="<%= CConstante.PAR_SUBMITSUPPRIMER %>" verification="true" validation="<%= lCodeValidation %>"/>
      </td>
    </tr>
  </tbody>
  </table>
  
  </transfert:transfertbean>

  <br>
  <p class="paragrapheSubmit">
    <% lCodeValidation = VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) + " () ; validerChamps () ;\n" ; %>
    <transfert:transfertsubmit libelle="Valider" valeur="<%= CConstante.PAR_SUBMIT %>" verification="true" validation="<%= lCodeValidation %>"/>
  </p>
  
</form>

<!-- Insertion du code javascript -->
<%    
  lCodeScript += "</script>\n" ;
  lCodeScriptActivite  += "</script>\n" ;
  lCodeScriptArtefact  += "</script>\n" ;
  lCodeScriptProduit   += "</script>\n" ;
  lCodeScriptArtEntree += "</script>\n" ;
%>
<%= lCodeScript %>
<%= lCodeScriptActivite %>
<%= lCodeScriptArtefact %>
<%= lCodeScriptProduit %>
<%= lCodeScriptArtEntree %>