<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page session="false" %>

<t:site>
	<jsp:attribute name="title">Beau Grantham | Track | <c:out value="${trip.name}" /></jsp:attribute>

	<jsp:attribute name="header">
		<link rel="stylesheet" href="<c:url value="/resources/css/ol.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/ol-popup.css" />" />
		<script src="<c:url value="/resources/js/ol.js" />"></script>
		<script src="<c:url value="/resources/js/ol-popup.js" />"></script>
	</jsp:attribute>

	<jsp:body>
		<div id="wrapper" class="container_12 clearfix">		
			
			<!-- Text Logo -->
			<h1 id="logo" class="grid_4"><a href="<c:url value="/" />" style="color: #000000;">track</a></h1>
			
			<!-- Navigation Menu -->
			<ul id="navigation" class="grid_8">
				<li><a href="<c:url value="/trips" />" class="current"><span class="meta">Past Adventures</span><br />Trips</a></li>
				<li><a href="<c:url value="/" />"><span class="meta">Homepage&nbsp;&nbsp;</span><br />Home</a></li>
			</ul>
			
			<div class="hr grid_12 clearfix">&nbsp;</div>
				
			<!-- Caption Line -->
			<h2 class="grid_12 caption clearfix">Past trips and distant adventures.</h2>
			
			<div class="hr grid_12 clearfix">&nbsp;</div>
			
			<!-- Column 1 /Content -->
			<div class="grid_8">
				
				<!-- Blog Post -->
				<div class="post">
					<!-- Post Title -->
                    <div style="float: left;">
    					<h3 class="title"><c:out value="${trip.name}" /></h3>
                    </div>
                    <div style="float: right; padding-top: 8px;">
                        <h4><a href="<c:url value="/trips/${slug}/popout" />" target="_blank">large map</a></h4>
                    </div>
                    <div class="clearfix">&nbsp;</div>

					<!-- Post Data -->
					<p class="sub">
	                    <fmt:formatDate value="${trip.startDate}" /> - <fmt:formatDate value="${trip.endDate}" /> &bull; 
	                    <c:out value="${trip.keywords}" /> <!--<a href="#">1 Comment</a>-->
	                </p>
					<div class="hr dotted clearfix">&nbsp;</div>
					<!-- Post Image -->

					<div id="map" class="thumb" style="margin-bottom: 15px;"></div>
	                <!-- <img class="thumb" alt="" src="images/610x150.gif" /> -->
					<!-- Post Content -->
	                <p></p>
	                <!--
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. <b>Mauris vel porta erat.</b> Quisque sit amet risus at odio pellentesque sollicitudin. Proin suscipit molestie facilisis. Aenean vel massa magna. Proin nec lacinia augue. Mauris venenatis libero nec odio viverra consequat. In hac habitasse platea dictumst.</p>
					<p>Cras vestibulum lorem et dui mollis sed posuere leo semper. Integer ac ultrices neque. Cras lacinia orci a augue tempor egestas. Sed cursus, sem ut vehicula vehicula, ipsum est mattis justo, at volutpat nibh arcu sit amet risus. Vestibulum tincidunt, eros ut commodo laoreet, arcu eros ultrices nibh, ac auctor est dui vel nibh.</p>
	            	-->
				</div>
	
	            <!--
				<div class="hr clearfix">&nbsp;</div>
	            -->
				
				<!-- Blog Navigation -->
	            <!--
				<p class="clearfix">
					<a href="#" class="button float">&lt;&lt; Previous Posts</a>
					<a href="#" class="button float right">Newer Posts >></a>
				</p>
	            -->
			</div>
			
			<!-- Column 2 / Sidebar -->
			<div class="grid_4">
			
				<h4>Latest positions</h4>
				<ul class="sidebar">

					<c:choose>
						<c:when test="${empty points}">
							No positions reported yet
						</c:when>

						<c:otherwise>
							<c:forEach var="i" begin="0" end="10">
								<li>
									<c:out value="${points[10-i].reportedReverseGeocode}" /><br />
									<fmt:formatDate value="${points[10-i].reportedTimestamp}" type="both" /><br />
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>

				</ul>
				
			</div>
			
			<div class="hr grid_12 clearfix">&nbsp;</div>
			
			<!-- Footer -->
			<p class="grid_12 footer clearfix">
				<span class="float"><b>&copy; Copyright</b> <a href="http://www.granth.am/">Beau Grantham (granth.am)</a></span>
				<a class="float right" href="#">top</a>
			</p>
			
		</div><!--end wrapper-->
	    
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