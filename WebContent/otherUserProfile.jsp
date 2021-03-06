<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="tweet.TweetDTO" %>
<%@ page import="tweet.TweetDAO" %>
<%@ page import="follow.FollowDTO" %>
<%@ page import="follow.FollowDAO" %>
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
	String otherUserNickname = null;
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
	if(request.getParameter("otherUserNickname") != null){
		otherUserNickname = request.getParameter("otherUserNickname");
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
			<div>
				<%= userNickname %>
			</div>
		</div>
	</nav>
	<div class="col-12 text-center mt-3"><font size="18px"><%= otherUserNickname%>'s page</font></div>
	<section class="container">
		<div class="row">
		<form method="get" action="./otherUserProfile.jsp" class="form-inline">
			<select name="otherUserNickname" class="form-control mx-1 mt-2">
				<option value= <%= otherUserNickname%>></option>
			</select>
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
		</form>
<%
	ArrayList<FollowDTO> followerList = new ArrayList<FollowDTO>();
	FollowDAO followDAOs = new FollowDAO();
	followerList = followDAOs.getMyFollower(otherUserNickname);
	boolean followed = false;
	FollowDTO follower = new FollowDTO();
	if(userNickname.equals(otherUserNickname) == false){
	if(followerList != null){
		for(int i = 0; i < followerList.size(); i++){
			follower = followerList.get(i);
			if(userNickname.equals(follower.getFollowFrom()))
				followed = true;
		}
		if(followed != true){
%>
		<a class="btn btn-secondary mx-1 mt-2" href="./followAction.jsp?otherUserNickname=<%= otherUserNickname%>">Follow</a>
		
<%
		}else{
%>
		<a class="btn btn-secondary mx-1 mt-2" href="./unfollowAction.jsp?otherUserNickname=<%= otherUserNickname%>">Unfollow</a>
<%
		}
	}
	}
%>
		</div>
		
		
		<div class="row">
		<div class="col-8">
<%		
	ArrayList<TweetDTO> tweetList = new ArrayList<TweetDTO>();
	TweetDAO tweetDAOs = new TweetDAO();
	tweetList = tweetDAOs.getMyList(tweetMood, searchType, search, otherUserNickname);
	
	ArrayList<FollowDTO> IsFollowList = new ArrayList<FollowDTO>();
	FollowDAO followDAO = new FollowDAO();
	FollowDTO followDTO = new FollowDTO();
	boolean CanISee = false;
	if(tweetList != null){
		for(int i = 0; i < tweetList.size(); i++){
			TweetDTO tweet = tweetList.get(i);
			IsFollowList = followDAO.getMyFollower(tweet.getUserID());
			CanISee = false;
			if(IsFollowList != null){
				for(int j = 0; j < IsFollowList.size(); j++){
					followDTO = IsFollowList.get(j);
					if((followDTO.getFollowFrom().equals(userNickname)) && (tweet.getTweetScope().equals("ToFollower"))){
						CanISee = true;
						break;
					}
				}
			}
			if(tweet.getTweetScope().equals("ToPublic")){
				CanISee = true;
			}
			
			if(CanISee == true){
%>
	
		<!-- card -->
	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left"><%= tweet.getTweetTitle()%> &nbsp&nbsp&nbsp&nbsp;<small><a href="./otherUserProfile.jsp?otherUserNickname=<%= tweet.getUserID() %>"><%= tweet.getUserID()%></a> (<%= tweet.getTweetScope() %>)</small></div>
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
<%
	if(tweet.getUserID().equals(otherUserNickname))
	{
%>			
					<a onclick="return confirm('Really want to delete?')" href="./deleteAction.jsp?tweetID=<%= tweet.getTweetIndex() %>">Delete</a>
<%
	}else{
%>
					<a data-toggle="modal" href="#reportModal">Report</a>
<%
	}
%>
					&nbsp&nbsp&nbsp&nbsp<a onclick="return confirm('Like this tweet?')" href="./likeAction.jsp?tweetID=<%= tweet.getTweetIndex() %>">Like</a>
				</div>
			</div>
		</div>
	</div>
<%
			}
		}
	}
%>
	</div>
	
	<div class="col-4">
	<div class="card bg-light mt-3">
		<label class="text-center mt-2">Followers</label>
		<div class="card-header bg-light">
			<div class="row">
<%		
	if(followerList != null)
		for(int i = 0; i < followerList.size(); i++){
			follower = followerList.get(i);
%>
			<!-- follower list -->
				<div class="card-header bg-light col-12 text-center"><a  href="./otherUserProfile.jsp?otherUserNickname=<%= follower.getFollowFrom() %>"><%= follower.getFollowFrom()%></a></div>
<%
		}
%>
			</div>
		</div>
	</div>
	
	<div class="card bg-light mt-3">
		<label class="text-center mt-2">Followings</label>
		<div class="card-header bg-light">
			<div class="row">
<%		
	ArrayList<FollowDTO> followingList = new ArrayList<FollowDTO>();
	FollowDAO followDAOss = new FollowDAO();
	followingList = followDAOss.getMyFollowing(otherUserNickname);
	if(followingList != null)
		for(int i = 0; i < followingList.size(); i++){
			FollowDTO following = followingList.get(i);
%>
			<!-- follower list -->
				<div class="card-header bg-light col-12 text-center"><a  href="./otherUserProfile.jsp?otherUserNickname=<%= following.getFollowTo() %>"><%= following.getFollowTo()%></a></div>
<%
		}
%>
			</div>
		</div>
	</div>
	</div>
	</div>
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