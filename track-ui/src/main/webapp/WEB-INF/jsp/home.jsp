<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
				<a class="navbar-brand" href="<c:url value="/" />">Beau Grantham | Track</a>
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
			<h1 class="my-4"></h1>

			<!-- Portfolio Item Row -->
			<div class="row">
	
				<div class="col-md-8">
					<img class="img-fluid rounded" src="<c:url value="/trips/${trips[0].slug}.png" />" alt="" />
				</div>
	
				<div class="col-md-4">
					<h2 class="my-3"><c:out value="${trips[0].name}" /></h2>
					<p><c:out value="${trips[0].description}" /></p>
					<a href="<c:url value="/trips/${trips[0].slug}" />" class="btn btn-primary float-left">View Trip</a>
				</div>
	
			</div>
			<!-- /.row -->
	
			<!-- Related Projects Row -->
			<h3 class="my-4">Related Trips</h3>

			<div class="row">
				<c:forEach var="i" begin="1" end="4">
					<div class="col-lg-3 col-md-6 mb-4">
						<div class="card">
							<img class="card-img-top" src="<c:url value="/trips/${trips[i].slug}.png" />" alt="">
							<div class="card-body">
								<h5 class="card-title"><c:out value="${trips[i].name}" /></h5>
								<p class="card-text"><c:out value="${trips[i].description}" /></p>
							</div>
							<div class="card-footer">
								<a href="<c:url value="/trips/${trips[i].slug}" />" class="btn btn-primary">View Trip</a>
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

		<script>
		    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		
		    ga('create', 'UA-42864823-2', 'granth.am');
		    ga('send', 'pageview');
		</script>
	</body>

</html>