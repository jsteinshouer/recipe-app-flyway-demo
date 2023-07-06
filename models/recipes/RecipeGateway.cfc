/**
*
* @file  models/recipes/RecipeGateway.cfc
* @author  
* @description
*
*/

component output="false" displayname="ReceipeGateway"  {

	property name="userService" inject="users.UserService";
	property name="beanFactory" inject="wirebox";

	public any function getByUserID( required numeric userID ) {

		var recipes = [];

		var sql = "
				SELECT 
					recipe_id,
					title,
					description,
					ingredients,
					directions,
					user_id
				FROM recipe
				WHERE user_id = :userID
			";

		var params = {
			userID = { value=arguments.userID, cfsqltype="integer" }
		};

		var q = queryExecute(sql,params);

		if (q.recordCount) {

			for (var item in q) {
				var recipe = beanFactory.getInstance("recipes.Recipe");
				recipe.setRecipeId(item.recipe_id);
				recipe.setTitle(item.title);
				recipe.setDescription(item.description);
				recipe.setIngredients(item.ingredients);
				recipe.setDirections(item.directions);
				recipe.setUser(userService.get(item.user_id));
				recipes.append(recipe);
			}
		}
		
		return recipes;
	}
	
	
	
	
	
}