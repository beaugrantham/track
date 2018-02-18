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
		
		<title>Beau Grantham | Track | <c:out value="${trip.name}" /></title>
		
		<!-- OpenLayers CSS -->
		<link rel="stylesheet" href="<c:url value="/resources/css/ol.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/ol-popup.css" />" />
		
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
						<li class="nav-item"><a class="nav-link" href="<c:url value="/" />">Home</a></li>
						<li class="nav-item active"><a class="nav-link" href="<c:url value="/trips" />">Trips<span class="sr-only">(current)</span></a></li>
					</ul>
				</div>
			</div>
		</nav>
	
		<!-- Page Content -->
		<div class="container">
	
			<div class="row">
	
				<!-- Post Content Column -->
				<div class="col-lg-8">
	
					<!-- Title -->
					<h1 class="mt-4"><c:out value="${trip.name}" /></h1>
	
					<!-- Date/Time -->
					<p><fmt:formatDate value="${trip.startDate}" /> - <fmt:formatDate value="${trip.endDate}" /></p>
	
					<hr>
	
					<!-- Preview Image -->
					<div id="map"></div>
	
					<hr>
	
					<!-- Post Content -->
					<p class="lead">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Ducimus, vero, obcaecati, aut, error quam
						sapiente nemo saepe quibusdam sit excepturi nam quia corporis
						eligendi eos magni recusandae laborum minus inventore?</p>
	
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut,
						tenetur natus doloremque laborum quos iste ipsum rerum obcaecati
						impedit odit illo dolorum ab tempora nihil dicta earum fugiat.
						Temporibus, voluptatibus.</p>
	
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
						Eos, doloribus, dolorem iusto blanditiis unde eius illum
						consequuntur neque dicta incidunt ullam ea hic porro optio ratione
						repellat perspiciatis. Enim, iure!</p>
	
					<blockquote class="blockquote">
						<p class="mb-0">Lorem ipsum dolor sit amet, consectetur
							adipiscing elit. Integer posuere erat a ante.</p>
						<footer class="blockquote-footer">
							Someone famous in <cite title="Source Title">Source Title</cite>
						</footer>
					</blockquote>
	
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
						Error, nostrum, aliquid, animi, ut quas placeat totam sunt tempora
						commodi nihil ullam alias modi dicta saepe minima ab quo voluptatem
						obcaecati?</p>
	
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
						Harum, dolor quis. Sunt, ut, explicabo, aliquam tenetur ratione
						tempore quidem voluptates cupiditate voluptas illo saepe quaerat
						numquam recusandae? Qui, necessitatibus, est!</p>
	
					<hr>
	
					<!-- Comments Form -->
					<div class="card my-4">
						<h5 class="card-header">Leave a Comment:</h5>
						<div class="card-body">
							<form>
								<div class="form-group">
									<textarea class="form-control" rows="3"></textarea>
								</div>
								<button type="submit" class="btn btn-primary">Submit</button>
							</form>
						</div>
					</div>
	
					<!-- Single Comment -->
					<div class="media mb-4">
						<img class="d-flex mr-3 rounded-circle"
							src="http://placehold.it/50x50" alt="">
						<div class="media-body">
							<h5 class="mt-0">Commenter Name</h5>
							Cras sit amet nibh libero, in gravida nulla. Nulla vel metus
							scelerisque ante sollicitudin. Cras purus odio, vestibulum in
							vulputate at, tempus viverra turpis. Fusce condimentum nunc ac
							nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
						</div>
					</div>
	
					<!-- Comment with nested comments -->
					<div class="media mb-4">
						<img class="d-flex mr-3 rounded-circle"
							src="http://placehold.it/50x50" alt="">
						<div class="media-body">
							<h5 class="mt-0">Commenter Name</h5>
							Cras sit amet nibh libero, in gravida nulla. Nulla vel metus
							scelerisque ante sollicitudin. Cras purus odio, vestibulum in
							vulputate at, tempus viverra turpis. Fusce condimentum nunc ac
							nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
	
							<div class="media mt-4">
								<img class="d-flex mr-3 rounded-circle"
									src="http://placehold.it/50x50" alt="">
								<div class="media-body">
									<h5 class="mt-0">Commenter Name</h5>
									Cras sit amet nibh libero, in gravida nulla. Nulla vel metus
									scelerisque ante sollicitudin. Cras purus odio, vestibulum in
									vulputate at, tempus viverra turpis. Fusce condimentum nunc ac
									nisi vulputate fringilla. Donec lacinia congue felis in
									faucibus.
								</div>
							</div>
	
							<div class="media mt-4">
								<img class="d-flex mr-3 rounded-circle"
									src="http://placehold.it/50x50" alt="">
								<div class="media-body">
									<h5 class="mt-0">Commenter Name</h5>
									Cras sit amet nibh libero, in gravida nulla. Nulla vel metus
									scelerisque ante sollicitudin. Cras purus odio, vestibulum in
									vulputate at, tempus viverra turpis. Fusce condimentum nunc ac
									nisi vulputate fringilla. Donec lacinia congue felis in
									faucibus.
								</div>
							</div>
	
						</div>
					</div>
	
				</div>
	
				<!-- Sidebar Widgets Column -->
				<div class="col-md-4">

					<!-- Search Widget -->
					<div class="card my-4">
						<h5 class="card-header">Latest Positions</h5>
						<div class="card-body">

							<c:choose>
								<c:when test="${empty points}">
									No positions reported yet
								</c:when>
		
								<c:otherwise>
									<ul class="list-group">
										<c:forEach var="i" begin="0" end="10">
											<li class="list-group-item">
												<c:out value="${points[10-i].reportedReverseGeocode}" /><br />
												<fmt:formatDate value="${points[10-i].reportedTimestamp}" type="both" />
											</li>
										</c:forEach>
									</ul>
								</c:otherwise>
							</c:choose>

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
	
		<!-- Bootstrap core JavaScript -->
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

		<!-- OpenLayers JS -->
		<script src="<c:url value="/resources/js/ol.js" />"></script>
		<script src="<c:url value="/resources/js/ol-popup.js" />"></script>
		
	    <script>
			$(document).ready(function() {				
	    		// Main view
				var view = new ol.View({
					center: ol.proj.fromLonLat([<c:out value="${trip.mapCenterLongitude}" />, <c:out value="${trip.mapCenterLatitude}" />]),
					zoom: <c:out value="${trip.mapZoom}" />
				});

				// KML source
				var source = new ol.source.Vector({
					url: '<c:url value="/kml" />/<c:out value="${slug}" />/<c:out value="${timestamp}" />.kml',
					format: new ol.format.KML()
				});

				// Fit map to KML content
				source.on('change', function() {
					view.fit(this.getExtent());
				});

				// KML layer
				var kml = new ol.layer.Vector({
					source: source
				});

				// Map
				var map = new ol.Map({
					target: 'map',
					view: view,
					layers: [
						new ol.layer.Tile({
							source: new ol.source.XYZ({
								url: 'https://api.mapbox.com/styles/v1/beaugrantham/cjd6oanie7ay02rp4ogjyaxmj/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYmVhdWdyYW50aGFtIiwiYSI6InZHQlQwY00ifQ.eKpjZmiLKGfU0OAy2AuFzQ',
								attributions: [
									new ol.Attribution({
										html: '© <a href="https://www.mapbox.com/about/maps/">Mapbox</a> © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> <strong><a href="https://www.mapbox.com/map-feedback/" target="_blank">Improve this map</a></strong>'
									})
								]
							})
						}),
						<c:if test="${showWeather}">
					        new ol.layer.Tile({
								source: new ol.source.TileWMS({
									url: 'https://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0q.cgi',
									params: {'LAYERS': 'nexrad-n0q-900913'},
					            }),
					            opacity: 0.7
							}),
		                </c:if>
						kml
					],
					controls: ol.control.defaults().extend([
						new ol.control.FullScreen()
					])
				});

				// Feature popup
				var popup = new ol.Overlay.Popup();
				map.addOverlay(popup);

				var displayFeatureInfo = function(evt) {
					var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature) {
						if (feature.get('description')) {
							return feature;
						}
					});

					if (feature) {
					    popup.show(evt.coordinate, '<div><p>' + feature.get('description') + '</p></div>');
					} else {
						popup.hide();
					}
				};

				// Display feature description when clicked
				map.on('singleclick', function(evt) {
					displayFeatureInfo(evt);
				});

				// Change cursor style for features with descriptions
				map.on('pointermove', function(e) {
					if (e.dragging) {
						popup.hide();
						return;
					}
					
					var pixel = map.getEventPixel(e.originalEvent);

					var hit = this.forEachFeatureAtPixel(pixel, function(feature, layer) {
						if (feature.get('description')) {
							return true;
						}
					}); 

					map.getTargetElement().style.cursor = hit ? 'pointer' : '';
				});				
			});
	    </script>		
	</body>

</html>