SELECT
       p.pwtype,
       p.dpotyp,
       p.idistm,
       p.BYRNUM,
       b.BYRNAM,
       p.pocls,
       p.powstat,
       CASE
          WHEN p.PODESC LIKE '%Mass Create%'
          THEN 'Mass Create'
          WHEN b.BYRNUM = 986
          THEN 'VD2C'
          ELSE 'Primo'
       END AS Order_Source,
       count(DISTINCT ponum) AS purchaseOrderCount
FROM
       mm4r6lib.powrkarc p
       JOIN MM4R6LIB.TBLBYR b ON p.BYRNUM = b.BYRNUM
WHERE p.rpdate > 190000
  AND p.rpdate < 700000
GROUP BY
       p.pwtype,
       p.dpotyp,
       p.idistm,
       p.BYRNUM,
       b.BYRNAM,
       p.pocls,
       p.powstat,
              CASE
          WHEN p.PODESC LIKE '%Mass Create%'
          THEN 'Mass Create'
          WHEN b.BYRNUM = 986
          THEN 'VD2C'
          ELSE 'Primo'
       END
ORDER BY
       9 DESC;