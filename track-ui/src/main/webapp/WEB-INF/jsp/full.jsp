<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page session="false" %>

<t:site>
	<jsp:attribute name="title">Beau Grantham | Track | <c:out value="${trip.name}" /></jsp:attribute>

	<jsp:attribute name="header">
	    <style>
	        html { height: 100% }
	        body { height: 100%; margin: 0; padding: 0 }
	        #map { height: 100% }
	    </style>
    
		<link rel="stylesheet" href="<c:url value="/resources/css/ol.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/ol-popup.css" />" />
		<script src="<c:url value="/resources/js/ol.js" />"></script>
		<script src="<c:url value="/resources/js/ol-popup.js" />"></script>
	</jsp:attribute>

	<jsp:body>
        <div id="map" style="width:100%; height:100%"></div>

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
								url: 'https://api.mapbox.com/styles/v1/beaugrantham/cjd6oanie7ay02rp4ogjyaxmj/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYmVhdWdyYW50aGFtIiwiYSI6InZHQlQwY00ifQ.eKpjZmiLKGfU0OAy2AuFzQ'
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
					]
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
	</jsp:body>
</t:site>
