package org.apache.jsp.JSP.Navigation;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import owep.controle.CConstante;

public final class FIteration_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<center>\r\n");
      out.write("\t<form id=\"navigation\">\r\n");
      out.write("    Choisissez l'itération : \t    \r\n");
      out.write("    \r\n");
      out.write("       <select name=\"pNumIteration\" size=1 onChange=\"navigationIteration (this.form.pNumIteration)\">   \r\n");
      out.write("      ");

      	//récupération de la liste des itérations à partir du projet sélectionné dans la session
        java.util.ArrayList listeIteration = ((owep.infrastructure.Session)(request.getSession().getAttribute("SESSION"))).getProjet().getListeIterations(); 
        for(int i=0; i<listeIteration.size(); i++)
        {
      
      out.write("\r\n");
      out.write("        <option\r\n");
      out.write("          ");
if (((owep.modele.execution.MIteration)listeIteration.get(i)).equals(((owep.infrastructure.Session)(request.getSession().getAttribute("SESSION"))).getIteration())){
      out.write("\r\n");
      out.write("            selected\r\n");
      out.write("          ");
}
      out.write("\r\n");
      out.write("          value=\"");
      out.print(((owep.modele.execution.MIteration)listeIteration.get(i)).getId());
      out.write("\">Itération ");
      out.print(((owep.modele.execution.MIteration)listeIteration.get(i)).getNumero());
      out.write("\r\n");
      out.write("        </option>\r\n");
      out.write("\t  ");
}
      out.write("  \r\n");
      out.write("\t    </select>\r\n");
      out.write("\t</form>\r\n");
      out.write("</center>");
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
