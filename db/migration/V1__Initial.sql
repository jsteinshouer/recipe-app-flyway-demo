
CREATE TABLE dbo.[user] (
	user_id int IDENTITY(1,1),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	username VARCHAR(50),
	password VARCHAR(150),
 	PRIMARY KEY (user_id)
);

CREATE TABLE dbo.recipe (
	recipe_id INT IDENTITY(1,1),
	title VARCHAR(50),
	description VARCHAR(100),
	ingredients VARCHAR(max),
	directions VARCHAR(max),
	user_id INT,
	PRIMARY KEY (recipe_id)
);