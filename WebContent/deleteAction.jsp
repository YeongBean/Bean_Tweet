<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="tweet.TweetDAO"%>
<%@ page import="likey.LikeyDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%
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
	if(userID.equals(tweetDAO.getUserID(tweetID)))
	{
		int result = new TweetDAO().delete(tweetID);
		if(result == 1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Tweet deleted');");
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
		script.println("alert('This tweet is not your tweet');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>