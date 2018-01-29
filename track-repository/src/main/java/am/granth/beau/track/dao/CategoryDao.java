package am.granth.beau.track.dao;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import am.granth.beau.track.entity.Category;

/**
 * Data access object for {@link Category}.
 * 
 * @author Beau Grantham
 */
public interface CategoryDao extends CrudRepository<Category, Integer> {

	/**
	 * Find all {@link Category}s containing a keyword. The returned list is ordered
	 * by title ascending.
	 * 
	 * @param keyword
	 *            The keyword to search.
	 * @return a {@link List} of {@link Category}s containing the keyword ordered by
	 *         title ascending.
	 */
	List<Category> findByKeywordsContainingOrderByTitleAsc(String keyword);

	/**
	 * Find all {@link Category}s. The returned list is ordered by title ascending.
	 * 
	 * @return a {@link List} of {@link Category}s ordered by title ascending.
	 */
	List<Category> findAllByOrderByTitleAsc();

}
