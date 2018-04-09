package am.granth.beau.track.ui.service;

import am.granth.beau.track.entity.Point;

/**
 * {@link Point} service layer.
 * 
 * @author Beau Grantham
 */
public interface PointService {

	/**
	 * Get a {@link Point} with the specified id.
	 * 
	 * @param id
	 *            The point id.
	 * @return the matching {@link Point} or null.
	 */
	Point getPoint(int id);

}
