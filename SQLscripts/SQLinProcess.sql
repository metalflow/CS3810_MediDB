CREATE FUNCTION func_find_patient
	(IN fname VARCHAR(255),IN lname VARCHAR(255), IN dob DATE, IN sex CHAR(2), IN height DECIMAL(2 , 2 ), IN pat_weight DECIMAL(4 , 2 ), IN eth VARCHAR(255), IN mail VARCHAR(255), IN phone CHAR(12), IN ssn CHAR(11))
BEGIN
	DECLARE countofrecords INT;
	DECLARE pat_id INT;
	IF fname IS NULL OR lname IS NULL THEN
		RETURN -2;
	END IF;

	SELECT COUNT(*) INTO countofrecords FROM PATIENT WHERE PAT_FNAME = fname AND PAT_LNAME = lname;
	IF countofrecords = 1 THEN
		SELECT PAT_ID INTO pat_id FROM PATIENT WHERE PAT_FNAME = fname AND PAT_LNAME = lname;
		RETURN pat_id;
	END IF;

	CASE
		WHEN dob IS NOT NULL AND sex IS NOT NULL AND height IS NOT NULL AND pat_weight IS NOT NULL AND eth IS NOT NULL AND mail IS NOT NULL AND phone IS NOT NULL AND ssn IS NOT NULL THEN
			SELECT COUNT(*) INTO countofrecords FROM PATIENT WHERE PAT_FNAME = fname AND PAT_LNAME = lname AND PAT_DOB = dob AND PAT_SEX = sex AND PAT_HEIGHT = height AND PAT_WEIGHT = pat_weight AND PAT_ETH = eth AND PAT_MAIL_ADDRESS = mail AND PAT_PHONE = phone AND PAT_SSN = ssn;
			IF countofrecords = 1 THEN
				SELECT PAT_ID INTO pat_id FROM PATIENT WHERE PAT_FNAME = fname AND PAT_LNAME = lname AND PAT_DOB = dob AND PAT_SEX = sex AND PAT_HEIGHT = height AND PAT_WEIGHT = pat_weight AND PAT_ETH = eth AND PAT_MAIL_ADDRESS = mail AND PAT_PHONE = phone AND PAT_SSN = ssn;
				RETURN pat_id;
			ELSE
				RETURN -1;
			END IF;
		WHEN action = 'create' THEN
			INSERT INTO sometable (column) VALUES (value);
	END CASE

	RETURN -2;
END;

