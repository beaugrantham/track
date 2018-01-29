<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page session="false" %>

<t:site>
	<jsp:attribute name="title">Beau Grantham | Track | Trips</jsp:attribute>

	<jsp:attribute name="header">
	    <style>
	        html { height: 100% }
	        body { height: 100%; margin: 0; padding: 0 }
	        #map { height: 100% }
	    </style>
    
	    <script src="https://maps.google.com/maps/api/js?key=AIzaSyCPjJD7Y1_Dw3KI54xgUxGR5cxmOG2fzic&sensor=false"></script>
	</jsp:attribute>

	<jsp:body>
        <div id="map" style="width:100%; height:100%"></div>

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
