package org.apache.jsp.JSP.test;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import owep.infrastructure.fileupload.*;
import java.util.List;
import java.io.File;
import java.util.Iterator;

public final class testupload_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write('\r');
      out.write('\n');

boolean isMultipart = FileUpload.isMultipartContent(request);
if(!isMultipart){
request.setAttribute("msg", "Request was not multipart!");
request.getRequestDispatcher("msg.jsp").forward(request, response);
return;
}

DiskFileUpload upload = new DiskFileUpload();
List items = upload.parseRequest(request);
Iterator itr = items.iterator();

while(itr.hasNext()){
FileItem item = (FileItem) itr.next();
if(item.isFormField()) {
String fieldName = item.getFieldName();
if(fieldName.equals("name"))
request.setAttribute("msg", "Thank You: " + item.getString());
} else {
File fullFile = new File(item.getName());
File savedFile = new File(getServletContext().getRealPath("/")+"/Artefacts/", fullFile.getName());
item.write(savedFile);
}
}

request.getRequestDispatcher("msg.jsp").forward(request, response);

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
