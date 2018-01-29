package am.granth.beau.track.ui.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import am.granth.beau.track.dao.PointDao;
import am.granth.beau.track.dao.TripDao;
import am.granth.beau.track.entity.Point;
import am.granth.beau.track.entity.Trip;
import am.granth.beau.track.ui.service.TripService;

/**
 * {@link Trip} service layer implementation.
 * 
 * @author Beau Grantham
 */
@Service
public class TripServiceImpl implements TripService {

	@Autowired
	private TripDao tripDao;

	@Autowired
	private PointDao pointDao;

	@Override
	public Trip getBySlug(String slug) {
		return tripDao.findBySlug(slug);
	}

	@Override
	public List<Point> getPoints(Trip trip) {
		return pointDao.findByUserAndRelationIdGreaterThanAndReportedTimestampBetweenOrderByIdAsc(trip.getUser(), 0, trip.getStartDate(), trip.getEndDate());
	}

}
