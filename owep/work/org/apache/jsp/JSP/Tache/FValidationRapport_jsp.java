package org.apache.jsp.JSP.Tache;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.text.SimpleDateFormat;
import owep.controle.CConstante;
import owep.modele.execution.MTache;

public final class FValidationRapport_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\r\n");
      out.write("\r\n");
      owep.modele.execution.MTache lTache = null;
      synchronized (session) {
        lTache = (owep.modele.execution.MTache) _jspx_page_context.getAttribute("lTache", PageContext.SESSION_SCOPE);
        if (lTache == null){
          lTache = new owep.modele.execution.MTache();
          _jspx_page_context.setAttribute("lTache", lTache, PageContext.SESSION_SCOPE);
        }
      }
      out.write(" \r\n");
      out.write("<HEAD>\r\n");
      out.write("<SCRIPT LANGUAGE=\"JavaScript\">\r\n");
      out.write("  <!--\r\n");
      out.write("    // fonction de vérification du bon format de la date\r\n");
      out.write("    function test_date(date) {\r\n");
      out.write("      expr_reg = /^[0-9][0-9]\\/[0-9][0-9]\\/[0-9][0-9][0-9][0-9]$/ ;\r\n");
      out.write("\r\n");
      out.write("      if ( expr_reg.test(date.value) ==0 ) \r\n");
      out.write("      {\r\n");
      out.write("        // ce n'est pas une date valide\r\n");
      out.write("        alert (\"La date que vous devez saisir doit être de la forme jj/mm/aaaa\") ;\r\n");
      out.write("      }\r\n");
      out.write("    } \r\n");
      out.write("    \r\n");
      out.write("    // fonction de vérification du bon format des heures\r\n");
      out.write("    function test_heure(heure) {\r\n");
      out.write("      expr_reg = /^[0-9]+$/ ;\r\n");
      out.write("\r\n");
      out.write("      if ( expr_reg.test(heure.value) == 0 ) \r\n");
      out.write("      {\r\n");
      out.write("        // ce n'est pas un nombre entier\r\n");
      out.write("        alert (\"Vous devez saisir un nombre entier\") ;\r\n");
      out.write("      }\r\n");
      out.write("    }  \r\n");
      out.write("    \r\n");
      out.write("    // fonction de conversion de la date saisie : jj/mm/aaaa en aaaa-mm-jj\r\n");
      out.write("    function valider() { \r\n");
      out.write("      var madateReelle = document.formValidation.pDateDebutReel.value ; \r\n");
      out.write("      var nouvelleDateReelle = madateReelle.split(\"\\/\"); \r\n");
      out.write("      document.formValidation.pDateDebutReel.value = nouvelleDateReelle[2]+\"-\"+nouvelleDateReelle[1]+\"-\"+nouvelleDateReelle[0] ; \r\n");
      out.write("      var madateReestimee = document.formValidation.pDateFinReestimee.value ; \r\n");
      out.write("      var nouvelleDateReestimee = madateReestimee.split(\"\\/\"); \r\n");
      out.write("      document.formValidation.pDateFinReestimee.value = nouvelleDateReestimee[2]+\"-\"+nouvelleDateReestimee[1]+\"-\"+nouvelleDateReestimee[0] ; \r\n");
      out.write("    }\r\n");
      out.write("  // -->\r\n");
      out.write("  </SCRIPT>\r\n");
      out.write("  \r\n");
      out.write("  <NOSCRIPT>\r\n");
      out.write("  <B>Votre browser ne supporte pas JavaScript et ne peut donc pas exploiter\r\n");
      out.write("  les fonctionnalités de cette page Web</B>\r\n");
      out.write("  </NOSCRIPT>\r\n");
      out.write("</HEAD>\r\n");
      out.write("\r\n");
      out.write("<form action=\"./ValidationRapport\" method=\"post\" name=\"formValidation\">\r\n");
      out.write("  <table class=\"tableau\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("  <tbody>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Nom de la tâche</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Artefacts</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Temps prévu(h)</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Temps passé(h)</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Reste à passer(h)</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Etat</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" colspan=\"4\">Date</td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\">début prévue</td>\r\n");
      out.write("      <td class=\"caseNiveau1\">début réelle</td>\r\n");
      out.write("      <td class=\"caseNiveau1\">fin prévue</td>\r\n");
      out.write("      <td class=\"caseNiveau1\">fin réestimée</td>\r\n");
      out.write("    </tr>\r\n");
      out.write("   \r\n");
      out.write("    <tr>\r\n");
      out.write("      ");
 lTache = (MTache) request.getAttribute (CConstante.PAR_TACHE) ; 
      out.write("\r\n");
      out.write("\t    <td class='caseNiveau2'>");
      out.print( lTache.getNom ());
      out.write("</td>\r\n");
      out.write("\t    <!--\r\n");
      out.write("\t    <!-- Affiche la liste des artefacts -->\r\n");
      out.write("\t    <td class='caseNiveau2'>\r\n");
      out.write("\t      ");

	        SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
	        out.print (lTache.getArtefactSortie (0).getNom ()) ;
	        for (int j = 1; j < lTache.getNbArtefactsSorties (); j ++)
	        {
	          out.print ("<br/>" + lTache.getArtefactSortie (j).getNom ()) ;
	        }
	      
      out.write("\r\n");
      out.write("\t    </td>\r\n");
      out.write("\t    \r\n");
      out.write("\t    <!-- Affiche les propriétés de la tâche -->\r\n");
      out.write("\t    <td class='caseNiveau3'>");
      out.print((int)lTache.getChargeInitiale ());
      out.write("</td>\r\n");
      out.write("\t    <td class='caseNiveau3'><input type=text size=1 name=\"");
      out.print(CConstante.PAR_TEMPSPASSE);
      out.write("\"   value=\"");
      out.print((int)lTache.getTempsPasse());
      out.write("\" onBlur=\"test_heure(this)\"></td>\r\n");
      out.write("\t    ");
 int bouton = Integer.parseInt(request.getParameter("pIdBoutonClique")) ; 
	       if (bouton == 2)
	       {
	    
      out.write("\r\n");
      out.write("\t    <td class='caseNiveau3'><input type=text size=1 name=\"");
      out.print(CConstante.PAR_RESTEAPASSER);
      out.write("\" value=\"");
      out.print((int)lTache.getResteAPasser());
      out.write("\" onBlur=\"test_heure(this)\"></td>\r\n");
      out.write("\t    ");
 } 
      out.write("\r\n");
      out.write("      ");
 if (bouton == 3) 
        {
      
      out.write("\r\n");
      out.write("      <td class='caseNiveau3'>");
      out.print((int)lTache.getResteAPasser());
      out.write("</td>\r\n");
      out.write("\t    ");
 } 
      out.write("\r\n");
      out.write("\t    ");
 if (lTache.getEtat () == 2)
	     {
	     
      out.write("\r\n");
      out.write("\t    <td class='caseNiveau3'>Suspendue</td>\r\n");
      out.write("\t    ");
 } 
      out.write("\r\n");
      out.write("      ");
 if (lTache.getEtat () == 3)
       {
       
      out.write("\r\n");
      out.write("      <td class='caseNiveau3'>Terminée</td>\r\n");
      out.write("      ");
 } 
      out.write("\r\n");
      out.write("\t    <td class='caseNiveau3'>");
      out.print(lDateFormat.format (lTache.getDateDebutPrevue () ));
      out.write("</td>\r\n");
      out.write("\t    <td class='caseNiveau3'><input type=text size=8 name=\"");
      out.print(CConstante.PAR_DATEDEBUTREELLE);
      out.write("\"\r\n");
      out.write("\t                             value=\"");
      out.print(lDateFormat.format (lTache.getDateDebutReelle ()) );
      out.write("\" onBlur=\"test_date(this)\">\r\n");
      out.write("\t    </td>\r\n");
      out.write("\t    <td class='caseNiveau3'>");
      out.print(lDateFormat.format (lTache.getDateFinPrevue ()));
      out.write("</td>\r\n");
      out.write("\t    <td class='caseNiveau3'><input type=text size=8 name=\"");
      out.print(CConstante.PAR_DATEFINREELLE);
      out.write("\" \r\n");
      out.write("\t                             value=\"");
      out.print(lDateFormat.format (lTache.getDateFinReelle()));
      out.write("\" onBlur=\"test_date(this)\">\r\n");
      out.write("\t    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("  </tbody>\r\n");
      out.write("  </table>\r\n");
      out.write("  <br><br>\r\n");
      out.write("  <input type=hidden name=\"");
      out.print(CConstante.PAR_TACHE);
      out.write("\" value=");
      out.print(lTache.getId());
      out.write(">\r\n");
      out.write("  <input type=hidden name=\"");
      out.print(CConstante.PAR_RESTEAPASSER);
      out.write("\" value=");
      out.print(lTache.getResteAPasser());
      out.write(">\r\n");
      out.write("  <input type=hidden name=\"");
      out.print(CConstante.PAR_ETAT);
      out.write("\" value=");
      out.print(lTache.getEtat());
      out.write(">\r\n");
      out.write("<center>\r\n");
      out.write("  <table border=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("\t    <td>\r\n");
      out.write("\t\t    <font class=\"texteSubmit\">\r\n");
      out.write("\t\t    <input type=\"submit\" value=\"Valider\" OnClick=\"valider()\">\r\n");
      out.write("\t\t    </font>\r\n");
      out.write("\t      </form>\r\n");
      out.write("      </td>\r\n");
      out.write("      <td>\r\n");
      out.write("\t      <form action=\"./ListeTacheVisu\" method=\"post\">\r\n");
      out.write("\t      <input type=\"submit\" value=\"Annuler\">\r\n");
      out.write("\t      </form>\r\n");
      out.write("      </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("  </table>\r\n");
      out.write("</center>\r\n");
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
