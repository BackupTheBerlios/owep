package org.apache.jsp.JSP.Template;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class FMenu_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\r\n");
      out.write("<table class=\"regionMenu\" style=\"width : 100%; height : 100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("<tbody>\r\n");
      out.write("  <!-- menu Avancement -->\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuListe\">\r\n");
      out.write("      <select class=\"menuListe\" name=\"LDProjet\" size =\"1\">\r\n");
      out.write("        <option VALUE=\"Projet1\">Projet 1</option>\r\n");
      out.write("      </select>\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuConnexion\">\r\n");
      out.write("      <a class=\"menuConnexion\" href=\"../Outil/Deconnexion\">\r\n");
      out.write("        Déconnexion \r\n");
      out.write("      </a>\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuSeparation\">\r\n");
      out.write("      &nbsp;\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  \r\n");
      out.write("  <!-- menu avancement -->\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau1\">\r\n");
      out.write("      <font class=\"menuNiveau1\">Avancement :</font>\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau2\">\r\n");
      out.write("      <a class=\"menuNiveau2\" href=\"../Tache/ListeTacheVisu\">Liste des tâches</a>\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuSeparation\">\r\n");
      out.write("      &nbsp;\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("\r\n");
      out.write("  <!-- menu projet -->\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau1\">\r\n");
      out.write("      <font class=\"menuNiveau1\">Projet :</font>\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau2\">\r\n");
      out.write("      Suivi du projet\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau2\">\r\n");
      out.write("      Suivi des collaborateurs\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau2\">\r\n");
      out.write("      Gestion des risques\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau2\">\r\n");
      out.write("      Gestion des problèmes\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau2\">\r\n");
      out.write("      Tâche imprévues\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuSeparation\">\r\n");
      out.write("      &nbsp;\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  \r\n");
      out.write("  <!-- menu configuration -->\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau1\">\r\n");
      out.write("      <font class=\"menuNiveau1\">Configuration :</font>\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau2\">\r\n");
      out.write("      Option de l'application\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuNiveau2\">\r\n");
      out.write("      Option de projet\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td style=\"height : 100%\" class=\"caseMenuSeparation2\">\r\n");
      out.write("      &nbsp;\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td class=\"caseMenuSeparation\">\r\n");
      out.write("      &nbsp;\r\n");
      out.write("    </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("</tbody>\r\n");
      out.write("</table>");
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
