/**
* Recipes Event Handler
*/
component extends="coldbox.system.EventHandler" {

	property name="recipeService" inject="recipes.RecipeService";
	property name="securityService" inject="security.SecurityService";

	/**
	* Runs before each handler
	*/
	any function preHandler( event, rc, prc ) {
		prc.user = securityService.getLoggedInUser();
	}

	/**
	* Index
	*/
	any function index( event, rc, prc ) {
		prc.recipes = recipeService.getByUserID( prc.user.getUserID() );
	}

	/**
	* list public recipes
	*/
	any function public( event, rc, prc ) {
		prc.recipes = recipeService.getPublic();
	}

	/**
	* show
	*/
	any function show( event, rc, prc ){
		
		prc.recipe = recipeService.get(rc.id);
		prc.canEdit = false;
		if ( prc.recipe.getUser().getUserId() == securityService.getLoggedInUser().getUserID() ) {
			prc.canEdit = true;
		}
			
		event.setView("recipes/show");
	}

	/**
	* edit
	*/
	any function edit( event, rc, prc ){

		prc.recipe = recipeService.get(rc.id);

		if ( prc.recipe.getUser().getUserId() != securityService.getLoggedInUser().getUserID() ) {
			relocate("recipes");
		}
		
		event.setView("recipes/form");
	}

	/**
	* add
	*/
	any function new( event, rc, prc ){

		prc.recipe = recipeService.get();
		
		event.setView("recipes/form");
	}

	/**
	* save
	*/
	any function save( event, rc, prc ){

		event.paramValue("id",0);
		event.paramValue("isPublic",false);

		var recipe = populateModel(recipeService.get(rc.id));

		if (recipe.getUser().getUserId() == 0) {
			var user = securityService.getLoggedInUser();
			recipe.setUser(user);
		}
		else if ( recipe.getUser().getUserId() != securityService.getLoggedInUser().getUserID() ) {
			throw("Unauthorized access");
		}

		recipeService.save(recipe);
		
		relocate("recipes.#recipe.getRecipeId()#");
	}

	/**
	* delete
	*/
	any function delete( event, rc, prc ){

		var recipe = recipeService.get(rc.id);

		if ( recipe.getUser().getUserId() != securityService.getLoggedInUser().getUserID() ) {
			throw("Unauthorized access");
		}

		recipeService.delete(recipe);
		
		relocate("recipes");
	}


}