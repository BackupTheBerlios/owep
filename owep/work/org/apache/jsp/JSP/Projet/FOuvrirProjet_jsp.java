package org.apache.jsp.JSP.Projet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.ArrayList;
import owep.modele.execution.MProjet;

public final class FOuvrirProjet_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      owep.modele.execution.MProjet lProjet = null;
      synchronized (_jspx_page_context) {
        lProjet = (owep.modele.execution.MProjet) _jspx_page_context.getAttribute("lProjet", PageContext.PAGE_SCOPE);
        if (lProjet == null){
          lProjet = new owep.modele.execution.MProjet();
          _jspx_page_context.setAttribute("lProjet", lProjet, PageContext.PAGE_SCOPE);
        }
      }
      out.write("\r\n");
      out.write("\r\n");
      out.write("<center>\r\n");
      out.write("\r\n");

  // Récupération des paramétres
  ArrayList lListProjet = (ArrayList) request.getAttribute("listProjetPossible");       // Probleme rencontré lors de l'enregistrement du collaborateur
  
  int i;
  for(i = 0 ; i < lListProjet.size() ; i++)
  {
    lProjet = (MProjet) lListProjet.get(i);

      out.write("\r\n");
      out.write("<a href=\"../Projet/OuvrirProjet?mIdProjet=");
      out.print(lProjet.getId());
      out.write('"');
      out.write('>');
      out.print(lProjet.getNom());
      out.write("</a><br>\r\n");

  }

      out.write("\r\n");
      out.write("\r\n");
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
