<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	String userEmail = null;
	if(request.getParameter("userID") != null)
	{
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null)
	{
		userPassword = request.getParameter("userPassword");
	}
	if(request.getParameter("userEmail") != null)
	{
		userEmail = request.getParameter("userEmail");
	}
	
	if(userID == null || userPassword == null || userEmail == null || userID.equals("") || userEmail.equals("") || userPassword.equals(""))
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
	UserDTO userDTO = new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false);
	int result = userDAO.join(userDTO);	
	if( result == -1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Already existing ID');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else	{
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendAction.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>