<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String)session.getAttribute("userID");
	}
	if(userID != null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Already sign in now');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
}
	String userPassword = null;
	String userEmail = null;
	String userProfileImg = null;
	String userNickname = null;
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
	if(request.getParameter("userNickname") != null)
	{
		userNickname = request.getParameter("userNickname");
	}
	
	if(userID == null || userPassword == null || userEmail == null || userNickname == null|| userID.equals("") || userEmail.equals("") || userPassword.equals("") || userNickname.equals(""))
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
	UserDTO userDTO = new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false, null, userNickname);
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