SELECT 
    vcInstanceName
    ,iRunnableTaskQueue 
FROM PerformanceAnalysis.vwCPUHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM PerformanceAnalysis.vwPolling)