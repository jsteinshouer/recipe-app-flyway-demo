/**
*
* Recipe Entity
* 
* @file  models/recipes/Recipe.cfc
* @author  Jason Steinshouer
* @description Recipe bean
*
*/
component output="false"  accessors="true" extends="models.BaseEntity" {

	property name="recipeID" type="numeric";
	property name="title" type="string";
	property name="description" type="string";
	property name="ingredients" type="string";
	property name="directions" type="string";
	property name="user" type="any";
	property name="isPublic" type="boolean" default="false";

	/**
	* Constructor
	* 
	* @user.inject users.User
	* 
	* @recipeId.hint Recipe identifier
	* @title.hint Recipe Title
	* @description.hint Recipe description
	* @directions.hint Receipe directions
	* @user.hint users.User Recipe owner
	* @isPublic.hint Is the recipe public (Meaning anyone can view it)
	*/
	public function init(
		recipeID = 0,
		title = "",
		description = "",
		ingredients = "",
		directions = "",
		user,
		isPublic = false
	){
		setRecipeID(arguments.recipeID);
		setTitle(arguments.title);
		setDescription(arguments.description);
		setIngredients(arguments.ingredients);
		setDirections(arguments.directions);
		setUser(arguments.user);
		setIsPublic(arguments.isPublic);


		return this;
	}
	
	
}