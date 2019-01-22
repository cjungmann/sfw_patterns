USE SFW_Patterns;
DELIMITER $$

-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_Keyword_List $$
CREATE PROCEDURE App_Keyword_List(id INT UNSIGNED)
BEGIN
   SELECT k.id,
          k.value
     FROM Keyword k
    WHERE (id IS NULL OR k.id = id);
END  $$


-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_Keyword_Add $$
CREATE PROCEDURE App_Keyword_Add(value VARCHAR(30))
BEGIN
   DECLARE newid INT UNSIGNED;
   DECLARE rcount INT UNSIGNED;

   INSERT INTO Keyword
          (value)
   VALUES (value);

   SELECT ROW_COUNT() INTO rcount;
   IF rcount > 0 THEN
      SET newid = LAST_INSERT_ID();
      CALL App_Keyword_List(newid);
   END IF;
END  $$


-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_Keyword_Read $$
CREATE PROCEDURE App_Keyword_Read(id INT UNSIGNED)
BEGIN
   SELECT k.id,
          k.value
     FROM Keyword k
    WHERE (id IS NULL OR k.id = id);
END  $$


-- ------------------------------------------
DROP PROCEDURE IF EXISTS App_Keyword_Value $$
CREATE PROCEDURE App_Keyword_Value(id INT UNSIGNED)
BEGIN
   SELECT k.id,
          k.value
     FROM Keyword k
    WHERE k.id = id;
END $$


-- -------------------------------------------
DROP PROCEDURE IF EXISTS App_Keyword_Update $$
CREATE PROCEDURE App_Keyword_Update(id INT UNSIGNED,
                                    value VARCHAR(30))
BEGIN
   UPDATE Keyword k
      SET k.value = value
    WHERE k.id = id;

   IF ROW_COUNT() > 0 THEN
      CALL App_Keyword_List(id);
   END IF;
END $$



-- -------------------------------------------
DROP PROCEDURE IF EXISTS App_Keyword_Delete $$
CREATE PROCEDURE App_Keyword_Delete(id INT UNSIGNED)
BEGIN
   DELETE
     FROM k USING Keyword AS k
    WHERE k.id = id;

   SELECT ROW_COUNT() AS deleted;
END  $$

DELIMITER ;
