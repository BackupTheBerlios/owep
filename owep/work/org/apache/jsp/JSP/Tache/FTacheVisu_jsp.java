package org.apache.jsp.JSP.Tache;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.text.SimpleDateFormat;
import owep.controle.CConstante;
import owep.modele.execution.MTache;

public final class FTacheVisu_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      owep.modele.execution.MArtefact lArtefact = null;
      synchronized (_jspx_page_context) {
        lArtefact = (owep.modele.execution.MArtefact) _jspx_page_context.getAttribute("lArtefact", PageContext.PAGE_SCOPE);
        if (lArtefact == null){
          lArtefact = new owep.modele.execution.MArtefact();
          _jspx_page_context.setAttribute("lArtefact", lArtefact, PageContext.PAGE_SCOPE);
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

    SimpleDateFormat lDateFormat = new SimpleDateFormat ("dd/MM/yyyy") ;
    lTache = (MTache) request.getAttribute (CConstante.PAR_TACHE) ;
    
    String [] tabEtat = {"Créée", "Prète", "Commencée", "Suspendue", "Terminée"};

      out.write("\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("<tbody>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td width=\"20%\">Tâche : </td>\r\n");
      out.write("    <td align=\"left\">");
      out.print( lTache.getNom ());
      out.write("</td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td width=\"20%\">Etat : </td>\r\n");
      out.write("    <td align=\"left\">");
      out.print( tabEtat[lTache.getEtat()]);
      out.write("</td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td width=\"20%\">Description : </td>\r\n");
      out.write("    <td align=\"left\">");
      out.print( lTache.getDescription());
      out.write("</td>\r\n");
      out.write("  </tr>\r\n");
      out.write("</tbody>\r\n");
      out.write("</table> \r\n");
      out.write(" \r\n");
      out.write("<br><br>\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("<tbody>\r\n");
      out.write("  <tr>\r\n");
      out.write("\t<td width=\"15%\">Temps prévu : </td>\r\n");
      out.write("\t<td width=\"20%\">");
      out.print(lTache.getChargeInitiale ());
      out.write("</td>\r\n");
      out.write("    <td width=\"15%\">Temps passé : </td>\r\n");
      out.write("    <td width=\"20%\">");
      out.print(lTache.getTempsPasse ()    );
      out.write("</td>\r\n");
      out.write("    <td width=\"15%\">Reste à passer : </td>\r\n");
      out.write("    <td width=\"15%\">");
      out.print(lTache.getResteAPasser ()  );
      out.write("</td>\r\n");
      out.write("  </tr>\r\n");
      out.write("</tbody>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<br>\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("<tbody>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td colspan=\"5\">Dates : </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td width=\"15%\">début prévue : </td>\r\n");
      out.write("    <td width=\"20%\">");
 if (lTache.getDateDebutPrevue () != null)
           {
             out.print (lDateFormat.format (lTache.getDateDebutPrevue ())) ;
           }
           else
           {
             out.print ("X") ;
           } 
      out.write("\r\n");
      out.write("    </td>\r\n");
      out.write("    <td width=\"15%\">début réelle : </td>\r\n");
      out.write("    <td width=\"20%\">");
 if (lTache.getDateDebutReelle () != null)
           {
             out.print (lDateFormat.format (lTache.getDateDebutReelle ())) ;
           }
           else
           {
             out.print ("X") ;
           } 
      out.write("\r\n");
      out.write("    </td>\r\n");
      out.write("    <td width=\"30%\"></td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td width=\"15%\">fin prévue</td>\r\n");
      out.write("    <td width=\"20%\">");
 if (lTache.getDateFinPrevue () != null)
           {
             out.print (lDateFormat.format (lTache.getDateFinPrevue ())) ;
           }
           else
           {
             out.print ("X") ;
           } 
      out.write("\r\n");
      out.write("    </td>\r\n");
      out.write("    <td width=\"15%\">fin réestimée : </td>\r\n");
      out.write("    <td width=\"20%\">");
 if (lTache.getDateFinReelle () != null)
           {
             out.print (lDateFormat.format (lTache.getDateFinReelle ())) ;
           }
           else
           {
             out.print ("X") ;
           } 
      out.write("\r\n");
      out.write("    </td>\r\n");
      out.write("    <td width=\"30%\"></td>\r\n");
      out.write("  </tr>\r\n");
      out.write("</tbody>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<br>\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("<tbody>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td colspan=\"5\">Dépassement de charge : </td>\r\n");
      out.write("  </tr>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td width=\"15%\">pourcentage : </td>\r\n");
      out.write("    <td width=\"20%\">");
      out.print( lTache.getPrcDepassementCharge () * 100 );
      out.write("</td>\r\n");
      out.write("    <td width=\"15%\">hommes jour : </td>\r\n");
      out.write("    <td width=\"20%\">");
      out.print( lTache.getHJDepassementCharge ()        );
      out.write("</td>\r\n");
      out.write("    <td width=\"30%\"></td>\r\n");
      out.write("  </tr>\r\n");
      out.write("</tbody>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<br><br>\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\">\r\n");
      out.write("  <tr>\r\n");
if (lTache.getNbArtefactsEntrees()>0){
      out.write("\r\n");
      out.write("  <td width=\"50%\" valign=\"top\">\r\n");
      out.write("    <center>Artefacts en entrée de la tache</center><br>\r\n");
      out.write("\t<table width=\"100%\" class=\"tableau\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("\t<tbody>\r\n");
      out.write("\t  <tr>\r\n");
      out.write("\t    <td class=\"caseNiveau1\">Artefact</td>\r\n");
      out.write("\t    <td class=\"caseNiveau1\">Disponibilité</td>\r\n");
      out.write("\t    <td class=\"caseNiveau1\">Responsable</td>\r\n");
      out.write("\t  </tr>\r\n");
      out.write("\t  ");
for (int i = 0; i < lTache.getNbArtefactsEntrees(); i ++)
	    {
	      lArtefact = lTache.getArtefact(i) ;  
	  
      out.write("\r\n");
      out.write("\t    <tr>\r\n");
      out.write("\t      <td class='caseNiveau2'>");
      out.print( lArtefact.getNom());
      out.write("</td>\r\n");
      out.write("\t      ");
if (lArtefact.getNomFichier() != null){
      out.write("\r\n");
      out.write("\t        <td class='caseNiveau2'><a href=");
      out.print( "../"+lArtefact.getPathFichier()+lArtefact.getNomFichier());
      out.write('>');
      out.print( lArtefact.getNomFichier());
      out.write("</a></td>\r\n");
      out.write("\t      ");
}else{
      out.write("\r\n");
      out.write("            <td class='caseNiveau2'>Nom disponible</td>\r\n");
      out.write("          ");
}
      out.write("\r\n");
      out.write("\t      <td class='caseNiveau2'>");
      out.print( lArtefact.getCollaborateur().getPrenom()+" "+lArtefact.getCollaborateur().getNom());
      out.write("</td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t  ");
}
      out.write("\r\n");
      out.write("\t</tbody>\r\n");
      out.write("\t</table>\r\n");
      out.write("  </td>\t\r\n");
}
      out.write("\r\n");
      out.write("\r\n");
if (lTache.getNbArtefactsSorties()>0){
      out.write("\r\n");
      out.write("  <td width=\"50%\" valign=\"top\">\r\n");
      out.write("    <center>Artefacts en sortie de la tache</center><br>\r\n");
      out.write("\t<table width=\"100%\" class=\"tableau\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("\t<tbody>\r\n");
      out.write("\t  <tr>\r\n");
      out.write("\t    <td class=\"caseNiveau1\">Artefact</td>\r\n");
      out.write("\t    <td class=\"caseNiveau1\">Disponibilité</td>\r\n");
      out.write("\t    <td class=\"caseNiveau1\">Upload</td>\r\n");
      out.write("\t  </tr>\r\n");
      out.write("\t  ");
for (int i = 0; i < lTache.getNbArtefactsSorties(); i ++)
	    {
	      lArtefact = lTache.getArtefactSortie(i) ;
	  
      out.write("\r\n");
      out.write("\t    <tr>\r\n");
      out.write("\t      <td class='caseNiveau2'>");
      out.print( lArtefact.getNom());
      out.write("</td>\r\n");
      out.write("\t      ");
if (lArtefact.getNomFichier() != null){
      out.write("\r\n");
      out.write("\t        <td class='caseNiveau2'><a href=");
      out.print( "../"+lArtefact.getPathFichier()+lArtefact.getNomFichier());
      out.write('>');
      out.print( lArtefact.getNomFichier());
      out.write("</a></td>\r\n");
      out.write("\t      ");
}else{
      out.write("\r\n");
      out.write("            <td class='caseNiveau2'>Nom disponible</td>\r\n");
      out.write("          ");
}
      out.write("\r\n");
      out.write("\t        <td class='caseNiveau2'><a href=");
      out.print( "../Artefact/ArtefactAjout?pArtefact="+ Integer.toString(lArtefact.getId())+"&pTacheAVisualiser="+lTache.getId());
      out.write('>');
      out.print( "Ajouter");
      out.write("</a></td>\r\n");
      out.write("\t    </tr>\r\n");
      out.write("\t  ");
}
      out.write("\r\n");
      out.write("\t</tbody>\r\n");
      out.write("\t</table>\r\n");
      out.write("  </td>\t\r\n");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("  </tr>\r\n");
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
