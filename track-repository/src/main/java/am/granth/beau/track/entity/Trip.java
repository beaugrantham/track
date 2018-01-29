package am.granth.beau.track.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Trip entity.
 * 
 * @author Beau Grantham
 */
@Entity
@Table(name = "trip", uniqueConstraints = {})
public class Trip implements java.io.Serializable {

	private static final long serialVersionUID = -3180384307797828198L;

	private Integer id;
	private User user;
	private String uid;
	private String name;
	private String shortName;
	private String description;
	private String keywords;
	private String slug;
	private Integer mapCenterLatitude;
	private Integer mapCenterLongitude;
	private Integer mapZoom;
	private Date startDate;
	private Date endDate;
	private byte[] thumbnail;
	private Date entryDate;
	private Date modifiedDate;
	private Set<Marker> markers = new HashSet<Marker>(0);
	private Set<Category> categories = new HashSet<Category>(0);
	
	@Id
	@Column(name = "id", unique = true, nullable = false, insertable = true, updatable = true)
	public Integer getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@ManyToOne(cascade = {}, fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", unique = false, nullable = false, insertable = true, updatable = true)
	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "uid", unique = false, nullable = true, insertable = true, updatable = true, length = 36)
	public String getUid() {
		return this.uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	@Column(name = "name", unique = false, nullable = false, insertable = true, updatable = true, length = 50)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "short_name", unique = false, nullable = false, insertable = true, updatable = true, length = 40)
	public String getShortName() {
		return this.shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
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

	@Column(name = "slug", unique = false, nullable = true, insertable = true, updatable = true, length = 254)
	public String getSlug() {
		return this.slug;
	}

	public void setSlug(String slug) {
		this.slug = slug;
	}

	@Column(name = "map_center_latitude", unique = false, nullable = true, insertable = true, updatable = true)
	public Integer getMapCenterLatitude() {
		return this.mapCenterLatitude;
	}

	public void setMapCenterLatitude(Integer mapCenterLatitude) {
		this.mapCenterLatitude = mapCenterLatitude;
	}

	@Column(name = "map_center_longitude", unique = false, nullable = true, insertable = true, updatable = true)
	public Integer getMapCenterLongitude() {
		return this.mapCenterLongitude;
	}

	public void setMapCenterLongitude(Integer mapCenterLongitude) {
		this.mapCenterLongitude = mapCenterLongitude;
	}

	@Column(name = "map_zoom", unique = false, nullable = true, insertable = true, updatable = true)
	public Integer getMapZoom() {
		return this.mapZoom;
	}

	public void setMapZoom(Integer mapZoom) {
		this.mapZoom = mapZoom;
	}

	@Column(name = "start_date", unique = false, nullable = true, insertable = true, updatable = true, length = 19)
	public Date getStartDate() {
		return this.startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	@Column(name = "end_date", unique = false, nullable = true, insertable = true, updatable = true, length = 19)
	public Date getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	@Column(name = "thumbnail", unique = false, nullable = true, insertable = true, updatable = true)
	public byte[] getThumbnail() {
		return thumbnail;
	}
	
	public void setThumbnail(byte[] thumbnail) {
		this.thumbnail = thumbnail;
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

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "trip_marker", joinColumns = @JoinColumn(name = "trip_id"), inverseJoinColumns = @JoinColumn(name = "marker_id"))
	public Set<Marker> getMarkers() {
		return markers;
	}
	
	public void setMarkers(Set<Marker> markers) {
		this.markers = markers;
	}
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "trip_category", joinColumns = @JoinColumn(name = "trip_id"), inverseJoinColumns = @JoinColumn(name = "category_id"))
	public Set<Category> getCategories() {
		return categories;
	}
	
	public void setCategories(Set<Category> categories) {
		this.categories = categories;
	}

}