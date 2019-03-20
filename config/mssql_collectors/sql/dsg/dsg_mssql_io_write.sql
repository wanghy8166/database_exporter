SELECT vcInstanceName,vcDatabaseNAme,snLogicalFileName,vcFileType,biWriteLatency
FROM PerformanceAnalysis.vwIOHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM PerformanceAnalysis.vwPolling)