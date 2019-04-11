<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="tweet.TweetDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%!
	public static String getClientIP(HttpServletRequest request)
	{
		String ip = request.getHeader("X-FORWARDED-FOR");
		if(ip == null || ip.length() == 0){
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0){
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0){
			ip = request.getRemoteAddr();
		}
		return ip;
	}
%>
<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String)session.getAttribute("userID");
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

	request.setCharacterEncoding("UTF-8");
	String tweetID = null;
	if(request.getParameter("tweetID") != null)
	{
		tweetID = request.getParameter("tweetID");
	}
	TweetDAO tweetDAO = new TweetDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	int result = likeyDAO.like(userID, Integer.parseInt(tweetID), getClientIP(request));
	if(result == 1)
	{
		result = tweetDAO.like(tweetID);
		if(result == 1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Like!');");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
			script.close();
			return;
		}else
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Database Error occured');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}else
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Can not like twice');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>