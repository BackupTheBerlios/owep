package org.apache.jsp.JSP;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  static {
    _jspx_dependants = new java.util.Vector(1);
    _jspx_dependants.add("/WEB-INF/tld/template.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_template_template_nom;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_template_section_typePage_region_contenu_nobody;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_template_template_nom = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_template_section_typePage_region_contenu_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_template_template_nom.release();
    _jspx_tagPool_template_section_typePage_region_contenu_nobody.release();
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
      out.write("<!DOCTYPE HTML PUBLIC \"-//w3c//dtd html 4.0 transitional//en\">\r\n");
      out.write("\r\n");
      if (_jspx_meth_template_template_0(_jspx_page_context))
        return;
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

  private boolean _jspx_meth_template_template_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:template
    owep.vue.template.VTemplateTag _jspx_th_template_template_0 = (owep.vue.template.VTemplateTag) _jspx_tagPool_template_template_nom.get(owep.vue.template.VTemplateTag.class);
    _jspx_th_template_template_0.setPageContext(_jspx_page_context);
    _jspx_th_template_template_0.setParent(null);
    _jspx_th_template_template_0.setNom("/JSP/Template/FTemplate.jsp");
    int _jspx_eval_template_template_0 = _jspx_th_template_template_0.doStartTag();
    if (_jspx_eval_template_template_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("  ");
        if (_jspx_meth_template_section_0(_jspx_th_template_template_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("  ");
        if (_jspx_meth_template_section_1(_jspx_th_template_template_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("  ");
        if (_jspx_meth_template_section_2(_jspx_th_template_template_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("  ");
        if (_jspx_meth_template_section_3(_jspx_th_template_template_0, _jspx_page_context))
          return true;
        out.write('\r');
        out.write('\n');
        int evalDoAfterBody = _jspx_th_template_template_0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_template_template_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_template_nom.reuse(_jspx_th_template_template_0);
    return false;
  }

  private boolean _jspx_meth_template_section_0(javax.servlet.jsp.tagext.JspTag _jspx_th_template_template_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:section
    owep.vue.template.VSectionTag _jspx_th_template_section_0 = (owep.vue.template.VSectionTag) _jspx_tagPool_template_section_typePage_region_contenu_nobody.get(owep.vue.template.VSectionTag.class);
    _jspx_th_template_section_0.setPageContext(_jspx_page_context);
    _jspx_th_template_section_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_template_template_0);
    _jspx_th_template_section_0.setRegion("RegionTitre");
    _jspx_th_template_section_0.setContenu("Identification");
    _jspx_th_template_section_0.setTypePage("false");
    int _jspx_eval_template_section_0 = _jspx_th_template_section_0.doStartTag();
    if (_jspx_th_template_section_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_section_typePage_region_contenu_nobody.reuse(_jspx_th_template_section_0);
    return false;
  }

  private boolean _jspx_meth_template_section_1(javax.servlet.jsp.tagext.JspTag _jspx_th_template_template_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:section
    owep.vue.template.VSectionTag _jspx_th_template_section_1 = (owep.vue.template.VSectionTag) _jspx_tagPool_template_section_typePage_region_contenu_nobody.get(owep.vue.template.VSectionTag.class);
    _jspx_th_template_section_1.setPageContext(_jspx_page_context);
    _jspx_th_template_section_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_template_template_0);
    _jspx_th_template_section_1.setRegion("RegionPrincipal");
    _jspx_th_template_section_1.setContenu("/JSP/FIndex.jsp");
    _jspx_th_template_section_1.setTypePage("true");
    int _jspx_eval_template_section_1 = _jspx_th_template_section_1.doStartTag();
    if (_jspx_th_template_section_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_section_typePage_region_contenu_nobody.reuse(_jspx_th_template_section_1);
    return false;
  }

  private boolean _jspx_meth_template_section_2(javax.servlet.jsp.tagext.JspTag _jspx_th_template_template_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:section
    owep.vue.template.VSectionTag _jspx_th_template_section_2 = (owep.vue.template.VSectionTag) _jspx_tagPool_template_section_typePage_region_contenu_nobody.get(owep.vue.template.VSectionTag.class);
    _jspx_th_template_section_2.setPageContext(_jspx_page_context);
    _jspx_th_template_section_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_template_template_0);
    _jspx_th_template_section_2.setRegion("RegionLogo");
    _jspx_th_template_section_2.setContenu("/JSP/Template/FLogo.jsp");
    _jspx_th_template_section_2.setTypePage("true");
    int _jspx_eval_template_section_2 = _jspx_th_template_section_2.doStartTag();
    if (_jspx_th_template_section_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_section_typePage_region_contenu_nobody.reuse(_jspx_th_template_section_2);
    return false;
  }

  private boolean _jspx_meth_template_section_3(javax.servlet.jsp.tagext.JspTag _jspx_th_template_template_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:section
    owep.vue.template.VSectionTag _jspx_th_template_section_3 = (owep.vue.template.VSectionTag) _jspx_tagPool_template_section_typePage_region_contenu_nobody.get(owep.vue.template.VSectionTag.class);
    _jspx_th_template_section_3.setPageContext(_jspx_page_context);
    _jspx_th_template_section_3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_template_template_0);
    _jspx_th_template_section_3.setRegion("RegionPied");
    _jspx_th_template_section_3.setContenu("/JSP/Template/FPied.jsp");
    _jspx_th_template_section_3.setTypePage("true");
    int _jspx_eval_template_section_3 = _jspx_th_template_section_3.doStartTag();
    if (_jspx_th_template_section_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_template_section_typePage_region_contenu_nobody.reuse(_jspx_th_template_section_3);
    return false;
  }
}
