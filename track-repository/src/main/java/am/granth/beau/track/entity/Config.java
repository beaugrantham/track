package am.granth.beau.track.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Config entity.
 * 
 * @author Beau Grantham
 */
@Entity
@Table(name = "config", uniqueConstraints = {})
public class Config implements java.io.Serializable {

	private static final long serialVersionUID = 3537979908550756329L;

	private Integer id;
	private String key;
	private String value;
	
	@Id
	@Column(name = "id", unique = true, nullable = false, insertable = true, updatable = true)
	public Integer getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "config_key", unique = true, nullable = false, insertable = true, updatable = true, length = 254)
	public String getKey() {
		return this.key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	@Column(name = "config_value", unique = false, nullable = false, insertable = true, updatable = true, length = 254)
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}