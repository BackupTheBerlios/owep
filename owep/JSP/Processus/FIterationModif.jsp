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
<%@page import="owep.modele.execution.MCondition"%>
<%@page import="owep.vue.transfert.VTransfert"%>
<%@page import="owep.vue.transfert.VTransfertConstante"%>
<%@page import="owep.vue.transfert.convertor.VDateConvertor"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri='/WEB-INF/tld/transfert.tld' prefix='transfert' %>


<!-- D�claration des variables locales -->
<%
  boolean lModif = request.getParameter (CConstante.PAR_SUBMIT) != null ;
  Session    lSession   = (Session) session.getAttribute (CConstante.SES_SESSION) ;
  MIteration lIteration = (MIteration) session.getAttribute (CConstante.SES_ITERATION) ;
  MProjet    lProjet    = lIteration.getProjet () ;
  MProcessus lProcessus = lProjet.getProcessus () ;
  String lCodeValidation ;

  // Liste des champs transf�r�s.
  String lChampTacheNom             = "" ;
  String lChampTacheDescription     = "" ;
  String lChampTacheChargeInitiale  = "" ;
  String lChampTacheDateDebutPrevue = "" ;
  String lChampTacheDateFinPrevue   = "" ;
  String lChampArtefactNom          = "" ;
  String lChampArtefactDescription  = "" ;
%>




<p class="titre1">PROJET : <%= lProjet.getNom () %></p>
<p class="texte"><%= lProjet.getDescription () %></p>
<br/><br/>
 
