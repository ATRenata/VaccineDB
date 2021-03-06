-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

INSERT INTO PRIORITYSYS
VALUES
    ('Health Worker',1),
    ('Elderly',1),
    ('ImmunCompromised',1),
    ('Teacher',2),
    ('Children',2),
    ('CloseFirstPriority',2),
    ('Essential Worker',3),
    ('CloseSecondPriority',3),
    ('Else',4);

INSERT INTO PERSON
VALUES
(586,'Jane Doe',91834634,'35907 Watsica Underpass Apt. 056 North Jarrett, NH 91134','1994-08-21','F','2020-04-01','Health Worker'),
(2019,'Abner Weimann',613550104,'563 Block Rapids\nEast Marquis, NY 81342','1950-11-30','M','2020-11-08','Elderly'),
(2034,'Trenton Pfeffer',40978111 ,'57131 Reina Rapid\nNorth Rosalynland, NJ 45768-2999','1986-10-31','M','2020-09-27','Teacher'),
(2133,'Ole Hickle',38250904,'697 McLaughlin Plains\nMakaylaborough, ND 22371','2012-03-08','F','2020-12-22','Children'),
(2294,'Bennie Grimes',53948640 ,'509 Erwin Pike Apt. 395\nLake Margaretchester, OR 35877-9497','1979-06-09','M','2020-10-11','CloseFirstPriority'),
(3492,'Ernie Stehr',82367491 ,'111 Juanita Divide Suite 229\nGoodwinstad, SC 45383-3152','2001-05-17','M','2020-11-24','Essential Worker'),
(4860,'Shanny Lehner MD',59441941 ,'2925 Kaylee Grove Suite 095\nWest Heidi, ID 37731','1987-01-21','F','2020-11-06','Else'),
(5553,'Sherwood Schulist',59948082 ,'35890 Williamson Crescent\nShawnaside, NJ 35972','2004-08-27','F','2020-04-13','CloseSecondPriority'),
(6335,'Jean Swaniawski V',16700371 ,'396 Eunice Estate\nHeathcoteville, VT 86854','2017-02-28','F','2020-08-07','Else'),
(9081,'Weston Durgan',39154847 ,'57596 Claudie Vista\nSouth Bessieside, AZ 55835','2000-02-02','M','2021-01-21','ImmunCompromised');

INSERT INTO VACLOCATION VALUES
    ('Jewish General','Montreal','H3T1E4','5767 Legare St'),
    ('General Hospital','Montreal','H3G1A4','1650 Cedar Ave'),
    ('Childrens Hospital','Montreal','H4A3J1','1001 Decarie Blvd'),
    ('CHUM','Montreal','H2X E4','1051 Rue Sanguinet'),
    ('Western Hospital','Toronto','M5T2S8','399 Bathurst St');

INSERT INTO HOSPITAL (hname) VALUES ('Jewish General');
INSERT INTO HOSPITAL (hname) VALUES ('General Hospital');
INSERT INTO HOSPITAL (hname) VALUES ('Childrens Hospital');
INSERT INTO HOSPITAL (hname) VALUES ('CHUM');
INSERT INTO HOSPITAL (hname) VALUES ('Western Hospital');


INSERT INTO NURSE VALUES
(4115, 'Princess McCullough', 'Jewish General'),
(4987, 'Mauricio Rempel', 'General Hospital'),
(5325, 'Charity Hegmann', 'Childrens Hospital'),
(5823, 'Brad Satterfield II', 'CHUM'),
(6440, 'Samara Johns', 'Western Hospital'),
(1012,'Tavares Bergnaum IV','Jewish General'),
(1241,'Alexandro Lueilwitz','Jewish General'),
(1816,'Rosalyn Steuber I','Childrens Hospital'),
(1910,'Stefan Steuber','Childrens Hospital'),
(3116,'Bettie Gutmann','Western Hospital'),
(1331,'Delfina Mohr','Jewish General'),
(1541,'Clementine Rath III','Jewish General'),
(2241,'Elmore Hartmann','Jewish General');


INSERT INTO NURSEASSIGNMENTS VALUES
(4115,'General Hospital', '2021-02-06'),
(4115,'Jewish General', '2021-07-19'),
(4115,'General Hospital', '2021-01-16'),
(4115,'General Hospital', '2021-01-29'),
(4987,'Jewish General', '2021-03-11'),
(4987,'Jewish General', '2021-12-02'),
(4987,'General Hospital', '2021-01-01'),
(4987,'Jewish General', '2021-05-20');


INSERT INTO VACDATES VALUES
('Jewish General','2021-07-19')
,('Jewish General','2021-05-20')
,('Jewish General','2021-05-21')
,('Jewish General','2021-06-03')
,('Jewish General','2021-12-02')
,('Jewish General','2021-03-11')
,('General Hospital','2021-12-08')
,('General Hospital','2021-09-30')
,('General Hospital','2021-01-16')
,('General Hospital','2021-01-13')
,('General Hospital','2021-04-19')
,('General Hospital','2021-02-06')
,('General Hospital','2021-01-01')
,('General Hospital','2021-01-29');


