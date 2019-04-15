<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="tweet.TweetDTO" %>
<%@ page import="tweet.TweetDAO" %>
<%@ page import="comment.CommentDTO" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>LittleBEAN Tweet</title>
	<!-- add bootstrap,custom CSS -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
	<script>
		function Load_More() {
			alert("Load 5 more tweets");
			
		}
		function Load_End() {
			alert("End of tweets");
		}
	</script>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String tweetTitle = null;
	String tweetNickname = null;
	String tweetcontent = null;
	String tweetMood = null;
	int like = 0;
	int tweetIndex = 0;
	int commentCount = 0;
	if(request.getParameter("tweetTitle") != null){
		tweetTitle = request.getParameter("tweetTitle");
	}
	if(request.getParameter("tweetNickname") != null){
		tweetNickname = request.getParameter("tweetNickname");
	}
	if(request.getParameter("tweetcontent") != null){
		tweetcontent = request.getParameter("tweetcontent");
	}
	if(request.getParameter("tweetMood") != null){
		tweetMood = request.getParameter("tweetMood");
	}
	if(request.getParameter("like") != null){
		try{
			like = Integer.parseInt(request.getParameter("like"));
		}catch(Exception e){
			System.out.println("Search page error");
		}		
	}
	if(request.getParameter("tweetIndex") != null){
		try{
			tweetIndex = Integer.parseInt(request.getParameter("tweetIndex"));
		}catch(Exception e){
			System.out.println("tweetIndex error");
		}		
	}
	if(request.getParameter("commentCount") != null){
		try{
			commentCount = Integer.parseInt(request.getParameter("commentCount"));
		}catch(Exception e){
			System.out.println("tweetIndex error");
		}		
	}
	
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
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
 %>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">LittleBEAN Tweet</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">Main</a>					
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="hotPage.jsp">Hot</a>					
				</li>		
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle mt=10" id="dropdown" data-toggle="dropdown">Member Menu</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
<%
	if(userID == null)
	{
%>
					
						<a class="dropdown-item" href="loginPage.jsp">Sign in</a>
						<a class="dropdown-item" href="joinPage.jsp">Sign up</a>
<%
	} else {
%>
						
						<a class="dropdown-item" href="userLogoutAction.jsp">Sign out</a>
						<a class="dropdown-item" href="profile.jsp">Your Profile</a>
<%
	}
%>
					</div>
				</li>								
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="Enter some contents" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
	<section class="container">
		<!-- card -->
	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left"><%=tweetTitle %> &nbsp&nbsp&nbsp&nbsp;<small><%= tweetNickname%></small></div>
				<div class="col-4 text-right">
					Mood : <span style="color: blue;"><%= tweetMood%></span>
				</div>
			</div>
		</div>
		<div class="card-body">
			<p class="card-text"><%= tweetcontent%></p>
			<div class="row">
				<div class="col-9 text-left">
					<span style="color:green;">Like: <%=like %></span>
					&nbsp&nbsp&nbsp&nbsp<a>Comment: <%= commentCount%></a>
				</div>
				<div class="col-3 text-right">					
					<a onclick="return confirm('Really want to delete?')" href="./deleteAction.jsp?tweetID=<%= tweetIndex %>">Delete</a>
					&nbsp&nbsp&nbsp&nbsp<a onclick="return confirm('Like this tweet?')" href="./likeAction.jsp?tweetID=<%= tweetIndex %>">Like</a>
				</div>
			</div>
		</div>
	</div>
		<!-- card end -->
		
	<div class="card bg-light mt-1 col-12">
		<form action="./commentAction.jsp?tweetIndex=<%= tweetIndex%>" method="post" class="form-inline my-2 my-lg-0 row">
			<div class="form-inline my-2 my-lg-0 col">
				<input type="text" name="commentBox" class="form-control mr-sm-2 col-10" placeholder="Enter <%= userNickname%>'s thoughts">
				<button class="btn btn-primary my-2 my-sm-0" type="submit">Comment</button>	
			</div>				
		</form>
	</div>
		<!-- comment list -->
		
	<%		
	ArrayList<CommentDTO> commentList = new ArrayList<CommentDTO>();
	CommentDAO commentDAOs = new CommentDAO();
	commentList = commentDAOs.getCommentList(tweetIndex);
	if(commentList != null)
		for(int i = 0; i < commentList.size(); i++){
			CommentDTO comm = commentList.get(i);
%>
	
		<!-- card -->
	<div class="card bg-light mt-1 col-12">
		<form action="./commentAction.jsp?tweetIndex=<%= tweetIndex%>" method="post" class="form-inline my-2 my-lg-0 row">
			<div class="form-inline my-2 my-lg-0 col">
				<div class="col-3 text-center">
					<a><%= comm.getCommentUserID() %></a>
				</div>
				<div class="col-9 text-left">					
					<a><%= comm.getCommentContent() %></a>
				</div>
			</div>				
		</form>
	</div>
<%
		}
%>
	
		<!--  comment list end -->
	</section>
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2019 LittleBEAN All Rights Reserved.
	</footer>
	<!-- add jQuery,popper,bootstrap java script -->
	<script src="./css/jQuery.min.js"></script>
	<script src="./js/popper.js"></script>
	<script src="./js/bootstrap.min.js"></script>	
</body>
</html>