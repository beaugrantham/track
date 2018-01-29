<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page session="false" %>

<t:site>
	<jsp:attribute name="title">Beau Grantham | Track | Trips</jsp:attribute>

	<jsp:attribute name="header">
	    <script src="https://maps.google.com/maps/api/js?key=AIzaSyCPjJD7Y1_Dw3KI54xgUxGR5cxmOG2fzic&sensor=false"></script>
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
                var centerLatlng = new google.maps.LatLng(<c:out value="${trip.mapCenterLatitude}" />, <c:out value="${trip.mapCenterLongitude}" />);
                var myOptions = {
                    zoom: <c:out value="${trip.mapZoom}" />,
                    center: centerLatlng,
                    mapTypeId: 'Styled'
                }

                var map = new google.maps.Map(document.getElementById("map"), myOptions);

                var styles = [
                    {
                        featureType: 'landscape',
                        elementType: 'all',
                        stylers: [
                            { hue: '#FFFFFF' },
                            { saturation: -100 },
                            { lightness: 100 },
                            { visibility: 'on' }
                        ]
                    }
                ];

                var styledMapType = new google.maps.StyledMapType(styles, { name: 'Styled' });
                map.mapTypes.set('Styled', styledMapType);

                var weatherOverlay = null;
                google.maps.event.addListener(map, 'idle', function() {
					var bounds = this.getBounds();
					var southWest = bounds.getSouthWest();
					var northEast = bounds.getNorthEast();
					
                	var weatherUrl = "https://radblast.wunderground.com/cgi-bin/radar/WUNIDS_composite";
                	weatherUrl += "?maxlat=" + northEast.lat() + "&maxlon=" + northEast.lng();
                	weatherUrl += "&minlat=" + southWest.lat() + "&minlon=" + southWest.lng();
                	weatherUrl += "&type=00Q&frame=0&num=1&delay=25";
                	weatherUrl += "&width=" + $("#map").width();
                	weatherUrl += "&height=" + $("#map").height();
                	weatherUrl += "&png=0&smooth=1&min=0&noclutter=1&rainsnow=1&nodebug=0&theext=.gif&merge=elev&reproj.automerc=1&timelabel=0&brand=wundermap";
                	weatherUrl += "&rand=<c:out value="${now}" />";

                    <c:if test="${showWeather}">
						if (weatherOverlay != null) {
							weatherOverlay.setMap(null);
						}
	
	                    weatherOverlay = new google.maps.GroundOverlay(
	                            weatherUrl,
	                            bounds,
	                            {
									opacity: 0.7	                            	
	                            });
	                    weatherOverlay.setMap(map);
                	</c:if>                	
                });

	            var geoXml = new google.maps.KmlLayer(
            		'https://track.beau.granth.am<c:url value="/kml" />/<c:out value="${slug}" />/<c:out value="${timestamp}" />.kml',
            		{
            			map: map,
            			preserveViewport: false
            		});
	        });
	    </script>
	</jsp:body>
</t:site>