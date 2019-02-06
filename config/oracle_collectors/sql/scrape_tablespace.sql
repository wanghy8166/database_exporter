SELECT 
  a.tablespace_name "name",
  a.bytes "bytes_used",
  b.bytes "bytes_free", 
  a.bytes + b.bytes "max_bytes"
FROM (
	SELECT tablespace_name
		,sum(BYTES) bytes
	FROM dba_data_files
	GROUP BY tablespace_name
	) a
	,(
		SELECT tablespace_name
			,sum(BYTES) bytes
		FROM dba_free_space
		GROUP BY tablespace_name
		) b
WHERE a.tablespace_name = b.tablespace_name
ORDER BY ((a.bytes - b.bytes) / a.bytes) DESC