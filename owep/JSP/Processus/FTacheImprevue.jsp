<%@page import="owep.controle.CConstante"%>
<%@page import="owep.infrastructure.Session"%>
<%@page import="owep.modele.processus.MProcessus"%>
<%@page import="owep.modele.execution.MIteration"%>
<%@page import="owep.modele.execution.MTacheImprevue"%>
<%@page import="owep.modele.execution.MActiviteImprevue"%>
<%@page import="owep.modele.execution.MProjet"%>
<%@page import="owep.modele.execution.MCollaborateur"%>
<%@page import="owep.modele.execution.MArtefact"%>
<%@page import="owep.modele.execution.MArtefactImprevue"%>
<%@page import="owep.vue.transfert.VTransfert"%>
<%@page import="owep.vue.transfert.VTransfertConstante"%>
<%@page import="owep.vue.transfert.convertor.VDateConvertor"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>


<!-- Déclaration des variables locales -->
<%
  Session    lSession   = (Session) session.getAttribute (CConstante.SES_SESSION) ;
  MIteration lIteration = lSession.getIteration () ;
  MProjet    lProjet    = lIteration.getProjet () ;
  MProcessus lProcessus = lProjet.getProcessus () ;

  String lCodeValidation ;

  // Liste des champs transférés.
  String lChampTacheImprevueNom             = "" ;
  String lChampTacheImprevueDescription     = "" ;
  String lChampTacheImprevueChargeInitiale  = "" ;
  String lChampTacheImprevueDateDebutPrevue = "" ;
  String lChampTacheImprevueDateFinPrevue   = "" ;
  String lChampArtefactNom          = "" ;
  String lChampArtefactDescription  = "" ;
%>




<p class="titre1">PROJET : <%= lProjet.getNom () %></p>
<p class="texte"><%= lProjet.getDescription () %></p>
<br/><br/>
 
