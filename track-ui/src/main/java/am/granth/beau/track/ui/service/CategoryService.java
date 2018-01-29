package am.granth.beau.track.ui.service;

import java.util.List;

import am.granth.beau.track.entity.Category;

/**
 * {@link Category} service layer.
 * 
 * @author Beau Grantham
 */
public interface CategoryService {

	/**
	 * Get the featured {@link Category}.
	 * 
	 * @return the featured {@link Category}.
	 */
	Category getFeatured();

	/**
	 * Get all {@link Category}s.
	 * 
	 * @return a {@link List} of all {@link Category}s.
	 */
	List<Category> getCategories();

}
