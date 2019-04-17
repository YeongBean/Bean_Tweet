<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="tweet.TweetDTO" %>
<%@ page import="tweet.TweetDAO" %>
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
	String tweetMood = "All";
	String searchType = "Current";
	String search = "";
	int pagenum = 0;
	if(request.getParameter("tweetMood") != null){
		tweetMood = request.getParameter("tweetMood");
	}
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	if(request.getParameter("pagenum") != null){
		try{
			pagenum = Integer.parseInt(request.getParameter("pagenum"));
		}catch(Exception e){
			System.out.println("Search page error");
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
	<div class="col-12 text-center mt-3"><font size="18px">MAIN PAGE</font></div>
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline">
			<select name="tweetMood" class="form-control mx-1 mt-2">
				<option value="All">All</option>
				<option value="Happy" <% if(tweetMood.equals("Happy")) out.println("selected"); %>>Happy</option>
				<option value="Sad" <% if(tweetMood.equals("Sad")) out.println("selected"); %>>Sad</option>
				<option value="Angry" <% if(tweetMood.equals("Angry")) out.println("selected"); %>>Angry</option>
				<option value="Normal" <% if(tweetMood.equals("Normal")) out.println("selected"); %>>Normal</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="Current" <% if(searchType.equals("Current")) out.println("selected"); %>>Current</option>
				<option value="Like" <% if(searchType.equals("Like")) out.println("selected"); %>>Like</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="Enter contents">
			<button class="btn btn-primary mx-1 mt-2" type="submit">Search</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">Post</a>
			<a class="btn btn-secondary mx-1 mt-2" data-toggle="modal" href="#reportModal">Report</a>
		</form>

	
		
<%		
	ArrayList<TweetDTO> tweetList = new ArrayList<TweetDTO>();
	TweetDAO tweetDAOs = new TweetDAO();
	tweetList = tweetDAOs.getList(tweetMood, searchType, search, pagenum);
	if(tweetList != null)
		for(int i = 0; i < tweetList.size(); i++){
			TweetDTO tweet = tweetList.get(i);
%>
	
		<!-- card -->
	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left"><%= tweet.getTweetTitle()%> &nbsp&nbsp&nbsp&nbsp;<small><a href="./otherUserProfile.jsp?otherUserNickname=<%= tweet.getUserID() %>"><%= tweet.getUserID()%></a></small></div>
				<div class="col-4 text-right">
					Mood : <span style="color: blue;"><%= tweet.getTweetMood() %></span>
				</div>
			</div>
		</div>
		<div class="card-body">
			<p class="card-text"><%= tweet.getTweetContent()%></p>
			<div class="row">
				<div class="col-9 text-left">
					<span style="color:green;">Like:<%= tweet.getLikeCount()%></span>
					&nbsp&nbsp&nbsp&nbsp<a href="./commentPage.jsp?tweetTitle=<%= tweet.getTweetTitle() %>&tweetNickname=<%= tweet.getUserID() %>&tweetcontent=<%= tweet.getTweetContent() %>&tweetMood=<%= tweet.getTweetMood() %>&like=<%= tweet.getLikeCount() %>&commentCount=<%= tweet.getCommentCount() %>&tweetIndex=<%= tweet.getTweetIndex() %>">Comment: <%= tweet.getCommentCount()%></a>
				</div>
				<div class="col-3 text-right">					
					<a onclick="return confirm('Really want to delete?')" href="./deleteAction.jsp?tweetID=<%= tweet.getTweetIndex() %>">Delete</a>
					&nbsp&nbsp&nbsp&nbsp<a onclick="return confirm('Like this tweet?')" href="./likeAction.jsp?tweetID=<%= tweet.getTweetIndex() %>">Like</a>
				</div>
			</div>
		</div>
	</div>
<%
		}
%>
	</section>
	<ul class="pagination justify-content-center mt-3">
		<li class = "page-item">
<%
	if(pagenum <= 0){		
%>
	<a class="page-link disabled">back</a>
<%
	}else{
%>
	<a class="page-link" href="./index.jsp?tweetMood=<% URLEncoder.encode(tweetMood, "UTF-8"); %>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pagenum=
	<%= pagenum-1 %>">back</a>
<%
	}
%>
		</li>
		<li class = "page-item">
<%
	if(tweetList.size() < (5 * pagenum)+5){		
%>
	<a class="page-link disabled">next</a>
<%
	}else{
%>
	<a class="page-link" href="./index.jsp?tweetMood=<% URLEncoder.encode(tweetMood, "UTF-8"); %>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pagenum=
	<%= pagenum+1 %>">next</a>
<%
	}
%>
		</li>
		
		
		<li class = "page-item">
<%
	if(tweetList.size() < (5 * pagenum)+5){		
%>
	<a class="page-link disabled" onclick = "Load_End();">Load More</a>
<%
	}else{
%>
	<a class="page-link" onclick="Load_More();">Load More</a>
<%
	}
%>
		</li>		
	</ul>
	<!-- modal -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				<!-- title -->
					<h5 class="modal-title" id="modal">Post tweet</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				<!-- content details -->
					<form action="./tweetRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-12">
								<label>Title</label>
								<input type="text" name="tweetTitle" class = "form-control" maxlength="40">								
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
							<label>Mood</label>
							</div>
							<div class="form-group col-sm-8">
							<select name="tweetMood" class="form-control">
								<option value="Happy" >Happy</option>
								<option value="Sad">Sad</option>
								<option value="Angry" selected>Angry</option>
								<option value="Normal">Normal</option>
							</select>
							</div>
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea name="tweetContent" class="form-control" maxlength="300"  style="height: 180px;" placeholder="Can type 300 words"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Exit</button>
							<button type="submit" class="btn btn-primary">Post</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				<!-- title -->
					<h5 class="modal-title" id="modal">Report tweet</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				<!-- content details -->
					<form action="./reportAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-12">
								<label>Title</label>
								<input type="text" name="reportTitle" class = "form-control" maxlength="40">								
							</div>
						</div>						
						<div class="form-group">
							<label>Report detail</label>
							<textarea name="reportContent" class="form-control" maxlength="300"  style="height: 180px;" placeholder="Can type 300 words"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Exit</button>
							<button type="submit" class="btn btn-danger">Report</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2019 LittleBEAN All Rights Reserved.
	</footer>
	<!-- add jQuery,popper,bootstrap java script -->
	<script src="./css/jQuery.min.js"></script>
	<script src="./js/popper.js"></script>
	<script src="./js/bootstrap.min.js"></script>	
</body>
</html>