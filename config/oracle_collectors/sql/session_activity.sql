SELECT status "status", type "type", COUNT(*) "count"
FROM v$session GROUP BY status, type