<form action="./TacheImprevue" method="post" name="<%= CConstante.PAR_FORMULAIRE%>">

  <transfert:transfertbean scope="Session" type="owep.modele.execution.MIteration" bean="pIteration" idArbre="<%= CConstante.PAR_ARBREITERATION %>">
  <input <transfert:transfertchamp membre="setNumero" type="java.lang.Integer" libelle="Numéro de l\\'itération" convertor="VIntegerConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
   type="hidden" value="<%= lIteration.getNumero () %>" maxlength="<%= CConstante.TXT_MOYEN %>">
  

  <table class="tableau" width="100%" cellpadding="0" cellspacing="0">
  <tbody>
  
    <!-- Liste des tâches imprévues-->
    <tr>
      <td class="caseNiveau1" colspan="2">
        Liste des tâches imprévues à réaliser :
      </td>
    </tr>
    <tr> 
      <!-- Liste des champs cachés contenant les données des tâches -->
      <%
        for (int lIndiceTacheImprevue = 0; lIndiceTacheImprevue < lIteration.getNbTachesImprevues (); lIndiceTacheImprevue ++)
        {
          MTacheImprevue lTacheImprevue = lIteration.getTacheImprevue (lIndiceTacheImprevue) ;
      %>
        <transfert:transfertbean scope="Session" type="owep.modele.execution.MTacheImprevue" bean="getTacheImprevue" idArbre="<%= CConstante.PAR_ARBREITERATION %>">
        <!-- Ajoute le champ "Nom" à la liste -->
        <input <transfert:transfertchamp membre="setNom" type="" libelle="Nom de la tâche imprévue" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= lTacheImprevue.getNom () %>">
        
        <!-- Ajoute le champ "Description" à la liste -->
        <input <transfert:transfertchamp membre="setDescription" type="" libelle="Description de la tâche imprévue" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= lTacheImprevue.getDescription () %>">
        
        <!-- Ajoute le champ "ChargeInitiale" à la liste -->
        <input <transfert:transfertchamp membre="setChargeInitiale" type="" libelle="Charge initiale de la tâche imprévue" convertor="VDoubleConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= lTacheImprevue.getChargeInitiale () %>">
        
        <!-- Ajoute le champ "DateDebutPrevu" à la liste -->
        <input <transfert:transfertchamp membre="setDateDebutPrevue" type="" libelle="Date de début prévue de la tâche imprévue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= VDateConvertor.getString (lTacheImprevue.getDateDebutPrevue ()) %>">
        
        <!-- Ajoute le champ "DateFinPrevue" à la liste -->
        <input <transfert:transfertchamp membre="setDateFinPrevue" type="" libelle="Date de fin prévue de la tâche imprévue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= VDateConvertor.getString (lTacheImprevue.getDateFinPrevue ()) %>">
        
        
        <!-- Ajoute les champs activités imprévues et collaborateurs -->
        <!-- TODO A optimiser en utilisant une méthode générale de recherche (cf. TODO controleur) -->
        <% 
          /* Liste des champs cachés contenant les données des artefacts en sorties */ 
          for (int lIndiceArtefactImprevueSortie = 0 ; lIndiceArtefactImprevueSortie < lTacheImprevue.getNbArtefactsImprevuesSorties () ; lIndiceArtefactImprevueSortie ++)
          {
        %>
            <transfert:transfertbean scope="Session" type="owep.modele.execution.MArtefactImprevue" bean="getArtefactImprevueSortie" idArbre="<%= CConstante.PAR_ARBREITERATION %>">

            <input <transfert:transfertchamp membre="setNom" type="" libelle="Nom de l\\'artefact en sortie" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
             type="hidden" value="<%= lTacheImprevue.getArtefactImprevueSortie (lIndiceArtefactImprevueSortie).getNom () %>">
             
            <input <transfert:transfertchamp membre="setDescription" type="" libelle="Description de l\\'artefact en sortie" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
             type="hidden" value="<%= lTacheImprevue.getArtefactImprevueSortie (lIndiceArtefactImprevueSortie).getDescription () %>">
             
            </transfert:transfertbean>
        <%
          }
        %>
      </transfert:transfertbean>
      <%
        }
      %>
      
      
      <td class="caseNiveau3">
        <select name="<%= CConstante.PAR_LISTETACHESIMPREVUES %>" class="niveau2" style="width: 200" size="29"
         onchange="selectTacheImprevue (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHESIMPREVUES %>.selectedIndex)">
          <%
            for (int lIndiceTacheImprevue = 0; lIndiceTacheImprevue < lIteration.getNbTachesImprevues (); lIndiceTacheImprevue ++)
            {
          %>
          <option value="<%= lIndiceTacheImprevue %>"> <%= lIteration.getTacheImprevue (lIndiceTacheImprevue).getNom () %> </option>
          <%    
            }
          %>
        </select>
      </td>
      
      
      
      <!-- Détail de la tâche -->
      <transfert:transfertbean scope="Session" type="owep.modele.execution.MTacheImprevue" bean="getTacheImprevue" idArbre="<%= CConstante.PAR_ARBRETACHESIMPREVUES %>">
      <td class="caseNiveau3" valign="top" align="left" width="100%" rowspan="2">
        <table width="100%" cellpadding="0" cellspacing="0" valign="top">
          <tr>
            <td colspan="2">
              <p class="titre2">Détail de la tâche imprévue :</p>
            </td>        
          </tr>
          <tr>
            <td width="50%" class="caseNiveau3SansBordure">    
              Nom * :
            </td>
            <td>
              <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHESIMPREVUES %>"/>
               type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_MOYEN %>"><br/>
              <% lChampTacheImprevueNom = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          <tr>
            <td class="caseNiveau3SansBordure">
              Description :
            </td>
            <td>
              <input <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBRETACHESIMPREVUES %>"/>
               type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_LARGE %>"><br/>
              <% lChampTacheImprevueDescription = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          <tr>
            <td class="caseNiveau3SansBordure">
              Charge initiale * :
            </td>
            <td>
              <input <transfert:transfertchamp membre="setChargeInitiale" type="java.lang.Double" libelle="Charge initiale" convertor="VDoubleConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHESIMPREVUES %>"/>
               type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_CHARGE %>"><br/>
              <% lChampTacheImprevueChargeInitiale = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          <tr>
            <td class="caseNiveau3SansBordure">
              Date de début prévue * :
            </td>
            <td>
              <input <transfert:transfertchamp membre="setDateDebutPrevue" type="java.util.Date" libelle="Date de début prévue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHESIMPREVUES %>"/>
               type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_DATE %>"><br/>
              <% lChampTacheImprevueDateDebutPrevue = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          <tr>
            <td class="caseNiveau3SansBordure">
              Date de fin prévue * :
            </td>
            <td>
              <input <transfert:transfertchamp membre="setDateFinPrevue" type="java.lang.Date" libelle="Date de fin prévue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHESIMPREVUES %>"/>
               type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_DATE %>"><br/>
              <% lChampTacheImprevueDateFinPrevue = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          </transfert:transfertbean>

          <tr>
            <td colspan="2">
              &nbsp;
            </td>
          </tr>
        
          <tr>
            <td class="caseNiveau3SansBordure">
              <!-- Données de l'activité imprévue. -->
              Activité imprévue * :
              <select class="niveau2" name="<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>" onchange="">
              <%
                for (int i = 0 ; i < lProjet.getNbActivitesImprevues () ; i++)
                {
              %> 
                <option value="<%= lProjet.getActiviteImprevue(i).getId() %>"> <%= lProjet.getActiviteImprevue(i).getNom () %> </option>
              <%
                }
              %>
              </select>
            </td>
          </tr>
          <tr>
            <td colspan="2" class="caseNiveau3SansBordure">
              Collaborateur affecté * :
              <select class="niveau2" name="<%= CConstante.PAR_LISTECOLLABORATEURS %>">
              <%
                for (int i = 0 ; i < lProjet.getNbCollaborateurs () ; i++)
                {
              %>
              <option value="<%= lProjet.getCollaborateur (i).getId () %>"> <%= lProjet.getCollaborateur (i).getNom () %> &nbsp; <%= lProjet.getCollaborateur (i).getPrenom () %> </option>
              <%
                }
              %>
              </select>
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
              <p class="titre2">Artefacts en Sorties :</p>
            </td>
            <td>
              <p class="titre2">Artefacts en Entrées :</p>
            </td>
          </tr>
          <tr>
            <td>
              <table width="100%" cellpadding="0" cellspacing="0" valign="top">
                <tr>       
                  <td colspan="2" align="center">
                    <select class="niveau2" name="<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>" style="width: 80%" onchange="selectArtefactImprevueSortie (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHESIMPREVUES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.selectedIndex)" size="4">
                    </select>
                  </td>
                </tr>
                <tr>
                  <td width="50%" class="caseNiveau3SansBordure">     
                    Nom * :
                  </td>
                  <td>
                    <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREARTEFACTSORTIES %>"/>
                     type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_MOYEN %>">
                    <br/>
                    <% lChampArtefactNom = VTransfert.getDernierChamp () ; %>
                  </td>
                </tr>
                  <td class="caseNiveau3SansBordure">
                    Description :
                  </td>
                  <td>
                    <input <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREARTEFACTSORTIES %>"/>
                     type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_LARGE %>">
                    <br/>
                    <% lChampArtefactDescription = VTransfert.getDernierChamp () ; %>
                  </td>
                </tr>
              </transfert:transfertbean>
                <tr>
                  <td class="caseNiveau3SansBordure">
                    Responsable * :
                  </td>
                  <td>
                    <select class="niveau2" name="<%= CConstante.PAR_LISTERESPONSABLES %>">
                    <%
                      for (int i = 0 ; i < lProjet.getNbCollaborateurs () ; i++)
                      {
                    %>
                        <option value="<%= i %>"> <%= lProjet.getCollaborateur (i).getNom () %> &nbsp; <%= lProjet.getCollaborateur (i).getPrenom () %> </option>
                    <%
                      }
                    %>
                    </select>
                    <br/>
                  </td>
                </tr>
                <tr>
                  <td colspan="2">        
                    <!-- Barre d'outils d'artefacts -->
                    <% lCodeValidation = "validerArtefactImprevueSortie (document. " + CConstante.PAR_FORMULAIRE + "." + CConstante.PAR_LISTETACHESIMPREVUES + ", 'Attention aucune tâche imprévue n\\'a été sélectionnée.' ) ;" ; %>
                    <transfert:transfertsubmit libelle="Ajouter"   valeur="<%= CConstante.PAR_SUBMITAJOUTER_ARTSORTIES %>" verification="true" validation="<%= lCodeValidation %>"/>
                    
                    <% lCodeValidation = "validerArtefactImprevueSortie (document. " + CConstante.PAR_FORMULAIRE + "." + CConstante.PAR_LISTEARTEFACTSSORTIES + ", 'Attention aucun artefact en sortie n\\'a été sélectionné.') ;" ; %>
                    <transfert:transfertsubmit libelle="Modifier"  valeur="<%= CConstante.PAR_SUBMITMODIFIER_ARTSORTIES %>" verification="true" validation="<%= lCodeValidation %>"/>
                    
                    <% lCodeValidation = "validerArtefactImprevueSortieSuppr (document. " + CConstante.PAR_FORMULAIRE +"." + CConstante.PAR_LISTEARTEFACTSSORTIES + ", 'Attention aucun artefact en sortie n\\'a été sélectionné.') ;" ; %>
                    <transfert:transfertsubmit libelle="Supprimer" valeur="<%= CConstante.PAR_SUBMITSUPPRIMER_ARTSORTIES %>" verification="true" validation="<%= lCodeValidation %>"/>
                  </td>
                </tr>
              </table>    
              
            </td>
            <td>
            
              <!-- Liste des artefacts en entrées -->
              <table width="100%" height="100%" cellpadding="0" cellspacing="0" valign="top">
                <tr>
                  <td class="caseNiveau3SansBordure" width="50%">        
                    <p class="">Possibles :</p>
                  </td>
                  <td class="caseNiveau3SansBordure">       
                    Effectifs :
                  </td>
                </tr>
                <tr>
                  <td align="center">        
                    <select class="niveau2" name="<%= CConstante.PAR_LISTEARTEFACTSPOSSIBLES %>"  style="width: 90%" size="9">
                    </select>
                  </td>
                  <td align="center">       
                    <select class="niveau2" name="<%= CConstante.PAR_LISTEARTEFACTSENTREES %>" style="width: 90%" size="9">
                    </select>
                  </td>
                </tr>
                <tr>
                  <td align="center">
                    <% lCodeValidation = "validerArtefactImprevueEntree (document. " + CConstante.PAR_FORMULAIRE + "." + CConstante.PAR_LISTEARTEFACTSPOSSIBLES + ", 'Attention aucun artefact en entrée n\\'a été sélectionné.' ) ;" ; %>
                    <transfert:transfertsubmit libelle="Ajouter"  valeur="<%= CConstante.PAR_SUBMITAJOUTER_ARTENTREES %>" verification="true" validation="<%= lCodeValidation %>"/>
                  </td>
                  <td align="center">     
                    <% lCodeValidation = "validerArtefactImprevueEntreeSuppr (document. " + CConstante.PAR_FORMULAIRE +"." + CConstante.PAR_LISTEARTEFACTSENTREES + ", 'Attention aucun artefact en entrée n\\'a été sélectionné.' ) ;" ; %>
                    <transfert:transfertsubmit libelle="Supprimer"  valeur="<%= CConstante.PAR_SUBMITSUPPRIMER_ARTENTREES %>" verification="true" validation="<%= lCodeValidation %>"/>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td colspan="2"> &nbsp;
            </td>
          </tr>
          
        </table>
      </td>
    </tr>
    <tr> 
      <!-- Barre d'outils de tâches -->
      <td class="caseNiveau3">
        <% lCodeValidation = "validerTacheImprevueAjout () ;" ; %>
        <transfert:transfertsubmit libelle="Ajouter" valeur="<%= CConstante.PAR_SUBMITAJOUTER %>" verification="true" validation="<%= lCodeValidation %>"/>
        
        <% lCodeValidation = "validerTacheImprevueModif (document. " + CConstante.PAR_FORMULAIRE + "." + CConstante.PAR_LISTETACHESIMPREVUES + ", 'Attention aucune tâche imprévue n\\'a été sélectionnée.') ;" ; %>
        <transfert:transfertsubmit libelle="Modifier" valeur="<%= CConstante.PAR_SUBMITMODIFIER %>" verification="true" validation="<%= lCodeValidation %>"/>
        
        <% lCodeValidation = "validerTacheImprevueSuppr (document. " + CConstante.PAR_FORMULAIRE + "." + CConstante.PAR_LISTETACHESIMPREVUES + ", 'Attention aucune tâche imprévue n\\'a été sélectionnée.') ;" ; %>
        <transfert:transfertsubmit libelle="Supprimer" valeur="<%= CConstante.PAR_SUBMITSUPPRIMER %>" verification="true" validation="<%= lCodeValidation %>"/>
      </td>
    </tr>
  </tbody>
  </table>
  
  </transfert:transfertbean>

  <br>
  <p class="paragrapheSubmit">
    <transfert:transfertsubmit libelle="Valider" valeur="<%= CConstante.PAR_SUBMIT %>" verification="true" validation="validerFormulaire () ;"/>
  </p>
  
