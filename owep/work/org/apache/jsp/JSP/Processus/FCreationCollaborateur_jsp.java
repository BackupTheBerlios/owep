package org.apache.jsp.JSP.Processus;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class FCreationCollaborateur_jsp extends org.apache.jasper.runtime.HttpJspBase
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
  String mProbleme = (String) request.getAttribute("mProbleme");       // Probleme rencontré lors de l'enregistrement du collaborateur
  String mPageSource = (String) request.getAttribute("mPageSource");   // Page qui a appellé la servlet création d'un collaborateur à l'origine
  
  String mNom = (String) request.getAttribute("mNom");                 // Nom du collaborateur
  String mPrenom = (String) request.getAttribute("mPrenom");           // Prenom du collaborateur
  String mLogin = (String) request.getAttribute("mLogin");             // Login du collaborateur
  String mMail = (String) request.getAttribute("mMail");               // Email du collaborateur
  String mAdresse = (String) request.getAttribute("mAdresse");         // Adresse du collaborateur
  String mTelephone = (String) request.getAttribute("mTelephone");     // Numéro du telephone du collaborateur
  String mPortable = (String) request.getAttribute("mPortable");       // Numéro du portable du collaborateur
  String mCommentaire = (String) request.getAttribute("mCommentaire"); // Commentaire du collaborateur
  
  // Définit si c'est le premier appel de la page
  if(mProbleme == null)
  {
    mProbleme = "nouveau";
  }
  
  // Définition du poblème rencontré
  if(mProbleme.equals("unique"))
  {

      out.write("\r\n");
      out.write("Veuillez choisir un autre login.<br>\r\n");

  }
  
  if(mProbleme.equals("login"))
  {

      out.write("\r\n");
      out.write("Veuillez saisir un login.<br>\r\n");

  }
  
  if(mProbleme.equals("mail"))
  {

      out.write("\r\n");
      out.write("Veuillez saisir une adresse eMail.<br>\r\n");

  }

  if(mProbleme.equals("nom"))
  {

      out.write("\r\n");
      out.write("Veuillez saisir un nom.<br>\r\n");

  }
  
  // Aucun probleme n'a été rencontré
  if(mProbleme.equals("false"))
  {
   // Auncun probléme n'a été rencontré

      out.write("\r\n");
      out.write("L'utilisateur a bien été enregistré<br>\r\n");
      out.write("<a href=\"");
      out.print(mPageSource);
      out.write("\">Ok</a>\r\n");

  }
  else
  {
    // Affichage du formulaire

      out.write("\r\n");
      out.write("<br>\r\n");
      out.write("<form action=\"./CreationCollaborateur\" method=\"post\">\r\n");
      out.write("  <table class=\"tableau\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("  <tbody>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\">Nom *</td>\r\n");
      out.write("      <td class=\"caseNiveau3\"><input type=\"text\" name=\"mNom\" value=");
      out.print((!mProbleme.equals("nouveau"))?mNom:"");
      out.write("></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\">Prenom</td>\r\n");
      out.write("      <td class=\"caseNiveau3\"><input type=\"text\" name=\"mPrenom\" value=");
      out.print((!mProbleme.equals("nouveau"))?mPrenom:"");
      out.write("></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\">Login *</td>\r\n");
      out.write("      <td class=\"caseNiveau3\"><input type=\"text\" name=\"mLogin\" value=");
      out.print((!mProbleme.equals("nouveau"))?mLogin:"");
      out.write("></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\">EMail *</td>\r\n");
      out.write("      <td class=\"caseNiveau3\"><input type=\"text\" name=\"mMail\" value=");
      out.print((!mProbleme.equals("nouveau"))?mMail:"");
      out.write("></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\">Adresse</td>\r\n");
      out.write("      <td class=\"caseNiveau3\"><textarea name=\"mAdresse\" rows=3>");
      out.print((!mProbleme.equals("nouveau"))?mAdresse:"");
      out.write("</textarea></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\">Numéro de téléphone</td>\r\n");
      out.write("      <td class=\"caseNiveau3\"><input type=\"text\" name=\"mTelephone\" value=");
      out.print((!mProbleme.equals("nouveau"))?mTelephone:"");
      out.write("></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\">Numéro de portable</td>\r\n");
      out.write("      <td class=\"caseNiveau3\"><input type=\"text\" name=\"mPortable\" value=");
      out.print((!mProbleme.equals("nouveau"))?mPortable:"");
      out.write("></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td class=\"caseNiveau1\">Commentaire</td>\r\n");
      out.write("      <td class=\"caseNiveau3\"><textarea name=\"mCommentaire\" rows=3>");
      out.print((!mProbleme.equals("nouveau"))?mCommentaire:"");
      out.write("</textarea></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("  </tbody>\r\n");
      out.write("  </table>\r\n");
      out.write("  <input type=\"hidden\" name=\"mPageSource\" value=\"");
      out.print(mPageSource);
      out.write("\">\r\n");
      out.write("  <br><br>\r\n");
      out.write("  <font class=\"texteSubmit\">\r\n");
      out.write("    <input type=\"submit\" value=\"Valider\">\r\n");
      out.write("  </font>\r\n");
      out.write("  <br><br><br>\r\n");
      out.write("  * : Champs obligatoire\r\n");
      out.write("</form>\r\n");
      out.write("</center>\r\n");
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
