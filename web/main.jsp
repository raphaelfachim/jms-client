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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JMS - sys</title>
    </head>
    <body>
        <form action="main.jsp">
		Código da mensagem: 
                <Input name="codigoMensagem" type="text" size="5" value="PL"><br>
		Código da Placa/Bobina:
                <Input name="codigoProduto" type="text" size="5"><br>
		Peso:
                <Input name="peso" type="number" size="5"><br>
		Largura:
                <Input name="largura" type="number" size="5"><br>
		Comprimento:
                <Input name="comprimento" type="number" size="5"><br>
		Espessura:
                <Input name="espessura" type="number" size="5"><br>
		<INPUT type="submit" name="todo" value="Enviar">
	</form>
                
    <%
	//Sample 9.08: Get Request Form Field Data
	String codigoMensagem = request.getParameter("codigoMensagem");
	String codigoProduto = request.getParameter("codigoProduto");
        Float peso = Float.valueOf(request.getParameter("peso"));
        Float largura = Float.valueOf(request.getParameter("largura"));
        Float comprimento = Float.valueOf(request.getParameter("comprimento"));
        Float espessura = Float.valueOf(request.getParameter("espessura"));
	
	//Sample 9.09 Check we have Valid Request
	if (codigoMensagem != null && codigoMensagem.trim().length() > 0
			&& codigoProduto != null && codigoProduto.trim().length() > 0
                        && peso != null && peso > 0.0
                        && largura != null && largura > 0.0
                        && comprimento != null && comprimento > 0.0
                        && espessura != null && espessura > 0.0
                )
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
		String mes = codigoMensagem + ";" + codigoProduto + ";" + peso + ";" + largura + ";" + comprimento + ";" + espessura ;
		
		//Sample 9.13: Post Message Data to the Queue
		MessageProducer sender = JmsSession.createProducer(ShipmentQueue);
		TextMessage TextMsg = JmsSession.createTextMessage();
		TextMsg.setText(mes);
		
		//Sample 9.14: Now Post the message to Shipment Queue on the Server
		sender.send(TextMsg);
	}
    %>
    </body>
</html>