<form action="./IterationModif" method="post" name="<%= CConstante.PAR_FORMULAIRE%>">

  <transfert:transfertbean scope="Session" type="owep.modele.execution.MIteration" bean="pIteration" idArbre="<%= CConstante.PAR_ARBREITERATION %>">
  <input <transfert:transfertchamp membre="setNumero" type="java.lang.Integer" libelle="Num�ro de l\\'it�ration" convertor="VIntegerConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
   type="hidden" value="<%= lIteration.getNumero () %>" maxlength="<%= CConstante.TXT_MOYEN %>">
  
  
  <table class="tableau" width="100%" cellpadding="0" cellspacing="0">
  <tbody>
  
    <!-- Champs de l'it�ration -->
    <tr> 
      <td class="caseNiveau1" colspan="2">It�ration <%= lIteration.getNumero () %> :</td>
    </tr>
    <tr>
      <td class="caseNiveau3" colspan="2">
        <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Libell� de l\'it�ration.')" onmouseout="tooltipOff(this, event)">
          Nom de l'it�ration * :
        </a>
        <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom de l\\'it�ration" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="text" size="48" class="niveau2"
         value="<%= lIteration.getNom () %>" maxlength="<%= CConstante.TXT_MOYEN %>">
      </td>
    </tr>
    <tr>
      <td class="caseNiveau3" width="50%">
        <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Date de d�but d\it�ration initialement pr�vue par le chef de projet.')" onmouseout="tooltipOff(this, event)">
          Date de d�but pr�vue * :
        </a>
        <input <transfert:transfertchamp membre="setDateDebutPrevue" type="java.util.Date" libelle="Date de d�but pr�vue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/> 
         type="text" size="8" class="niveau2"
         value="<%= VDateConvertor.getString (lIteration.getDateDebutPrevue ()) %>"  maxlength="<%= CConstante.TXT_DATE %>">
      </td>
      <td class="caseNiveau3" width="50%">
        <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Date de fin d\it�ration initialement pr�vue par le chef de projet.')" onmouseout="tooltipOff(this, event)">
          Date de fin pr�vue * :
        </a>
        <input <transfert:transfertchamp membre="setDateFinPrevue" type="java.util.Date" libelle="Date de fin pr�vue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>  
         type="text" size="8" class="niveau2" value="<%= VDateConvertor.getString (lIteration.getDateFinPrevue ()) %>" maxlength="<%= CConstante.TXT_DATE %>">
      </td>
    </tr>
  </tbody>
  </table>
  
  <br/><br/><br/>
  
  <table class="tableau" width="100%" cellpadding="0" cellspacing="0">
  <tbody>
  
    <!-- Liste des t�ches -->
    <tr>
      <td class="caseNiveau1" colspan="2">
        Liste des t�ches � r�aliser :
      </td>
    </tr>
    <tr> 
      
      <!-- Liste des champs cach�s contenant les donn�es des t�ches -->
      <%
        for (int lIndiceTache = 0; lIndiceTache < lIteration.getNbTaches (); lIndiceTache ++)
        {
          MTache lTache = lIteration.getTache (lIndiceTache) ;
      %>
        <transfert:transfertbean scope="Session" type="owep.modele.execution.MTache" bean="getTache" idArbre="<%= CConstante.PAR_ARBREITERATION %>">
        <!-- Ajoute le champ "Nom" � la liste -->
        <input <transfert:transfertchamp membre="setNom" type="" libelle="Nom de la t�che" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= lTache.getNom () %>">
        
        <!-- Ajoute le champ "Description" � la liste -->
        <input <transfert:transfertchamp membre="setDescription" type="" libelle="Description de la t�che" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= lTache.getDescription () %>">
        
        <!-- Ajoute le champ "ChargeInitiale" � la liste -->
        <input <transfert:transfertchamp membre="setChargeInitiale" type="" libelle="Charge initiale de la t�che" convertor="VDoubleConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= lTache.getChargeInitiale () %>">
        
        <!-- Ajoute le champ "DateDebutPrevu" � la liste -->
        <input <transfert:transfertchamp membre="setDateDebutPrevue" type="" libelle="Date de d�but pr�vue de la t�che" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= VDateConvertor.getString (lTache.getDateDebutPrevue ()) %>">
        
        <!-- Ajoute le champ "DateFinPrevue" � la liste -->
        <input <transfert:transfertchamp membre="setDateFinPrevue" type="" libelle="Date de fin pr�vue de la t�che" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
         type="hidden" value="<%= VDateConvertor.getString (lTache.getDateFinPrevue ()) %>">
        
        
        <!-- Ajoute les champs Disciplines, activit�s et collaborateurs -->
        <!-- TODO A optimiser en utilisant une m�thode g�n�rale de recherche (cf. TODO controleur) -->
        <% 
          /* Liste des champs cach�s contenant les donn�es des artefacts en sorties */ 
          for (int lIndiceArtefactSortie = 0 ; lIndiceArtefactSortie < lTache.getNbArtefactsSorties () ; lIndiceArtefactSortie ++)
          {
        %>
            <transfert:transfertbean scope="Session" type="owep.modele.execution.MArtefact" bean="getArtefactSortie" idArbre="<%= CConstante.PAR_ARBREITERATION %>">

            <input <transfert:transfertchamp membre="setNom" type="" libelle="Nom de l\\'artefact en sortie" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
             type="hidden" value="<%= lTache.getArtefactSortie (lIndiceArtefactSortie).getNom () %>">
             
            <input <transfert:transfertchamp membre="setDescription" type="" libelle="Description de l\\'artefact en sortie" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBREITERATION %>"/>
             type="hidden" value="<%= lTache.getArtefactSortie (lIndiceArtefactSortie).getDescription () %>">
             
            </transfert:transfertbean>
        <%
          }
        %>
      </transfert:transfertbean>
      <%
        }
      %>
      
      
      <td class="caseNiveau3">
        <select name="<%= CConstante.PAR_LISTETACHES %>" class="niveau2" style="width: 200" size="29"
         onchange="selectTache (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHES %>.selectedIndex)"
         onmouseover="tooltipOn(this, event, 'Liste des t�ches actuellement d�finies pour l\'it�ration. Selectionnez-en une pour pouvoir la modifier.')" onmouseout="tooltipOff(this, event)">
          <%
            for (int lIndiceTache = 0; lIndiceTache < lIteration.getNbTaches (); lIndiceTache ++)
            {
          %>
          <option value="<%= lIndiceTache %>"> <%= lIteration.getTache (lIndiceTache).getNom () %> </option>
          <%    
            }
          %>
        </select>
      </td>
      
        
        
      <transfert:transfertbean scope="Session" type="owep.modele.execution.MTache" bean="getTache" idArbre="<%= CConstante.PAR_ARBRETACHES %>">
      
      <!-- D�tail de la t�che -->
      <td class="caseNiveau3" valign="top" align="left" width="100%" rowspan="2">
        <table width="100%" cellpadding="0" cellspacing="0" valign="top">
          <tr>
            <td colspan="2">
              <p class="titre2" onmouseout="tooltipOff(this, event)" onmouseover="tooltipOn(this, event, '<b>Section</b> vous permettant de sp�cifier les informations sur une t�ches.<br/>' +
               ' Cliquez ensuite sur le bouton <b>Ajouter</b> ou <b>Modifier</b> en bas � gauche pour valider.')">
                D�tail de la t�che :
              </p>
            </td>        
          </tr>
          <tr>
            <td width="50%" class="caseNiveau3SansBordure">    
              <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Libell� de la t�che.')" onmouseout="tooltipOff(this, event)">
                Nom * :
              </a>
            </td>
            <td>
              <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHES %>"/>
               type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_MOYEN %>"><br/>
              <% lChampTacheNom = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          <tr>
            <td class="caseNiveau3SansBordure">
              <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Description de ce qui doit �tre fait au cours de la t�che.')" onmouseout="tooltipOff(this, event)">
                Description :
              </a>
            </td>
            <td>
              <input <transfert:transfertchamp membre="setDescription" type="java.lang.String" libelle="Description" convertor="VStringConvertor" obligatoire="false" idArbre="<%= CConstante.PAR_ARBRETACHES %>"/>
               type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_LARGE %>"><br/>
              <% lChampTacheDescription = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          <tr>
            <td class="caseNiveau3SansBordure">
              <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Charge affect�e par le chef de projet sur la t�che (en heures).')" onmouseout="tooltipOff(this, event)">
                Charge initiale * :
              </a>
            </td>
            <td>
              <input <transfert:transfertchamp membre="setChargeInitiale" type="java.lang.Double" libelle="Charge initiale" convertor="VDoubleConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHES %>"/>
               type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_CHARGE %>"><br/>
              <% lChampTacheChargeInitiale = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          <tr>
            <td class="caseNiveau3SansBordure">
              <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Date � laquelle le chef de projet a pr�vu de d�marrer la t�che.')" onmouseout="tooltipOff(this, event)">
                Date de d�but pr�vue * :
              </a>
            </td>
            <td>
              <input <transfert:transfertchamp membre="setDateDebutPrevue" type="java.util.Date" libelle="Date de d�but pr�vue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHES %>"/>
               type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_DATE %>"><br/>
              <% lChampTacheDateDebutPrevue = VTransfert.getDernierChamp () ; %>
            </td>
          </tr>
          <tr>
            <td class="caseNiveau3SansBordure">
              <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Date � laquelle le chef de projet a pr�vue de terminer la t�che.')" onmouseout="tooltipOff(this, event)">
                Date de fin pr�vue * :
              </a>
            </td>
            <td>
              <input <transfert:transfertchamp membre="setDateFinPrevue" type="java.lang.Date" libelle="Date de fin pr�vue" convertor="VDateConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBRETACHES %>"/>
               type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_DATE %>"><br/>
              <% lChampTacheDateFinPrevue = VTransfert.getDernierChamp () ; %>
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
              <!-- Activit�s et collaborateurs -->
              <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Permet de filtrer les activit�s par d�finitions de travail.<br/>' +
               'Attention ce champ n\'est modifiable que si aucun artefact en entr�e ou sortie n\'a �t� sp�cifi�.')" onmouseout="tooltipOff(this, event)">
                Discipline * :
              </a>
              <select class="niveau2" name="<%= CConstante.PAR_LISTEDISCIPLINES %>" onchange="selectDiscipline (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex) ;
                                                                                              selectActivite (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex);
                                                                                              selectProduit (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEPRODUITS %>.selectedIndex);">
              <% 
                 int lDisciplineCourante = 0 ;
                 for (int i = 0; i < lProcessus.getNbComposants (); i++)             
                 {
                   MComposant lComposant = lProcessus.getComposant(i);
                   
                   for (int j = 0; j < lComposant.getNbDefinitionsTravail (); j++)
                   {
              %>
                <option value="<%= lDisciplineCourante ++ %>"> <%= lComposant.getDefinitionTravail (j).getNom () %> </option>
              <%   
                   } 
                }
              %>
              </select>
            </td>
            
            <td class="caseNiveau3SansBordure">
              <!-- Donn�es de l'activit�. -->
              <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Choisissez l\'activit� du processus � laquelle correspond la t�che.<br/>' +
               'Attention ce champ n\'est modifiable que si aucun artefact en entr�e ou sortie n\'a �t� sp�cifi�.')" onmouseout="tooltipOff(this, event)">
                Activit� * :
              </a>
              <select class="niveau2" name="<%= CConstante.PAR_LISTEACTIVITES %>" onchange="selectActivite (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex) ;
                                                                                            selectProduit (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEPRODUITS %>.selectedIndex);">
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
              <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Choisissez le collaborateur qui effectuera la t�che.')" onmouseout="tooltipOff(this, event)">
                Collaborateur affect� * :
              </a>
              <select class="niveau2" name="<%= CConstante.PAR_LISTECOLLABORATEURS %>">
              <%
                MActivite lActiviteTmp = lProcessus.getComposant (0).getDefinitionTravail (0).getActivite (0) ;
                MCollaborateur lCollaborateurAct = null ;
                ArrayList lListeCollaborateurAct = new ArrayList () ;
                for (int i = 0; i < lActiviteTmp.getNbRoles (); i++) 
                {
                  MRole lRoleTmp = lActiviteTmp.getRole (i) ;
                  for (int j = 0 ; j < lRoleTmp.getNbCollaborateurs () ; j++)
                  {
                    lCollaborateurAct = lRoleTmp.getCollaborateur (j) ;
                    if (!lListeCollaborateurAct.contains (lCollaborateurAct))
                    {
                      lListeCollaborateurAct.add (lCollaborateurAct) ;
                    }
                  }
                }
                for (int i = 0 ; i < lListeCollaborateurAct.size () ; i++)
                {
                  lCollaborateurAct = (MCollaborateur) lListeCollaborateurAct.get (i) ;
              %>
              <option value="<%= lCollaborateurAct.getId () %>"> <%= lCollaborateurAct.getNom () %> &nbsp; <%= lCollaborateurAct.getPrenom () %> </option>
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
              <p class="titre2" onmouseout="tooltipOff(this, event)" onmouseover="tooltipOn(this, event, '<b>Section</b> vous permettant de sp�cifier les artefacts en sorties r�alis�s au cours de la t�che selectionn�e.<br/>' +
               ' Cliquez sur le bouton <b>Ajouter</b> ou <b>Modifier</b> en dessous pour valider, individuellement, chaque <b>artefact</b>.')">
                Artefacts en Sorties :
              </p>
            </td>
            <td>
              <p class="titre2" onmouseout="tooltipOff(this, event)" onmouseover="tooltipOn(this, event, '<b>Section</b> vous permettant de sp�cifier les artefacts en entr�es n�cessaires � la r�alisation de la t�che selectionn�e.<br/>' +
               ' Cliquez sur le bouton <b>Ajouter</b> pour ajouter un artefact depuis la liste des <b>artefacts possibles</b>.')">
                Artefacts en Entr�es :
              </p>
            </td>
          </tr>
          <tr>
            <td>
              <table width="100%" cellpadding="0" cellspacing="0" valign="top">
                <tr>       
                  <td colspan="2" align="center">
                    <select class="niveau2" name="<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>" style="width: 80%"
                     onchange="selectArtefact (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.selectedIndex)" size="4"
                     onmouseout="tooltipOff(this, event)" onmouseover="tooltipOn(this, event, 'Listes des artefacts en sorties d�j� disponible pour la t�che.')">
                    </select>
                  </td>
                </tr>
                <tr>
                  <td width="50%" class="caseNiveau3SansBordure">     
                    <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Libell� de l\'artefact en sortie.')" onmouseout="tooltipOff(this, event)">
                      Nom * :
                    </a>
                  </td>
                  <td>
                    <input <transfert:transfertchamp membre="setNom" type="java.lang.String" libelle="Nom" convertor="VStringConvertor" obligatoire="true" idArbre="<%= CConstante.PAR_ARBREARTEFACTSORTIES %>"/>
                     type="text" size="8" class="niveau2" value="" maxlength="<%= CConstante.TXT_MOYEN %>">
                    <br/>
                    <% lChampArtefactNom = VTransfert.getDernierChamp () ; %>
                  </td>
                </tr>
                  <td class="caseNiveau3SansBordure">
                    <a href="#" class="texte" onmouseover="tooltipOn(this, event, 'Description de l\'artefact en sortie.')" onmouseout="tooltipOff(this, event)">
                      Description :
                    </a>
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
                    <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Produit du processus dont est tir� l\'artefact.')" onmouseout="tooltipOff(this, event)">
                      Produit * :
                    </a>
                  </td>
                  <td>
                    <select class="niveau2" name="<%= CConstante.PAR_LISTEPRODUITS %>" onchange="selectProduit (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEPRODUITS %>.selectedIndex)">
                    <%
                      MActivite lActivite = lProcessus.getComposant(0).getDefinitionTravail(0).getActivite (0) ;
                      for (int i = 0 ; i < lActivite.getNbProduitsSorties () ; i++)
                      {
                    %> 
                      <option value="<%= i %>"> <%= lActivite.getProduitSortie (i).getNom () %> </option>
                    <%
                      }
                    %>
                    </select>
                    <br/>
                  </td>
                </tr>
                <tr>
                  <td class="caseNiveau3SansBordure">
                    <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Collaborateur qui s\'assurera de la bonne r�alisation de l\'artefact (g�n�ralement la personne qui le r�alise).')" onmouseout="tooltipOff(this, event)">
                      Responsable * :
                    </a>
                  </td>
                  <td>
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
                    </select>
                    <br/>
                  </td>
                </tr>
                <tr>
                  <td colspan="2">        
                    <!-- Barre d'outils d'artefacts -->
                    <% lCodeValidation = "validerArtefactSortie (document." + CConstante.PAR_FORMULAIRE +"." + CConstante.PAR_LISTETACHES + ", 'Attention aucune t�che n\\'a �t� s�lectionn�e.' ) ;" ; %>
                    <transfert:transfertsubmit libelle="Ajouter"   valeur="<%= CConstante.PAR_SUBMITAJOUTER_ARTSORTIES %>" verification="true" validation="<%= lCodeValidation %>"
                     additionnel="onmouseover=\"tooltipOn(this, event, 'Ajoute un nouvel artefact en sortie.')\" onmouseout=\"tooltipOff(this, event)\""/>
                    
                    <% lCodeValidation = "validerArtefactSortie (document." + CConstante.PAR_FORMULAIRE + "." + CConstante.PAR_LISTEARTEFACTSSORTIES + ", 'Attention aucun artefact en sortie n\\'a �t� s�lectionn�.') ;" ; %>
                    <transfert:transfertsubmit libelle="Modifier"  valeur="<%= CConstante.PAR_SUBMITMODIFIER_ARTSORTIES %>" verification="true" validation="<%= lCodeValidation %>"
                     additionnel="onmouseover=\"tooltipOn(this, event, 'Modifie l\\'artefact en sortie selectionn�e dans la liste.')\" onmouseout=\"tooltipOff(this, event)\""/>
                    
                    <% lCodeValidation = "validerArtefactSortieSuppr (document." + CConstante.PAR_FORMULAIRE +"." + CConstante.PAR_LISTEARTEFACTSSORTIES + ", 'Attention aucun artefact en sortie n\\'a �t� s�lectionn�.') ;" ; %>
                    <transfert:transfertsubmit libelle="Supprimer" valeur="<%= CConstante.PAR_SUBMITSUPPRIMER_ARTSORTIES %>" verification="true" validation="<%= lCodeValidation %>"
                     additionnel="onmouseover=\"tooltipOn(this, event, 'Supprime l\\'artefact en sortie selectionn�e dans la liste.')\" onmouseout=\"tooltipOff(this, event)\""/>
                  </td>
                </tr>
              </table>    
              
            </td>
            <td>
            
              <!-- Liste des artefacts en entr�es -->
              <table width="100%" height="100%" cellpadding="0" cellspacing="0" valign="top">
                <tr>
                  <td class="caseNiveau3SansBordure" width="50%">        
                    <a href="#" class="texte" onmouseover="tooltipOn(this, event, 'Liste des artefacts qui sont suceptibles d\'�tre en entr�e de la t�che.')" onmouseout="tooltipOff(this, event)">
                      Possibles :
                    </a>
                  </td>
                  <td class="caseNiveau3SansBordure">       
                    <a href="#" class="texte" onmouseover="tooltipOn(this, event, 'Liste des artefacts r�ellement en entr�e de la t�che.')" onmouseout="tooltipOff(this, event)">
                      Effectifs :
                    </a>
                  </td>
                </tr>
                <tr>
                  <td align="center">        
                    <select class="niveau2" name="<%= CConstante.PAR_LISTEARTEFACTSPOSSIBLES %>" style="width: 90%" size="9">
                    </select>
                  </td>
                  <td align="center">       
                    <select class="niveau2" name="<%= CConstante.PAR_LISTEARTEFACTSENTREES %>" style="width: 90%" size="9">
                    </select>
                  </td>
                </tr>
                <tr>
                  <td align="center">
                    <% lCodeValidation = "validerArtefactEntree (document." + CConstante.PAR_FORMULAIRE + "." + CConstante.PAR_LISTEARTEFACTSPOSSIBLES + ", 'Attention aucun artefact en entr�e n\\'a �t� s�lectionn�.' ) ;" ; %>
                    <transfert:transfertsubmit libelle="Ajouter"  valeur="<%= CConstante.PAR_SUBMITAJOUTER_ARTENTREES %>" verification="true" validation="<%= lCodeValidation %>"
                     additionnel="onmouseover=\"tooltipOn(this, event, 'Ajoute l\\'artefact en entr�e de la t�che.')\" onmouseout=\"tooltipOff(this, event)\""/>
                  </td>
                  <td align="center">     
                    <% lCodeValidation = "validerArtefactEntreeSuppr (document." + CConstante.PAR_FORMULAIRE + "." + CConstante.PAR_LISTEARTEFACTSENTREES + ", 'Attention aucun artefact en entr�e n\\'a �t� s�lectionn�.' ) ;" ; %>
                    <transfert:transfertsubmit libelle="Supprimer"  valeur="<%= CConstante.PAR_SUBMITSUPPRIMER_ARTENTREES %>" verification="true" validation="<%= lCodeValidation %>"
                     additionnel="onmouseover=\"tooltipOn(this, event, 'Supprime l\\'artefact des entr�es de la t�che.')\" onmouseout=\"tooltipOff(this, event)\""/>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td colspan="2"> &nbsp;
            </td>
          </tr>
          <tr>
            <td>
              <p class="titre2" onmouseout="tooltipOff(this, event)" onmouseover="tooltipOn(this, event, '<b>Section</b> vous permettant de sp�cifier de quelles t�ches est d�pendante celle que vous d�finissez actuellement.<br/>' +
               ' Cliquez sur le bouton <b>Ajouter</b> pour valider la nouvelle <b>condition</b>.')">
                T�ches d�pendantes :
              </p>
              
              <!-- Liste des t�ches d�pendantes -->
              <table width="100%" height="100%" cellpadding="0" cellspacing="0" valign="top">
                <tr>
                  <td align="center">        
                    <select class="niveau2" name="<%= CConstante.PAR_LISTETACHESDEPENDANTES %>" style="width: 80%" size="4" onchange="selectTacheDependante (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHES%>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHESDEPENDANTES%>.selectedIndex)">
                    </select>
                  </td>
                </tr>
                <tr>
                  <td class="caseNiveau3SansBordure">        
                    <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'T�che envers laquelle il est suceptible d\'y avoir une d�pendance.')" onmouseout="tooltipOff(this, event)">
                      T�ches possibles * :
                    </a>
                    <select class="niveau2" name="<%= CConstante.PAR_LISTETACHESPOSSIBLES %>">
                      <%
                        for (int lIndiceTache = 0; lIndiceTache < lIteration.getNbTaches (); lIndiceTache ++)
                        {
                      %>
                          <option value="<%= lIndiceTache %>"> <%= lIteration.getTache (lIndiceTache).getNom () %> </option>
                      <%
                        }
                      %>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td class="caseNiveau3SansBordure">
                    <a href="#" class="texte" onmouseover="tooltipTitreOn(this, event, 'Champ obligatoire', 'Quelle doit �tre l\'�tat de la t�che pour pouvoir d�marrer la t�che courante.')" onmouseout="tooltipOff(this, event)">
                      Condition * :
                    </a>
                    <select class="niveau2" name="<%= CConstante.PAR_LISTETACHESCONDITION %>">
                      <option value="0"> En cours </option>
                      <option value="1"> Termin�e </option>
                    </select>
                  </td>
                  
                </tr>
                <tr>
                  <td align="center">
                    <% lCodeValidation = "validerTachesDep (document." + CConstante.PAR_FORMULAIRE +"." + CConstante.PAR_LISTETACHES + ", 'cv' ) ;" ; %>
                    <transfert:transfertsubmit libelle="Ajouter"  valeur="<%= CConstante.PAR_SUBMITAJOUTER_TACDEPEND %>" verification="true" validation="<%= lCodeValidation %>"
                     additionnel="onmouseover=\"tooltipOn(this, event, 'Ajoute une d�pendance vers une t�che tierce.')\" onmouseout=\"tooltipOff(this, event)\""/>
                    <% lCodeValidation = "validerTachesDepSuppr (document." + CConstante.PAR_FORMULAIRE + "." + CConstante.PAR_LISTETACHESDEPENDANTES + ", 'Attention aucune t�che  n\\'a �t� s�lectionn�e.' ) ;" ; %>   
                    <transfert:transfertsubmit libelle="Supprimer"  valeur="<%= CConstante.PAR_SUBMITSUPPRIMER_TACDEPEND %>" verification="true" validation="<%= lCodeValidation %>"
                     additionnel="onmouseover=\"tooltipOn(this, event, 'Supprime la d�pendance.')\" onmouseout=\"tooltipOff(this, event)\""/>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <!-- Barre d'outils de t�ches -->
      <td class="caseNiveau3">
        <% lCodeValidation = "validerTacheAjout () ;" ; %>
        <transfert:transfertsubmit libelle="Ajouter" valeur="<%= CConstante.PAR_SUBMITAJOUTER %>" verification="true" validation="<%= lCodeValidation %>"
        additionnel="onmouseover=\"tooltipOn(this, event, 'Ajoute une nouvelle t�che.')\" onmouseout=\"tooltipOff(this, event)\""/>
        
        <% lCodeValidation = "validerTacheModif (document." + CConstante.PAR_FORMULAIRE + "." + CConstante.PAR_LISTETACHES + ", 'Attention aucune t�che n\\'a �t� s�lectionn�e.') ;" ; %>
        <transfert:transfertsubmit libelle="Modifier" valeur="<%= CConstante.PAR_SUBMITMODIFIER %>" verification="true" validation="<%= lCodeValidation %>"
        additionnel="onmouseover=\"tooltipOn(this, event, 'Modifie la t�che actuellement selectionn�e dans la liste.')\" onmouseout=\"tooltipOff(this, event)\""/>
        
        <% lCodeValidation = "validerTacheSuppr (document." + CConstante.PAR_FORMULAIRE +"." + CConstante.PAR_LISTETACHES + ", 'Attention aucune t�che n\\'a �t� s�lectionn�e.') ;" ; %>
        <transfert:transfertsubmit libelle="Supprimer" valeur="<%= CConstante.PAR_SUBMITSUPPRIMER %>" verification="true" validation="<%= lCodeValidation %>"
        additionnel="onmouseover=\"tooltipOn(this, event, 'Supprime la t�che actuellement selectionn�e dans la liste.')\" onmouseout=\"tooltipOff(this, event)\""/>
      </td>
    </tr>
  </tbody>
  </table>
  </transfert:transfertbean>

  <p class="texteObligatoire">Les champs marqu� d'un * sont obligatoires.</p>
  <p class="texteSubmit">
    <transfert:transfertsubmit libelle="Valider" valeur="<%= CConstante.PAR_SUBMIT %>" verification="true" validation="validerFormulaire () ;"
     additionnel="onmouseover=\"tooltipOn(this, event, 'Valide toutes les donn�es de l\\'it�ration.')\" onmouseout=\"tooltipOff(this, event)\""/>
  </p>
  