</form>




<!-- Code javascript -->
<script type="text/javascript" language="JavaScript">

  <!----------------------------------------->
  <!-- Ensemble des données de l'itération -->
  <!----------------------------------------->
  var gListeTachesImprevues = new Array () ;
  <%
  // Parcours la liste des tâches imprévues.
  for (int lIndiceTacheImprevue = 0; lIndiceTacheImprevue < lIteration.getNbTachesImprevues (); lIndiceTacheImprevue ++)
  {
    MTacheImprevue    lTacheImprevue         = lIteration.getTacheImprevue (lIndiceTacheImprevue) ;
    MActiviteImprevue lTacheActiviteImprevue = lTacheImprevue.getActiviteImprevue () ;
    int lIdActiviteImprevue             = lTacheActiviteImprevue.getId () ;
    int lIdCollaborateurTacheImprevue = lTacheImprevue.getCollaborateur ().getId () ;
    int lIndiceActiviteImprevue = 0 ;
    int lIndiceCollaborateur = 0 ;
    boolean trouve = false ;
    
    for (lIndiceActiviteImprevue = 0; (! trouve) && (lIndiceActiviteImprevue < lProjet.getNbActivitesImprevues ()); lIndiceActiviteImprevue ++)
    {
      if (lProjet.getActiviteImprevue (lIndiceActiviteImprevue).getId () == lIdActiviteImprevue)
      {
        trouve = true ;
      }
    }
    trouve = false ;
    for (lIndiceCollaborateur = 0; (! trouve) && (lIndiceCollaborateur < lProjet.getNbCollaborateurs ()); lIndiceCollaborateur ++)
    {
      if (lProjet.getCollaborateur (lIndiceCollaborateur).getId () == lIdCollaborateurTacheImprevue)
      {
        trouve = true ;
      } 
    }
    lIndiceActiviteImprevue -- ;
    lIndiceCollaborateur -- ;
  %>
        <!-- Données de la tâche. -->
        gListeTachesImprevues.push (new Array ("<%= lTacheImprevue.getNom () %>", "<%=lTacheImprevue.getDescription ()%>", "<%=lTacheImprevue.getChargeInitiale () %>",
                                      "<%= VDateConvertor.getString (lTacheImprevue.getDateDebutPrevue ()) %>", "<%= VDateConvertor.getString (lTacheImprevue.getDateFinPrevue ()) %>",
                                      "<%= lIndiceActiviteImprevue %>",
                                      "<%= lIndiceCollaborateur %>", new Array (), new Array(), new Array())) ;
  <%
    // Parcours la liste des artefacts en entrées.
    for (int lIndiceArtefactImprevueEntree = 0; lIndiceArtefactImprevueEntree < lTacheImprevue.getNbArtefactsImprevuesEntrees (); lIndiceArtefactImprevueEntree ++)
    {
      MArtefactImprevue lArtefactImprevueEntree = lTacheImprevue.getArtefactImprevueEntree (lIndiceArtefactImprevueEntree) ;
  %>
      <!-- Données de l'artefact en entrée -->
      gListeTachesImprevues[<%= lIndiceTacheImprevue %>][8].push (new Array ("<%= lArtefactImprevueEntree.getId () %>", "<%= lTacheImprevue.getArtefactImprevueEntree (lIndiceArtefactImprevueEntree).getNom () %>")) ;
  <%
    }
    
    // Parcours la liste des artefacts en sorties.
    for (int lIndiceArtefactImprevueSortie = 0; lIndiceArtefactImprevueSortie < lTacheImprevue.getNbArtefactsImprevuesSorties (); lIndiceArtefactImprevueSortie ++)
    {
      MArtefactImprevue      lArtefactImprevueSortie = lTacheImprevue.getArtefactImprevueSortie (lIndiceArtefactImprevueSortie) ;
      MCollaborateur lResponsable    = lArtefactImprevueSortie.getResponsable () ;
      trouve = false ;
      int lIndiceResponsableA = 0 ;
      
      for (lIndiceResponsableA = 0 ; (! trouve) && (lIndiceResponsableA < lProjet.getNbCollaborateurs ()); lIndiceResponsableA ++)
      {
        if (lProjet.getCollaborateur (lIndiceResponsableA).getId () == lResponsable.getId ())
        {
          trouve = true ;
        }
      }
      lIndiceResponsableA -- ;
      
  %>
          <!-- Données de l'artefact en sortie -->
          gListeTachesImprevues[<%= lIndiceTacheImprevue %>][7].push (new Array ("<%= lArtefactImprevueSortie.getId () %>", "<%= lArtefactImprevueSortie.getNom () %>",
                                                                "<%= lArtefactImprevueSortie.getDescription () %>", "<%= lIndiceResponsableA %>")) ;
  <%
    }
  }
  %>




  <!--------------------------------------->
  <!-- Ensemble des données du processus -->
  <!--------------------------------------->
  var gListeActivitesImprevues = new Array () ;
  <%
    for (int lIndiceActiviteImprevue = 0; lIndiceActiviteImprevue < lProjet.getNbActivitesImprevues (); lIndiceActiviteImprevue ++)
    {
        MActiviteImprevue lActiviteImprevue = lProjet.getActiviteImprevue (lIndiceActiviteImprevue) ;
  %>
        <!-- Données de l'activité -->
        gListeActivitesImprevues.push (new Array ("<%= lActiviteImprevue.getId () %>", "<%= lActiviteImprevue.getNom () %>")) ;
  <%
   }
  %>
  
  
  
  
  <!------------------------------------------------------->
  <!-- Fonctions de gestion des composants du formulaire -->
  <!------------------------------------------------------->
  function selectTacheImprevue(pIndice)
  {
    // Efface les ancienne données.
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.length = 0 ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampArtefactNom %>.value = '' ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampArtefactDescription %>.value = '' ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSPOSSIBLES %>.length = 0 ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSENTREES %>.length = 0 ;
    
    // Données de la tâche.
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampTacheImprevueNom %>.value = gListeTachesImprevues[pIndice][0] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampTacheImprevueDescription %>.value = gListeTachesImprevues[pIndice][1] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampTacheImprevueChargeInitiale %>.value = gListeTachesImprevues[pIndice][2] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampTacheImprevueDateDebutPrevue %>.value = gListeTachesImprevues[pIndice][3] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampTacheImprevueDateFinPrevue %>.value = gListeTachesImprevues[pIndice][4] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>.selectedIndex = gListeTachesImprevues[pIndice][5] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTECOLLABORATEURS %>.selectedIndex = gListeTachesImprevues[pIndice][6] ;
    
    // Initialise la liste des artefacts en sorties.
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.length = 0 ;
    for (i = 0 ; i <  gListeTachesImprevues[pIndice][7].length ; i ++)
    {
      var option = new Option(gListeTachesImprevues [pIndice][7][i][1],gListeTachesImprevues [pIndice][7][i][0]) ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.options[i] = option ;
    }
    
    // Initialise la liste des artefacts en entrées.
    for (i = 0 ; i <  gListeTachesImprevues[pIndice][8].length ; i ++)
    {
      var option = new Option(gListeTachesImprevues [pIndice][8][i][1],gListeTachesImprevues [pIndice][8][i][0]) ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSENTREES %>.options[i] = option ;
    }
    
    // Initialise la liste des artefacts en entrées
    k = 0;
    for (i = 0; i < gListeTachesImprevues.length ; i++)
    {
      if (i != pIndice)
      {
        for (j = 0; j < gListeTachesImprevues[i][7].length; j ++)
        {
          var option = new Option(gListeTachesImprevues [i][7][j][1],gListeTachesImprevues [i][7][j][0]) ;
          document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSPOSSIBLES %>.options[k] = option ;
          k = k + 1;
        }
      }
    }
  }
  
  
  function selectArtefactImprevueSortie(pIndiceTacheImprevue, pIndiceArtefactImprevue)
  {
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampArtefactNom %>.value = gListeTachesImprevues[pIndiceTacheImprevue][7][pIndiceArtefactImprevue][1] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampArtefactDescription %>.value = gListeTachesImprevues[pIndiceTacheImprevue][7][pIndiceArtefactImprevue][2] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTERESPONSABLES %>.selectedIndex = gListeTachesImprevues[pIndiceTacheImprevue][7][pIndiceArtefactImprevue][3] ;
  }
  
  <!------------------------------------------->
  <!-- Fonctions de validation du formulaire -->
  <!------------------------------------------->
  function validerTacheImprevueAjout ()
  {
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHESIMPREVUES) %> () ;
    validerChamps () ;  
  }
  
  
  function validerTacheImprevueModif (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>.disabled = false ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHESIMPREVUES) %> () ;
      validerChamps () ;
    }
  }
  
  
  function validerTacheImprevueSuppr (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.submit () ;
    }
  }
  
  
  function validerArtefactImprevueSortie (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>.disabled = false ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREARTEFACTSORTIES) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHESIMPREVUES) %> () ;
      validerChamps () ;
    }
  }
  

  function validerArtefactImprevueSortieSuppr (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.submit () ;
    }
  }
  
  
  function validerArtefactImprevueEntree (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>.disabled = false ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHESIMPREVUES) %> () ;
      validerChamps () ;
    }
  }
  
  
  function validerArtefactImprevueEntreeSuppr (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>.disabled = false ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHESIMPREVUES) %> () ;
      validerChamps () ;
    }
  }
  
  
  function validerFormulaire ()
  {
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITESIMPREVUES %>.disabled = false ;
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREARTEFACTSORTIES) %> () ;
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHESIMPREVUES) %> () ;
    validerChamps () ;
  }
</script>