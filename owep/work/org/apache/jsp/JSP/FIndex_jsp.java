package org.apache.jsp.JSP;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class FIndex_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\r\n");
      out.write("<center>\r\n");
      out.write("\r\n");

  // Récupération des parametres
  String mProbleme = (String) request.getAttribute("mProbleme"); // Probleme rencontré lors de l'enregistrement du collaborateur
  
  // Si l'attribut mProbleme existe alors un probleme est survenu lors de l'dentification
  if(mProbleme != null)
  {

      out.write("\r\n");
      out.write("Le login et le mot de passe saisi ne sont pas valide<BR>\r\n");

  }

      out.write("\r\n");
      out.write("\r\n");
      out.write("<form action=\"../Outil/Connexion\" method=\"post\">\r\n");
      out.write("  <table class=\"tableauInvisible\" border=\"0\" cellpadding=\"1\" cellspacing=\"1\">\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseInvisible\" rowspan=\"2\" align=\"right\">Login&nbsp<br>Mot de passe&nbsp</td>\r\n");
      out.write("      <td class=\"caseInvisible\" rowspan=\"2\"><input type=text size=10 name=\"login\"><br><input type=\"PASSWORD\" size=10 name=\"pwd\"></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("  </table>\r\n");
      out.write("  <br><br>\r\n");
      out.write("  <font class=\"texteSubmit\">\r\n");
      out.write("    <input type=\"submit\" value=\"Valider\">\r\n");
      out.write("  </font>\r\n");
      out.write("</form>\r\n");
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
