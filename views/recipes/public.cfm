<cfoutput>
<h3>Public Recipes</h3>
<table class="table">
	<tbody>
		<cfloop array="#prc.recipes#" index="recipe">
		<tr>
			<td><a href="#event.buildLink("recipes.#recipe.getRecipeId()#")#">#recipe.getTitle()#</a></td>
			<td>#recipe.getDescription()#</td>
			<td>#recipe.getUser().getName()#</td>
		</tr>
		</cfloop>
	</tbody>
</table>
</cfoutput>