package am.granth.beau.track.dao;

import java.util.Date;
import java.util.List;

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
	 * @param user
	 *            The {@link User} to which the point belongs.
	 * @param relation
	 *            The relationship which to exceed.
	 * @param fromDate
	 *            The minimum date.
	 * @param toDate
	 *            The maximum date.
	 * @return a {@link List} of {@link Point}s matching the specified criteria
	 *         ordered by ID ascending.
	 */
	List<Point> findByUserAndRelationIdGreaterThanAndReportedTimestampBetweenOrderByIdDesc(User user, int relation, Date fromDate, Date toDate);

}
