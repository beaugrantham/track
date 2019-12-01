<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta name="description" content="">
		<meta name="author" content="Beau Grantham">
		
		<title>Beau Grantham | Track | <c:out value="${trip.name}" /></title>
		
		<!-- OpenLayers CSS -->
		<link rel="stylesheet" href="<c:url value="/resources/css/ol.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/ol-popup.css" />" />
		
		<style>
			body {
				margin: 0px;
				height: 100%;
			}
			#map {
				width: 100%;
				height: 100vh;
				color: red;
			}
		</style>
	</head>
	
	<body>
		<div id="map"></div>

		<!-- Core JavaScript -->
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>

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
					url: '<c:url value="/kml" />/<c:out value="${slug}" />/<c:out value="${timestamp}" />.kml?media=false',
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
								url: 'https://api.mapbox.com/styles/v1/beaugrantham/cjd6oanie7ay02rp4ogjyaxmj/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYmVhdWdyYW50aGFtIiwiYSI6InZHQlQwY00ifQ.eKpjZmiLKGfU0OAy2AuFzQ'
							})
						}),
						kml
					],
					controls: ol.control.defaults({
						attribution: false,
						zoom: false
					})
				});
			});
	    </script>
	</body>

</html>