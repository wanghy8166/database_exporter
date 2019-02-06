SELECT
   l1.sid AS "blocking_session", 
   l2.sid AS "blocked_session", 
   count(l2.sid) AS "blocking_count"
FROM
   v$lock l1, v$lock l2
WHERE
   l1.block = 1 AND
   l2.request > 0 AND
   l1.id1 = l2.id1 AND
   l1.id2 = l2.id2
GROUP BY l1.sid,l2.sid