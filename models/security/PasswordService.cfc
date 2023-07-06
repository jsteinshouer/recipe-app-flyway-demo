/* 
* Password service
*/
component singleton {

	property name="DISALLOWED_PASSWORDS";
	property name="bcrypt" inject="BCrypt@BCrypt";
	property name="wirebox" inject="wirebox";
	property name="passwordEstimator" inject="security.PasswordStrengthEstimator";
	

	/**
	 * Constructor
	 * 
	 * @blockedPasswordsFile.inject coldbox:setting:DISALLOWED_PASSWORDS_FILE
	 */ 
	public PasswordService function init( required string blockedPasswordsFile ) {

		DISALLOWED_PASSWORDS = loadDisallowed( arguments.blockedPasswordsFile );

		return this;
	}

	/**
	* Hash a password using bcrypt
	*/
	public string function hashPassword( required string password ) {

		return bcrypt.hashPassword( arguments.password );
	}

	/**
	* Check the hashed password using bcrypt.
	*/
	public string function checkPassword( required string password, required string hash ) {

		return bcrypt.checkPassword( arguments.password, arguments.hash );
	}


	/**
	* Check if a password is allowed
	*/
	public boolean function isAllowed( required string password ) {

		return !DISALLOWED_PASSWORDS.find( lcase( arguments.password ) );
	}

	/**
	* Check if a password is valid
	*/
	public models.util.ValidationResult function validatePassword( required string password ) {

		var validationResult = wirebox.getInstance("util.ValidationResult");

		/* Must be at least 8 characters long */
		if ( arguments.password.len() < 8 ) {
			validationResult.addError("The password must be at least 8 characters.");
		}

		/* Make sure estimator score is not too weak */
		var estimate = passwordEstimator.estimate( arguments.password );
		if ( estimate.getScore() < 2 ) {
			// writeDump(estimate);abort;
			var message = "The password is too weak.";
			if ( estimate.getWarning().len() ) {
				message &= " " & estimate.getWarning();
			}

			message &= " " & estimate.getSuggestions().toList(", ");
			validationResult.addError(message);
		}

		/* Is the password allowed? */
		if ( !isAllowed( arguments.password ) ) {
			validationResult.addError("Your password is not allowed because it is too common!");
		}

		return validationResult;
	}

	/**
	* Load a Disallowed
	*/
	private array function loadDisallowed( required string blockedPasswordsFile ) {
		var disallowedList = [];

		if ( arguments.blockedPasswordsFile.len() == 0 ) {
			disallowedList = loadDisallowedFromURL( "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10k-most-common.txt" );
		}
		else if ( isValid( "URL", arguments.blockedPasswordsFile ) ) {
			disallowedList = loadDisallowedFromURL( arguments.blockedPasswordsFile );
		}
		else if ( fileExists( arguments.blockedPasswordsFile ) ){
			disallowedList = loadDisallowedFromFile( arguments.blockedPasswordsFile );
		}
		
		return disallowedList;
	}

	/**
	* Load the disallowed password list from file
	*/
	private array function loadDisallowedFromFile( required string file ) {
		var disallowedList = [];

		try {
			disallowedList = listToArray( 
				fileRead( arguments.file ), 
				chr(10) & chr(13) 
			);
		}
		catch(any e) { }
		
		return disallowedList;
	}

	/**
	* Load a disallowed password list from url
	*/
	private array function loadDisallowedFromURL( required string url ) {
		var disallowedList = [];
		var httpResult = "";

		try {
			cfhttp( url = arguments.url, result = "httpResult"  );
			disallowedList = listToArray( 
				httpResult.fileContent, 
				chr(10) & chr(13) 
			);
		}
		catch(any e) {}
		
		return disallowedList;
		
	}

}