<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="en">

	<head>	
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="Beau Grantham">
		
		<title>Beau Grantham | Track</title>
		
		<!-- Bootstrap core CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		
		<!-- Custom styles -->
		<link href="/resources/css/bs/screen.css" rel="stylesheet">
	</head>

	<body>
		<!-- Navigation -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
			<div class="container">
				<a class="navbar-brand" href="#">Beau Grantham | Track</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarResponsive" aria-controls="navbarResponsive"
					aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarResponsive">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item active"><a class="nav-link" href="<c:url value="/" />">Home<span class="sr-only">(current)</span></a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value="/trips" />">Trips</a></li>
					</ul>
				</div>
			</div>
		</nav>
	
		<!-- Page Content -->
		<div class="container">
	
			<!-- Portfolio Item Heading -->
			<h1 class="my-4">
				<c:out value="${trips[0].name}" />
			</h1>
	
			<!-- Portfolio Item Row -->
			<div class="row">
	
				<div class="col-md-8">
					<a href="<c:url value="/trips/${trips[0].slug}" />"><img class="img-fluid" src="<c:url value="/trips/${trips[0].slug}.jpg" />" alt=""></a>
				</div>
	
				<div class="col-md-4">
					<h3 class="my-3">Project Description</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam
						viverra euismod odio, gravida pellentesque urna varius vitae. Sed
						dui lorem, adipiscing in adipiscing et, interdum nec metus. Mauris
						ultricies, justo eu convallis placerat, felis enim.</p>
					<h3 class="my-3">Project Details</h3>
					<ul>
						<li>Lorem Ipsum</li>
						<li>Dolor Sit Amet</li>
					</ul>
					
					<a href="<c:url value="/trips" />" class="btn btn-primary">View More Trips</a>
				</div>
	
			</div>
			<!-- /.row -->
	
			<!-- Related Projects Row -->
			<h3 class="my-4">Related Trips</h3>

			<div class="row">
				<c:forEach var="i" begin="1" end="4">
					<div class="col-lg-3 col-md-6 mb-4">
						<div class="card">
							<img class="card-img-top" src="<c:url value="/trips/${trips[i].slug}.jpg" />" alt="">
							<div class="card-body">
								<h4 class="card-title"><c:out value="${trips[i].name}" /></h4>
								<p class="card-text"><c:out value="${trips[i].description}" /></p>
							</div>
							<div class="card-footer">
								<a href="#" class="btn btn-primary">View Trip</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- /.row -->
	
		</div>
		<!-- /.container -->
	
		<!-- Footer -->
		<footer class="py-5 bg-dark">
			<div class="container">
				<p class="m-0 text-center text-white">Copyright &copy; Beau Grantham (<a href="https://www.granth.am/">granth.am</a>) 2018</p>
			</div>
			<!-- /.container -->
		</footer>
	
		<!-- Bootstrap core JavaScript -->
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	</body>

</html>