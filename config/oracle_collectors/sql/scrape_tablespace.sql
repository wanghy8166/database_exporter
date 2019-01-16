SELECT
  Z.name,
  dt.status,
  dt.contents,
  dt.extent_management,
  Z.bytes,
  Z.max_bytes,
  Z.free_bytes
FROM
(
  SELECT
    X.name                   as name,
    SUM(nvl(X.free_bytes,0)) as free_bytes,
    SUM(X.bytes)             as bytes,
    SUM(X.max_bytes)         as max_bytes
  FROM
    (
      SELECT
        ddf.tablespace_name as name,
        ddf.status as status,
        ddf.bytes as bytes,
        sum(coalesce(dfs.bytes, 0)) as free_bytes,
        CASE
          WHEN ddf.maxbytes = 0 THEN ddf.bytes
          ELSE ddf.maxbytes
        END as max_bytes
      FROM
        sys.dba_data_files ddf,
        sys.dba_tablespaces dt,
        sys.dba_free_space dfs
      WHERE ddf.tablespace_name = dt.tablespace_name
      AND ddf.file_id = dfs.file_id(+)
      GROUP BY
        ddf.tablespace_name,
        ddf.file_name,
        ddf.status,
        ddf.bytes,
        ddf.maxbytes
    ) X
  GROUP BY X.name
  UNION ALL
  SELECT
    Y.name                   as name,
    MAX(nvl(Y.free_bytes,0)) as free_bytes,
    SUM(Y.bytes)             as bytes,
    SUM(Y.max_bytes)         as max_bytes
  FROM
    (
      SELECT
        dtf.tablespace_name as name,
        dtf.status as status,
        dtf.bytes as bytes,
        (
          SELECT
            ((f.total_blocks - s.tot_used_blocks)*vp.value)
          FROM
            (SELECT tablespace_name, sum(used_blocks) tot_used_blocks FROM gv$sort_segment WHERE  tablespace_name!='DUMMY' GROUP BY tablespace_name) s,
            (SELECT tablespace_name, sum(blocks) total_blocks FROM dba_temp_files where tablespace_name !='DUMMY' GROUP BY tablespace_name) f,
            (SELECT value FROM v$parameter WHERE name = 'db_block_size') vp
          WHERE f.tablespace_name=s.tablespace_name AND f.tablespace_name = dtf.tablespace_name
        ) as free_bytes,
        CASE
          WHEN dtf.maxbytes = 0 THEN dtf.bytes
          ELSE dtf.maxbytes
        END as max_bytes
      FROM
        sys.dba_temp_files dtf
    ) Y
  GROUP BY Y.name
) Z, sys.dba_tablespaces dt
WHERE
  Z.name = dt.tablespace_name