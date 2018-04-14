package am.granth.beau.track.ui.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import am.granth.beau.track.entity.Category;
import am.granth.beau.track.entity.Point;
import am.granth.beau.track.entity.Trip;
import am.granth.beau.track.ui.service.CategoryService;
import am.granth.beau.track.ui.service.PointService;
import am.granth.beau.track.ui.service.TripService;

/**
 * Controller for {@link Trip} related views.
 * 
 * @author Beau Grantham
 */
@Controller
@RequestMapping(value = "/trips")
public class TripController {

	private static final Logger logger = LoggerFactory.getLogger(TripController.class);

	@Autowired
	private TripService tripService;

	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private PointService pointService;

	/**
	 * View for displaying all trips.
	 * 
	 * Exclude the featured category (front-page only).
	 * 
	 * @param model
	 *            The {@link Model} object.
	 * @return the view displaying all trips.
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String getTrips(Model model) {
		Map<Category, List<Trip>> categoryTripMap = new LinkedHashMap<Category, List<Trip>>();

		for (Category c : categoryService.getCategories()) {
			if (!c.getTitle().equalsIgnoreCase("Featured")) {
				List<Trip> trips = new ArrayList<>(c.getTrips());
	
				Collections.sort(trips, new Comparator<Trip>() {
					public int compare(Trip t1, Trip t2) {
						return t2.getStartDate().compareTo(t1.getStartDate());
					}
				});
				
				categoryTripMap.put(c, trips);
			}
		}

		model.addAttribute("categoryTripMap", categoryTripMap);

		return "trips";
	}

	/**
	 * View for displaying a single trip.
	 * 
	 * @param model
	 *            The {@link Model} object.
	 * @param slug
	 *            The trip slug.
	 * @return the view for a single trip, or a redirect if not found.
	 */
	@RequestMapping(value = "/{slug}", method = RequestMethod.GET)
	public String getTrip(Model model, @PathVariable("slug") String slug) {
		long timestamp;
		Date now = new Date();

		Trip trip = tripService.getBySlug(slug);

		if (trip == null) {
			logger.warn("Trip does not exist: " + slug);

			return "redirect:/trips";
		}

		List<Point> points = tripService.getPoints(trip);

		logger.debug("Loading trip " + slug + " (" + trip.getId() + ")");
		logger.debug("  Trip name: " + trip.getName() + "");
		logger.debug("  Trip owner: " + trip.getUser().getUserName() + " (" + trip.getUser().getId() + ")");
		logger.debug("  Trip dates: " + trip.getStartDate() + " -> " + trip.getEndDate());
		logger.debug("  Trip points: " + points.size());

		List<Point> media = points.stream()
				.filter(point -> point.getMedia() != null)
				.collect(Collectors.toList());
		
		/*
		 * Set the timestamp (for KML caching) to either 
		 * a) trip start date 
		 * b) latest point date 
		 * c) trip end date <- this one removes the current location marker
		 */
		if (points.isEmpty()) {
			timestamp = trip.getStartDate().getTime();
		} else if (now.after(trip.getEndDate())) {
			timestamp = trip.getEndDate().getTime();
		} else {
			timestamp = points.get(0).getReportedTimestamp().getTime();
		}

		model.addAttribute("now", now.getTime());
		model.addAttribute("slug", slug);
		model.addAttribute("trip", trip);
		model.addAttribute("points", points);
		model.addAttribute("media", media);
		model.addAttribute("timestamp", timestamp);
		model.addAttribute("showWeather", now.before(trip.getEndDate()) ? true : false);

		return "trip";
	}
	
	/**
	 * View for displaying a trip media.
	 * 
	 * @param model
	 *            The {@link Model} object.
	 * @param slug
	 *            The trip slug.
	 * @return the view for a trip media, or a redirect if not found.
	 */
	@RequestMapping(value = "/{slug}/media", method = RequestMethod.GET)
	public String getTripMedia(Model model, @PathVariable("slug") String slug) {
		Trip trip = tripService.getBySlug(slug);

		if (trip == null) {
			logger.warn("Trip does not exist: " + slug);

			return "redirect:/trips";
		}

		List<Point> media = tripService.getPointsWithMedia(trip);

		if (media == null || media.isEmpty()) {
			logger.warn("No media exists for trip [{}]", trip.getName());
			
			return "redirect:/trips/" + trip.getSlug();
		}
		
		model.addAttribute("slug", slug);
		model.addAttribute("trip", trip);
		model.addAttribute("media", media);

		return "media";
	}
	
	/**
	 * View for robots to grab map snapshots.
	 * 
	 * @param model
	 *            The {@link Model} object.
	 * @param slug
	 *            The trip slug.
	 * @return the map view.
	 */
	@RequestMapping(value = "/{slug}/map", method = RequestMethod.GET)
	public String getMap(Model model, @PathVariable("slug") String slug) {
		getTrip(model, slug);
		
		return "map";
	}
	
	@RequestMapping(value="/{slug}/media/{id}.jpg", produces=MediaType.IMAGE_JPEG_VALUE)
	public @ResponseBody byte[] media(@PathVariable("id") int id) {
		Point point = pointService.getPoint(id);

		return point != null ? point.getMedia() : null;
	}
	               
	/**
	 * Display thumbnail image for a trip.
	 * 
	 * @param slug
	 *            The trip slug.
	 * @return the image as raw binary data.
	 */
	@RequestMapping(value="/{slug}.png", produces=MediaType.IMAGE_PNG_VALUE)
	public @ResponseBody byte[] thumbnail(@PathVariable("slug") String slug) {
		Trip trip = tripService.getBySlug(slug);
		return trip.getThumbnail();
	}

}