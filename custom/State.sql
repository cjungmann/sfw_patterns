USE SFW_Patterns;
DELIMITER $$

-- ---------------------------------------
DROP PROCEDURE IF EXISTS App_State_List $$
CREATE PROCEDURE App_State_List(id INT UNSIGNED)
BEGIN
   SELECT s.id,
          s.name,
          s.abbreviation
     FROM State s
    WHERE (id IS NULL OR s.id = id);
END  $$


-- --------------------------------------
DROP PROCEDURE IF EXISTS App_State_Add $$
CREATE PROCEDURE App_State_Add(name VARCHAR(30),
                               abbreviation CHAR(2))
BEGIN
   DECLARE newid INT UNSIGNED;
   DECLARE rcount INT UNSIGNED;

   INSERT INTO State
          (name, 
           abbreviation)
   VALUES (name, 
           abbreviation);

   SELECT ROW_COUNT() INTO rcount;
   IF rcount > 0 THEN
      SET newid = LAST_INSERT_ID();
      CALL App_State_List(newid);
   END IF;
END  $$


-- ---------------------------------------
DROP PROCEDURE IF EXISTS App_State_Read $$
CREATE PROCEDURE App_State_Read(id INT UNSIGNED)
BEGIN
   SELECT s.id,
          s.name,
          s.abbreviation
     FROM State s
    WHERE (id IS NULL OR s.id = id);
END  $$


-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_State_Value $$
CREATE PROCEDURE App_State_Value(id INT UNSIGNED)
BEGIN
   SELECT s.id,
          s.name,
          s.abbreviation
     FROM State s
    WHERE s.id = id;
END $$


-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_State_Update $$
CREATE PROCEDURE App_State_Update(id INT UNSIGNED,
                                  name VARCHAR(30),
                                  abbreviation CHAR(2))
BEGIN
   UPDATE State s
      SET s.name = name,
          s.abbreviation = abbreviation
    WHERE s.id = id;

   IF ROW_COUNT() > 0 THEN
      CALL App_State_List(id);
   END IF;
END $$



-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_State_Delete $$
CREATE PROCEDURE App_State_Delete(id INT UNSIGNED)
BEGIN
   DELETE
     FROM s USING State AS s
    WHERE s.id = id;

   SELECT ROW_COUNT() AS deleted;
END  $$

DELIMITER ;
