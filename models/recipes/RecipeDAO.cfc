/**
*
* @file  models/recipes/RecipeDAO.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {

	property name="userService" inject="users.UserService";

	public any function read(recipe) {

		var q = queryExecute(
			"
				SELECT 
					recipe_id,
					title,
					description,
					ingredients,
					directions,
					user_id,
					is_public
				FROM recipe
				WHERE 
					recipe_id = :recipeId
			",
			{
				recipeId = recipe.getRecipeId()
			}
		);

		if (q.recordCount) {
			recipe.setTitle(q.title);
			recipe.setDescription(q.description);
			recipe.setIngredients(q.ingredients);
			recipe.setDirections(q.directions);
			recipe.setUser(userService.get(q.user_id));
			recipe.setIsPublic(q.is_public);
		}
		
		return recipe;
	}

	public any function create(recipe) {
		var q = "";
		queryExecute(
			"
				INSERT INTO recipe (
					title,
					description,
					ingredients,
					directions,
					user_id,
					is_public
				)
				VALUES (
					:title,
					:description,
					:ingredients,
					:directions,
					:userId,
					:isPublic
				);
			",
			{
				title = recipe.getTitle(),
				description = recipe.getDescription(),
				ingredients = recipe.getIngredients(),
				directions = recipe.getDirections(),
				userId = recipe.getUser().getUserId(),
				isPublic = recipe.getIsPublic()
			},
			{
				result = "q"
			}
		);

		/* Set the id */
		recipe.setRecipeId(q.GeneratedKey);
		
		return recipe;
	}


	public any function update(recipe) {

		var q = queryExecute(
			"
				UPDATE recipe 
				SET
					title = :title,
					description = :description,
					ingredients = :ingredients,
					directions = :directions,
					user_id = :userId,
					is_public = :isPublic
				WHERE
					recipe_id = :recipeId
			",
			{
				recipeId = recipe.getRecipeId(),
				title = recipe.getTitle(),
				description = recipe.getDescription(),
				ingredients = recipe.getIngredients(),
				directions = recipe.getDirections(),
				userId = recipe.getUser().getUserId(),
				isPublic = recipe.getIsPublic()
			}
		);
		
		return recipe;
	}


	public void function delete(recipe) {
		
		var q = queryExecute(
			"
				DELETE
				FROM recipe
				WHERE 
					recipe_id = :recipeId
			",
			{
				recipeId = recipe.getRecipeId()
			}
		);
	}
	
	
}