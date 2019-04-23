<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="tweet.TweetDAO"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="comment.CommentDTO"%>
<%@ page import="likey.LikeyDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	String userID = null;
	String userNickname = null;
	if(session.getAttribute("userNickname") != null)
	{
		userID = (String)session.getAttribute("userNickname");
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

	request.setCharacterEncoding("UTF-8");
	
	String commentContent = null;
	int tweetIndex = 0;
	if(request.getParameter("commentBox") != null)
	{
		commentContent = request.getParameter("commentBox"); //comment content
	}
	if(request.getParameter("tweetIndex") != null){
		try{
			tweetIndex = Integer.parseInt(request.getParameter("tweetIndex"));
		}catch(Exception e){
			System.out.println("tweetIndex error");
		}		
	}
	
	if(commentContent == null || commentContent.equals(""))
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please enter comment');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else
	{
		CommentDAO commentDAO = new CommentDAO();
		CommentDTO commentDTO = new CommentDTO(0,tweetIndex,userNickname,commentContent);
		int result = commentDAO.addComment(commentDTO);
		if(result == -1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Error occured');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}else{
			TweetDAO tweetDAO = new TweetDAO();
			result = tweetDAO.comment(tweetIndex);
			if(result == -1)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Error occured');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
				return;
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'commentPage.jsp?tweetIndex=" + tweetIndex + "'");
				script.println("</script>");
				script.close();
				return; //successed
			}			
		}		
	}
%>