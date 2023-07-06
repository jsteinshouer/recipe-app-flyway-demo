/**
*
* Database Migration using Flyway
*
*/
component output="false" singleton="true" {
	
	/**
	 *
	 * Constructor
	 * 
	 * @util.inject coldbox.system.core.util.Util
	 *
	 */
	public any function init( dsn = "RecipeBox", util = new coldbox.system.core.util.Util() ) {

		var serviceFactory = createObject("java", "coldfusion.server.ServiceFactory");
		var datasourceService = serviceFactory.getDataSourceService();
		var ds = datasourceService.getDatasource( arguments.dsn );
		var directory = getDirectoryFromPath( expandPath("/") );
		variables.flyway = createObject("java","org.flywaydb.core.Flyway")
			.configure()
			.locations( javaCast("string[]",["filesystem:/db/migration"] ) )
			// .locations( javaCast("string[]",["filesystem:#lcase(directory)#db\migration"] ) )
			.dataSource(ds)
			.load();

		// var DB_HOST = util.getSystemSetting("DB_HOST");
		// var DB_NAME = util.getSystemSetting("DB_NAME");
		// var DB_USER = util.getSystemSetting("DB_USER");
		// var DB_PASSWORD = util.getSystemSetting("DB_PASSWORD");
		// flyway = createObject("java","org.flywaydb.core.Flyway")
		// 	.configure()
		// 	.dataSource("jdbc:sqlserver://#DB_HOST#/#DB_NAME#:1433;databaseName=#DB_NAME#",DB_USER,DB_PASSWORD);
		// flyway.setLocations( ["filesystem:#directory#\db\migrations"] );
		
		return this;
	}

	/**
	*
	* Migrate the database
	*
	*/
	public void function migrate() {

		var out = flyway.migrate();
		// writeDump(flyway.getConfiguration().getLocations()[1].toString());
		writeDump(out.migrations);abort;
	}
	
	
}