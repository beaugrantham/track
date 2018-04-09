package am.granth.beau.track.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Point entity.
 * 
 * @author Beau Grantham
 */
@Entity
@Table(name = "point", uniqueConstraints = {})
public class Point implements java.io.Serializable {

	private static final long serialVersionUID = -2208636505805160694L;

	private Integer id;
	private Relation relation;
	private User user;
	private Date reportedTimestamp;
	private BigDecimal reportedLatitude;
	private BigDecimal reportedLongitude;
	private int reportedAccuracyInMeters;
	private String reportedReverseGeocode;
	private int minutesReported;
	private String annotation;
	private byte[] media;
	private Date entryDate;
	private Date modifiedDate;

	@Id
	@Column(name = "id", unique = true, nullable = false, insertable = false, updatable = false)
	@GeneratedValue(strategy = GenerationType.AUTO)
	public Integer getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "relation", unique = false, nullable = false, insertable = true, updatable = true)
	public Relation getRelation() {
		return this.relation;
	}

	public void setRelation(Relation relation) {
		this.relation = relation;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", unique = false, nullable = false, insertable = true, updatable = true)
	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "reported_timestamp", unique = false, nullable = false, insertable = true, updatable = true, length = 19)
	public Date getReportedTimestamp() {
		return this.reportedTimestamp;
	}

	public void setReportedTimestamp(Date reportedTimestamp) {
		this.reportedTimestamp = reportedTimestamp;
	}

	@Column(name = "reported_latitude", unique = false, nullable = false, insertable = true, updatable = true, precision = 12, scale = 6)
	public BigDecimal getReportedLatitude() {
		return this.reportedLatitude;
	}

	public void setReportedLatitude(BigDecimal reportedLatitude) {
		this.reportedLatitude = reportedLatitude;
	}

	@Column(name = "reported_longitude", unique = false, nullable = false, insertable = true, updatable = true, precision = 12, scale = 6)
	public BigDecimal getReportedLongitude() {
		return this.reportedLongitude;
	}

	public void setReportedLongitude(BigDecimal reportedLongitude) {
		this.reportedLongitude = reportedLongitude;
	}

	@Column(name = "reported_accuracy_in_meters", unique = false, nullable = false, insertable = true, updatable = true)
	public int getReportedAccuracyInMeters() {
		return this.reportedAccuracyInMeters;
	}

	public void setReportedAccuracyInMeters(int reportedAccuracyInMeters) {
		this.reportedAccuracyInMeters = reportedAccuracyInMeters;
	}

	@Column(name = "reported_reverse_geocode", unique = false, nullable = false, insertable = true, updatable = true, length = 254)
	public String getReportedReverseGeocode() {
		return this.reportedReverseGeocode;
	}

	public void setReportedReverseGeocode(String reportedReverseGeocode) {
		this.reportedReverseGeocode = reportedReverseGeocode;
	}

	@Column(name = "minutes_reported", unique = false, nullable = false, insertable = true, updatable = true)
	public int getMinutesReported() {
		return this.minutesReported;
	}

	public void setMinutesReported(int minutesReported) {
		this.minutesReported = minutesReported;
	}

	@Column(name = "annotation", unique = false, nullable = true, insertable = true, updatable = true, length = 255)
	public String getAnnotation() {
		return this.annotation;
	}

	public void setAnnotation(String annotation) {
		this.annotation = annotation;
	}
	
	@Column(name = "media", unique = false, nullable = true, insertable = true, updatable = true)
	public byte[] getMedia() {
		return media;
	}
	
	public void setMedia(byte[] media) {
		this.media = media;
	}

	@Column(name = "entry_date", unique = false, nullable = false, insertable = true, updatable = true, length = 19)
	public Date getEntryDate() {
		return this.entryDate;
	}

	public void setEntryDate(Date entryDate) {
		this.entryDate = entryDate;
	}

	@Column(name = "modified_date", unique = false, nullable = false, insertable = true, updatable = true, length = 19)
	public Date getModifiedDate() {
		return this.modifiedDate;
	}

	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}

}