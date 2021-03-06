package am.granth.beau.track.ui.controller;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
import de.micromata.opengis.kml.v_2_2_0.Schema;
import de.micromata.opengis.kml.v_2_2_0.SchemaData;
import de.micromata.opengis.kml.v_2_2_0.Style;
import de.micromata.opengis.kml.v_2_2_0.Units;
import de.micromata.opengis.kml.v_2_2_0.Vec2;

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
	
	private static final DateFormat ISO8601 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm'Z'");
	
	@Value("${application.root}")
	private String applicationRoot;

	@Autowired
	private TripService tripService;

	/**
	 * Generate KML for the given slug.
	 * 
	 * @param slug
	 *            The slug to use for looking up a trip.
	 * @param media
	 *            Whether or not to include media markers.
	 * @return the generated KML.
	 */
	@RequestMapping(value = "/{slug}.kml", method = RequestMethod.GET, produces = "application/xml")
	public @ResponseBody String generateKmlViaApi(@PathVariable("slug") String slug, @RequestParam(name="media", defaultValue = "true") boolean media) {
		return generateKmlViaApiWithCache(slug, null, media);
	}

	/**
	 * Generate KML for the given slug. The cache variable is used for client
	 * cacheing.
	 * 
	 * @param slug
	 *            The slug to use for looking up a trip.
	 * @param random
	 *            A string for client cacehing.
	 * @param media
	 *            Whether or not to include media markers.
	 * @return the generated KML.
	 */
	@RequestMapping(value = "/{slug}/{cache}.kml", method = RequestMethod.GET, produces = "application/xml")
	public @ResponseBody String generateKmlViaApiWithCache(@PathVariable("slug") String slug, @PathVariable("cache") String random, @RequestParam(name="media", defaultValue = "true") boolean media) {
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

		Schema mediaDataSchema = document.createAndAddSchema()
				.withId("mediaData")
				.withName("mediaData");
		
		mediaDataSchema.createAndAddSimpleField().withName("media").withType("string");
		mediaDataSchema.createAndAddSimpleField().withName("location").withType("string");
		mediaDataSchema.createAndAddSimpleField().withName("datetime").withType("string");
		mediaDataSchema.createAndAddSimpleField().withName("timezone").withType("string");
		
		Vec2 iconHotspot = new Vec2()
				.withX(0.5).withXunits(Units.FRACTION)
				.withY(0).withYunits(Units.FRACTION);

		final Style stylePlacemark = document.createAndAddStyle().withId("stylePlacemark");
		stylePlacemark.createAndSetIconStyle()
				.withIcon(new Icon().withHref("https://maps.google.com/mapfiles/ms/icons/red-dot.png"))
				.withHotSpot(iconHotspot)
				.withScale(1);

		final Style styleWaymark = document.createAndAddStyle().withId("styleWaymark");
		styleWaymark.createAndSetIconStyle()
				.withIcon(new Icon().withHref("https://maps.google.com/mapfiles/ms/icons/yellow.png"))
				.withHotSpot(iconHotspot)
				.withScale(0.7);

		final Style styleMediaWaymark = document.createAndAddStyle().withId("styleMediaWaymark");
		styleMediaWaymark.createAndSetIconStyle()
				.withIcon(new Icon().withHref("https://maps.google.com/mapfiles/kml/pal4/icon38.png"))
				.withScale(0.7);
		
		final Style styleLive = document.createAndAddStyle().withId("styleLive");
		styleLive.createAndSetIconStyle()
				.withIcon(new Icon().withHref(applicationRoot + "/resources/img/red_circle.png"))
				.withScale(1);

		final Style trackStyle = document.createAndAddStyle().withId("stylePath");
		trackStyle.createAndSetLineStyle()
				.withColor("#a0ea8b17")
				.withWidth(5);
		
		if (!points.isEmpty()) {
			Placemark pathPlacemark = document.createAndAddPlacemark()
					.withName(trip.getName())
					.withStyleUrl("#stylePath");

			LineString pathLineString = pathPlacemark.createAndSetLineString();
			List<Coordinate> pathCoordinateList = pathLineString.createAndSetCoordinates();

			for (Point p : points) {
				pathCoordinateList.add(new Coordinate(
						Double.parseDouble(p.getReportedLongitude().toString()),
						Double.parseDouble(p.getReportedLatitude().toString())));
				
				/*
				 * Add annotation markers.
				 *
				 * Skip media markers if media=false.
				 */
				
				if (!StringUtils.isEmpty(p.getAnnotation())) {
					if (media || p.getMedia() == null) {
						Placemark waymarkPlacemark = document.createAndAddPlacemark()
								.withDescription(p.getAnnotation())
								.withStyleUrl(p.getMedia() == null ? "#styleWaymark" : "#styleMediaWaymark");

						waymarkPlacemark.createAndSetPoint().addToCoordinates(
								Double.parseDouble(p.getReportedLongitude().toString()),
								Double.parseDouble(p.getReportedLatitude().toString()));

						if (p.getMedia() != null) {
							SchemaData schemaData = waymarkPlacemark.createAndSetExtendedData()
									.createAndAddSchemaData()
									.withSchemaUrl("#mediaData");
							
							schemaData.createAndAddSimpleData("media")
									.setValue(applicationRoot + "/trips/" + slug + "/media/" + p.getId() + ".jpg");
							schemaData.createAndAddSimpleData("location")
									.setValue(p.getReportedReverseGeocode());
							schemaData.createAndAddSimpleData("datetime")
									.setValue(ISO8601.format(p.getReportedTimestamp()));
							schemaData.createAndAddSimpleData("timezone")
									.setValue(p.getReportedTimezone());
						}
					}
				}
			}

			/*
			 * Add a marker for the current location
			 */

			Date currentDate = new Date();

			if (currentDate.after(trip.getStartDate()) && currentDate.before(trip.getEndDate())) {
				Placemark livePlacemark = document.createAndAddPlacemark()
						.withName("Current Location")
						.withDescription(points.get(0).getReportedReverseGeocode())
						.withStyleUrl("#styleLive");

				livePlacemark.createAndSetPoint().addToCoordinates(
						Double.parseDouble(points.get(0).getReportedLongitude().toString()),
						Double.parseDouble(points.get(0).getReportedLatitude().toString()));
			}
		}

		/*
		 * Add pre-defined markers
		 */
		
		for (Marker marker : trip.getMarkers()) {
			Placemark placemark = document.createAndAddPlacemark()
					.withName(marker.getDescription())
					.withDescription(marker.getDescription())
					.withStyleUrl("#stylePlacemark");

			placemark.createAndSetPoint().addToCoordinates(
					Double.parseDouble(marker.getLongitude().toString()),
					Double.parseDouble((marker.getLatitude().toString())));
		}

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

		try {
			kml.marshal(outputStream);
		} catch (FileNotFoundException e) {
			// Not dealing with files
		}

		return new String(outputStream.toByteArray(), Charset.defaultCharset());
	}

}