SELECT vcInstanceName, dBufferCacheHitRatio
FROM PerformanceAnalysis.vwCacheHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM PerformanceAnalysis.vwPolling)