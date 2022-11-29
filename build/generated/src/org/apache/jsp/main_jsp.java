package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.jms.TextMessage;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Queue;
import javax.naming.InitialContext;
import javax.naming.Context;

public final class main_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

    String placeHolder = "Your Name";

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <form action=\"main.jsp\">\n");
      out.write("\t\tBooking Person Name: \n");
      out.write("                <Input name=\"BookerName\" type=\"text\" size=\"25\" value=\"");
      out.print(placeHolder);
      out.write("\" ><br>\n");
      out.write("\t\tWeight of Shipment:\n");
      out.write("\t\t<Input name=\"ShipmentWt\" type=\"text\" size=\"5\" value=\"0\" > in Kg <br>\n");
      out.write("\t\t<INPUT type=\"submit\" name=\"todo\" value=\"Book Shipment\">\n");
      out.write("\t\t<p>Once you get your Shipment Number, call our agent and give the Number for Free Shipping.</p>\n");
      out.write("\t\t<p>Note: Getting Shipment Number may take a while!</p>\n");
      out.write("\t\t<br>\n");
      out.write("\t</form>\n");
      out.write("                \n");
      out.write("    ");

	//Sample 9.08: Get Request Form Field Data
	String BookingPerson = request.getParameter("BookerName");
	String CarryWt = request.getParameter("ShipmentWt");
	
	//Sample 9.09 Check we have Valid Request
	if (BookingPerson != null 
			&& BookingPerson.trim().length() > 0
			&& CarryWt != null
			&& CarryWt.trim().length() > 0)
	{
		//Sample 9.10: Get JMS Queue 
		Context ctx = new InitialContext(System.getProperties());
		Queue ShipmentQueue = (javax.jms.Queue) ctx.lookup("java:/jms/queue/myDestination");
		
		//Sample 9.11: Get the connection
		ConnectionFactory factory = 
			(ConnectionFactory)ctx.lookup("java:/ConnectionFactory");
		Connection JmsCon = factory.createConnection();
		Session JmsSession = JmsCon.createSession(false, Session.AUTO_ACKNOWLEDGE);
		
		//Sample 9.12: Format the Message String
		String data = BookingPerson + "^" + CarryWt ;
		
		//Sample 9.13: Post Message Data to the Queue
		MessageProducer sender = JmsSession.createProducer(ShipmentQueue);
		TextMessage TextMsg = JmsSession.createTextMessage();
		TextMsg.setText(data);
		
		//Sample 9.14: Now Post the message to Shipment Queue on the Server
		sender.send(TextMsg);
		out.println("<h1>Shipment Request Posted.</h1>");
		out.println("<h3><em>Login Tomorrow to get your free Shipment Id</em></h1>");
	}
    
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
