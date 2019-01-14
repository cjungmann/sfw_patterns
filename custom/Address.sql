USE SFW_Patterns;
DELIMITER $$

DROP PROCEDURE IF EXISTS App_Address_State_Lookup $$
CREATE PROCEDURE App_Address_State_Lookup()
BEGIN
   SELECT * FROM State;
END $$

-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_Address_List $$
CREATE PROCEDURE App_Address_List(id INT UNSIGNED)
BEGIN
   SELECT a.id,
          a.type,
          a.street,
          a.city,
          a.state
     FROM Address a
    WHERE (id IS NULL OR a.id = id);

    CALL App_Address_State_Lookup();
END  $$

-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_Address_Add $$
CREATE PROCEDURE App_Address_Add(type VARCHAR(12),
                                 street VARCHAR(50),
                                 city VARCHAR(30),
                                 state VARCHAR(30))
BEGIN
   DECLARE newid INT UNSIGNED;
   DECLARE rcount INT UNSIGNED;

   INSERT INTO Address
          (type, 
           street, 
           city, 
           state)
   VALUES (type, 
           street, 
           city, 
           state);

   SELECT ROW_COUNT() INTO rcount;
   IF rcount > 0 THEN
      SET newid = LAST_INSERT_ID();
      CALL App_Address_List(newid);
   END IF;
END  $$


-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_Address_Read $$
CREATE PROCEDURE App_Address_Read(id INT UNSIGNED)
BEGIN
   SELECT a.id,
          a.type,
          a.street,
          a.city,
          a.state
     FROM Address a
    WHERE (id IS NULL OR a.id = id);

    CALL App_Address_State_Lookup();
END  $$


-- ------------------------------------------
DROP PROCEDURE IF EXISTS App_Address_Value $$
CREATE PROCEDURE App_Address_Value(id INT UNSIGNED)
BEGIN
   SELECT a.id,
          a.type,
          a.street,
          a.city,
          a.state
     FROM Address a
    WHERE a.id = id;

    CALL App_Address_State_Lookup();
END $$


-- -------------------------------------------
DROP PROCEDURE IF EXISTS App_Address_Update $$
CREATE PROCEDURE App_Address_Update(id INT UNSIGNED,
                                    type VARCHAR(12),
                                    street VARCHAR(50),
                                    city VARCHAR(30),
                                    state VARCHAR(30))
BEGIN
   UPDATE Address a
      SET a.type = type,
          a.street = street,
          a.city = city,
          a.state = state
    WHERE a.id = id;

   IF ROW_COUNT() > 0 THEN
      CALL App_Address_List(id);
   END IF;
END $$



-- -------------------------------------------
DROP PROCEDURE IF EXISTS App_Address_Delete $$
CREATE PROCEDURE App_Address_Delete(id INT UNSIGNED)
BEGIN
   DELETE
     FROM a USING Address AS a
    WHERE a.id = id;

   SELECT ROW_COUNT() AS deleted;
END  $$

DELIMITER ;
