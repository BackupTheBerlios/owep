package org.apache.jsp.JSP.Artefact;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import owep.controle.CConstante;
import owep.modele.execution.MArtefact;

public final class FArtefactAjout_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\r\n");
      owep.modele.execution.MArtefact lArtefact = null;
      synchronized (_jspx_page_context) {
        lArtefact = (owep.modele.execution.MArtefact) _jspx_page_context.getAttribute("lArtefact", PageContext.PAGE_SCOPE);
        if (lArtefact == null){
          lArtefact = new owep.modele.execution.MArtefact();
          _jspx_page_context.setAttribute("lArtefact", lArtefact, PageContext.PAGE_SCOPE);
        }
      }
      out.write("\r\n");
      out.write("\r\n");

    lArtefact = (MArtefact) request.getAttribute (CConstante.PAR_ARTEFACT) ;

      out.write("\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<title>Ajout d'un artefact</title>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("<table width=\"100%\">\r\n");
      out.write("<tr>\r\n");
      out.write("<td width=\"100%\">\r\n");
      out.write("  <form action=\"./ArtefactAjout\" method=\"post\" enctype=\"multipart/form-data\">\r\n");
      out.write("      \r\n");
      out.write("      ");
if (lArtefact.getNomFichier() != null) {
      out.write("\r\n");
      out.write("      <center>\r\n");
      out.write("        Attention il existe déjà un fichier pour l'artefact ");
      out.print(lArtefact.getNom());
      out.write(' ');
      out.write(':');
      out.write(' ');
      out.print(lArtefact.getNomFichier());
      out.write(" !! \r\n");
      out.write("        <br>\r\n");
      out.write("        Si vous continuez vous remplacerez l'ancien fichier par le nouveau. \r\n");
      out.write("      </center>\r\n");
      out.write("      <br><br>\r\n");
      out.write("      ");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("      <center>\r\n");
      out.write("        Nouveau fichier : <input type=\"file\" name=\"fichierArtefact\">\r\n");
      out.write("      </center>\r\n");
      out.write("    <br>\r\n");
      out.write("  \r\n");
      out.write("    <input type=\"hidden\" name=\"pArtefact\" value=\"");
      out.print(lArtefact);
      out.write(">\r\n");
      out.write("</td>\r\n");
      out.write("</tr> \r\n");
      out.write("    \r\n");
      out.write("<tr>\r\n");
      out.write("<td width=\"100%\">    \r\n");
      out.write("  <table border=\"0\" width=\"100%\">\r\n");
      out.write("    <tr>\r\n");
      out.write("\t    <td align=right width=\"50%\">\r\n");
      out.write("\t\t    <font class=\"texteSubmit\">\r\n");
      out.write("\t\t    <input type=\"submit\" value=\"Valider\">\r\n");
      out.write("\t\t    </font>\r\n");
      out.write("\t      </form>\r\n");
      out.write("      </td>\r\n");
      out.write("      <td align=left width=\"50%\">\r\n");
      out.write("\t      <form action=\"../Tache/TacheVisu\" method=\"get\">\r\n");
      out.write("\t      <input type=\"submit\" value=\"Annuler\">\r\n");
      out.write("\t      <input type=\"hidden\" name=\"pTacheAVisualiser\" value=\"");
      out.print(lArtefact.getTacheSortie().getId());
      out.write("\"+\" \">\r\n");
      out.write("\t      </form>\r\n");
      out.write("      </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("  </table>\r\n");
      out.write("</td>\r\n");
      out.write("</tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
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
