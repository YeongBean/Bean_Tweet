<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="tweet.TweetDAO"%>
<%@ page import="likey.LikeyDTO"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="comment.CommentDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList" %>
<%
	String userID = null;
	if(session.getAttribute("userNickname") != null)
	{
		userID = (String)session.getAttribute("userNickname");
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
	int commentIndex = 0;
	int tweetIndex = 0;
	if(request.getParameter("commentIndex") != null){
		try{
			commentIndex = Integer.parseInt(request.getParameter("commentIndex"));
		}catch(Exception e){
			System.out.println("commentIndex error");
		}		
	}
	if(request.getParameter("tweetIndex") != null){
		try{
			tweetIndex = Integer.parseInt(request.getParameter("tweetIndex"));
		}catch(Exception e){
			System.out.println("tweetIndex error");
		}		
	}
	

	CommentDAO commentDAO = new CommentDAO();
	CommentDTO commentDTO = commentDAO.getCommentUserNickname(commentIndex);
	int result = commentDAO.delete(commentIndex);
	if(result == 1)
	{		
		TweetDAO twDAO = new TweetDAO();
		result = twDAO.deletecomment(tweetIndex);
		if(result == 1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'commentPage.jsp?tweetIndex=" + tweetIndex + "'");
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
		script.println("alert('This Comment is not your tweet');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>