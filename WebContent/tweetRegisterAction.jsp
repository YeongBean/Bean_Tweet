<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="tweet.TweetDTO"%>
<%@ page import="tweet.TweetDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please sign in first');");
		script.println("location.href = 'loginPage.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String tweetTitle = null;
	String tweetContent = null;
	String tweetMood = null;
	
	String userPassword = null;
	String userEmail = null;
	if(request.getParameter("tweetTitle") != null)
	{
		tweetTitle = request.getParameter("tweetTitle");
	}
	if(request.getParameter("tweetContent") != null)
	{
		tweetContent = request.getParameter("tweetContent");
	}
	if(request.getParameter("tweetMood") != null)
	{
		tweetMood = request.getParameter("tweetMood");
	}
	
	if(tweetTitle == null || tweetContent == null || tweetMood == null || tweetTitle.equals("") || tweetContent.equals(""))
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('There are missing components');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	TweetDAO tweetDAO = new TweetDAO();
	TweetDTO tweetDTO = new TweetDTO(0, userID, tweetTitle, tweetContent, tweetMood, 0);
	int result = tweetDAO.write(tweetDTO);
	if( result == -1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Failed to post...');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else	{
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>