package am.granth.beau.track.dao;

import org.springframework.data.repository.CrudRepository;

import am.granth.beau.track.entity.Trip;

/**
 * Data access object for {@link Trip}.
 * 
 * @author Beau Grantham
 */
public interface TripDao extends CrudRepository<Trip, Integer> {

	/**
	 * Find a {@link Trip} matching a slug.
	 * 
	 * @param slug
	 *            The slug to search.
	 * @return the matching {@link Trip} or null.
	 */
	Trip findBySlug(String slug);

}
