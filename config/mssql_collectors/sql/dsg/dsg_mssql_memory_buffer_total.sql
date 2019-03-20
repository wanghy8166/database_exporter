SELECT 
vcInstanceName, vcDBName, iDBTotalBufferPages
FROM PerformanceAnalysis.vwMemoryBufferHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM PerformanceAnalysis.vwPolling)