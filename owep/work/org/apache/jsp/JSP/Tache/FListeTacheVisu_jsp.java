package org.apache.jsp.JSP.Tache;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.text.SimpleDateFormat;
import owep.controle.CConstante;
import owep.modele.execution.MCollaborateur;

public final class FListeTacheVisu_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    JspFactory _jspxFactory = null;
    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      _jspxFactory = JspFactory.getDefaultFactory();
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      owep.modele.execution.MCollaborateur lCollaborateur = null;
      synchronized (_jspx_page_context) {
        lCollaborateur = (owep.modele.execution.MCollaborateur) _jspx_page_context.getAttribute("lCollaborateur", PageContext.PAGE_SCOPE);
        if (lCollaborateur == null){
          lCollaborateur = new owep.modele.execution.MCollaborateur();
          _jspx_page_context.setAttribute("lCollaborateur", lCollaborateur, PageContext.PAGE_SCOPE);
        }
      }
      out.write('\r');
      out.write('\n');
      owep.modele.execution.MTache lTache = null;
      synchronized (_jspx_page_context) {
        lTache = (owep.modele.execution.MTache) _jspx_page_context.getAttribute("lTache", PageContext.PAGE_SCOPE);
        if (lTache == null){
          lTache = new owep.modele.execution.MTache();
          _jspx_page_context.setAttribute("lTache", lTache, PageContext.PAGE_SCOPE);
        }
      }
      out.write(" \r\n");
      out.write("\r\n");
      out.write("<meta http-equiv=\"refresh\" content=\"60; URL=./ListeTacheVisu\">\r\n");
      out.write("\r\n");

    SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
    lCollaborateur = (MCollaborateur) request.getAttribute (CConstante.PAR_COLLABORATEUR) ;
    if(lCollaborateur.getNbTaches()>0)
    {

      out.write("\r\n");
      out.write("\r\n");
      out.write("<table class=\"tableau\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("<tbody>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseNiveau1\" rowspan=\"2\">Tâches</td>\r\n");
      out.write("    <td class=\"caseNiveau1\" rowspan=\"2\">Temps prévu(h)</td>\r\n");
      out.write("    <td class=\"caseNiveau1\" rowspan=\"2\">Temps passé(h)</td>\r\n");
      out.write("    <td class=\"caseNiveau1\" rowspan=\"2\">Reste à passer(h)</td>\r\n");
      out.write("    <td class=\"caseNiveau1\" rowspan=\"2\">Etat</td>\r\n");
      out.write("    <td class=\"caseNiveau1\" colspan=\"4\">Date</td>\r\n");
      out.write("    <td class=\"caseNiveau1\" colspan=\"2\">Dépassement de charge</td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseNiveau1\">début prévue</td>\r\n");
      out.write("    <td class=\"caseNiveau1\">début réelle</td>\r\n");
      out.write("    <td class=\"caseNiveau1\">fin prévue</td>\r\n");
      out.write("    <td class=\"caseNiveau1\">fin réestimée</td>\r\n");
      out.write("    <td class=\"caseNiveau1\">(%)</td>\r\n");
      out.write("    <td class=\"caseNiveau1\">(h)</td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  \r\n");
      out.write("  ");

    for (int i = 0; i < lCollaborateur.getNbTaches(); i ++)
    {
      lTache = lCollaborateur.getTache (i) ;
  
      out.write("\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class='caseNiveau2'><a href=\"./TacheVisu?pTacheAVisualiser=");
      out.print( lTache.getId());
      out.write('"');
      out.write('>');
      out.print( lTache.getNom ());
      out.write("</a></td>\r\n");
      out.write("  \r\n");
      out.write("      <!-- Affiche la liste des artefacts -->\r\n");
      out.write("            \r\n");
      out.write("      <!-- Affiche les propriétés de la tâche -->\r\n");
      out.write("      <td class='caseNiveau3'>");
      out.print((int)lTache.getChargeInitiale ());
      out.write("</td>\r\n");
      out.write("      <td class='caseNiveau3'>");
      out.print((int)lTache.getTempsPasse ()    );
      out.write("</td>\r\n");
      out.write("      <td class='caseNiveau3'>");
      out.print((int)lTache.getResteAPasser ()  );
      out.write("</td>\r\n");
      out.write("      <!-- On passe l id du bouton cliqué et l id de la tache en parametre de la requete -->      \r\n");
      out.write("      <td class='caseNiveau3'>\r\n");
      out.write("      <!-- Si le collaborateur n'a pas de taches en état démarré, on peut commencer ou reprendre n'importe quelle tâche -->  \r\n");
      out.write("      ");
 if(lCollaborateur.getTacheEnCours()==0)
           {
            switch (lTache.getEtat())
             { 
               case -1 : 
      out.write("\r\n");
      out.write("                 ");
      out.write("\r\n");
      out.write("                 Tâche non prête\r\n");
      out.write("            ");
  break ;
               case 0 : 
      out.write("\r\n");
      out.write("                 ");
      out.write("\r\n");
      out.write("                 <a href=\"./Etat?pBoutonClique=1&");
      out.print(CConstante.PAR_TACHE);
      out.write('=');
      out.print(lTache.getId());
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY);
      out.write("\"></a><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE);
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP);
      out.write("\">\r\n");
      out.write("            ");
  break ; 
               case 1 : 
      out.write("\r\n");
      out.write("                 ");
      out.write("\r\n");
      out.write("                 <IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAYACTIF);
      out.write("\"><a href=\"./Etat?pBoutonClique=2&");
      out.print(CConstante.PAR_TACHE);
      out.write('=');
      out.print(lTache.getId());
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE);
      out.write("\"></a><a href=\"./Etat?pBoutonClique=3&");
      out.print(CConstante.PAR_TACHE);
      out.write('=');
      out.print(lTache.getId());
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP);
      out.write("\"></a>\r\n");
      out.write("            ");
 break ; 
               case 2 : 
      out.write("\r\n");
      out.write("                 ");
      out.write("\r\n");
      out.write("                 <a href=\"./Etat?pBoutonClique=1&");
      out.print(CConstante.PAR_TACHE);
      out.write('=');
      out.print(lTache.getId());
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY);
      out.write("\"></a><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSEACTIF);
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP);
      out.write("\">\r\n");
      out.write("            ");
 break ;
               case 3 : 
      out.write("\r\n");
      out.write("                 <!-- Affichage boutons pour etat terminé -->\r\n");
      out.write("                 Terminée\r\n");
      out.write("            <!-- Si le collaborateur a une tache en état démarré, on ne peut modifier l'état que de cette tâche -->\r\n");
      out.write("            ");
 }
           } 
          else if(lCollaborateur.getTacheEnCours()==1)
           {
            switch (lTache.getEtat())
             { 
               case -1 : 
                 
      out.write("\r\n");
      out.write("                 ");
      out.write("\r\n");
      out.write("                 Tâche non prête\r\n");
      out.write("            ");
  break ;
               case 0 : 
                 
      out.write("\r\n");
      out.write("                 ");
      out.write("\r\n");
      out.write("                 <IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY);
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE);
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP);
      out.write("\">\r\n");
      out.write("            ");
   break ; 
               case 1 : 
                 
      out.write("\r\n");
      out.write("                 \r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
      out.write("\r\n");
      out.write("                 <IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAYACTIF);
      out.write("\"><a href=\"./Etat?pBoutonClique=2&");
      out.print(CConstante.PAR_TACHE);
      out.write('=');
      out.print(lTache.getId());
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSE);
      out.write("\"></a><a href=\"./Etat?pBoutonClique=3&");
      out.print(CConstante.PAR_TACHE);
      out.write('=');
      out.print(lTache.getId());
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP);
      out.write("\"></a>\r\n");
      out.write("               \r\n");
      out.write("            ");
   break ;  
               case 2 : 
                 
      out.write("\r\n");
      out.write("                 ");
      out.write("\r\n");
      out.write("                 <IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PLAY);
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_PAUSEACTIF);
      out.write("\"><IMG SRC=\"");
      out.print(owep.infrastructure.localisation.LocalisateurIdentifiant.LID_STOP);
      out.write("\">\r\n");
      out.write("            ");
   break ; 
               case 3 : 
      out.write("\r\n");
      out.write("                 <!-- Affichage boutons pour etat terminé -->\r\n");
      out.write("                 Terminée\r\n");
      out.write("          ");
 }
           } 
      out.write("\r\n");
      out.write("      </td>\r\n");
      out.write("      <td class='caseNiveau3'>");
 if (lTache.getDateDebutPrevue () != null)
                                 {
                                   out.print (lDateFormat.format (lTache.getDateDebutPrevue ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } 
      out.write("\r\n");
      out.write("      </td>\r\n");
      out.write("      <td class='caseNiveau3'>");
 if (lTache.getDateDebutReelle () != null)
                                 {
                                   out.print (lDateFormat.format (lTache.getDateDebutReelle ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } 
      out.write("\r\n");
      out.write("      </td>\r\n");
      out.write("      <td class='caseNiveau3'>");
 if (lTache.getDateFinPrevue () != null)
                              {
                                out.print (lDateFormat.format (lTache.getDateFinPrevue ())) ;
                              }
                           else
                           {
                             out.print ("X") ;
                           } 
      out.write("\r\n");
      out.write("      </td>\r\n");
      out.write("      <td class='caseNiveau3'>");
 if (lTache.getDateFinReelle () != null)
                                 {
                                   out.print (lDateFormat.format (lTache.getDateFinReelle ())) ;
                                 }
                                 else
                                 {
                                   out.print ("X") ;
                                 } 
      out.write("\r\n");
      out.write("      </td>\r\n");
      out.write("      <td class='caseNiveau3'>");
      out.print( (int)(lTache.getPrcDepassementCharge () * 100) );
      out.write("</td>\r\n");
      out.write("      <td class='caseNiveau3'>");
      out.print( (int)lTache.getHJDepassementCharge ()        );
      out.write("</td>\r\n");
      out.write("    </tr>\r\n");
      out.write("  ");

    }
  
      out.write("\r\n");
      out.write("</tbody>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
}
      out.write('\r');
      out.write('\n');
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      if (_jspxFactory != null) _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
