package am.granth.beau.track.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Relation entity.
 * 
 * @author Beau Grantham
 */
@Entity
@Table(name = "relation", uniqueConstraints = {})
public class Relation implements java.io.Serializable {

	private static final long serialVersionUID = 1238396468334776308L;

	private int id;
	private String description;
	private Date entryDate;
	private Date modifiedDate;
	private Set<Point> points = new HashSet<Point>(0);

	public Relation() { }
	
	public Relation(int id) {
		this.id = id;
	}
	
	@Id
	@Column(name = "id", unique = true, nullable = false, insertable = true, updatable = true)
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "description", unique = false, nullable = true, insertable = true, updatable = true, length = 254)
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

	@OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY, mappedBy = "relation")
	public Set<Point> getPoints() {
		return this.points;
	}

	public void setPoints(Set<Point> points) {
		this.points = points;
	}

}