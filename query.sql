-- Include your drop table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
-- CONNECT TO cs421;

-- Remember to put the drop table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been dropped (reverse of the creation order).

-- This is only an example of how you add drop table ddls to this file.
--   You may remove it.

-- 4a
SELECT vdate, vtime
FROM SLOT
WHERE vdate = '2021-05-20' AND asndate is null AND location = 'Jewish General';

-- 4b
SELECT expirydate
FROM  SLOT s, VACCINEBATCH vb
WHERE s.vbid = vb.vbid AND s.vdate = '2021-02-06' AND s.insnum = (SELECT insnum
    FROM PERSON p
    WHERE p.pname = 'Jane Doe' );

-- 4c
SELECT COUNT(SID)
FROM SLOT s, VACLOCATION v
WHERE s.location = v.locname AND v.vcity = 'Montreal' AND s.vdate = '2021-02-06' AND vialid is not null;

-- 4d
SELECT pname, pphone, p.insnum
FROM PERSON p, SLOT s
WHERE p.insnum = s.insnum AND s.vaccine = 'Pfizer-BioNTech' AND s.vdate < '2021-02-01' AND
      p.insnum NOT IN
    (SELECT MAX(s.insnum)
    FROM person p, slot s
    where p.insnum = s.insnum);


-- 4d
SELECT category, COUNT(DISTINCT p.INSNUM)
FROM PERSON p, SLOT s
WHERE p.insnum = s.insnum AND s.vialid is not null
GROUP BY category;

-- mtlnurse
drop table mtlnurses;
CREATE TABLE MTLNURSES
AS (
    SELECT n.licensenum, n.nname, n.hname, v.vpostalcode, v.vstreetadr
    FROM NURSE n, HOSPITAL h, VACLOCATION v
    WHERE n.hname = h.hname AND h.hname = v.locname AND v.vcity = 'Montreal')
    WITH DATA;

SELECT *
FROM MTLNURSES
LIMIT 5;

SELECT *
FROM MTLNURSES
WHERE hname = 'Jewish General'
LIMIT 5;

INSERT INTO MTLNURSES VALUES (4144, 'Tommy McCullough', 'Jewish General');
SELECT *
FROM MTLNURSES
WHERE hname = 'Jewish General'
LIMIT 5;
-- is not added because when the table was created the record was not added

-- 6
ALTER TABLE VACCINEBATCH
ADD CONSTRAINT check_expiry
CHECK ( manufdate < expirydate );


INSERT INTO VACCINEBATCH VALUES
(113,'Pfizer', 'Pfizer-BioNTech','2021-07-01','2021-05-06');

