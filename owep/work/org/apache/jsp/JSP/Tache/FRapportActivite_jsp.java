package org.apache.jsp.JSP.Tache;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.text.SimpleDateFormat;
import owep.controle.CConstante;
import owep.modele.execution.MCollaborateur;

public final class FRapportActivite_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      owep.modele.execution.MCollaborateur lCollaborateur = null;
      synchronized (session) {
        lCollaborateur = (owep.modele.execution.MCollaborateur) _jspx_page_context.getAttribute("lCollaborateur", PageContext.SESSION_SCOPE);
        if (lCollaborateur == null){
          lCollaborateur = new owep.modele.execution.MCollaborateur();
          _jspx_page_context.setAttribute("lCollaborateur", lCollaborateur, PageContext.SESSION_SCOPE);
        }
      }
      out.write('\r');
      out.write('\n');
      owep.modele.execution.MTache lTache = null;
      synchronized (session) {
        lTache = (owep.modele.execution.MTache) _jspx_page_context.getAttribute("lTache", PageContext.SESSION_SCOPE);
        if (lTache == null){
          lTache = new owep.modele.execution.MTache();
          _jspx_page_context.setAttribute("lTache", lTache, PageContext.SESSION_SCOPE);
        }
      }
      out.write(" \r\n");
      out.write("\r\n");
      out.write("<form action=\"./RapportActivite\" method=\"post\">\r\n");
      out.write("  <table class=\"tableau\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("  <tbody>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Tâches</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Artefact</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Charge prévue</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Temps passé</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Reste à passer</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" rowspan=\"2\">Etat</td>\r\n");
      out.write("      <td class=\"caseNiveau1\" colspan=\"4\">Date</td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\">début prévue</td>\r\n");
      out.write("      <td class=\"caseNiveau1\">début réelle</td>\r\n");
      out.write("      <td class=\"caseNiveau1\">fin prévue</td>\r\n");
      out.write("      <td class=\"caseNiveau1\">fin réestimée</td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    \r\n");
      out.write("    ");

      lCollaborateur = (MCollaborateur) request.getAttribute (CConstante.PAR_COLLABORATEUR) ;
      for (int i = 0; i < lCollaborateur.getNbTaches (); i ++)
      {
        lTache = lCollaborateur.getTache (i) ;
    
      out.write("\r\n");
      out.write("      <tr>\r\n");
      out.write("        <td class='caseNiveau2'>");
      out.print( lTache.getNom ());
      out.write("</td>\r\n");
      out.write("    \r\n");
      out.write("        <!-- Affiche la liste des artefacts -->\r\n");
      out.write("        <td class='caseNiveau2'>\r\n");
      out.write("          ");

            SimpleDateFormat lDateFormat = new SimpleDateFormat ("yyyy-MM-dd") ;
            out.print (lTache.getArtefactSortie (0).getNom ()) ;
            for (int j = 1; j < lTache.getNbArtefactsSorties (); j ++)
            {
              out.print ("<br/>" + lTache.getArtefactSortie (j).getNom ()) ;
            }
          
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("        \r\n");
      out.write("        <!-- Affiche les propriétés de la tâche -->\r\n");
      out.write("        <td class='caseNiveau3'>");
      out.print(lTache.getChargeInitiale ());
      out.write("</td>\r\n");
      out.write("        <td class='caseNiveau3'><input type=text size=1 name=\"");
      out.print(CConstante.PAR_TEMPSPASSE);
      out.print(lTache.getId());
      out.write("\"   value=\"");
      out.print(lTache.getTempsPasse());
      out.write("\"></td>\r\n");
      out.write("        <td class='caseNiveau3'><input type=text size=1 name=\"");
      out.print(CConstante.PAR_RESTEAPASSER);
      out.print(lTache.getId());
      out.write("\" value=\"");
      out.print(lTache.getResteAPasser());
      out.write("\"></td>\r\n");
      out.write("        <td class='caseNiveau3'>");
      out.print(lTache.getEtat ());
      out.write("</td>\r\n");
      out.write("        <td class='caseNiveau3'>");
if (lTache.getDateDebutPrevue () != null)
                                  {
                                    out.print (lDateFormat.format (lTache.getDateDebutPrevue ())) ;
                                  }
                                  else
                                  {
                                    out.print ("X") ;
                                  } 
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("        <td class='caseNiveau3'><input type=text size=8 name=\"");
      out.print(CConstante.PAR_DATEDEBUTREELLE);
      out.print(lTache.getId());
      out.write("\"\r\n");
      out.write("                                 value=\"");
if (lTache.getDateDebutReelle () != null)
                                          {
                                            out.print (lTache.getDateDebutReelle ()) ;
                                          }
      out.write("\">\r\n");
      out.write("        </td>\r\n");
      out.write("        <td class='caseNiveau3'>");
if (lTache.getDateFinPrevue () != null)
                                  {
                                    out.print (lDateFormat.format (lTache.getDateFinPrevue ())) ;
                                  }
                                  else
                                  {
                                    out.print ("X") ;
                                  } 
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("        <td class='caseNiveau3'><input type=text size=8 name=\"");
      out.print(CConstante.PAR_DATEFINREELLE);
      out.print(lTache.getId());
      out.write("\"\r\n");
      out.write("                           value=\"");
if (lTache.getDateFinReelle () != null)
                                    {
                                      out.print (lTache.getDateFinReelle ()) ;
                                    }
      out.write("\">\r\n");
      out.write("        </td>\r\n");
      out.write("      </tr>\r\n");
      out.write("    ");

      }
    
      out.write("\r\n");
      out.write("  </tbody>\r\n");
      out.write("  </table>\r\n");
      out.write("  <input type=hidden name=\"");
      out.print(CConstante.PAR_SUBMIT);
      out.write("\" value=\"true\">\r\n");
      out.write("  <br><br>\r\n");
      out.write("  <font class=\"texteSubmit\">\r\n");
      out.write("    <input type=\"submit\" value=\"Valider\">\r\n");
      out.write("  </font>\r\n");
      out.write("</form>");
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
