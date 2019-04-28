<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="follow.FollowDTO"%>
<%@ page import="follow.FollowDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
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
		script.println("alert('Please sign in first');");
		script.println("location.href = 'loginPage.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String otherUserNickname = null;
	
	if(request.getParameter("otherUserNickname") != null)
	{
		otherUserNickname = request.getParameter("otherUserNickname");
	}
	if(otherUserNickname == null || otherUserNickname.equals(""))
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Error occured!');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	FollowDAO followDAO = new FollowDAO();
	FollowDTO followDTO = new FollowDTO(userNickname, otherUserNickname);
	int result = followDAO.getFollowTo(followDTO);
	if( result == -1) //if i following this user
	{
		result = followDAO.unfollow(followDTO);
		if(result != -1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Unfollowed');");
			script.println("location.href = 'otherUserProfile.jsp?otherUserNickname=" + otherUserNickname + "'");
			script.println("</script>");
			script.close();
			return;
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Unfollowing failed..');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}				
	}else	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('You are not following');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
%>