package am.granth.beau.track.rest.controller;

import java.math.BigDecimal;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import am.granth.beau.track.dao.PointDao;
import am.granth.beau.track.entity.Point;
import am.granth.beau.track.entity.Relation;
import am.granth.beau.track.entity.User;

/**
 * RESTful service for publishing location detail.
 * 
 * @author Beau Grantham
 */
@RestController
@RequestMapping(value = "/publish")
public class PublishController {

	private static final Logger logger = LoggerFactory.getLogger(PublishController.class);

	private static final Relation relation = new Relation(3); // VERSION 2 UNKNOWN
	private static final String reverseGeocode = "Geocoding...";
	private static final int minutesReported = 0;

	@Autowired
	private PointDao pointDao;

	/**
	 * Publish a collection of records.
	 * 
	 * {  
	 *    "123":{  
	 *       "time":"1517017568933",
	 *       "user":"2432859998404394256",
	 *       "satellites":"123",
	 *       "annotation":"string",
	 *       "altitude":"123",
	 *       "latitude":"29.170127",
	 *       "accuracy":"123",
	 *       "speed":"123",
	 *       "direction":"123",
	 *       "longitude":"-81.084342"
	 *    }
	 * }
	 * 
	 * @param records
	 *            The records to publish.
	 * @return a string indicating success.
	 */
	@RequestMapping(value = "", method = RequestMethod.POST)
	public @ResponseBody String publish(@RequestBody String records) {
		Gson gson = new GsonBuilder().create();

		@SuppressWarnings("unchecked")
		Map<Integer, Map<String, String>> map = gson.fromJson(records, Map.class);

		for (Map.Entry<Integer, Map<String, String>> entry : map.entrySet()) {
			logger.info(entry.getKey() + "");

			Date date = new Date(Long.parseLong(entry.getValue().get("time")));
			Format format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			logger.info("   " + "time       : " + format.format(date).toString());

			long user = Long.parseLong(entry.getValue().get("user"));
			logger.info("   " + "user       : " + user);
			
			Double latitude = Double.parseDouble(entry.getValue().get("latitude"));
			Double longitude = Double.parseDouble(entry.getValue().get("longitude"));
			Double accuracy = Double.parseDouble(entry.getValue().get("accuracy"));
			String annotation = entry.getValue().get("annotation");

			logger.info("   " + "speed      : " + entry.getValue().get("speed"));
			logger.info("   " + "direction  : " + entry.getValue().get("direction"));
			logger.info("   " + "altitude   : " + entry.getValue().get("altitude"));
			logger.info("   " + "latitude   : " + latitude);
			logger.info("   " + "longitude  : " + longitude);
			logger.info("   " + "satellites : " + entry.getValue().get("satellites"));
			logger.info("   " + "accuracy   : " + accuracy);
			logger.info("   " + "annotation : " + annotation);

			Point point = new Point();
			point.setUser(new User(user));
			point.setReportedTimestamp(date);
			point.setReportedLatitude(BigDecimal.valueOf(latitude));
			point.setReportedLongitude(BigDecimal.valueOf(longitude));
			point.setReportedAccuracyInMeters(accuracy.intValue());
			point.setReportedReverseGeocode(reverseGeocode);
			point.setMinutesReported(minutesReported);
			point.setAnnotation(annotation);
			point.setRelation(relation);

			pointDao.save(point);
		}

		return "success";
	}

}