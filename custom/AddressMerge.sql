USE SFW_Patterns;
DELIMITER $$

-- ------------------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_State_Lookup $$
CREATE PROCEDURE App_AddressMerge_State_Lookup()
BEGIN
   SELECT * FROM State;
END $$

-- --------------------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Keyword_Lookup $$
CREATE PROCEDURE App_AddressMerge_Keyword_Lookup()
BEGIN
   SELECT * FROM Keyword;
END $$

-- --------------------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Feature_Lookup $$
CREATE PROCEDURE App_AddressMerge_Feature_Lookup()
BEGIN
   SELECT * FROM Feature;
END $$

-- ---------------------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Keywords_Assign $$
CREATE PROCEDURE App_AddressMerge_Keywords_Assign(id_address INT UNSIGNED,
                                                  keywords TEXT)
BEGIN
   -- Using identifier qualifier (field name enclosed in backticks):
   DELETE FROM Keyword2Address 
    WHERE `id_address` = id_address;

   IF keywords IS NOT NULL AND LENGTH(keywords) > 0 THEN
      CALL ssys_make_SFW_IntTable_from_list(keywords);

      INSERT INTO Keyword2Address (id_address, id_keyword)
         SELECT id_address, t.val
           FROM SFW_IntTable t;

      DROP TABLE SFW_IntTable;
   END IF;
END $$

-- ---------------------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Features_Assign $$
CREATE PROCEDURE App_AddressMerge_Features_Assign(id_address INT UNSIGNED,
                                                  features TEXT)
BEGIN
   -- Using identifier qualifier (field name enclosed in backticks):
   DELETE FROM Feature2Address 
    WHERE `id_address` = id_address;

   IF features IS NOT NULL AND LENGTH(features) > 0 THEN
      CALL ssys_make_SFW_IntTable_from_list(features);

      INSERT INTO Feature2Address (id_address, id_feature, position)
         SELECT id_address, t.val, t.pos
           FROM SFW_IntTable t
       ORDER BY t.pos;

      DROP TABLE SFW_IntTable;
   END IF;
END $$

-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_List $$
CREATE PROCEDURE App_AddressMerge_List(id INT UNSIGNED)
BEGIN
   SELECT a.id,
          a.zone,
          a.street,
          a.city,
          a.state,
          GROUP_CONCAT(DISTINCT k.id_keyword) AS klist,
          GROUP_CONCAT(DISTINCT f.id_feature ORDER BY f.position) AS flist
     FROM Address a
          LEFT JOIN Keyword2Address k ON k.id_address = a.id
          LEFT JOIN Feature2Address f ON f.id_address = a.id
    WHERE (id IS NULL OR a.id = id)
    GROUP BY a.id;
--    GROUP BY a.id, a.zone, a.street, a.state;

    CALL App_AddressMerge_State_Lookup();
    CALL App_AddressMerge_Keyword_Lookup();
    CALL App_AddressMerge_Feature_Lookup();
END  $$

-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Add $$
CREATE PROCEDURE App_AddressMerge_Add(zone VARCHAR(12),
                                 street VARCHAR(50),
                                 city VARCHAR(30),
                                 state VARCHAR(30),
                                 klist TEXT,
                                 flist TEXT)
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
      CALL App_AddressMerge_Keywords_Assign(newid, klist);
      CALL App_AddressMerge_Features_Assign(newid, flist);

      -- Return new row for merging into client's result
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
          a.state,
          GROUP_CONCAT(DISTINCT k.id_keyword) AS klist,
          GROUP_CONCAT(DISTINCT f.id_feature ORDER BY f.position) AS flist
     FROM Address a
          LEFT JOIN Keyword2Address k ON k.id_address=a.id
          LEFT JOIN Feature2Address f ON f.id_address=a.id
    WHERE a.id = id
    GROUP BY a.id;
END  $$


-- ------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Value $$
CREATE PROCEDURE App_AddressMerge_Value(id INT UNSIGNED)
BEGIN
   SELECT a.id,
          a.zone,
          a.street,
          a.city,
          a.state,
          GROUP_CONCAT(DISTINCT k.id_keyword) AS klist,
          GROUP_CONCAT(DISTINCT f.id_feature ORDER BY f.position) AS flist
     FROM Address a
          LEFT JOIN Keyword2Address k ON k.id_address=a.id
          LEFT JOIN Feature2Address f ON f.id_address=a.id
    WHERE a.id = id
    GROUP BY a.id;
END $$


-- -------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Update $$
CREATE PROCEDURE App_AddressMerge_Update(id INT UNSIGNED,
                                    zone VARCHAR(12),
                                    street VARCHAR(50),
                                    city VARCHAR(30),
                                    state VARCHAR(30),
                                    klist TEXT,
                                    flist TEXT)
BEGIN
   UPDATE Address a
      SET a.zone = zone,
          a.street = street,
          a.city = city,
          a.state = state
    WHERE a.id = id;

    -- Unconditional keywords update because ROW_COUNT()
    -- may be 0 if no other fields have changed.
    CALL App_AddressMerge_Keywords_Assign(id, klist);
    CALL App_AddressMerge_Features_Assign(id, flist);

    -- Unconditional record reflection because we can't
    -- tell if the keywords were changed.
    CALL App_AddressMerge_List(id);
END $$



-- -------------------------------------------
DROP PROCEDURE IF EXISTS App_AddressMerge_Delete $$
CREATE PROCEDURE App_AddressMerge_Delete(id INT UNSIGNED)
BEGIN
   DELETE FROM Keyword2Address
      WHERE id_address = id;
   DELETE FROM Feature2Address
      WHERE id_address = id;

   DELETE
     FROM a USING Address AS a
    WHERE a.id = id;

   SELECT ROW_COUNT() AS deleted;
END  $$

DELIMITER ;
