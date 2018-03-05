package am.granth.beau.track.ui.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import am.granth.beau.track.entity.Category;
import am.granth.beau.track.entity.Trip;
import am.granth.beau.track.ui.service.CategoryService;

/**
 * Home controller for serving the landing page.
 * 
 * @author Beau Grantham
 */
@Controller
@RequestMapping(value = "/")
public class HomeController {

    @Autowired
    private CategoryService categoryService;

    /**
     * Load and display the landing page.
     * 
     * @param model The {@link Model} object.
     * @return the home view.
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String home(Model model) {
        Category category = categoryService.getFeatured();
        List<Trip> trips = new ArrayList<>(category.getTrips());
        
		Collections.sort(trips, new Comparator<Trip>() {
			public int compare(Trip t1, Trip t2) {
				return t2.getStartDate().compareTo(t1.getStartDate());
			}
		});
        
        model.addAttribute("category", category);
        model.addAttribute("trips", trips);
        
        return "home";
    }

}
