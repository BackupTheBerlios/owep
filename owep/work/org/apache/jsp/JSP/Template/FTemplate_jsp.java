package org.apache.jsp.JSP.Template;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class FTemplate_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  static {
    _jspx_dependants = new java.util.Vector(1);
    _jspx_dependants.add("/WEB-INF/tld/template.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_template_region_nom_nobody;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_template_region_nom_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_template_region_nom_nobody.release();
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
      out.write("<!-- en-tête de la page -->\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("  <meta content=\"text/html; charset=ISO-8859-1\" http-equiv=\"content-type\">\r\n");
      out.write("  <meta name=\"author\" content=\"OWEP Team\">\r\n");
      out.write("  <meta name=\"description\" content=\"Outil de Workflow pour une équipe de Projet\">\r\n");
      out.write("  <title>OWEP</title>\r\n");
      out.write("  <link rel=\"stylesheet\" href=\"../CSS/Red.css\" type=\"text/css\">\r\n");
      out.write("  <script language=\"javascript\" src=\"../JavaScript/");
      if (_jspx_meth_template_region_0(_jspx_page_context))
        return;
      out.write("\"></script>\r\n");
      out.write("  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!-- corps de la page -->\r\n");
      out.write("<body>\r\n");
      out.write("  <table style=\"width : 100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("  <tbody>\r\n");
      out.write("    <tr style=\"height : 100%\">\r\n");
      out.write("    \r\n");
      out.write("      <!-- colonne de gauche -->\r\n");
      out.write("      <td style=\"width : 170px\">\r\n");
      out.write("        <table class=\"regionGauche\" style=\"width : 100%; height : 100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("        <tbody>\r\n");
      out.write("        \r\n");
      out.write("          <!-- logo de l'application -->\r\n");
      out.write("          <tr>\r\n");
      out.write("            <td>\r\n");
      out.write("              ");
      if (_jspx_meth_template_region_1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("            </td>\r\n");
      out.write("          </tr>\r\n");
      out.write("          \r\n");
      out.write("          \r\n");
      out.write("          <!-- menu Avancement -->\r\n");
      out.write("          <tr>\r\n");
      out.write("            <td>\r\n");
      out.write("              ");
      if (_jspx_meth_template_region_2(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("            </td>\r\n");
      out.write("          </tr>\r\n");
      out.write("        </tbody>\r\n");
      out.write("        </table>\r\n");
      out.write("      </td>\r\n");
      out.write("      \r\n");
      out.write("      \r\n");
      out.write("      \r\n");
      out.write("      <!-- colonne principale -->\r\n");
      out.write("      <td style=\"width : 100%\">\r\n");
      out.write("        <table class=\"regionDroit\" style=\"width : 100%; height : 100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("        <tbody>\r\n");
      out.write("                \r\n");
      out.write("          <!-- messagerie -->\r\n");
      out.write("          <tr>\r\n");
      out.write("            <td>\r\n");
      out.write("              ");
      if (_jspx_meth_template_region_3(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("            </td>\r\n");
      out.write("          </tr>\r\n");
      out.write("          \r\n");
      out.write("          <tr style=\"height: 100%; width: 100%\">\r\n");
      out.write("            <td>\r\n");
      out.write("              <table class=\"regionPrincipal\" style=\"height: 100%; width: 100%\">\r\n");
      out.write("              <tbody>\r\n");
      out.write("                <!-- titre -->\r\n");
      out.write("                <tr>\r\n");
      out.write("                  <td class=\"regionTitre\">\r\n");
      out.write("                    ");
      if (_jspx_meth_template_region_4(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("                  </td>\r\n");
      out.write("                </tr>\r\n");
      out.write("                \r\n");
      out.write("                <!-- navigation -->\r\n");
      out.write("                <tr>\r\n");
      out.write("                  <td class=\"regionNavigation\">\r\n");
      out.write("                    ");
      if (_jspx_meth_template_region_5(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("                  </td>\r\n");
      out.write("                </tr>\r\n");
      out.write("                \r\n");
      out.write("                <!-- contenu -->\r\n");
      out.write("                <tr style=\"height: 100%\">\r\n");
      out.write("                  <td class=\"regionContenu\">\r\n");
      out.write("                    ");
      if (_jspx_meth_template_region_6(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("                  </td>\r\n");
      out.write("                </tr>\r\n");
      out.write("              </tbody>\r\n");
      out.write("              </table>\r\n");
      out.write("            </td>\r\n");
      out.write("          </tr>\r\n");
      out.write("          \r\n");
      out.write("          \r\n");
      out.write("        </tbody>\r\n");
      out.write("        </table>\r\n");
      out.write("      </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    \r\n");
      out.write("    \r\n");
      out.write("    <!-- pied de page -->\r\n");
      out.write("    <tr>\r\n");
      out.write("      <td colspan=\"2\">\r\n");
      out.write("        ");
      if (_jspx_meth_template_region_7(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("      </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("  </tbody>\r\n");
      out.write("  </table>\r\n");
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

  private boolean _jspx_meth_template_region_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:region
    owep.vue.template.VRegionTag _jspx_th_template_region_0 = (owep.vue.template.VRegionTag) _jspx_tagPool_template_region_nom_nobody.get(owep.vue.template.VRegionTag.class);
    _jspx_th_template_region_0.setPageContext(_jspx_page_context);
    _jspx_th_template_region_0.setParent(null);
    _jspx_th_template_region_0.setNom("RegionScript");
    int _jspx_eval_template_region_0 = _jspx_th_template_region_0.doStartTag();
    if (_jspx_th_template_region_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_region_nom_nobody.reuse(_jspx_th_template_region_0);
    return false;
  }

  private boolean _jspx_meth_template_region_1(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:region
    owep.vue.template.VRegionTag _jspx_th_template_region_1 = (owep.vue.template.VRegionTag) _jspx_tagPool_template_region_nom_nobody.get(owep.vue.template.VRegionTag.class);
    _jspx_th_template_region_1.setPageContext(_jspx_page_context);
    _jspx_th_template_region_1.setParent(null);
    _jspx_th_template_region_1.setNom("RegionLogo");
    int _jspx_eval_template_region_1 = _jspx_th_template_region_1.doStartTag();
    if (_jspx_th_template_region_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_region_nom_nobody.reuse(_jspx_th_template_region_1);
    return false;
  }

  private boolean _jspx_meth_template_region_2(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:region
    owep.vue.template.VRegionTag _jspx_th_template_region_2 = (owep.vue.template.VRegionTag) _jspx_tagPool_template_region_nom_nobody.get(owep.vue.template.VRegionTag.class);
    _jspx_th_template_region_2.setPageContext(_jspx_page_context);
    _jspx_th_template_region_2.setParent(null);
    _jspx_th_template_region_2.setNom("RegionMenu");
    int _jspx_eval_template_region_2 = _jspx_th_template_region_2.doStartTag();
    if (_jspx_th_template_region_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_region_nom_nobody.reuse(_jspx_th_template_region_2);
    return false;
  }

  private boolean _jspx_meth_template_region_3(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:region
    owep.vue.template.VRegionTag _jspx_th_template_region_3 = (owep.vue.template.VRegionTag) _jspx_tagPool_template_region_nom_nobody.get(owep.vue.template.VRegionTag.class);
    _jspx_th_template_region_3.setPageContext(_jspx_page_context);
    _jspx_th_template_region_3.setParent(null);
    _jspx_th_template_region_3.setNom("RegionMessagerie");
    int _jspx_eval_template_region_3 = _jspx_th_template_region_3.doStartTag();
    if (_jspx_th_template_region_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_region_nom_nobody.reuse(_jspx_th_template_region_3);
    return false;
  }

  private boolean _jspx_meth_template_region_4(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:region
    owep.vue.template.VRegionTag _jspx_th_template_region_4 = (owep.vue.template.VRegionTag) _jspx_tagPool_template_region_nom_nobody.get(owep.vue.template.VRegionTag.class);
    _jspx_th_template_region_4.setPageContext(_jspx_page_context);
    _jspx_th_template_region_4.setParent(null);
    _jspx_th_template_region_4.setNom("RegionTitre");
    int _jspx_eval_template_region_4 = _jspx_th_template_region_4.doStartTag();
    if (_jspx_th_template_region_4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_region_nom_nobody.reuse(_jspx_th_template_region_4);
    return false;
  }

  private boolean _jspx_meth_template_region_5(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:region
    owep.vue.template.VRegionTag _jspx_th_template_region_5 = (owep.vue.template.VRegionTag) _jspx_tagPool_template_region_nom_nobody.get(owep.vue.template.VRegionTag.class);
    _jspx_th_template_region_5.setPageContext(_jspx_page_context);
    _jspx_th_template_region_5.setParent(null);
    _jspx_th_template_region_5.setNom("RegionNavigation");
    int _jspx_eval_template_region_5 = _jspx_th_template_region_5.doStartTag();
    if (_jspx_th_template_region_5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_region_nom_nobody.reuse(_jspx_th_template_region_5);
    return false;
  }

  private boolean _jspx_meth_template_region_6(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:region
    owep.vue.template.VRegionTag _jspx_th_template_region_6 = (owep.vue.template.VRegionTag) _jspx_tagPool_template_region_nom_nobody.get(owep.vue.template.VRegionTag.class);
    _jspx_th_template_region_6.setPageContext(_jspx_page_context);
    _jspx_th_template_region_6.setParent(null);
    _jspx_th_template_region_6.setNom("RegionPrincipal");
    int _jspx_eval_template_region_6 = _jspx_th_template_region_6.doStartTag();
    if (_jspx_th_template_region_6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_region_nom_nobody.reuse(_jspx_th_template_region_6);
    return false;
  }

  private boolean _jspx_meth_template_region_7(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:region
    owep.vue.template.VRegionTag _jspx_th_template_region_7 = (owep.vue.template.VRegionTag) _jspx_tagPool_template_region_nom_nobody.get(owep.vue.template.VRegionTag.class);
    _jspx_th_template_region_7.setPageContext(_jspx_page_context);
    _jspx_th_template_region_7.setParent(null);
    _jspx_th_template_region_7.setNom("RegionPied");
    int _jspx_eval_template_region_7 = _jspx_th_template_region_7.doStartTag();
    if (_jspx_th_template_region_7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_region_nom_nobody.reuse(_jspx_th_template_region_7);
    return false;
  }
}
