package am.granth.beau.track.dao;

import org.springframework.data.repository.CrudRepository;

import am.granth.beau.track.entity.Config;

/**
 * Data access object for {@link Config}.
 * 
 * @author Beau Grantham
 */
public interface ConfigDao extends CrudRepository<Config, Integer> {

	/**
	 * Find the {@link Config} entry by key.
	 * 
	 * @param key
	 *            The key to lookup.
	 * @return the {@link Config} entry.
	 */
	Config findByKey(String key);

}
