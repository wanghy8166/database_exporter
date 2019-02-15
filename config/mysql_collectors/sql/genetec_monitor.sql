SELECT @@SERVERNAME AS servername
	,e.name as name
	,e.Description as description
	,SUBSTRING(UPPER(s.EventGroup), len(s.EventGroup) - 11, len(s.EventGroup)) AS macaddress
	,s.IsActive as inactive
FROM HealthMonitor.dbo.STATE s
INNER JOIN Directory.dbo.Entity e
	ON SUBSTRING(CONVERT(VARCHAR(36), guid), len(CONVERT(VARCHAR(36), guid)) - 11, len(CONVERT(VARCHAR(36), guid))) = SUBSTRING(UPPER(s.EventGroup), len(s.EventGroup) - 11, len(s.EventGroup))
WHERE e.type = 17