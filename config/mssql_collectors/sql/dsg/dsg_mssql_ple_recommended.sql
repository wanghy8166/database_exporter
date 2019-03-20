SELECT 
vcInstanceName,iPLERecommended
FROM PerformanceAnalysis.vwPLEHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM PerformanceAnalysis.vwPolling)