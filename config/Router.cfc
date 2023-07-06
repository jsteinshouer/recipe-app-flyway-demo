component {

	function configure() {
		// Set Full Rewrites
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 *
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 *
		 */

        route(pattern="register")
            .withAction({ GET = "index", POST = "submit" } )
            .toHandler("Register");
        route(pattern="login/step2")
            .withAction({ GET = "step2", POST = "verifyCode" } )
            .toHandler("Security");
        route(pattern="login")
            .withAction({ GET = "login", POST = "authenticate" } )
            .toHandler("Security")
        route(pattern="recipes/new")
            .withAction("new")
            .toHandler("recipes");
        route(pattern="recipes/:id/:action")
            .toHandler("recipes");
        route(pattern="recipes/:id")
            .withAction("show")
            .toHandler("Recipes");
            
        route(pattern="recipes")
            .withAction("index")
            .toHandler("Recipes");
		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}