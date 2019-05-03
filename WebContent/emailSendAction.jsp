<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="java.util.Properties"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="util.Gmail"%>

<%

	UserDAO userDAO = new UserDAO();
	String userID = null;
	String userNickname = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String)session.getAttribute("userID");
		userNickname = (String)session.getAttribute("userNickname");
	}
	if(userID == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Sign in first, please');");
		script.println("location.href = 'loginPage.jsp'");
		script.println("</script>");
		script.close();
		return;
	}

	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if(emailChecked == true)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Already checked E-mail');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	String host = "http://localhost:8080/Bean_Tweet/";
	String from = "yoonbin31@gmail.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "This is for confirm registration";
	String content = "Click the link below to authenticate your email" + 
			"<a href=" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + ">check_email</a>";
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	
	try
	{
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr); //Sender
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr); //Receiver
		msg.setContent(content, "text/html;charset=UTF-8");
		Transport.send(msg);
	}catch(Exception e){
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Error occured');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>LittleBEAN Tweet</title>
	<!-- add bootstrap,custom CSS -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">LittleBEAN Tweet</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">Main</a>					
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="hotPage.jsp">Hot</a>					
				</li>		
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle mt=10" id="dropdown" data-toggle="dropdown">Member Menu</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
<%
	if(userID == null)
	{
%>
					
						<a class="dropdown-item" href="loginPage.jsp">Sign in</a>
						<a class="dropdown-item" href="joinPage.jsp">Sign up</a>
<%
	} else {
%>
						
						<a class="dropdown-item" href="userLogoutAction.jsp">Sign out</a>
						<a class="dropdown-item" href="profile.jsp">Your Profile</a>
<%
	}
%>
					</div>
				</li>								
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="Enter some contents" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
	<section class="container mt-5" style="max-width: 560px;">
		<div class="alert alert-success mt-4" role="alert">
			Email for authentication sent. Please check your Email
		</div>
	</section>	
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2019 LittleBEAN All Rights Reserved.
	</footer>
	<!-- add jQuery,popper,bootstrap java script -->
	<script src="./css/jQuery.min.js"></script>
	<script src="./js/popper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>