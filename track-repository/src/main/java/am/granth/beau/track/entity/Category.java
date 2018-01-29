package am.granth.beau.track.entity;

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
 * Category entity.
 * 
 * @author Beau Grantham
 */
@Entity
@Table(name = "category", uniqueConstraints = {})
public class Category implements java.io.Serializable {

	private static final long serialVersionUID = 7866927951111123359L;

	private Integer id;
	private String title;
	private String description;
	private String keywords;
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

	@Column(name = "title", unique = false, nullable = false, insertable = true, updatable = true, length = 50)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "description", unique = false, nullable = true, insertable = true, updatable = true, length = 2000)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "keywords", unique = false, nullable = true, insertable = true, updatable = true, length = 254)
	public String getKeywords() {
		return this.keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
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

	@ManyToMany(mappedBy = "categories", fetch = FetchType.LAZY)
	public Set<Trip> getTrips() {
		return trips;
	}

	public void setTrips(Set<Trip> trips) {
		this.trips = trips;
	}
}