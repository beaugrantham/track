package am.granth.beau.track.ui.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import am.granth.beau.track.dao.CategoryDao;
import am.granth.beau.track.entity.Category;
import am.granth.beau.track.ui.service.CategoryService;

/**
 * {@link Category} service layer implementation.
 * 
 * @author Beau Grantham
 */
@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDao categoryDao;

	@Override
	public Category getFeatured() {
		return categoryDao.findByKeywordsContainingOrderByTitleAsc("featured").get(0);
	}

	@Override
	public List<Category> getCategories() {
		return categoryDao.findAllByOrderByTitleAsc();
	}

}
