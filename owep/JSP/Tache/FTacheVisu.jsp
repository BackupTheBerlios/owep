<%@page import="java.text.SimpleDateFormat"%>
<%@page import="owep.controle.CConstante"%>
<%@page import="owep.modele.execution.MTache"%>
<%@page import="owep.infrastructure.Session"%>

<jsp:useBean id="lArtefact"  class="owep.modele.execution.MArtefact"  scope="page"/>
<jsp:useBean id="lTache"     class="owep.modele.execution.MTache"     scope="page"/> 
<jsp:useBean id="lSession"   class="owep.infrastructure.Session"      scope="page"/> 
<jsp:useBean id="lCondition" class="owep.modele.execution.MCondition" scope="page"/>

<%
    SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
    lTache = (MTache) request.getAttribute (CConstante.PAR_TACHE) ;
    lSession = (Session) request.getAttribute (CConstante.SES_SESSION) ;
    
    String [] tabEtat = {"Cr��e", "Pr�te", "Commenc�e", "Suspendue", "Termin�e"};

    String PATH_ARTEFACT = lSession.getConfiguration().getPathArtefact();
%>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tbody>
<tr>
  <td width="50%">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tbody>
      <tr>
        <td width="30%" class="caseNiveau2SansBordure" onmouseover="tooltipOn(this, event, 'Temps n�cessaire, estim� par le collaborateur, pour r�aliser la t�che.')" onmouseout="tooltipOff(this, event)">
          <a href="#" class="niveau2" onmouseover="tooltipOn(this, event,
           '<b>Cr��e</b> si le collaborateur ne peut lancer la t�che du fait d\'une t�che tierce non termin� ou d�marr�.<br/>' +
           '<b>Non d�marr�</b> si le collaborateur n\'a pas entam� la t�che.<br/>' +
           '<b>En cours</b> si le collaborateur travaille sur la t�che.<br/>' +
           '<b>Suspendu</b> si le collaborateur a entam� la t�che mais n\'y travaille pas actuellement dessus.<br/>' +
           '<b>Termin�</b> si le collaborateur a fini sa t�che.<br/>')" onmouseout="tooltipOff(this, event)">
            Etat : 
          </a>
        </td>
        <td align="left" class="caseNiveau3SansBordure">
          <%= tabEtat[lTache.getEtat()+1]%>
        </td>
      </tr>
      <%if (lTache.getDescription() != "") {%>
      <tr>
        <td width="30%" class="caseNiveau2SansBordure">
          <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Description de ce qui doit �tre r�alis� au cours de la t�che.')" onmouseout="tooltipOff(this, event)">
            Description :
          </a>
        </td>
        <td align="left" class="caseNiveau3SansBordure"><%= lTache.getDescription()%></td>
      </tr>
      <%}%>
    </tbody>
    </table> 
  </td>

  <%if (lTache.getNbConditions()>0 && lTache.getEtat()==-1){%>
  <td width="50%">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tbody>
      <tr>
        <td width="50%" valign="top" class="caseNiveau2SansBordure">
          <center>Conditions pour que la tache puisse d�marrer</center><br>
        <table width="100%" class="tableau" border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td class="caseNiveau1">
              <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'T�che vers laquelle il y\'a une d�pendance.')" onmouseout="tooltipOff(this, event)">
                Tache attendue
              </a>
            </td>
            <td class="caseNiveau1">
              <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Etat dans lequel doit �tre la t�che pour que la t�che puisse �tre d�marr�e.')" onmouseout="tooltipOff(this, event)">
                Etat
              </a>
            </td>
            <td class="caseNiveau1">
              <a href="#" class="niveau1" onmouseover="tooltipOn(this, event, 'Etat dans lequel doit �tre la t�che pour que la t�che courante puisse �tre d�marr�e.')" onmouseout="tooltipOff(this, event)">
                Condition
              </a>
            </td>
          </tr>
          <%for (int i = 0; i < lTache.getNbConditions(); i++)
            {
              lCondition = lTache.getCondition(i) ;
          %>
            <tr>
              <td class='caseNiveau2'><%= lCondition.getTachePrecedente().getNom()%></td>
              <td class='caseNiveau2'><%= tabEtat[lCondition.getEtat()]%></td>
              <td class='caseNiveau2'><%= tabEtat[lCondition.getTachePrecedente().getEtat()]%></td>
            </tr>
          <%}%>
        </tbody>
        </table>
        </td>  
      </tr>
    </tbody>
    </table> 
  </td>
  <%}%> 
