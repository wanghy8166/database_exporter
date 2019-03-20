SELECT vcInstanceName, tiSystemCPUUtilization 
FROM PerformanceAnalysis.vwCPUHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM PerformanceAnalysis.vwPolling)