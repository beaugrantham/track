package am.granth.beau.track.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import am.granth.beau.track.entity.Point;
import am.granth.beau.track.entity.User;

/**
 * Data access object for {@link Point}.
 * 
 * @author Beau Grantham
 */
public interface PointDao extends CrudRepository<Point, Integer> {

	/**
	 * Find all {@link Point}s with the specified parameters. The returned list is
	 * ordered by ID descending.
	 * 
	 * Points with annotations will be returned regardless of relation.
	 * 
	 * @param user
	 *            The {@link User} to which the point belongs.
	 * @param fromDate
	 *            The minimum date.
	 * @param toDate
	 *            The maximum date.
	 * @param relation
	 *            The relationship which to exceed.
	 * @return a {@link List} of {@link Point}s matching the specified criteria
	 *         ordered by ID ascending.
	 */
	@Query("select p from Point p where p.user = ?1 and p.reportedTimestamp between ?2 and ?3 and (p.relation.id > ?4 or p.annotation != null)")
	List<Point> findByUserAndReportedTimestampBetweenAndRelationIdGreaterThanOrderByIdDesc(User user, Date fromDate, Date toDate, int relation);

	/**
	 * Find the most recent {@link Point} with the given reverse geocode.
	 * 
	 * @param reportedReverseGeocode
	 *            The reverse geocode to lookup.
	 * @return the most recent matching {@link Point}.
	 */
	Point findFirstByReportedReverseGeocodeOrderByIdDesc(String reportedReverseGeocode);
	  
}
