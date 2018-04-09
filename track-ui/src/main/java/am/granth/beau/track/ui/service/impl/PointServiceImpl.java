package am.granth.beau.track.ui.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import am.granth.beau.track.dao.PointDao;
import am.granth.beau.track.entity.Point;
import am.granth.beau.track.ui.service.PointService;

/**
 * {@link Point} service layer implementation.
 * 
 * @author Beau Grantham
 */
@Service
public class PointServiceImpl implements PointService {

	@Autowired
	private PointDao pointDao;

	@Override
	public Point getPoint(int id) {
		return pointDao.findOne(id);
	}

}
