package am.granth.beau.track.api.task;

import java.math.BigDecimal;
import java.util.Optional;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import am.granth.beau.track.dao.ConfigDao;
import am.granth.beau.track.dao.PointDao;
import am.granth.beau.track.entity.Point;

/**
 * Scheduled task to periodically reverse geocode points.
 * 
 * @author Beau Grantham
 */
@Component
public class GeocodeTask {

	private static final Logger logger = LoggerFactory.getLogger(GeocodeTask.class);
	
	private static final String URI_TEMPLATE = "https://maps.googleapis.com/maps/api/geocode/json?result_type=locality|administrative_area_level_1|country&key=%s&latlng=%s,%s";
	
	@Autowired
	private PointDao pointDao;
	
	@Autowired
	private ConfigDao configDao;
	
	/**
	 * Fetch a {@link Point} without an address and reverse geocode it.
	 * 
	 * If an address is found, write it to the database. Otherwise indicate that it
	 * is unknown.
	 * 
	 * Start with the most recent points as these are the ones displayed to users.
	 * Older points will be done over time.
	 */
	@Scheduled(fixedDelay = 60000)
	public void reverseGeocode() {
		Point point = pointDao.findFirstByReportedReverseGeocodeOrderByIdDesc("Geocoding...");

		if (point != null) {
			Optional<String> address = getAddress(point.getReportedLatitude(), point.getReportedLongitude());
			
			if (address.isPresent()) {
				logger.info("Reverse geocoded [{}, {}] to [{}]", point.getReportedLatitude(), point.getReportedLongitude(), address.get());
			} else {
				logger.info("Unable to reverse geocode [{}, {}]", point.getReportedLatitude(), point.getReportedLongitude());
			}
			
			point.setReportedReverseGeocode(address.orElse("Unknown"));
			pointDao.save(point);
		}
		
	}
	
	/*
	 * Reverse geocode a given latitude and longitude.
	 */
	private Optional<String> getAddress(BigDecimal latitude, BigDecimal longitude) {
		String uri = String.format(URI_TEMPLATE, configDao.findByKey("google_api_key").getValue(), latitude.toString(), longitude.toString());
		
		JSONObject jsonObject = getJson(uri);
		
		return parseAddress(jsonObject);
	}
	
	/*
	 * Invoke a web service and and unmarshal the response into a JSONObject.
	 */
	private JSONObject getJson(String uri) {
		RestTemplate restTemplate = new RestTemplate();

		String json = restTemplate.getForObject(uri, String.class);
		
		return new JSONObject(json);
	}
	
	/*
	 * Parse an address out of a response.
	 * 
	 * https://developers.google.com/maps/documentation/geocoding/intro#GeocodingResponses
	 */
	private Optional<String> parseAddress(JSONObject jsonObject) {
		if (jsonObject.has("results")) {
			JSONArray results = jsonObject.getJSONArray("results");
			
			if (results.length() >= 1) {
				JSONObject result = results.getJSONObject(0);
				
				if (result.has("formatted_address")) {
					String formatted_address = result.getString("formatted_address");
										
					return Optional.ofNullable(formatted_address);
				}
			}
		}

		return Optional.empty();
	}

}
