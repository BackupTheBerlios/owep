package org.apache.jsp.JSP.Template;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class FMessagerie_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<table class=\"regionMessagerie\" style=\"width : 100%; height : 100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("<tbody style=\"vertical-align : top\">\r\n");
      out.write("  <tr>\r\n");
      out.write("    <!-- commandes de la messagerie -->\r\n");
      out.write("    <td>\r\n");
      out.write("      <table width=\"85px\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("      <tbody>\r\n");
      out.write("        <tr>\r\n");
      out.write("          <td class=\"caseMessageCommande\">\r\n");
      out.write("            <a class=\"messageCommande\" href=\"\">Envoyer</a>\r\n");
      out.write("          </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("          <td class=\"caseMessageCommande\">\r\n");
      out.write("            <a class=\"messageCommande\" href=\"\">Consulter</a>\r\n");
      out.write("          </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("          <td class=\"caseMessageCommande\">\r\n");
      out.write("            <a class=\"messageCommande\" href=\"\">Rafraîchir</a>\r\n");
      out.write("          </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("      </tbody>\r\n");
      out.write("      </table>\r\n");
      out.write("    </td>\r\n");
      out.write("  \r\n");
      out.write("    <!-- liste des messages -->\r\n");
      out.write("    <td style=\"width : 100%\">\r\n");
      out.write("      <table style=\"width : 100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("      <tbody>\r\n");
      out.write("        <tr>\r\n");
      out.write("          <td class=\"caseMessage\">\r\n");
      out.write("            <a class=\"messageOrigine\" href=\"\">Collaborateur1&nbsp;></a>\r\n");
      out.write("          </td>\r\n");
      out.write("          <td style=\"width : 100%\" class=\"caseMessage\">\r\n");
      out.write("            <font class=\"message\">Message 1...</font>\r\n");
      out.write("          </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("          <td class=\"caseMessage\">\r\n");
      out.write("            <a class=\"messageOrigine\" href=\"\">Spécification&nbsp;></a>\r\n");
      out.write("          </td>\r\n");
      out.write("          <td style=\"width : 100%\" class=\"caseMessage\">\r\n");
      out.write("            <font class=\"message\">L'artefact CU_Messagerie est maintenant diponible.</font>\r\n");
      out.write("          </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("      </tbody>\r\n");
      out.write("      </table>\r\n");
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
