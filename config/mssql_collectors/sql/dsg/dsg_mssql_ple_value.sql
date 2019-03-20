SELECT 
vcInstanceName,iPLEValue
FROM PerformanceAnalysis.vwPLEHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM PerformanceAnalysis.vwPolling)