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
    PAT_FNAME VARCHAR(255),
    PAT_LNAME VARCHAR(255),
    PAT_DOB DATE,
    PAT_SEX CHAR(2),
    PAT_HEIGHT DECIMAL(2 , 2 ) COMMENT 'Stored in meters',
    PAT_WEIGHT DECIMAL(4 , 2 ) COMMENT 'Stored in kilograms',
    PAT_ETH VARCHAR(255),
    PAT_MAIL_ADDRESS VARCHAR(255),
    PAT_PHONE CHAR(12),
    PAT_SSN CHAR(11)
);

CREATE TABLE IF NOT EXISTS HISTORY_RECORD (
    HIST_REC_ID INT PRIMARY KEY,
    HIST_REC_ADMIT_DATE DATE,
    HIST_REC_ADMIT_TIME TIME,
    HIST_REC_ADMIT_EMP INT,
    HIST_REC_DISCH_DATE DATE,
    HIST_REC_DISCH_TIME TIME,
    HIST_REC_DISCH_EMP INT,
    HIST_REC_HEIGHT DECIMAL(3 , 2 ) COMMENT 'Stored in meters',
    HIST_REC_WEIGHT DECIMAL(3 , 2 ) COMMENT 'Stored in kilograms'
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

CREATE PROCEDURE prc_admit_patient
	(IN variable INT)
	BEGIN
END;

CREATE PROCEDURE prc_discharge_patient
	(IN variable INT)
	BEGIN
END;

CREATE PROCEDURE prc_transfer_patient
	(IN variable INT)
	BEGIN
END;

CREATE PROCEDURE prc_add_hospital
	(IN variable INT)
	BEGIN
END;

CREATE PROCEDURE prc_remove_hospital
	(IN variable INT)
	BEGIN
END;

CREATE PROCEDURE prc_add_employee
	(IN variable INT)
	BEGIN
END;

CREATE PROCEDURE prc_remove_employee
	(IN variable INT)
	BEGIN
END;

CREATE PROCEDURE prc_add_location_group
	(IN variable INT)
	BEGIN
END;

CREATE PROCEDURE prc_remove_location_group
	(IN variable INT)
	BEGIN
END;

CREATE PROCEDURE prc_add_location
	(IN variable INT)
	BEGIN
END;

CREATE PROCEDURE prc_remove_location
	(IN variable INT)
	BEGIN
END;

CREATE TRIGGER trg_update_bill
	BEFORE UPDATE ON VISIT
    FOR EACH ROW
	BEGIN
END;

CREATE TRIGGER trg_add_hist_rec
	BEFORE UPDATE ON VISIT
    FOR EACH ROW
	BEGIN
END;