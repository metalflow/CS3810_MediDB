CREATE SCHEMA IF NOT EXISTS CS3810_MediDB;

USE CS3810_MediDB;

CREATE TABLE IF NOT EXISTS HOSPITAL (
    HOS_ID INT PRIMARY KEY,
    HOS_NAME VARCHAR(255),
    HOS_PHYS_ADDRESS VARCHAR(255),
    HOS_MAIL_ADDRESS VARCHAR(255),
    HOS_BILL_ADDRESS VARCHAR(255),
    HOS_BILL_PHONE CHAR(10),
    HOS_PC_PHONE VARCHAR(255),
    HOS_HR_PHONE VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS PATIENT (
    PAT_ID INT PRIMARY KEY,
    PAT_NAME VARCHAR(255),
    PAT_DOB DATE,
    PAT_SEX CHAR(1),
    PAT_HEIGHT VARCHAR(255),
    PAT_ETH VARCHAR(255),
    PAT_MAIL_ADDRESS VARCHAR(255),
    PAT_PHONE VARCHAR(255),
    PAT_SSN INT(9)
);

CREATE TABLE IF NOT EXISTS HISTORY_RECORD (
    HIST_REC_ID INT PRIMARY KEY,
    HIST_REC_ADMIT_DATE DATE,
    HIST_REC_ADMIT_TIME TIME,
    HIST_REC_ADMIT_EMP INT,
    HIST_REC_DISCH_DATE DATE,
    HIST_REC_DISCH_TIME TIME,
    HIST_REC_DISCH_EMP INT,
    HIST_REC_HEIGHT DECIMAL(3 , 2 ),
    HIST_REC_WEIGHT DECIMAL(3 , 2 )
);

CREATE TABLE IF NOT EXISTS EMPLOYEE (
    EMP_ID INT PRIMARY KEY,
    EMP_NAME VARCHAR(255),
    EMP_MAIL_ADDRESSS VARCHAR(255),
    EMP_PHONE VARCHAR(255),
    EMP_TITLE VARCHAR(255),
    EMP_WAGE DECIMAL(9 , 2 ),
    EMP_SALARY DECIMAL(18 , 2 )
);

CREATE TABLE IF NOT EXISTS BILL (
    BILL_NUMBER INT PRIMARY KEY,
    BILL_PAT_NAME VARCHAR(255),
    BILL_PAT_MAILING_ADDRESS VARCHAR(255),
    BILL_PAT_PHONE VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS LOCATION_GROUP (
    LOC_GROUP_NAME VARCHAR(255),
    LOC_GROUP_HOS_ID INT,
    PRIMARY KEY (LOC_GROUP_NAME , LOC_GROUP_HOS_ID),
    FOREIGN KEY (LOC_GROUP_HOS_ID)
        REFERENCES HOSPITAL (HOS_ID)
);

CREATE TABLE IF NOT EXISTS LOCATION (
    LOC_ID INT PRIMARY KEY,
    LOC_NAME VARCHAR(255),
    LOC_RATE DECIMAL(6 , 2 ),
    LOC_PHONE VARCHAR(255),
    LOC_LOC_GROUP_NAME VARCHAR(255),
    LOC_HOS_ID INT,
    FOREIGN KEY (LOC_LOC_GROUP_NAME)
        REFERENCES LOCATION_GROUP (LOC_GROUP_NAME),
    FOREIGN KEY (LOC_HOS_ID)
        REFERENCES HOSPITAL (HOS_ID)
);

CREATE TABLE IF NOT EXISTS BILL_LINE (
    BILL_LINE_ITEM_NUMBER INT,
    BILL_NUMBER INT,
    LOC_NAME VARCHAR(255),
    LOC_RATE DECIMAL(6 , 2 ),
    LOC_TIME TIME,
    PRIMARY KEY (BILL_LINE_ITEM_NUMBER , BILL_NUMBER),
    FOREIGN KEY (BILL_NUMBER)
        REFERENCES BILL (BILL_NUMBER)
);

CREATE TABLE IF NOT EXISTS VISIT (
    VISIT_ID INT PRIMARY KEY,
    VISIT_ADMIT_DATE DATE,
    VISIT_ADMIT_TIME TIME,
    VISIT_DISCH_DATE DATE,
    VISIT_LOC_ID INT,
    VISIT_LOC_DATE_START DATE,
    VISIT_LOC_TIME_START TIME,
    VISIT_PAT_ID INT,
    VISIT_DISCH_EMP INT,
    VISIT_ADMIT_EMP INT,
    FOREIGN KEY (VISIT_LOC_ID)
        REFERENCES LOCATION (LOC_ID),
    FOREIGN KEY (VISIT_PAT_ID)
        REFERENCES PATIENT (PAT_ID),
    FOREIGN KEY (VISIT_DISCH_EMP)
        REFERENCES EMPLOYEE (EMP_ID),
    FOREIGN KEY (VISIT_ADMIT_EMP)
        REFERENCES EMPLOYEE (EMP_ID)
);

CREATE OR REPLACE PROCEDURE prc_new_detail 
	vid_num IN INT
	DECLARE 
	rentfee DECIMAL (8,2) := NULL,
	dailylatefee DECIMAL (8,2) := NULL
	BEGIN
		IF (SELECT VID_NUM FROM VIDEO 
			WHERE VID_NUM = vid_num) IS NOT NULL THEN
			SELECT PRICE_RENTFEE, PRICE_DAILYLATEFEE 
				INTO rentfee, dailylatefee
				FROM PRICE JOIN MOVIE JOIN VIDEO
				WHERE VID_NUM = vid_num;
			INSERT INTO DETAILRENTAL
				(VID_NUM, DETAIL_FEE, DETAIL_DUEDATE, DETAIL_DAILYLATEFEE, DETAIL_RETURNDATE)
				VALUES (vid_num, rentfee, ADDDATE(SYSDATE,15), dailylatefee, NULL);
		END IF;
	END;