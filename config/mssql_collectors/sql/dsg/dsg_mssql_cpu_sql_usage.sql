SELECT vcInstanceName, tiSQLCPUUtilization 
FROM DBA_Management.PerformanceAnalysis.vwCPUHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM DBA_Management.PerformanceAnalysis.vwPolling)