</tr>

</tbody>
</table> 
 
<br>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Charge affect�e par le chef de projet sur la t�che (en heures).')" onmouseout="tooltipOff(this, event)">
        Temps pr�vu :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure">
      <%=lTache.getChargeInitiale ()%>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Temps que vous avez effectivement pass� sur la t�che.')" onmouseout="tooltipOff(this, event)">
        Temps pass� :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure">
      <%=lTache.getTempsPasse ()    %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Temps n�cessaire que vous avez estim� pour terminer la t�che.')" onmouseout="tooltipOff(this, event)">
        Reste � passer :
      </a>
    </td>
    <td width="15%" class="caseNiveau3SansBordure">
      <%=lTache.getResteAPasser ()  %>
    </td>
  </tr>
</tbody>
</table>

<br>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td colspan="4" class="caseNiveau2SansBordure">
      Dates :
    </td>
    <td colspan="2" class="caseNiveau2SansBordure">
      D�passement de charge :
    </td>
  </tr>
  <tr>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Date � laquelle le chef de projet a pr�vue de d�marrer la t�che.')" onmouseout="tooltipOff(this, event)">
        d�but pr�vue :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure"><% if (lTache.getDateDebutPrevue () != null)
           {
             out.print (lDateFormat.format (lTache.getDateDebutPrevue ())) ;
           }
           else
           {
             out.print ("X") ;
           } %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Date � laquelle vous avez effectivement d�marr� la t�che.')" onmouseout="tooltipOff(this, event)">
        d�but r�elle :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure"><% if (lTache.getDateDebutReelle () != null)
           {
             out.print (lDateFormat.format (lTache.getDateDebutReelle ())) ;
           }
           else
           {
             out.print ("X") ;
           } %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'D�passement du temps de r�alisation pour la t�che (en pourcent).')" onmouseout="tooltipOff(this, event)">
        pourcentage :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure">
      <%= lTache.getPrcDepassementCharge () * 100 %>
    </td>
  </tr>
  <tr>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Date � laquelle le chef de projet a pr�vue de terminer la t�che.')" onmouseout="tooltipOff(this, event)">
        fin pr�vue
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure">
      <% if (lTache.getDateFinPrevue () != null)
         {
           out.print (lDateFormat.format (lTache.getDateFinPrevue ())) ;
         }
         else
         {
           out.print ("X") ;
         }
       %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'Date � laquelle vous avez effectivement termin� la t�che.')" onmouseout="tooltipOff(this, event)">
        fin r�estim�e :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure"><% if (lTache.getDateFinReelle () != null)
           {
             out.print (lDateFormat.format (lTache.getDateFinReelle ())) ;
           }
           else
           {
             out.print ("X") ;
           } %>
    </td>
    <td width="15%" class="caseNiveau2SansBordure">
      <a href="#" class="niveau2" onmouseover="tooltipOn(this, event, 'D�passement du temps de r�alisation pour la t�che (en heures).')" onmouseout="tooltipOff(this, event)">
        hommes / jour :
      </a>
    </td>
    <td width="20%" class="caseNiveau3SansBordure">
      <%= lTache.getHJDepassementCharge () %>
    </td>
  </tr>
