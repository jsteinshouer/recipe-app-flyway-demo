
ALTER TABLE dbo.[recipe] ADD is_public bit CONSTRAINT [df_recipe_is_public] DEFAULT 0 NOT NULL;
