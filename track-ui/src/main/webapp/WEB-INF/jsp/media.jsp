<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="Beau Grantham">
		
		<title>Beau Grantham | Track | <c:out value="${trip.name}" /></title>
		
		<!-- OpenLayers CSS -->
		<link rel="stylesheet" href="<c:url value="/resources/css/ol.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/ol-popup.css" />" />
		
		<!-- Bootstrap core CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		
		<!-- ekko-lightbox CSS-->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.css" integrity="sha256-HAaDW5o2+LelybUhfuk0Zh2Vdk8Y2W2UeKmbaXhalfA=" crossorigin="anonymous" />
		
		<!-- Custom styles -->
		<link href="/resources/css/screen.css" rel="stylesheet">
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
						<li class="nav-item"><a class="nav-link" href="<c:url value="/" />">Home</a></li>
						<li class="nav-item active"><a class="nav-link" href="<c:url value="/trips" />">Trips<span class="sr-only">(current)</span></a></li>
					</ul>
				</div>
			</div>
		</nav>
	
		<!-- Page content -->
		<div class="container">
	
			<div class="row">
	
				<!-- Main column -->
				<div class="col-lg-8">
	
					<!-- Title -->
					<h1 class="mt-4"><c:out value="${trip.name}" /></h1>
	
					<!-- Dates -->
					<p><fmt:formatDate value="${trip.startDate}" /> - <fmt:formatDate value="${trip.endDate}" /></p>
	
					<hr />

					<!-- Description -->
					<p><c:out value="${trip.description}" /></p>

					<hr />

					<!-- Media -->
					<div class="card my-4">
						<h5 class="card-header">Media</h5>
						<div class="card-body">
							<c:forEach var="i" begin="0" end="${fn:length(media) - 1}" varStatus="status">
								<c:if test="${status.index % 4 eq 0}">
									<div class="row">
								</c:if>
									<a href="<c:url value="/trips/${trip.slug}/media/${media[i].id}.jpg" />"
										data-toggle="lightbox" 
										data-gallery="media-gallery" 
										data-title="${media[i].annotation}" 
										data-footer="<fmt:formatDate value="${media[i].reportedTimestamp}" type="both" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" /> @ ${media[i].reportedReverseGeocode}" 
										class="col-sm-3">
										<img src="<c:url value="/trips/${trip.slug}/media/${media[i].id}.jpg" />" class="img-fluid rounded" style="margin-bottom: 15px;">
									</a>
								<c:if test="${status.index % 4 eq 3 or status.last}">
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>

				</div>
	
				<!-- Sidebar column -->
				<div class="col-md-4">

					<!-- History -->
					<div class="card my-4">
						<h5 class="card-header">Map</h5>
						<div class="card-body">
							<a href="/trips/${trip.slug}">
								<img class="img-fluid rounded" src="<c:url value="/trips/${trip.slug}.png" />" alt="" />
							</a>
						</div>
						<div class="card-footer">
							<a href="<c:url value="/trips/${trip.slug}" />" class="btn btn-primary float-right">View Trip</a>
						</div>
					</div>

				</div>
	
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
	
		<div id="media" data-toggle="lightbox"></div>
	
		<!-- Bootstrap core JS -->
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

		<!-- ekko-lightbox JS -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.min.js" integrity="sha256-Y1rRlwTzT5K5hhCBfAFWABD4cU13QGuRN6P5apfWzVs=" crossorigin="anonymous"></script>
		
	    <script>
			$(document).ready(function() {
				// Convert ISO8601 UTC date/time to local date/time
				var localizeDate = function(utc) {
					var date = new Date(utc);
					return date.toLocaleString("en-US", { month: 'short', day: 'numeric', year: 'numeric', hour: 'numeric', minute: '2-digit', second: '2-digit' });
				};
							
				// Convert date/time to local (media)
				$('*[data-footer]').filter(function() {
					return $(this).attr('data-footer').match(/^\S+T\S+Z\s@\s.*$/);
				}).each(function(e) {
					var text = $(this).attr('data-footer').split('@', 2);
					$(this).attr('data-footer', localizeDate(text[0].trim()) + ' @ ' + text[1].trim());
				});
				
			});
			
			// Enable ekko-lightbox
			$(document).on('click', '[data-toggle="lightbox"]', function(event) {
				event.preventDefault();
				$(this).ekkoLightbox();
			});
	    </script>

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