</tbody>
</table>
<!--
<br>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tbody>
  <tr>
    <td colspan="5" class="caseNiveau2SansBordure">D�passement de charge : </td>
  </tr>
  <tr>
    <td width="15%" class="caseNiveau2SansBordure">pourcentage : </td>
    <td width="20%" class="caseNiveau3SansBordure"><%= lTache.getPrcDepassementCharge () * 100 %></td>
    <td width="15%" class="caseNiveau2SansBordure">hommes jour : </td>
    <td width="20%" class="caseNiveau3SansBordure"><%= lTache.getHJDepassementCharge ()        %></td>
    <td width="30%"></td>
  </tr>
</tbody>
</table>
-->
<br><br>

<table width="100%">
  <tr>
<%if (lTache.getNbArtefactsEntrees()>0){%>
  <td width="50%" valign="top" class="caseNiveau2SansBordure">
    <center>Artefacts en entr�e de la tache</center><br>
  <table width="100%" class="tableau" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td class="caseNiveau1">Artefact</td>
      <td class="caseNiveau1">Disponibilit�</td>
      <td class="caseNiveau1">Responsable</td>
    </tr>
    <%for (int i = 0; i < lTache.getNbArtefactsEntrees(); i ++)
      {
        lArtefact = lTache.getArtefactEntree(i) ;  
    %>
      <tr>
        <td class='caseNiveau2'><%= lArtefact.getNom()%></td>
        <%if (lArtefact.getNomFichier() != null){%>
          <td class='caseNiveau2'><a href=<%= "/owep/"+PATH_ARTEFACT+lArtefact.getPathFichier()+lArtefact.getNomFichier()%>><%= lArtefact.getNomFichier()%></a></td>
        <%}else{%>
            <td class='caseNiveau2'>Non disponible</td>
          <%}%>
        <td class='caseNiveau2'><%= lArtefact.getResponsable().getPrenom()+" "+lArtefact.getResponsable().getNom()%></td>
      </tr>
    <%}%>
  </tbody>
  </table>
  </td>  
<%}%>

<%if (lTache.getNbArtefactsSorties()>0){%>
  <td width="50%" valign="top" class="caseNiveau2SansBordure">
    <center>Artefacts en sortie de la tache</center><br>
  <table width="100%" class="tableau" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td class="caseNiveau1">Artefact</td>
      <td class="caseNiveau1">Disponibilit�</td>
      <td class="caseNiveau1">Upload</td>
    </tr>
    <%for (int i = 0; i < lTache.getNbArtefactsSorties(); i ++)
      {
        lArtefact = lTache.getArtefactSortie(i) ;
    %>
      <tr>
        <td class='caseNiveau2'><%= lArtefact.getNom()%></td>
        <%if (lArtefact.getNomFichier() != null){%>
          <td class='caseNiveau2'><a href=<%= "/owep/"+PATH_ARTEFACT+lArtefact.getPathFichier()+lArtefact.getNomFichier()%>><%= lArtefact.getNomFichier()%></a></td>
        <%}else{%>
            <td class='caseNiveau2'>Non disponible</td>
          <%}%>
          <td class='caseNiveau2'><a href=<%= "/owep/Artefact/ArtefactAjout?pArtefact="+ Integer.toString(lArtefact.getId())+"&pTacheAVisualiser="+lTache.getId()%>><%= "Ajouter"%></a></td>
      </tr>
    <%}%>
  </tbody>
  </table>
  </td>
<%}%>

  </tr>
  
</table>


<!-- Aide en ligne -->
<script type="text/javascript" language="JavaScript">
pCodeAide  = "La page de <b>D�tail de la t�che</b> vous permet de visualiser pr�cis�ment les <b>caract�ristiques</b> de la t�che et de ce qui doit �tre r�alis�." ;
pCodeAide += " Vous pouvez en particulier savoir quelles sont les <b>conditions n�cessaires</b> pour que la t�che puisse d�marrer," ;
pCodeAide += " quels sont les <b>artefacts n�cessaires</b> et ceux que vous devez <b>produire</b>." ;
pCodeAide += " Vous pouvez de plus ajouter les artefacts que vous <b>produisez</b> dans le r�f�rentiel pour les mettre � disposition de tout le monde (lien \"<b>Ajouter</b>\")." ;
</script>
