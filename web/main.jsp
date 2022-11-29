<%-- 
    Document   : main
    Created on : 29/11/2022, 11:52:38
    Author     : raphael.fachim
--%>
<%@page import="javax.jms.TextMessage"%>
<%@page import="javax.jms.MessageProducer"%>
<%@page import="javax.jms.Session"%>
<%@page import="javax.jms.Connection"%>
<%@page import="javax.jms.ConnectionFactory"%>
<%@page import="javax.jms.Queue"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%
    String idMensagem = "PC06";
    String data = "20220101";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="main.jsp">
		Booking Person Name: 
                <Input name="BookerName" type="text" size="25" value="<%=idMensagem%>" ><br>
		Weight of Shipment:
                <Input name="ShipmentWt" type="text" size="5" value="<%=data%>" > in Kg <br>
		<INPUT type="submit" name="todo" value="Book Shipment">
		<p>Once you get your Shipment Number, call our agent and give the Number for Free Shipping.</p>
		<p>Note: Getting Shipment Number may take a while!</p>
		<br>
	</form>
                
    <%
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
		Queue ShipmentQueue = (javax.jms.Queue) ctx.lookup("java:/jms/queue/MQ_ACI_COND_N3_CPCS");
		
		//Sample 9.11: Get the connection
		ConnectionFactory factory = 
			(ConnectionFactory)ctx.lookup("java:/ConnectionFactory");
		Connection JmsCon = factory.createConnection();
		Session JmsSession = JmsCon.createSession(false, Session.AUTO_ACKNOWLEDGE);
		
		//Sample 9.12: Format the Message String
		String mes = BookingPerson + CarryWt ;
		
		//Sample 9.13: Post Message Data to the Queue
		MessageProducer sender = JmsSession.createProducer(ShipmentQueue);
		TextMessage TextMsg = JmsSession.createTextMessage();
		TextMsg.setText(mes);
		
		//Sample 9.14: Now Post the message to Shipment Queue on the Server
		sender.send(TextMsg);
		out.println("<h1>Shipment Request Posted.</h1>");
		out.println("<h3><em>Login Tomorrow to get your free Shipment Id</em></h1>");
	}
    %>
    </body>
</html>
