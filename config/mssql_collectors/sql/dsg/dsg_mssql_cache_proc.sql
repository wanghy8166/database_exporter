SELECT vcInstanceName, dProcCacheHitRatio
FROM PerformanceAnalysis.vwCacheHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM PerformanceAnalysis.vwPolling)