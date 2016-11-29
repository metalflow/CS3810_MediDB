CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_add_location`(IN name varchar(255), IN rate decimal(6,2),IN phone varchar(255),IN loc_group varchar(255),IN hos int, OUT outstring varchar(255))
BEGIN
		IF loc_group is NULL then
			IF (SELECT HOS_ID FROM HOSPITAL WHERE HOS_ID=hos) IS NULL then
				SET outstring = 'Cannot add a location without a HOS_ID';
			ELSE  
				INSERT INTO LOCATION (LOC_NAME,LOC_RATE,LOC_PHONE,LOC_LOC_GROUP_NAME,LOC_LOC_GROUP_NAME,LOC_HOS_ID) VALUES (name,rate,phone,loc_group,hos);
				SET outstring = 'success';
			END IF;
		ELSE
			IF (SELECT LOC_GROUP_NAME FROM LOCATION_GROUP WHERE LOC_GROUP_NAME = loc_group) IS NULL then
				SET outstring = 'given location group does not exist';
			ELSE IF (SELECT HOS_ID FROM HOSPITAL WHERE HOS_ID=hos) IS NULL then
				SET outstring = 'Cannot add a location without a HOS_ID';
			ELSE
				INSERT INTO LOCATION (LOC_NAME,LOC_RATE,LOC_PHONE,LOC_LOC_GROUP_NAME,LOC_LOC_GROUP_NAME,LOC_HOS_ID) VALUES (name,rate,phone,loc_group,hos);
				SET outstring = 'success';
			END IF;
		END IF;
        END IF;
END