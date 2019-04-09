<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	if(request.getParameter("userID") != null)
	{
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null)
	{
		userPassword = request.getParameter("userPassword");
	}

	
	if(userID == null || userPassword == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('There are missing components');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, userPassword);
	if( result == 1) //log in success
	{
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}else if (result == 0){ //wrong password
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Wrong password!');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else if (result == -1){ //wrong password
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('No user information');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else if (result == -2){ //wrong password
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Database error');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
%>