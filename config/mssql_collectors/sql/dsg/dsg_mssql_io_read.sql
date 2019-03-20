SELECT vcInstanceName,vcDatabaseNAme,snLogicalFileName,vcFileType,biReadLatency
FROM PerformanceAnalysis.vwIOHealth
WHERE biPollingID = (SELECT MAX(biPollingID) FROM PerformanceAnalysis.vwPolling)