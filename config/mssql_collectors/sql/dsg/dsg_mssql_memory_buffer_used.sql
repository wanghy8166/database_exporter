SELECT 
vcInstanceName, vcDBName, iDBUsedBufferPages
FROM PerformanceAnalysis.vwMemoryBufferHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM PerformanceAnalysis.vwPolling)