</form>




<!-- Code javascript -->
<script type="text/javascript" language="JavaScript">

  <!----------------------------------------->
  <!-- Ensemble des donn�es de l'it�ration -->
  <!----------------------------------------->
  var gListeTaches = new Array () ;
  <%
  // Parcours la liste des t�ches.
  for (int lIndiceTache = 0; lIndiceTache < lIteration.getNbTaches (); lIndiceTache ++)
  {
    MTache    lTache         = lIteration.getTache (lIndiceTache) ;
    MActivite lTacheActivite = lTache.getActivite () ;
    int lIdActivite             = lTacheActivite.getId () ;
    int lIndiceDefTravailAbsolu = 0 ;
    int lIndiceActivite = 0 ;
    
    // Recherche l'activit� correspondant � celle instanci�e par la t�che courante.
    boolean lTrouve     = false ;
    for (int lIndiceComposant = 0; (! lTrouve) && (lIndiceComposant < lProcessus.getNbComposants ()); lIndiceComposant ++)             
    {
      MComposant lComposant = lProcessus.getComposant (lIndiceComposant) ;
    
      // Parcours la liste des d�finitions de travail.
      for (int lIndiceDefTravail = 0; (! lTrouve) && (lIndiceDefTravail < lComposant.getNbDefinitionsTravail ()); lIndiceDefTravail ++)
      {
        MDefinitionTravail lDefinitionTravail = lComposant.getDefinitionTravail (lIndiceDefTravail) ;
        
        // Parcours la liste des activit�s.
        for (lIndiceActivite = 0; (! lTrouve) && (lIndiceActivite < lDefinitionTravail.getNbActivites ()); lIndiceActivite ++) 
        {
          MActivite lActivite = lDefinitionTravail.getActivite (lIndiceActivite) ;
          
          // Si on trouve l'activit� li�e � la t�che est trouv�e dans la d�finition de travail, on met leurs indices dans le tableau.
          if (lActivite.getId () == lIdActivite)
          {
            lTrouve = true ;
          }
        }
        
        lIndiceDefTravailAbsolu ++ ;
      }
    }
    
    // Rectifie les indices.
    lIndiceDefTravailAbsolu -- ;
    lIndiceActivite -- ;
    
    // Recherche le collaborateur correspondant � celui r�alisant la t�che courante.
    int lIdCollaborateur = lTache.getCollaborateur ().getId () ;
    lTrouve = false ;
    //for (int lIndiceCollaborateur = 0; (! lTrouve) && (lIndiceCollaborateur < lProjet.getNbCollaborateurs ()); lIndiceCollaborateur ++) 
    //{
      //if (lProjet.getCollaborateur (lIndiceCollaborateur).getId () == lIdCollaborateur)
      //{
    ArrayList list = new ArrayList ();
    MActivite  act = lTache.getActivite ();
    for (int l = 0; l < act.getNbRoles(); l++)
    {
      MRole rol = act.getRole(l);
      for (int p = 0; p < rol.getNbCollaborateurs();p++)
      {
        if (!list.contains(rol.getCollaborateur(p)))
        {
          list.add(rol.getCollaborateur(p));
        }
      }
    }
    for (int lIndiceCollaborateur = 0; lIndiceCollaborateur < list.size(); lIndiceCollaborateur++)
    {
      if (lIdCollaborateur == ((MCollaborateur)list.get(lIndiceCollaborateur)).getId())
      {
  %>
        <!-- Donn�es de la t�che. -->
        gListeTaches.push (new Array ("<%= lTache.getNom () %>", "<%=lTache.getDescription ()%>", "<%=lTache.getChargeInitiale () %>",
                                      "<%= VDateConvertor.getString (lTache.getDateDebutPrevue ()) %>", "<%= VDateConvertor.getString (lTache.getDateFinPrevue ()) %>",
                                      "<%= lIndiceDefTravailAbsolu %>", "<%= lIndiceActivite %>",
                                      "<%= lIndiceCollaborateur %>", new Array (), new Array(), new Array())) ;
  <%
      }
    }
    
    
    // Parcours la liste des artefacts en entr�es.
    for (int lIndiceArtefactEntree = 0; lIndiceArtefactEntree < lTache.getNbArtefactsEntrees (); lIndiceArtefactEntree ++)
    {
      MArtefact lArtefactEntree = lTache.getArtefactEntree (lIndiceArtefactEntree) ;
  %>
      <!-- Donn�es de l'artefact en entr�e -->
      gListeTaches[<%= lIndiceTache %>][9].push (new Array ("<%= lTache.getArtefactEntree (lIndiceArtefactEntree).getId () %>", "<%= lTache.getArtefactEntree (lIndiceArtefactEntree).getNom () %>")) ;
  <%
    }
    
    // Parcours la liste des artefacts en sorties.
    for (int lIndiceArtefactSortie = 0; lIndiceArtefactSortie < lTache.getNbArtefactsSorties (); lIndiceArtefactSortie ++)
    {
      MArtefact      lArtefactSortie = lTache.getArtefactSortie (lIndiceArtefactSortie) ;
      MCollaborateur lResponsable    = lArtefactSortie.getResponsable () ;
      lTrouve = false ;
      
      // Parcours la liste des produits en sorties.
      for (int lIndiceProduitSortie  = 0; (! lTrouve) && (lIndiceProduitSortie < lTacheActivite.getNbProduitsSorties ()); lIndiceProduitSortie ++) 
      {
        MProduit lProduit         = lTacheActivite.getProduitSortie (lIndiceProduitSortie) ;
        MRole    lRoleResponsable = lProduit.getResponsable () ;
        int      lIndiceResponsable ;
        
        // Si on a trouv� le produit contenant l'artefact courant,
        if (lProduit.getId () == lArtefactSortie.getProduit ().getId ()) 
        {
          // Parcour l'ensemble des collaborateurs tenant le r�le responsable de l'artefact.
          for (lIndiceResponsable = 0; (! lTrouve) && (lIndiceResponsable < lRoleResponsable.getNbCollaborateurs ()); lIndiceResponsable ++)
          {
            MCollaborateur lCollaborateur = lRoleResponsable.getCollaborateur (lIndiceResponsable) ;
            
            if (lCollaborateur.getId () == lResponsable.getId ()) 
            {
              lTrouve = true ;
            }
          }
          
          // Rectifie les indices.
          lIndiceResponsable -- ;
  %>
          <!-- Donn�es de l'artefact en sortie -->
          gListeTaches[<%= lIndiceTache %>][8].push (new Array ("<%= lIndiceArtefactSortie %>", "<%= lArtefactSortie.getNom () %>",
                                                                "<%= lArtefactSortie.getDescription () %>", "<%= lIndiceProduitSortie %>",
                                                                "<%= lIndiceResponsable %>")) ;
  <%
        }
      }
    }
    
    // Parcours des t�ches d�pendantes
    for (int lIndiceTacheDep = 0; lIndiceTacheDep < lTache.getNbConditions (); lIndiceTacheDep ++)
    {
      MCondition lCondition = lTache.getCondition (lIndiceTacheDep) ;
      MTache     lTacheDep  = lCondition.getTachePrecedente () ;
      int lIndiceEtat ;
      if (lCondition.getEtat () == 1) 
      {
        lIndiceEtat = 0 ;
      }
      else
      {
        lIndiceEtat = 1 ;
      }
   %>
        gListeTaches[<%= lIndiceTache %>][10].push (new Array ("<%= lIndiceTacheDep %>", "<%= lIteration.getListeTaches().indexOf(lTacheDep) %>", "<%= lIndiceEtat %>")) ; 
   <%   
    }
  }
  %>




  <!--------------------------------------->
  <!-- Ensemble des donn�es du processus -->
  <!--------------------------------------->
  var gListeActivites = new Array () ;
  <%
  MComposant lComposant ;
  // Parcours la liste des composants.
  int lDisciplineCourante = 0 ;
  for (int lIndiceComposant = 0; lIndiceComposant < lProcessus.getNbComposants (); lIndiceComposant ++)
  {
    lComposant = lProcessus.getComposant(lIndiceComposant);
    
    // Parcours la liste des d�finition de travail.
    for (int lIndiceDefinitionTravail = 0; lIndiceDefinitionTravail < lComposant.getNbDefinitionsTravail (); lIndiceDefinitionTravail ++)
    {
      MDefinitionTravail lDefinitionTravail = lComposant.getDefinitionTravail (lIndiceDefinitionTravail) ;
  %>
      gListeActivites.push (new Array ()) ;
  <%
      for (int lIndiceActivite = 0; lIndiceActivite < lDefinitionTravail.getNbActivites (); lIndiceActivite ++)
      {
        MActivite lActivite = lComposant.getDefinitionTravail (lIndiceDefinitionTravail).getActivite(lIndiceActivite) ;
        ArrayList lListeRoleCollaborateur = new ArrayList () ; // Contient la liste des collaborateur pouvant participer � cette activit�
  %>
        <!-- Donn�es de l'activit� -->
        gListeActivites[<%= lDisciplineCourante %>].push (new Array ("<%= lActivite.getId () %>", "<%= lActivite.getNom () %>", new Array (), new Array (), new Array ())) ;
  <%
        // Parcours des produits en sorties de l'activite.
        for (int lIndiceProduitSortie = 0; lIndiceProduitSortie < lActivite.getNbProduitsSorties(); lIndiceProduitSortie ++) 
        {
          MProduit lProduit = lActivite.getProduitSortie(lIndiceProduitSortie) ;
          MRole lRole = lProduit.getResponsable () ;
  %>
          <!-- Donn�es du produit -->
          gListeActivites[<%= lDisciplineCourante %>][<%= lIndiceActivite %>][2].push (new Array ("<%= lIndiceProduitSortie %>", "<%= lProduit.getNom () %>", new Array ())) ;
  <%
          // Sauvegarde des collaborateurs suceptible d'�tre responsables du produits.
          for (int lIndiceCollaborateur = 0; lIndiceCollaborateur < lRole.getNbCollaborateurs (); lIndiceCollaborateur ++)
          {
            MCollaborateur lCollaborateur = lRole.getCollaborateur (lIndiceCollaborateur) ;
  %>
            <!-- Donn�es du collaborateur -->
            gListeActivites[<%= lDisciplineCourante %>][<%= + lIndiceActivite %>][2][<%= lIndiceProduitSortie %>][2].push (new Array ("<%= lIndiceCollaborateur %>", "<%= lCollaborateur.getNom () %>", "<%= lCollaborateur.getPrenom () %>")) ;
  <%
          }
        }
        
        // Parcours la liste des artefact en entr�es.
        for (int lIndiceProduitSortie = 0 ; lIndiceProduitSortie < lActivite.getNbProduitsEntrees (); lIndiceProduitSortie ++)
        {
          MProduit lProduitEntree = lActivite.getProduitEntree (lIndiceProduitSortie) ;
          
          for (int ll = 0 ; ll < lProduitEntree.getNbArtefacts (); ll ++)
          {
            MArtefact lArtEntreeTmp = lProduitEntree.getArtefact (ll) ;
  %>
            <!-- Donn�es de l'artefact -->
            gListeActivites[<%= lDisciplineCourante %>][<%= lIndiceActivite %>][3].push (new Array ("<%= + lArtEntreeTmp.getId () %>", "<%= lArtEntreeTmp.getNom () %>")) ;
  <%
          }
        }
        
        // Parcours des r�les pouvant faire cette activit�
        for (int lIndiceRole = 0 ;  lIndiceRole < lActivite.getNbRoles () ; lIndiceRole ++)
        {
          MRole lRole = lActivite.getRole (lIndiceRole) ;
          
          // Parcours de la liste des collaborateurs ayant ce r�le 
          for (int lIndiceRoleCollaborateur = 0 ; lIndiceRoleCollaborateur < lRole.getNbCollaborateurs () ; lIndiceRoleCollaborateur ++)
          {
            MCollaborateur lCollaborateurTmp = lRole.getCollaborateur (lIndiceRoleCollaborateur) ;
            if (!lListeRoleCollaborateur.contains (lCollaborateurTmp))
            {
              lListeRoleCollaborateur.add (lCollaborateurTmp) ;
            }
          }
        }
        for (int lIndiceListe = 0 ; lIndiceListe < lListeRoleCollaborateur.size () ; lIndiceListe ++)
        {
          MCollaborateur lCollaborateurTmp = (MCollaborateur) lListeRoleCollaborateur.get (lIndiceListe) ;
  %>
          <!-- Sauvegarde des collaborateurs pouvant faire la t�che -->
          gListeActivites[<%= lDisciplineCourante %>][<%= lIndiceActivite %>][4].push (new Array ("<%= lCollaborateurTmp.getId () %>", "<%= lCollaborateurTmp.getNom () %>", "<%= lCollaborateurTmp.getPrenom () %>")) ;
  <%
        }
      }
      
      lDisciplineCourante ++ ;
    }
  }
  %>
  
  
  
  
  <!------------------------------------------------------->
  <!-- Fonctions de gestion des composants du formulaire -->
  <!------------------------------------------------------->
  function selectTache(pIndice)
  {
    // Efface les ancienne donn�es.
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.length = 0 ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampArtefactNom %>.value = '' ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampArtefactDescription %>.value = '' ;
    
    // Donn�es de la t�che.
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampTacheNom %>.value = gListeTaches[pIndice][0] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampTacheDescription %>.value = gListeTaches[pIndice][1] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampTacheChargeInitiale %>.value = gListeTaches[pIndice][2] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampTacheDateDebutPrevue %>.value = gListeTaches[pIndice][3] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampTacheDateFinPrevue %>.value = gListeTaches[pIndice][4] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex = gListeTaches[pIndice][5] ;
    selectDiscipline (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex) ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex = gListeTaches[pIndice][6] ;
    selectActivite (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex) ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTECOLLABORATEURS %>.selectedIndex = gListeTaches[pIndice][7] ;
    
    
    // Initialise la liste des artefacts en sorties.
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.length = 0 ;
    for (i = 0 ; i <  gListeTaches[pIndice][8].length ; i ++)
    {
      var option = new Option(gListeTaches [pIndice][8][i][1],gListeTaches [pIndice][8][i][0]) ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.options[i] = option ;
    }
    
    // Initialise la liste des artefacts en entr�es.
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSENTREES %>.length = 0 ;
    for (i = 0 ; i <  gListeTaches[pIndice][9].length ; i ++)
    {
      var option = new Option(gListeTaches [pIndice][9][i][1],gListeTaches [pIndice][9][i][0]) ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSENTREES %>.options[i] = option ;
    }
    
    // Bloque la s�lection d'une activit� ou discipline si un artefact en sortie est associ� � la t�che.
    if (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.length > 0)
    {
      // Initialise la liste des artefacts et d�sactive les listes disciplines et activit�s.
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSSORTIES %>.selectedIndex = 0 ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.disabled = true ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.disabled = true ;
      
      selectArtefact (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHES %>.selectedIndex, 0) ;
    }
    else
    // Bloque la s�lection d'une activit� ou discipline si un artefact en entr�e est associ� � la t�che.
    if (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSENTREES %>.length > 0)
    {
      // D�sactive les listes disciplines et activit�s.
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.disabled = true ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.disabled = true ;
    }
    else
    {
      // Active les listes disciplines et activit�s.
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.disabled = false ;
    }
    
    // Initialise la liste des t�ches d�pendantes
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHESDEPENDANTES %>.length = 0 ;
    for (i = 0 ; i < gListeTaches[pIndice][10].length ; i ++)
    {
      indice = gListeTaches[pIndice][10][i][1] ;
      var option = new Option (gListeTaches[indice][0] , gListeTaches[pIndice][10][i][0]) ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHESDEPENDANTES %>.options[i] = option ;
    }
    
  }
  
  
  function selectDiscipline (pIndice)
  {
    // Met � jour la liste des activit�s.
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.length = 0 ;
    for (i = 0 ; i <  gListeActivites[pIndice].length ; i++)
    {
      var option = new Option(gListeActivites [pIndice][i][1],gListeActivites [pIndice][i][0]) ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.options[i] = option ;
    }
  }
  
  
  function selectActivite (pIndiceDiscipline, pIndiceActivite)
  {
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEPRODUITS %>.length = 0 ;
    
    // Met � jour la liste des activit�s.
    for (lIndiceProduit = 0; lIndiceProduit <  gListeActivites[pIndiceDiscipline][pIndiceActivite][2].length; lIndiceProduit ++)
    {
      var option = new Option(gListeActivites [pIndiceDiscipline][pIndiceActivite][2][lIndiceProduit][1],
                              gListeActivites [pIndiceDiscipline][pIndiceActivite][2][lIndiceProduit][0]) ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEPRODUITS %>.options[lIndiceProduit] = option;
    }
    
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTECOLLABORATEURS %>.length = 0 ;
    // Met � jour la liste des collaborateurs
    for (lIndiceCollaborateur = 0; lIndiceCollaborateur < gListeActivites[pIndiceDiscipline][pIndiceActivite][4].length; lIndiceCollaborateur++)
    {
      var option = new Option(gListeActivites [pIndiceDiscipline][pIndiceActivite][4][lIndiceCollaborateur][1] + '   ' +
                              gListeActivites [pIndiceDiscipline][pIndiceActivite][4][lIndiceCollaborateur][2],
                              gListeActivites [pIndiceDiscipline][pIndiceActivite][4][lIndiceCollaborateur][0]) ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTECOLLABORATEURS %>.options[lIndiceCollaborateur] = option ;
    }
    
    // Met � jour la liste des artefacts.
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSPOSSIBLES %>.length = 0 ;          
    if (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHES %>.selectedIndex != -1)
    {
      // Cherche l'artefact dans la liste des artefacts affect�s � la t�che.
      for (lIndiceArtefact = 0; lIndiceArtefact < gListeActivites[pIndiceDiscipline][pIndiceActivite][3].length; lIndiceArtefact++)
      {
        var lPresent = 0 ;
        
        for (lIndiceTache = 0; lIndiceTache <  gListeTaches[document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHES %>.selectedIndex][9].length; lIndiceTache ++)
        {
          if (gListeActivites [pIndiceDiscipline][pIndiceActivite][3][lIndiceArtefact][0] == gListeTaches[document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHES %>.selectedIndex][9][lIndiceTache][0])
          {
             lPresent = 1 ;
          }
        }
        
        // Ajoute l'artefact � la liste des artefacts possible s'il n'est pas associ� � la t�che.
        if (lPresent == 0)
        {
          var option = new Option(gListeActivites [pIndiceDiscipline][pIndiceActivite][3][lIndiceArtefact][1],
                                  gListeActivites [pIndiceDiscipline][pIndiceActivite][3][lIndiceArtefact][0]) ; 
          document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSPOSSIBLES %>.options[document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSPOSSIBLES %>.length] = option ;
        }
      }
    }
    else
    {
      for (lIndiceArtefact = 0; lIndiceArtefact < gListeActivites[pIndiceDiscipline][pIndiceActivite][3].length; lIndiceArtefact ++)
      {
        var option = new Option(gListeActivites [pIndiceDiscipline][pIndiceActivite][3][lIndiceArtefact][1],
                                gListeActivites [pIndiceDiscipline][pIndiceActivite][3][lIndiceArtefact][0]) ;
        document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSPOSSIBLES %>.options[document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEARTEFACTSPOSSIBLES %>.length] = option ;
      }
    }
  }
  
  
  function selectProduit (pIndiceDiscipline, pIndiceActivite, pIndiceProduit)
  {
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTERESPONSABLES %>.length = 0 ;
    for (lIndiceCollaborateur = 0; lIndiceCollaborateur <  gListeActivites[pIndiceDiscipline][pIndiceActivite][2][pIndiceProduit][2].length; lIndiceCollaborateur ++)
    { 
      var option = new Option(gListeActivites [pIndiceDiscipline][pIndiceActivite][2][pIndiceProduit][2][lIndiceCollaborateur][1] + '   ' +
                              gListeActivites [pIndiceDiscipline][pIndiceActivite][2][pIndiceProduit][2][lIndiceCollaborateur][2],
                              gListeActivites [pIndiceDiscipline][pIndiceActivite][2][pIndiceProduit][2][lIndiceCollaborateur][0]) ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTERESPONSABLES %>.options[lIndiceCollaborateur] = option ;
    }
  }
  
  
  function selectArtefact(pIndiceTache, pIndiceArtefact)
  {
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampArtefactNom %>.value = gListeTaches[pIndiceTache][8][pIndiceArtefact][1] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= lChampArtefactDescription %>.value = gListeTaches[pIndiceTache][8][pIndiceArtefact][2] ;
    selectActivite (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex) ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEPRODUITS %>.selectedIndex = gListeTaches[pIndiceTache][8][pIndiceArtefact][3] ;
    selectProduit (document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.selectedIndex, document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEPRODUITS %>.selectedIndex) ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTERESPONSABLES %>.selectedIndex = gListeTaches[pIndiceTache][8][pIndiceArtefact][4] ;
  }
  
  
  function selectTacheDependante(pIndiceTache, pIndiceTacheDep)
  {
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHESPOSSIBLES %>.selectedIndex = gListeTaches[pIndiceTache][10][pIndiceTacheDep][1] ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTETACHESCONDITION %>.selectedIndex = gListeTaches[pIndiceTache][10][pIndiceTacheDep][2] ;
    
  }
  
  <!------------------------------------------->
  <!-- Fonctions de validation du formulaire -->
  <!------------------------------------------->
  function validerTacheAjout ()
  {
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES) %> () ;
    validerChamps () ;  
  }
  
  
  function validerTacheModif (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.disabled = false ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES) %> () ;
      validerChamps () ;
    }
  }
  
  
  function validerTacheSuppr (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.submit () ;
    }
  }
  
  
  function validerArtefactSortie (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.disabled = false ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREARTEFACTSORTIES) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES) %> () ;
      validerChamps () ;
    }
  }
  

  function validerArtefactSortieSuppr (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.submit () ;
    }
  }
  
  
  function validerArtefactEntree (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.disabled = false ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES) %> () ;
      validerChamps () ;
    }
  }
  
  
  function validerArtefactEntreeSuppr (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.disabled = false ;
      document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.disabled = false ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES) %> () ;
      validerChamps () ;
    }
  }
  
  
  function validerFormulaire ()
  {
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEDISCIPLINES %>.disabled = false ;
    document.<%= CConstante.PAR_FORMULAIRE%>.<%= CConstante.PAR_LISTEACTIVITES %>.disabled = false ;
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREARTEFACTSORTIES) %> () ;
    <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES) %> () ;
    validerChamps () ;
  }


  function validerTachesDep (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES) %> () ;
      validerChamps () ;
    }
  }
  
  
  function validerTachesDepSuppr (pSelect, pMessage)
  {
    if (pSelect.selectedIndex == -1)
    {
      alert (pMessage) ;
    }
    else
    {
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBREITERATION) %> () ;
      <%= VTransfertConstante.getVerification (CConstante.PAR_ARBRETACHES) %> () ;
      validerChamps () ;
    }
  }
    
