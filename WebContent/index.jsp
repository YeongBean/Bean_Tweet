<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>LittleBEAN Tweet</title>
	<!-- add bootstrap,custom CSS -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
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
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle mt=10" id="dropdown" data-toggle="dropdown">Member Menu</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
						<a class="dropdown-item" href="loginPage.jsp">Sign in</a>
						<a class="dropdown-item" href="joinPage.jsp">Sign up</a>
						<a class="dropdown-item" href="logoutPage.jsp">Sign out</a>
					</div>
				</li>								
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search" plceholder="Enter some contents" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="tweetDivide" class="form-control mx-1 mt-2">
				<option value="All">All</option>
				<option value="All">Happy</option>
				<option value="All">Sad</option>
				<option value="All">Angry</option>
				<option value="All">Normal</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="Enter contents">
			<button class="btn btn-primary mx-1 mt-2" type="submit">Search</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">Post</a>
			<a class="btn btn-secondary mx-1 mt-2" data-toggle="modal" href="#reportModal">Report</a>
		</form>
		
		<!-- card -->
	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left">This is First tweet&nbsp&nbsp&nbsp&nbsp;<small>LittleBean</small></div>
				<div class="col-4 text-right">
					Mood : <span style="color: blue;">Happy</span>
				</div>
			</div>
		</div>
		<div class="card-body">
			<p class="card-text">This is example tweet content. I dont know what to write</p>
			<div class="row">
				<div class="col-9 text-left">
					<span style="color:green;">Like: 1</span>
				</div>
				<div class="col-3 text-right">					
					<a onclick="return confirm('Really want to delete?')" href="./deleteAction.jsp?evaluationID=">Delete</a>
					&nbsp&nbsp&nbsp&nbsp<a onclick="return confirm('Like this tweet?')" href="./likeAction.jsp?evaluationID=">Like</a>
				</div>
			</div>
		</div>
	</div>
	

	</section>
	
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
								<input type="text" name="tweetName" class = "form-control" maxlength="40">								
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
							<label>Mood</label>
							</div>
							<div class="form-group col-sm-8">
							<select name="mood" class="form-control">
								<option value="Happy">Happy</option>
								<option value="Sad">Sad</option>
								<option value="Angry">Angry</option>
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
								<input type="text" name="reportName" class = "form-control" maxlength="40">								
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