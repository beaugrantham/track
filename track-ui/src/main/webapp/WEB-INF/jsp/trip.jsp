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
	
					<!-- Map -->
					<div id="map"></div>

					<hr />

					<!-- Description -->
					<p><c:out value="${trip.description}" /></p>
					
					<c:if test="${not empty media}">
						<hr />
						
						<!-- Media -->
						<div class="card my-4">
							<h5 class="card-header">Media <c:if test="${fn:length(media) > 4}">(4 of <c:out value="${fn:length(media)}" />)</c:if></h5>
							<div class="card-body">
 								<div class="row">
									<c:forEach var="i" begin="0" end="${fn:length(media) > 4 ? 3 : fn:length(media) - 1}">
										<a href="<c:url value="/trips/${trip.slug}/media/${media[i].id}.jpg" />"
											data-toggle="lightbox" 
											data-gallery="media-gallery" 
											data-title="${media[i].annotation}" 
											data-footer='<span class="timezone-aware" data-reported-time="<fmt:formatDate value="${media[i].reportedTimestamp}" type="both" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" />" data-reported-timezone="${media[i].reportedTimezone}"></span> <span>@ ${media[i].reportedReverseGeocode}</span>' 
											class="col-sm-3">
											<img src="<c:url value="/trips/${trip.slug}/media/${media[i].id}.jpg" />" class="img-fluid img-thumbnail" style="margin-bottom: 15px;">
										</a>
									</c:forEach>
									
									<c:if test="${fn:length(media) > 4}">
										<c:forEach var="i" begin="4" end="${fn:length(media) - 1}">										
											<div 
												data-toggle="lightbox" 
												data-gallery="media-gallery" 
												data-title="${media[i].annotation}" 
												data-footer='<span class="timezone-aware" data-reported-time="<fmt:formatDate value="${media[i].reportedTimestamp}" type="both" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" />" data-reported-timezone="${media[i].reportedTimezone}"></span> <span>@ ${media[i].reportedReverseGeocode}</span>' 
												data-remote="<c:url value="/trips/${trip.slug}/media/${media[i].id}.jpg" />"></div>
										</c:forEach>
									</c:if>
								</div>
							</div>
							<c:if test="${fn:length(media) > 4}">
								<div class="card-footer">
									<a href="<c:url value="/trips/${trip.slug}/media" />" class="btn btn-primary float-right">View More</a>
								</div>
							</c:if>
						</div>
					</c:if>
				</div>
	
				<!-- Sidebar column -->
				<div class="col-md-4">

					<!-- History -->
					<div class="card my-4">
						<h5 class="card-header">Latest Positions (10)</h5>
						<div class="card-body">

							<c:choose>
								<c:when test="${empty points}">
									No positions reported yet
								</c:when>
		
								<c:otherwise>
									<ul class="list-group">
										<c:forEach var="i" begin="0" end="9">
											<li class="list-group-item">
												<c:out value="${points[i].reportedReverseGeocode}" /><br />
												<span class="timezone-aware"
													data-reported-time="<fmt:formatDate value="${points[i].reportedTimestamp}" type="both" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" />"
													data-reported-timezone="${points[i].reportedTimezone}">
												</span>
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
	
		<div id="media" data-toggle="lightbox"></div>
	
		<!-- Bootstrap core JS -->
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

		<!-- ekko-lightbox JS -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.min.js" integrity="sha256-Y1rRlwTzT5K5hhCBfAFWABD4cU13QGuRN6P5apfWzVs=" crossorigin="anonymous"></script>

		<!-- moment.js -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.1/moment.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.16/moment-timezone-with-data.min.js"></script>

		<!-- OpenLayers JS -->
		<script src="<c:url value="/resources/js/ol.js" />"></script>
		<script src="<c:url value="/resources/js/ol-popup.js" />"></script>

		<!-- Custom JS -->
		<script src="<c:url value="/resources/js/track.js" />"></script>
		
	    <script>
			$(document).ready(function() {
				window.app = {};
				var app = window.app;
				
				// Attribution
				var attribution = new ol.Attribution({
					html: '© <a href="https://www.mapbox.com/about/maps/">Mapbox</a> © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> <strong><a href="https://www.mapbox.com/map-feedback/" target="_blank">Improve this map</a></strong>'
				});
				
				// Streets source (default)
				var streetSource = new ol.source.XYZ({
					url: 'https://api.mapbox.com/styles/v1/beaugrantham/cjd6oanie7ay02rp4ogjyaxmj/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYmVhdWdyYW50aGFtIiwiYSI6InZHQlQwY00ifQ.eKpjZmiLKGfU0OAy2AuFzQ',
					attributions: [ attribution ]
				});
				streetSource.set('source-name', 'Street');	// custom property used for layer switching control
				
				// Satellite source (optional)
				var satelliteSource = new ol.source.XYZ({
					url: 'https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v9/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYmVhdWdyYW50aGFtIiwiYSI6InZHQlQwY00ifQ.eKpjZmiLKGfU0OAy2AuFzQ',
					attributions: [ attribution ]
				});
				satelliteSource.set('source-name', 'Satellite');	// custom property used for layer switching control
				
				// Base tile layer
				var baseTileLayer = new ol.layer.Tile({
					source: streetSource
				});
				
				// KML source
				var kmlSource = new ol.source.Vector({
					url: '<c:url value="/kml" />/<c:out value="${slug}" />/<c:out value="${timestamp}" />.kml',
					format: new ol.format.KML()
				});

				// Fit map to KML content
				kmlSource.on('change', function()  {
					view.fit(this.getExtent());
				});

				// KML layer
				var kmlLayer = new ol.layer.Vector({
					source: kmlSource
				});
				
				// Layer switching control
				app.SwitchLayerControl = function() {
					var button = document.createElement('button');
					button.innerHTML = satelliteSource.get('source-name');
					
					var this_ = this;
					var handleSwitchLayer = function() {
						button.innerHTML = baseTileLayer.getSource().get('source-name');
						
						if (baseTileLayer.getSource() === streetSource) {
							baseTileLayer.setSource(satelliteSource);
						} else {
							baseTileLayer.setSource(streetSource);
						}
					}
					
					button.addEventListener('click', handleSwitchLayer, false);
					
					var element = document.createElement('div');
					element.className = 'switch-layer ol-unselectable ol-control';
					element.appendChild(button);
					
					ol.control.Control.call(this, {
						element: element
					});					
				};
				
				ol.inherits(app.SwitchLayerControl, ol.control.Control);
				
				// Main view
				var view = new ol.View({
					center: ol.proj.fromLonLat([<c:out value="${trip.mapCenterLongitude}" />, <c:out value="${trip.mapCenterLatitude}" />]),
					zoom: <c:out value="${trip.mapZoom}" />
				});
				
				// Map
				var map = new ol.Map({
					target: 'map',
					view: view,
					layers: [
						baseTileLayer,
						<c:if test="${showWeather}">
					        new ol.layer.Tile({
								source: new ol.source.TileWMS({
									url: 'https://nowcoast.noaa.gov/arcgis/services/nowcoast/radar_meteo_imagery_nexrad_time/MapServer/WMSServer',
									params: {'LAYERS': '1'},
					            }),
					            opacity: 0.7
							}),
		                </c:if>
						kmlLayer
					],
					controls: ol.control.defaults({rotate: false}).extend([
						new ol.control.FullScreen(),
						new app.SwitchLayerControl()
					]),
					interactions: ol.interaction.defaults({altShiftDragRotate:false, pinchRotate:false})
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
						if (feature.get('media') !== undefined) {
						    $("#media")
						    	.attr("data-title", feature.get('description'))
					    		.attr("data-footer", '<span class="timezone-aware" data-reported-time="' + feature.get('datetime') + '" data-reported-timezone="' + feature.get('timezone') + '"></span> <span>@ ' + feature.get('location') + '</span>')
					    		.attr("data-remote", feature.get('media'))
					    		.ekkoLightbox({ "onContentLoaded" : function() { adjustTimezones(session['timezone']); } });
						} else {
							popup.show(evt.coordinate, '<div><p>' + feature.get('description') + '</p></div>');
						}
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
			
			// Enable ekko-lightbox
			$(document).on('click', '[data-toggle="lightbox"]', function(event) {
				event.preventDefault();
				$(this).ekkoLightbox({ "onContentLoaded" : function() { adjustTimezones(session['timezone']); } });
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
