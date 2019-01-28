USE SFW_Patterns;
DELIMITER $$

-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_Feature_List $$
CREATE PROCEDURE App_Feature_List(id INT UNSIGNED)
BEGIN
   SELECT f.id,
          f.value
     FROM Feature f
    WHERE (id IS NULL OR f.id = id);
END  $$


-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_Feature_Add $$
CREATE PROCEDURE App_Feature_Add(value VARCHAR(30))
BEGIN
   DECLARE newid INT UNSIGNED;
   DECLARE rcount INT UNSIGNED;

   INSERT INTO Feature
          (value)
   VALUES (value);

   SELECT ROW_COUNT() INTO rcount;
   IF rcount > 0 THEN
      SET newid = LAST_INSERT_ID();
      CALL App_Feature_List(newid);
   END IF;
END  $$


-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_Feature_Read $$
CREATE PROCEDURE App_Feature_Read(id INT UNSIGNED)
BEGIN
   SELECT f.id,
          f.value
     FROM Feature f
    WHERE (id IS NULL OR f.id = id);
END  $$


-- ------------------------------------------
DROP PROCEDURE IF EXISTS App_Feature_Value $$
CREATE PROCEDURE App_Feature_Value(id INT UNSIGNED)
BEGIN
   SELECT f.id,
          f.value
     FROM Feature f
    WHERE f.id = id;
END $$


-- -------------------------------------------
DROP PROCEDURE IF EXISTS App_Feature_Update $$
CREATE PROCEDURE App_Feature_Update(id INT UNSIGNED,
                                    value VARCHAR(30))
BEGIN
   UPDATE Feature f
      SET f.value = value
    WHERE f.id = id;

   IF ROW_COUNT() > 0 THEN
      CALL App_Feature_List(id);
   END IF;
END $$



-- -------------------------------------------
DROP PROCEDURE IF EXISTS App_Feature_Delete $$
CREATE PROCEDURE App_Feature_Delete(id INT UNSIGNED)
BEGIN
   DELETE
     FROM f USING Feature AS f
    WHERE f.id = id;

   SELECT ROW_COUNT() AS deleted;
END  $$

DELIMITER ;
