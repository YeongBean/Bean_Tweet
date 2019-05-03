<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String code = null;
	
	if(request.getParameter("code") != null)
	{
		code = request.getParameter("code");
	}
	
	String userID = null;
	
	UserDAO userDAO = new UserDAO();
	
	if(session.getAttribute("userID") != null)
	{
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please sign in first');");
		script.println("location.href = 'loginPage.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	String userNickname = null;
	String userEmail = userDAO.getUserEmail(userID);
	userNickname = userDAO.getUsernickname(userID);
	boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;
	
	if(isRight == true)
	{
		userDAO.setUserEmailChecked(userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Confirmed');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
	}else
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Not available code');");
		script.println("location href = 'index.jsp'");
		script.println("</script>");
		script.close();
	}
	
%>