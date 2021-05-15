  -- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;


CREATE TABLE PRIORITYSYS(
    sysname CHAR(20) NOT NULL,
    prioritynum INTEGER,
    PRIMARY KEY (sysname)
);

CREATE TABLE PERSON
(
    insNum INTEGER NOT NULL UNIQUE,
    pname CHAR(50) NOT NULL,
    pphone INTEGER NOT NULL ,
    paddress CHAR (100) NOT NULL ,
    pbirthdate DATE NOT NULL ,
    gender CHAR(1),
    pregdate DATE NOT NULL ,
    category CHAR(20),
    PRIMARY KEY (insNum),
    FOREIGN KEY (category) REFERENCES PRIORITYSYS(sysname)
);

CREATE TABLE VACLOCATION(
    locname CHAR(20) NOT NULL UNIQUE,
    vcity CHAR (15),
    vpostalcode CHAR (6),
    vstreetadr CHAR (100),
    PRIMARY KEY (locname)
);
CREATE TABLE VACDATES(
    location CHAR(20) NOT NULL ,
    vdate DATE NOT NULL UNIQUE,
    PRIMARY KEY (location, vdate),
    FOREIGN KEY (location) REFERENCES VACLOCATION(locname)
);
CREATE TABLE LOCCAPACITY(
    locname CHAR(20) NOT NULL,
    day DATE NOT NULL UNIQUE ,
    capacity INTEGER NOT NULL,
    PRIMARY KEY (locname, day),
    FOREIGN KEY (locname,day) REFERENCES VACDATES(location,vdate)
);

CREATE TABLE  HOSPITAL(
    hname CHAR (20) NOT NULL ,
    PRIMARY KEY (hname),
    FOREIGN KEY (hname) REFERENCES VACLOCATION(locname)
);

CREATE TABLE NURSE(
    licensenum INTEGER NOT NULL,
    nname CHAR(50) NOT NULL,
    hname CHAR(20),
    PRIMARY KEY (licensenum),
    FOREIGN KEY (hname) REFERENCES  HOSPITAL
);

CREATE TABLE  NURSEASSIGNMENTS(
    licensenum INTEGER NOT NULL,
    location CHAR(20) NOT NULL,
    vdate DATE NOT NULL,
    PRIMARY KEY (licensenum, location, vdate),
    FOREIGN KEY (licensenum) REFERENCES NURSE,
    FOREIGN KEY (location, vdate) REFERENCES VACDATES
);
CREATE TABLE VACCINE(
    vname CHAR (15) NOT NULL ,
    vnumdoses INTEGER NOT  NULL,
    vcompany CHAR (15),
    vwaitperiod INTEGER,
    PRIMARY KEY  (vname)
);

CREATE TABLE  VACCINEBATCH(
    vbid INTEGER NOT NULL,
    vbcompany CHAR (15) NOT NULL ,
    vaccine CHAR (15) NOT NULL ,
    manufdate DATE NOT NULL,
    expirydate DATE NOT NULL,
    PRIMARY KEY (vbid, vbcompany, vaccine),
    FOREIGN KEY (vaccine) REFERENCES VACCINE(vname)
);

CREATE  TABLE VIAL(
    vialid INTEGER NOT NULL,
    vbid INTEGER NOT NULL,
    vaccine CHAR (15) NOT NULL ,
    vbcompany CHAR (15) NOT NULL ,
    PRIMARY KEY (vialid, vbid, vbcompany, vaccine),
    FOREIGN KEY (vbid,vbcompany,vaccine) REFERENCES  VACCINEBATCH(vbid, vbcompany,vaccine)
);

CREATE TABLE  SENDBATCH (
    locname CHAR(20) NOT NULL ,
    vbid INTEGER NOT NULL ,
    vbcompany CHAR(15) NOT NULL,
    vaccine CHAR(15),
    vactotal INTEGER,
    PRIMARY KEY (locname, vbid, vbcompany ),
    FOREIGN KEY (locname) REFERENCES VACLOCATION,
    FOREIGN KEY  (vbid, vbcompany,vaccine) REFERENCES  VACCINEBATCH
);

CREATE TABLE SLOT(
    location CHAR(20) NOT NULL,
    vdate DATE NOT NULL,
    vtime TIME NOT NULL,
    sid INTEGER NOT NULL,
    insNum INTEGER,
    asndate DATE,
    licensenum INTEGER,
    vaccine CHAR(15),
    vbcompany CHAR(15),
    vbid INTEGER,
    vialid INTEGER,
    PRIMARY KEY (location, vdate, vtime,sid),
    FOREIGN KEY (location, vdate) REFERENCES VACDATES(location, vdate),
    FOREIGN KEY (licensenum) REFERENCES NURSE,
    FOREIGN KEY (insNum) REFERENCES PERSON,
    FOREIGN KEY (vaccine,vbcompany, vbid, vialid) REFERENCES VIAL(vaccine,vbcompany, vbid, vialid)
);
