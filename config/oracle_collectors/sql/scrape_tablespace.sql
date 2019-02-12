SELECT    
    a.TABLESPACE_NAME AS "name",
    a.BYTES AS "bytes_used",
    b.BYTES AS "bytes_free",
    a.bytes+b.bytes AS "max_bytes",
    b.largest AS "largest_data_file",
    round(((a.BYTES-b.BYTES)/a.BYTES)*100,2) percent_used
FROM    
    (
        SELECT     
            TABLESPACE_NAME,
            sum(BYTES) BYTES
        FROM     dba_data_files
        GROUP     by TABLESPACE_NAME
    )
    a,
    (
        select     TABLESPACE_NAME,
            sum(BYTES) BYTES ,
            max(BYTES) largest
        from     dba_free_space
        group     by TABLESPACE_NAME
    )
    b
WHERE     a.TABLESPACE_NAME=b.TABLESPACE_NAME
ORDER     by ((a.BYTES-b.BYTES)/a.BYTES) desc