INSERT INTO SLOT
VALUES
('Jewish General','2021-05-20','08:36:28',535,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Jewish General','2021-05-20','15:24:21',1,6335,'2021-01-01',NULL,NULL,NULL,NULL,NULL),
('Jewish General','2021-05-20','12:51:18',2,4860,'2021-01-01',NULL,NULL,NULL,NULL,NULL),
('Jewish General','2021-05-20','12:40:18',3,3492,'2021-01-10',NULL,NULL,NULL,NULL,NULL),
('General Hospital','2021-12-08','02:32:01',88,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('General Hospital','2021-09-30','23:46:54',8,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Jewish General','2021-06-03','08:36:28',55,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('General Hospital','2021-01-16','07:39:44',12,2034,'2021-01-01',NULL,NULL,NULL,NULL,NULL),
('Jewish General','2021-12-02','09:26:15',53,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('General Hospital','2021-01-01','07:43:12',15,9081,'2020-05-21',NULL,NULL,NULL,NULL,NULL),
('General Hospital','2021-01-29','18:51:16',33,9081,'2020-12-22',NULL,NULL,NULL,NULL,NULL),
('General Hospital','2021-02-06','17:45:44',582,586,'2020-01-21',NULL,NULL,NULL,NULL,NULL),
('General Hospital','2021-01-13','17:15:44',52,2019,'2021-01-01',NULL,NULL,NULL,NULL,NULL);


INSERT INTO VACCINE VALUES
('Pfizer-BioNTech',2,'Pfizer',32),
('Moderna',2,'Moderna',37),
('AstraZeneca',2,'BARDA',38),
('Sputnik V',2,'Gamaleya',26),
('CoronaVac',2,'Sinovac',37);


INSERT INTO VACCINEBATCH VALUES
(11,'Pfizer', 'Pfizer-BioNTech','2021-01-01','2021-05-06'),
(1, 'Moderna','Moderna','2021-01-01','2021-05-12'),
(2,'BARDA','AstraZeneca','2021-01-01','2021-03-01'),
(3,'Gamaleya','Sputnik V','2021-01-01','2021-12-02'),
(32,'Sinovac','CoronaVac','2021-01-01','2021-05-26');



INSERT INTO VIAL VALUES (43,11,'Pfizer-BioNTech','Pfizer');
INSERT INTO VIAL VALUES (238,11,'Pfizer-BioNTech','Pfizer');
INSERT INTO VIAL VALUES (240,11,'Pfizer-BioNTech','Pfizer');
INSERT INTO VIAL VALUES (162,11,'Pfizer-BioNTech','Pfizer');
INSERT INTO VIAL VALUES (486,11,'Pfizer-BioNTech','Pfizer');
INSERT INTO VIAL VALUES (46,11,'Pfizer-BioNTech','Pfizer');
INSERT INTO VIAL VALUES (86,11,'Pfizer-BioNTech','Pfizer');
INSERT INTO VIAL VALUES (4846,11,'Pfizer-BioNTech','Pfizer');

UPDATE
    SLOT
SET
    licensenum = 4115,
    vaccine = 'Pfizer-BioNTech',
    vbcompany = 'Pfizer',
    vbid = 11,
    vialid = 43
WHERE insnum = 586;


UPDATE
    SLOT
SET
    licensenum = 4115,
    vaccine = 'Pfizer-BioNTech',
    vbcompany = 'Pfizer',
    vbid = 11,
    vialid = 162
WHERE insnum = 2019;


UPDATE
    SLOT
SET
    licensenum = 4115,
    vaccine = 'Pfizer-BioNTech',
    vbcompany = 'Pfizer',
    vbid = 11,
    vialid = 238
WHERE insnum = 2034;

-- last two will have two doses

UPDATE
    SLOT
SET
    licensenum = 4115,
    vaccine = 'Pfizer-BioNTech',
    vbcompany = 'Pfizer',
    vbid = 11,
    vialid = 240
WHERE insnum = 9081;


UPDATE
    SLOT
SET
    licensenum = 4987,
    vaccine = 'Pfizer-BioNTech',
    vbcompany = 'Pfizer',
    vbid = 11,
    vialid = 486
WHERE insnum = 9081;


UPDATE
    SLOT
SET
    licensenum = 4987,
    vaccine = 'Pfizer-BioNTech',
    vbcompany = 'Pfizer',
    vbid = 11,
    vialid = 46
WHERE insnum = 6335;


UPDATE
    SLOT
SET
    licensenum = 4987,
    vaccine = 'Pfizer-BioNTech',
    vbcompany = 'Pfizer',
    vbid = 11,
    vialid = 4846
WHERE insnum = 4860;

UPDATE
    SLOT
SET
    licensenum = 4987,
    vaccine = 'Pfizer-BioNTech',
    vbcompany = 'Pfizer',
    vbid = 11,
    vialid = 86
WHERE insnum = 3492;
