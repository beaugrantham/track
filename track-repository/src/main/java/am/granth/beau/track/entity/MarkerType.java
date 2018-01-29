package am.granth.beau.track.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * MarkerType entity.
 * 
 * @author Beau Grantham
 */
@Entity
@Table(name = "marker_type", uniqueConstraints = {})
public class MarkerType implements java.io.Serializable {

	private static final long serialVersionUID = 9109877794413054884L;

	private int id;
	private String description;
	private Date entryDate;
	private Date modifiedDate;

	@Id
	@Column(name = "id", unique = true, nullable = false, insertable = true, updatable = true)
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
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

}