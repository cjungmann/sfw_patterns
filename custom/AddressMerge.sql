USE SFW_Patterns;
DELIMITER $$

DROP PROCEDURE IF EXISTS App_AddressMerge_State_Lookup $$
CREATE PROCEDURE App_AddressMerge_State_Lookup()
BEGIN
   SELECT * FROM State;
END $$

-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_List $$
CREATE PROCEDURE App_AddressMerge_List(id INT UNSIGNED)
BEGIN
   SELECT a.id,
          a.zone,
          a.street,
          a.city,
          a.state
     FROM Address a
    WHERE (id IS NULL OR a.id = id);

    CALL App_AddressMerge_State_Lookup();
END  $$

-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Add $$
CREATE PROCEDURE App_AddressMerge_Add(zone VARCHAR(12),
                                 street VARCHAR(50),
                                 city VARCHAR(30),
                                 state VARCHAR(30))
BEGIN
   DECLARE newid INT UNSIGNED;
   DECLARE rcount INT UNSIGNED;

   INSERT INTO Address
          (zone, 
           street, 
           city, 
           state)
   VALUES (zone, 
           street, 
           city, 
           state);

   SELECT ROW_COUNT() INTO rcount;
   IF rcount > 0 THEN
      SET newid = LAST_INSERT_ID();
      CALL App_AddressMerge_List(newid);
   END IF;
END  $$


-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Read $$
CREATE PROCEDURE App_AddressMerge_Read(id INT UNSIGNED)
BEGIN
   SELECT a.id,
          a.zone,
          a.street,
          a.city,
          a.state
     FROM Address a
    WHERE (id IS NULL OR a.id = id);
END  $$


-- ------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Value $$
CREATE PROCEDURE App_AddressMerge_Value(id INT UNSIGNED)
BEGIN
   SELECT a.id,
          a.zone,
          a.street,
          a.city,
          a.state
     FROM Address a
    WHERE a.id = id;
END $$


-- -------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Update $$
CREATE PROCEDURE App_AddressMerge_Update(id INT UNSIGNED,
                                    zone VARCHAR(12),
                                    street VARCHAR(50),
                                    city VARCHAR(30),
                                    state VARCHAR(30))
BEGIN
   UPDATE Address a
      SET a.zone = zone,
          a.street = street,
          a.city = city,
          a.state = state
    WHERE a.id = id;

   IF ROW_COUNT() > 0 THEN
      CALL App_AddressMerge_List(id);
   END IF;
END $$



-- -------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Delete $$
CREATE PROCEDURE App_AddressMerge_Delete(id INT UNSIGNED)
BEGIN
   DELETE
     FROM a USING Address AS a
    WHERE a.id = id;

   SELECT ROW_COUNT() AS deleted;
END  $$

DELIMITER ;
