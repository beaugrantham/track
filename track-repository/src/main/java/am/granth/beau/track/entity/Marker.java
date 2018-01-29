package am.granth.beau.track.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 * Marker entity.
 * 
 * @author Beau Grantham
 */
@Entity
@Table(name = "marker", uniqueConstraints = {})
public class Marker implements java.io.Serializable {

	private static final long serialVersionUID = -9007851386084558830L;

	private Integer id;
	private BigDecimal latitude;
	private BigDecimal longitude;
	private String description;
	private Date entryDate;
	private Date modifiedDate;
	private Set<Trip> trips = new HashSet<Trip>(0);

	@Id
	@Column(name = "id", unique = true, nullable = false, insertable = true, updatable = true)
	public Integer getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "latitude", unique = false, nullable = false, insertable = true, updatable = true, precision = 12, scale = 6)
	public BigDecimal getLatitude() {
		return this.latitude;
	}

	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}

	@Column(name = "longitude", unique = false, nullable = false, insertable = true, updatable = true, precision = 12, scale = 6)
	public BigDecimal getLongitude() {
		return this.longitude;
	}

	public void setLongitude(BigDecimal longitude) {
		this.longitude = longitude;
	}

	@Column(name = "description", unique = false, nullable = false, insertable = true, updatable = true, length = 50)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	@ManyToMany(mappedBy = "markers", fetch = FetchType.LAZY)
	public Set<Trip> getTrips() {
		return trips;
	}

	public void setTrips(Set<Trip> trips) {
		this.trips = trips;
	}

}