</script>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>Gestion d\'it�ration</b> vous permet de modifier ou de cr�er une nouvelle <b>it�ration</b>." ;
pCodeAide += " Vous devez d�finir, pour cel�, toute une s�rie de <b>t�ches</b> qui seront r�alis�es durant l\'it�ration (section \"<b>D�tail de la t�che</b>\"), en pr�cisant leurs noms, descriptions, charges et dates de r�alisations." ;
pCodeAide += " Lorsque vous validez une nouvelle t�che, celle-ci s\'ajoute � la <b>liste des t�ches</b> � gauche de l\'�cran." ;
pCodeAide += " Une fois les t�ches ajout�es, vous pouvez pr�cisez, pour chacune d\'entre elle, leurs <b>artefacts en entr�es et sorties</b> (c\'est � dire tous <b>\"documents\" n�cessaires</b> � la r�alisation des t�ches et ceux qu\'elles <b>produisent</b>)." ;
pCodeAide += " Pour terminer, vous pouvez d�finir de quelles t�ches tierces <b>d�pendent</b> chacune des t�ches. Il est ainsi possible d\'indiquer qu\'une t�che ne doit <b>d�marrer</b> que lorsqu\'une seconde � �t� <b>entam�e</b> ou <b>termin�e</b>." ;
pCodeAide += " <a href=\"#\" onclick=\"popup ('/owep/JSP/Aide/TAideIterationModif.jsp')\">(Tutoriel pas � pas...)</a>" ;
</script>
