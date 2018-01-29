package am.granth.beau.track.ui.controller;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.nio.charset.Charset;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import am.granth.beau.track.entity.Marker;
import am.granth.beau.track.entity.Point;
import am.granth.beau.track.entity.Trip;
import am.granth.beau.track.ui.service.TripService;
import de.micromata.opengis.kml.v_2_2_0.Coordinate;
import de.micromata.opengis.kml.v_2_2_0.Document;
import de.micromata.opengis.kml.v_2_2_0.Icon;
import de.micromata.opengis.kml.v_2_2_0.Kml;
import de.micromata.opengis.kml.v_2_2_0.KmlFactory;
import de.micromata.opengis.kml.v_2_2_0.LineString;
import de.micromata.opengis.kml.v_2_2_0.Placemark;
import de.micromata.opengis.kml.v_2_2_0.Style;

/**
 * Controller for KML generation.
 * 
 * @author Beau Grantham
 */
@Controller
@RequestMapping(value = "/kml")
public class KmlController {

	private static final Logger logger = LoggerFactory.getLogger(KmlController.class);

	public static final int MAX_ROWS = 500;

	@Autowired
	private TripService tripService;

	/**
	 * Generate KML for the given slug.
	 * 
	 * @param slug
	 *            The slug to use for looking up a trip.
	 * @return the generated KML.
	 */
	@RequestMapping(value = "/{slug}.kml", method = RequestMethod.GET, produces = "application/xml")
	public @ResponseBody String generateKmlViaApi(@PathVariable("slug") String slug) {
		return generateKmlViaApiWithCache(slug, null);
	}

	/**
	 * Generate KML for the given slug. The cache variable is used for client
	 * cacheing.
	 * 
	 * TODO: FQDNs/URLs should not be hardcoded.
	 * 
	 * @param slug
	 *            The slug to use for looking up a trip.
	 * @param random
	 *            A string for client cacehing.
	 * @return the generated KML.
	 */
	@RequestMapping(value = "/{slug}/{cache}.kml", method = RequestMethod.GET, produces = "application/xml")
	public @ResponseBody String generateKmlViaApiWithCache(@PathVariable("slug") String slug, @PathVariable("cache") String random) {
		List<Point> points = null;

		Trip trip = tripService.getBySlug(slug);

		if (trip != null) {
			points = tripService.getPoints(trip);

			logger.debug("Loading trip " + slug + " (" + trip.getId() + ")");
			logger.debug("  Trip name: " + trip.getName() + "");
			logger.debug("  Total points: " + points.size());
		} else {
			trip = new Trip();
			points = Collections.<Point>emptyList();

			logger.warn("Trip does not exist: " + slug);
		}

		Kml kml = KmlFactory.createKml();
		Document document = kml.createAndSetDocument();

		final Style markerStyle = document.createAndAddStyle().withId("markerStyle");
		markerStyle.createAndSetIconStyle().withIcon(new Icon().withHref("https://track.beau.granth.am/resources/img/red_circle.png"));

		final Style annotationStyle = document.createAndAddStyle().withId("annotationStyle");
		annotationStyle.createAndSetIconStyle().withIcon(new Icon().withHref("https://track.beau.granth.am/resources/img/mm_20_yellow.png"));
		
		if (!points.isEmpty()) {
			Placemark placemark = document.createAndAddPlacemark()
					.withName(trip.getName())
					.withDescription(trip.getDescription());

			LineString lineString = placemark.createAndSetLineString();
			List<Coordinate> coordinateList = lineString.createAndSetCoordinates();

			for (Point p : points) {
				coordinateList.add(new Coordinate(
						Double.parseDouble(p.getReportedLongitude().toString()),
						Double.parseDouble(p.getReportedLatitude().toString())));
				
				/*
				 * Add annotation markers
				 */
				
				if (!StringUtils.isEmpty(p.getAnnotation())) {
					Placemark currentLocation = document.createAndAddPlacemark()
							.withName("Annotation")
							.withDescription(p.getAnnotation())
							.withStyleUrl("#annotationStyle");
	
					de.micromata.opengis.kml.v_2_2_0.Point markerPoint = currentLocation.createAndSetPoint();
	
					markerPoint.addToCoordinates(
							Double.parseDouble(p.getReportedLongitude().toString()),
							Double.parseDouble(p.getReportedLatitude().toString()));
				}
			}

			/*
			 * Add a marker for the current location
			 */

			Date currentDate = new Date();

			if (currentDate.after(trip.getStartDate()) && currentDate.before(trip.getEndDate())) {
				Placemark currentLocation = document.createAndAddPlacemark()
						.withName("Current Location")
						.withDescription(points.get(0).getReportedReverseGeocode())
						.withStyleUrl("#markerStyle");

				de.micromata.opengis.kml.v_2_2_0.Point markerPoint = currentLocation.createAndSetPoint();

				markerPoint.addToCoordinates(
						Double.parseDouble(points.get(0).getReportedLongitude().toString()),
						Double.parseDouble(points.get(0).getReportedLatitude().toString()));
			}
		}

		/*
		 * Add pre-defined markers
		 */
		
		for (Marker marker : trip.getMarkers()) {
			Placemark markerPlacemark = document.createAndAddPlacemark()
					.withName(marker.getDescription())
					.withDescription(marker.getDescription());

			de.micromata.opengis.kml.v_2_2_0.Point markerPoint = markerPlacemark.createAndSetPoint();

			markerPoint.addToCoordinates(
					Double.parseDouble(marker.getLongitude().toString()),
					Double.parseDouble((marker.getLatitude().toString())));
		}

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

		try {
			kml.marshal(outputStream);
		} catch (FileNotFoundException e) {
			// Not dealing with files
		}

		String output = new String(outputStream.toByteArray(), Charset.defaultCharset());

		// Remove namespace to be compatible with Google Maps
		// https://github.com/micromata/javaapiforkml/issues/5
		output = output.replace("ns2:", "");
		output = output.replace(":ns2", "");
		
		return output;
	}

}