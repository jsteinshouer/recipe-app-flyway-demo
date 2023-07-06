
ALTER TABLE dbo.[user] ADD two_factor_auth_enabled bit;
ALTER TABLE dbo.[user] ADD two_factor_auth_key nvarchar(50);

