package am.granth.beau.track.ui.service;

import java.util.List;

import am.granth.beau.track.entity.Point;
import am.granth.beau.track.entity.Trip;

/**
 * {@link Trip} service layer.
 * 
 * @author Beau Grantham
 */
public interface TripService {

	/**
	 * Get a {@link Trip} with the specified slug.
	 * 
	 * @param slug
	 *            The trip slug.
	 * @return the matching {@link Trip} or null.
	 */
	Trip getBySlug(String slug);

	/**
	 * Get a list of {@link Point}s for the specified {@link Trip}.
	 * 
	 * @param trip
	 *            The trip.
	 * @return a {@link List} of {@link Point}s.
	 */
	List<Point> getPoints(Trip trip);
	
	/**
	 * Get a list of {@link Point}s for the specified {@link Trip} that contain
	 * media.
	 * 
	 * @param trip
	 *            The trip.
	 * @return a {@link List} of {@link Point}s.
	 */
	List<Point> getPointsWithMedia(Trip trip);

}
