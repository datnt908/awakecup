-- use awakecup database
USE `awakecup`;

--
-- Create procedures and functions
-- 

-- create is_substr function
DROP function IF EXISTS `is_substr`;

DELIMITER $$
CREATE FUNCTION `is_substr` (
    substr VARCHAR(1024),
    str VARCHAR(1024)) RETURNS INT DETERMINISTIC
BEGIN
SET substr = LTRIM(RTRIM(substr));
IF substr IS NULL THEN SET substr = ''; END IF;
SET str = LTRIM(RTRIM(str));
IF str IS NULL THEN SET str = ''; END IF;
RETURN str LIKE CONCAT('%',CONVERT(substr,BINARY),'%');
END$$

DELIMITER ;

-- create category_table_query procedure
DROP procedure IF EXISTS `category_table_query`;

DELIMITER $$
CREATE PROCEDURE `category_table_query` (
    _ID INT, _Title VARCHAR(32), 
    _Search VARCHAR(32), _Sorting VARCHAR(32), _PageNo INT, _PageSize INT
)
BEGIN
    -- preprocessing input params
    SET _Title = LTRIM(RTRIM(_Title));
    SET _Search = LTRIM(RTRIM(_Search));
    IF _ID IS NULL THEN SET @ID = "NULL"; ELSE SET @ID = _ID; END IF;
    IF _Title IS NULL THEN SET @Title = "''"; ELSE SET @Title = CONCAT("'",_Title,"'"); END IF;
    IF _Search IS NULL THEN SET @Search = "''"; ELSE SET @Search = CONCAT("'",_Search,"'"); END IF;
    IF _Sorting IS NULL OR NOT (
        (_Sorting LIKE 'ID%' OR _Sorting LIKE 'CategoryTitle%') 
        AND (_Sorting LIKE '%ASC' OR _Sorting LIKE '%DESC')
    )THEN SET @Sorting = 'ID ASC'; ELSE SET @Sorting = _Sorting; END IF;
    IF (_PageSize IS NULL OR _PageSize = 0) THEN SET @Size = 1; ELSEIF _PageSize > 50 THEN SET @Size = 50; ELSE SET @Size = _PageSize; END IF;
    IF _PageNo IS NULL OR _PageNo = 0 THEN SET @Offset_ = 0; ELSE SET @Offset_ = @Size * (_PageNo - 1); END IF;
    -- build statements
    SET @WhereStmt = CONCAT("
        WHERE (",@ID," IS NULL OR ",@ID," = `ID`)
            AND is_substr(",@Title,", `CategoryTitle`) > 0
            AND (
                is_substr(",@Search,", `CategoryTitle`) > 0
            )
    ");
    SET @TotalStmt = CONCAT('SELECT COUNT(`ID`) FROM `category` ',@WhereStmt);
    SET @SortStmt = CONCAT('ORDER BY ', @Sorting, ' ');
    SET @LimitStmt = CONCAT('LIMIT ',@Offset_,', ',@Size);
    SET @QueryStmt = CONCAT('SELECT (',@TotalStmt,') AS TotalRows, `category`.* FROM `category` ',@WhereStmt, @SortStmt, @LimitStmt);
    -- call query statement
    PREPARE stmt FROM @QueryStmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- create order_status_table_query procedure
DROP procedure IF EXISTS `order_status_table_query`;

DELIMITER $$
CREATE PROCEDURE `order_status_table_query` (
    _ID INT, _Status VARCHAR(32), 
    _Search VARCHAR(32), _Sorting VARCHAR(32), _PageNo INT, _PageSize INT
)
BEGIN
    -- preprocessing input params
    SET _Status = LTRIM(RTRIM(_Status));
    SET _Search = LTRIM(RTRIM(_Search));
    IF _ID IS NULL THEN SET @ID = "NULL"; ELSE SET @ID = _ID; END IF;
    IF _Status IS NULL THEN SET @Status = "''"; ELSE SET @Status = CONCAT("'",_Status,"'"); END IF;
    IF _Search IS NULL THEN SET @Search = "''"; ELSE SET @Search = CONCAT("'",_Search,"'"); END IF;
    IF _Sorting IS NULL OR NOT (
        (_Sorting LIKE 'ID%' OR _Sorting LIKE 'Status%') 
        AND (_Sorting LIKE '%ASC' OR _Sorting LIKE '%DESC')
    )THEN SET @Sorting = 'ID ASC'; ELSE SET @Sorting = _Sorting; END IF;
    IF (_PageSize IS NULL OR _PageSize = 0) THEN SET @Size = 1; ELSEIF _PageSize > 50 THEN SET @Size = 50; ELSE SET @Size = _PageSize; END IF;
    IF _PageNo IS NULL OR _PageNo = 0 THEN SET @Offset_ = 0; ELSE SET @Offset_ = @Size * (_PageNo - 1); END IF;
    -- build statements
    SET @WhereStmt = CONCAT("
        WHERE (",@ID," IS NULL OR ",@ID," = `ID`)
            AND is_substr(",@Status,", `Status`) > 0
            AND (
                is_substr(",@Search,", `Status`) > 0
            )
    ");
    SET @TotalStmt = CONCAT('SELECT COUNT(`ID`) FROM `order_status` ',@WhereStmt);
    SET @SortStmt = CONCAT('ORDER BY ', @Sorting, ' ');
    SET @LimitStmt = CONCAT('LIMIT ',@Offset_,', ',@Size);
    SET @QueryStmt = CONCAT('SELECT (',@TotalStmt,') AS TotalRows, `order_status`.* FROM `order_status` ',@WhereStmt, @SortStmt, @LimitStmt);
    -- call query statement
    PREPARE stmt FROM @QueryStmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- create account_table_query procedure
DROP procedure IF EXISTS `account_table_query`;

DELIMITER $$
CREATE PROCEDURE `account_table_query` (
    _ID INT, _Username VARCHAR(32),
    _Search VARCHAR(32), _Sorting VARCHAR(32), _PageNo INT, _PageSize INT
)
BEGIN
    -- preprocessing input params
    SET _Username = LTRIM(RTRIM(_Username));
    SET _Search = LTRIM(RTRIM(_Search));
    IF _ID IS NULL THEN SET @ID = "NULL"; ELSE SET @ID = _ID; END IF;
    IF _Username IS NULL THEN SET @Username = "''"; ELSE SET @Username = CONCAT("'",_Username,"'"); END IF;
    IF _Search IS NULL THEN SET @Search = "''"; ELSE SET @Search = CONCAT("'",_Search,"'"); END IF;
    IF _Sorting IS NULL OR NOT (
        (_Sorting LIKE 'ID%' OR _Sorting LIKE 'Username%') 
        AND (_Sorting LIKE '%ASC' OR _Sorting LIKE '%DESC')
    )THEN SET @Sorting = 'ID ASC'; ELSE SET @Sorting = _Sorting; END IF;
    IF (_PageSize IS NULL OR _PageSize = 0) THEN SET @Size = 1; ELSEIF _PageSize > 50 THEN SET @Size = 50; ELSE SET @Size = _PageSize; END IF;
    IF _PageNo IS NULL OR _PageNo = 0 THEN SET @Offset_ = 0; ELSE SET @Offset_ = @Size * (_PageNo - 1); END IF;
    -- build statements
    SET @WhereStmt = CONCAT("
        WHERE (",@ID," IS NULL OR ",@ID," = `ID`)
            AND is_substr(",@Username,", `Username`) > 0
            AND (
                is_substr(",@Search,", `Username`) > 0
            )
    ");
    SET @TotalStmt = CONCAT('SELECT COUNT(`ID`) FROM `account` ',@WhereStmt);
    SET @SortStmt = CONCAT('ORDER BY ', @Sorting, ' ');
    SET @LimitStmt = CONCAT('LIMIT ',@Offset_,', ',@Size);
    SET @QueryStmt = CONCAT('SELECT (',@TotalStmt,') AS TotalRows, `account`.* FROM `account` ',@WhereStmt, @SortStmt, @LimitStmt);
    -- call query statement
    PREPARE stmt FROM @QueryStmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- create administrative_division_table_query procedure
DROP procedure IF EXISTS `administrative_division_table_query`;

DELIMITER $$
CREATE PROCEDURE `administrative_division_table_query` (
    _ID INT, _FatherID INT, _Name VARCHAR(32), _Type VARCHAR(32), _Level VARCHAR(32),
    _Search VARCHAR(32), _Sorting VARCHAR(32), _PageNo INT, _PageSize INT
)
BEGIN
    -- preprocessing input params
    SET _Name = LTRIM(RTRIM(_Name));
    SET _Type = LTRIM(RTRIM(_Type));
    SET _Level = LTRIM(RTRIM(_Level));
    SET _Search = LTRIM(RTRIM(_Search));
    IF _ID IS NULL THEN SET @ID = "NULL"; ELSE SET @ID = _ID; END IF;
    IF _FatherID IS NULL THEN SET @FatherID = "NULL"; ELSE SET @FatherID = _FatherID; END IF;
    IF _Name IS NULL THEN SET @Name = "''"; ELSE SET @Name = CONCAT("'",_Name,"'"); END IF;
    IF _Type IS NULL THEN SET @Type = "''"; ELSE SET @Type = CONCAT("'",_Type,"'"); END IF;
    IF _Level IS NULL THEN SET @Level = "''"; ELSE SET @Level = CONCAT("'",_Level,"'"); END IF;
    IF _Search IS NULL THEN SET @Search = "''"; ELSE SET @Search = CONCAT("'",_Search,"'"); END IF;
    IF _Sorting IS NULL OR NOT (
        (_Sorting LIKE 'ID%' OR _Sorting LIKE 'FatherID%' OR _Sorting LIKE 'Name%' OR _Sorting LIKE 'Type%' OR _Sorting LIKE 'Level%') 
        AND (_Sorting LIKE '%ASC' OR _Sorting LIKE '%DESC')
    )THEN SET @Sorting = 'ID ASC'; ELSE SET @Sorting = _Sorting; END IF;
    IF (_PageSize IS NULL OR _PageSize = 0) THEN SET @Size = 1; ELSEIF _PageSize > 50 THEN SET @Size = 50; ELSE SET @Size = _PageSize; END IF;
    IF _PageNo IS NULL OR _PageNo = 0 THEN SET @Offset_ = 0; ELSE SET @Offset_ = @Size * (_PageNo - 1); END IF;
    -- build statements
    SET @WhereStmt = CONCAT("
        WHERE (",@ID," IS NULL OR ",@ID," = `ID`)
            AND (",@FatherID," IS NULL OR ",@FatherID," = `FatherID`)
            AND is_substr(",@Name,", `Name`) > 0
            AND is_substr(",@Type,", `Type`) > 0
            AND is_substr(",@Level,", `Level`) > 0
            AND (
                is_substr(",@Search,", `Name`) > 0
                OR is_substr(",@Search,", `Type`) > 0
                OR is_substr(",@Search,", `Level`) > 0
            )
    ");
    SET @TotalStmt = CONCAT('SELECT COUNT(`ID`) FROM `administrative_division` ',@WhereStmt);
    SET @SortStmt = CONCAT('ORDER BY ', @Sorting, ' ');
    SET @LimitStmt = CONCAT('LIMIT ',@Offset_,', ',@Size);
    SET @QueryStmt = CONCAT('SELECT (',@TotalStmt,') AS TotalRows, `administrative_division`.* FROM `administrative_division` ',@WhereStmt, @SortStmt, @LimitStmt);
    -- call query statement
    PREPARE stmt FROM @QueryStmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- create product_table_query procedure
DROP procedure IF EXISTS `product_table_query`;

DELIMITER $$
CREATE PROCEDURE `product_table_query` (
    _ID INT, _Code VARCHAR(8), _Title VARCHAR(32), _Description VARCHAR(1024), _CategoryID INT, _PriceFrom INT, _PriceTo INT, _ImageURL VARCHAR(256), _RecordStatus TINYINT,
    _Search VARCHAR(32), _Sorting VARCHAR(32), _PageNo INT, _PageSize INT
)
BEGIN
    -- preprocessing input params
    SET _Code = LTRIM(RTRIM(_Code));
    SET _Title = LTRIM(RTRIM(_Title));
    SET _Description = LTRIM(RTRIM(_Description));
    SET _ImageURL = LTRIM(RTRIM(_ImageURL));
    SET _Search = LTRIM(RTRIM(_Search));
    IF _ID IS NULL THEN SET @ID = "NULL"; ELSE SET @ID = _ID; END IF;
    IF _Code IS NULL THEN SET @Code = "''"; ELSE SET @Code = CONCAT("'",_Code,"'"); END IF;
    IF _Title IS NULL THEN SET @Title = "''"; ELSE SET @Title = CONCAT("'",_Title,"'"); END IF;
    IF _Description IS NULL THEN SET @Description = "''"; ELSE SET @Description = CONCAT("'",_Description,"'"); END IF;
    IF _CategoryID IS NULL THEN SET @CategoryID = "NULL"; ELSE SET @CategoryID = _CategoryID; END IF;
    IF _PriceFrom IS NULL THEN SET @PriceFrom = "NULL"; ELSE SET @PriceFrom = _PriceFrom; END IF;
    IF _PriceTo IS NULL THEN SET @PriceTo = "NULL"; ELSE SET @PriceTo = _PriceTo; END IF;
    IF _ImageURL IS NULL THEN SET @ImageURL = "''"; ELSE SET @ImageURL = CONCAT("'",_ImageURL,"'"); END IF;
    IF _RecordStatus IS NULL THEN SET @RecordStatus = "NULL"; ELSE SET @RecordStatus = _RecordStatus; END IF;
    IF _Search IS NULL THEN SET @Search = "''"; ELSE SET @Search = CONCAT("'",_Search,"'"); END IF;
    IF _Sorting IS NULL OR NOT (
        (_Sorting LIKE 'ID%' OR _Sorting LIKE 'Code%' OR _Sorting LIKE 'ProductTitle%' OR _Sorting LIKE 'Description%' OR _Sorting LIKE 'CategoryID%' OR _Sorting LIKE 'Price%' OR _Sorting LIKE 'ImageURL%' OR _Sorting LIKE 'RecordStatus%')
        AND (_Sorting LIKE '%ASC' OR _Sorting LIKE '%DESC')
    )THEN SET @Sorting = 'ID ASC'; ELSE SET @Sorting = _Sorting; END IF;
    IF (_PageSize IS NULL OR _PageSize = 0) THEN SET @Size = 1; ELSEIF _PageSize > 50 THEN SET @Size = 50; ELSE SET @Size = _PageSize; END IF;
    IF _PageNo IS NULL OR _PageNo = 0 THEN SET @Offset_ = 0; ELSE SET @Offset_ = @Size * (_PageNo - 1); END IF;
    -- build statements
    SET @WhereStmt = CONCAT("
        WHERE (",@ID," IS NULL OR ",@ID," = `ID`)
            AND is_substr(",@Code,", `Code`) > 0
            AND is_substr(",@Title,", `ProductTitle`) > 0
            AND is_substr(",@Description,", `Description`) > 0
            AND (",@CategoryID," IS NULL OR ",@CategoryID," = `CategoryID`)
            AND (",@PriceFrom," IS NULL OR ",@PriceFrom," <= `Price`)
            AND (",@PriceTo," IS NULL OR ",@PriceTo," >= `Price`)
            AND is_substr(",@ImageURL,", `ImageURL`) > 0
            AND (",@RecordStatus," IS NULL OR ",@RecordStatus," = `RecordStatus`)
            AND (
                is_substr(",@Search,", `Code`) > 0
                OR is_substr(",@Search,", `ProductTitle`) > 0
                OR is_substr(",@Search,", `Description`) > 0
                OR is_substr(",@Search,", `ImageURL`) > 0
            )
    ");
    SET @TotalStmt = CONCAT('SELECT COUNT(`ID`) FROM `product` ',@WhereStmt);
    SET @SortStmt = CONCAT('ORDER BY ', @Sorting, ' ');
    SET @LimitStmt = CONCAT('LIMIT ',@Offset_,', ',@Size);
    SET @QueryStmt = CONCAT('SELECT (',@TotalStmt,') AS TotalRows, `product`.* FROM `product` ',@WhereStmt, @SortStmt, @LimitStmt);
    -- call query statement
    PREPARE stmt FROM @QueryStmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- create order_table_query procedure
DROP procedure IF EXISTS `order_table_query`;

DELIMITER $$
CREATE PROCEDURE `order_table_query` (
    _ID INT, _Firstname VARCHAR(32), _Lastname VARCHAR(32), _StatusID INT, _Phone VARCHAR(16), _ProvinceID INT, _DistrictID INT, _CommuneID INT, _Address VARCHAR(256), _Note VARCHAR(256), 
    _Search VARCHAR(32), _Sorting VARCHAR(32), _PageNo INT, _PageSize INT
)
BEGIN
    -- preprocessing input params
    SET _Firstname = LTRIM(RTRIM(_Firstname));
    SET _Lastname = LTRIM(RTRIM(_Lastname));
    SET _Phone = LTRIM(RTRIM(_Phone));
    SET _Address = LTRIM(RTRIM(_Address));
    SET _Note = LTRIM(RTRIM(_Note));
    SET _Search = LTRIM(RTRIM(_Search));
    IF _ID IS NULL THEN SET @ID = "NULL"; ELSE SET @ID = _ID; END IF;
    IF _Firstname IS NULL THEN SET @Firstname = "''"; ELSE SET @Firstname = CONCAT("'",_Firstname,"'"); END IF;
    IF _Lastname IS NULL THEN SET @Lastname = "''"; ELSE SET @Lastname = CONCAT("'",_Lastname,"'"); END IF;
    IF _StatusID IS NULL THEN SET @StatusID = "NULL"; ELSE SET @StatusID = _StatusID; END IF;
    IF _Phone IS NULL THEN SET @Phone = "''"; ELSE SET @Phone = CONCAT("'",_Phone,"'"); END IF;
    IF _ProvinceID IS NULL THEN SET @ProvinceID = "NULL"; ELSE SET @ProvinceID = _ProvinceID; END IF;
    IF _DistrictID IS NULL THEN SET @DistrictID = "NULL"; ELSE SET @DistrictID = _DistrictID; END IF;
    IF _CommuneID IS NULL THEN SET @CommuneID = "NULL"; ELSE SET @CommuneID = _CommuneID; END IF;
    IF _Address IS NULL THEN SET @Address = "''"; ELSE SET @Address = CONCAT("'",_Address,"'"); END IF;
    IF _Note IS NULL THEN SET @Note = "''"; ELSE SET @Note = CONCAT("'",_Note,"'"); END IF;
    IF _Search IS NULL THEN SET @Search = "''"; ELSE SET @Search = CONCAT("'",_Search,"'"); END IF;
    IF _Sorting IS NULL OR NOT (
        (_Sorting LIKE 'ID%' OR _Sorting LIKE 'Firstname%' OR _Sorting LIKE 'Lastname%' OR _Sorting LIKE 'StatusID%' OR _Sorting LIKE 'Phone%' OR _Sorting LIKE 'ProvinceID%' OR _Sorting LIKE 'DistrictID%' OR _Sorting LIKE 'CommuneID%' OR _Sorting LIKE 'Address%' OR _Sorting LIKE 'Note%')
        AND (_Sorting LIKE '%ASC' OR _Sorting LIKE '%DESC')
    )THEN SET @Sorting = 'ID ASC'; ELSE SET @Sorting = _Sorting; END IF;
    IF (_PageSize IS NULL OR _PageSize = 0) THEN SET @Size = 1; ELSEIF _PageSize > 50 THEN SET @Size = 50; ELSE SET @Size = _PageSize; END IF;
    IF _PageNo IS NULL OR _PageNo = 0 THEN SET @Offset_ = 0; ELSE SET @Offset_ = @Size * (_PageNo - 1); END IF;
    -- build statements
    SET @WhereStmt = CONCAT("
        WHERE (",@ID," IS NULL OR ",@ID," = `ID`)
            AND is_substr(",@Firstname,", `Firstname`) > 0
            AND is_substr(",@Lastname,", `Lastname`) > 0
            AND (",@StatusID," IS NULL OR ",@StatusID," = `StatusID`)
            AND is_substr(",@Phone,", `Phone`) > 0
            AND (",@ProvinceID," IS NULL OR ",@ProvinceID," = `ProvinceID`)
            AND (",@DistrictID," IS NULL OR ",@DistrictID," = `DistrictID`)
            AND (",@CommuneID," IS NULL OR ",@CommuneID," = `CommuneID`)
            AND is_substr(",@Address,", `Address`) > 0
            AND is_substr(",@Note,", `Note`) > 0
            AND (
                is_substr(",@Search,", `Firstname`) > 0
                OR is_substr(",@Search,", `Lastname`) > 0
                OR is_substr(",@Search,", `Phone`) > 0
                OR is_substr(",@Search,", `Address`) > 0
                OR is_substr(",@Search,", `Note`) > 0
            )
    ");
    SET @TotalStmt = CONCAT('SELECT COUNT(`ID`) FROM `order` ',@WhereStmt);
    SET @SortStmt = CONCAT('ORDER BY ', @Sorting, ' ');
    SET @LimitStmt = CONCAT('LIMIT ',@Offset_,', ',@Size);
    SET @QueryStmt = CONCAT('SELECT (',@TotalStmt,') AS TotalRows, `order`.* FROM `order` ',@WhereStmt, @SortStmt, @LimitStmt);
    -- call query statement
    PREPARE stmt FROM @QueryStmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- create cart_table_query procedure
DROP procedure IF EXISTS `cart_table_query`;

DELIMITER $$
CREATE PROCEDURE `cart_table_query` (
    _OrderID INT, _SubtotalFrom INT, _SubtotalTo INT, _DeliveryFrom INT, _DeliveryTo INT, _DiscountFrom INT, _DiscountTo INT, _TotalFrom INT, _TotalTo INT,
    _Search VARCHAR(32), _Sorting VARCHAR(32), _PageNo INT, _PageSize INT
)
BEGIN
    -- preprocessing input params
    SET _Search = LTRIM(RTRIM(_Search));
    IF _OrderID IS NULL THEN SET @OrderID = "NULL"; ELSE SET @OrderID = _OrderID; END IF;
    IF _SubtotalFrom IS NULL THEN SET @SubtotalFrom = "NULL"; ELSE SET @SubtotalFrom = _SubtotalFrom; END IF;
    IF _SubtotalTo IS NULL THEN SET @SubtotalTo = "NULL"; ELSE SET @SubtotalTo = _SubtotalTo; END IF;
    IF _DeliveryFrom IS NULL THEN SET @DeliveryFrom = "NULL"; ELSE SET @DeliveryFrom = _DeliveryFrom; END IF;
    IF _DeliveryTo IS NULL THEN SET @DeliveryTo = "NULL"; ELSE SET @DeliveryTo = _DeliveryTo; END IF;
    IF _DiscountFrom IS NULL THEN SET @DiscountFrom = "NULL"; ELSE SET @DiscountFrom = _DiscountFrom; END IF;
    IF _DiscountTo IS NULL THEN SET @DiscountTo = "NULL"; ELSE SET @DiscountTo = _DiscountTo; END IF;
    IF _TotalFrom IS NULL THEN SET @TotalFrom = "NULL"; ELSE SET @TotalFrom = _TotalFrom; END IF;
    IF _TotalTo IS NULL THEN SET @TotalTo = "NULL"; ELSE SET @TotalTo = _TotalTo; END IF;
    IF _Search IS NULL THEN SET @Search = "''"; ELSE SET @Search = CONCAT("'",_Search,"'"); END IF;
    IF _Sorting IS NULL OR NOT (
        (_Sorting LIKE 'OrderID%' OR _Sorting LIKE 'Subtotal%' OR _Sorting LIKE 'Delivery%' OR _Sorting LIKE 'Discount%' OR _Sorting LIKE 'Total%') 
        AND (_Sorting LIKE '%ASC' OR _Sorting LIKE '%DESC')
    )THEN SET @Sorting = 'OrderID ASC'; ELSE SET @Sorting = _Sorting; END IF;
    IF (_PageSize IS NULL OR _PageSize = 0) THEN SET @Size = 1; ELSEIF _PageSize > 50 THEN SET @Size = 50; ELSE SET @Size = _PageSize; END IF;
    IF _PageNo IS NULL OR _PageNo = 0 THEN SET @Offset_ = 0; ELSE SET @Offset_ = @Size * (_PageNo - 1); END IF;
    -- build statements
    SET @WhereStmt = CONCAT("
        WHERE (",@OrderID," IS NULL OR ",@OrderID," = `OrderID`)
            AND (",@SubtotalFrom," IS NULL OR ",@SubtotalFrom," <= `Subtotal`)
            AND (",@SubtotalTo," IS NULL OR ",@SubtotalTo," >= `Subtotal`)
            AND (",@DeliveryFrom," IS NULL OR ",@DeliveryFrom," <= `Delivery`)
            AND (",@DeliveryTo," IS NULL OR ",@DeliveryTo," >= `Delivery`)
            AND (",@DiscountFrom," IS NULL OR ",@DiscountFrom," <= `Discount`)
            AND (",@DiscountTo," IS NULL OR ",@DiscountTo," >= `Discount`)
            AND (",@TotalFrom," IS NULL OR ",@TotalFrom," <= `Total`)
            AND (",@TotalTo," IS NULL OR ",@TotalTo," >= `Total`)
    ");
    SET @TotalStmt = CONCAT('SELECT COUNT(`OrderID`) FROM `cart` ',@WhereStmt);
    SET @SortStmt = CONCAT('ORDER BY ', @Sorting, ' ');
    SET @LimitStmt = CONCAT('LIMIT ',@Offset_,', ',@Size);
    SET @QueryStmt = CONCAT('SELECT (',@TotalStmt,') AS TotalRows, `cart`.* FROM `cart` ',@WhereStmt, @SortStmt, @LimitStmt);
    -- call query statement
    PREPARE stmt FROM @QueryStmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- create cart_detail_table_query procedure
DROP procedure IF EXISTS `cart_detail_table_query`;

DELIMITER $$
CREATE PROCEDURE `cart_detail_table_query` (
    _OrderID INT, _ProductID INT, _PriceFrom INT, _PriceTo INT, _QuantityFrom INT, _QuantityTo INT, _TotalFrom INT, _TotalTo INT, 
    _Search VARCHAR(32), _Sorting VARCHAR(32), _PageNo INT, _PageSize INT
)
BEGIN
    -- preprocessing input params
    SET _Search = LTRIM(RTRIM(_Search));
    IF _OrderID IS NULL THEN SET @OrderID = "NULL"; ELSE SET @OrderID = _OrderID; END IF;
    IF _ProductID IS NULL THEN SET @ProductID = "NULL"; ELSE SET @ProductID = _ProductID; END IF;
    IF _PriceFrom IS NULL THEN SET @PriceFrom = "NULL"; ELSE SET @PriceFrom = _PriceFrom; END IF;
    IF _PriceTo IS NULL THEN SET @PriceTo = "NULL"; ELSE SET @PriceTo = _PriceTo; END IF;
    IF _QuantityFrom IS NULL THEN SET @QuantityFrom = "NULL"; ELSE SET @QuantityFrom = _QuantityFrom; END IF;
    IF _QuantityTo IS NULL THEN SET @QuantityTo = "NULL"; ELSE SET @QuantityTo = _QuantityTo; END IF;
    IF _TotalFrom IS NULL THEN SET @TotalFrom = "NULL"; ELSE SET @TotalFrom = _TotalFrom; END IF;
    IF _TotalTo IS NULL THEN SET @TotalTo = "NULL"; ELSE SET @TotalTo = _TotalTo; END IF;

    IF _Search IS NULL THEN SET @Search = "''"; ELSE SET @Search = CONCAT("'",_Search,"'"); END IF;
    IF _Sorting IS NULL OR NOT (
        (_Sorting LIKE 'OrderID%' OR _Sorting LIKE 'ProductID%' OR _Sorting LIKE 'Price%' OR _Sorting LIKE 'Quantity%' OR _Sorting LIKE 'Total%') 
        AND (_Sorting LIKE '%ASC' OR _Sorting LIKE '%DESC')
    )THEN SET @Sorting = 'OrderID ASC'; ELSE SET @Sorting = _Sorting; END IF;
    IF (_PageSize IS NULL OR _PageSize = 0) THEN SET @Size = 1; ELSEIF _PageSize > 50 THEN SET @Size = 50; ELSE SET @Size = _PageSize; END IF;
    IF _PageNo IS NULL OR _PageNo = 0 THEN SET @Offset_ = 0; ELSE SET @Offset_ = @Size * (_PageNo - 1); END IF;
    -- build statements
    SET @WhereStmt = CONCAT("
        WHERE (",@OrderID," IS NULL OR ",@OrderID," = `OrderID`)
            AND (",@ProductID," IS NULL OR ",@ProductID," = `ProductID`)
            AND (",@PriceFrom," IS NULL OR ",@PriceFrom," <= `Price`)
            AND (",@PriceTo," IS NULL OR ",@PriceTo," >= `Price`)
            AND (",@QuantityFrom," IS NULL OR ",@QuantityFrom," <= `Quantity`)
            AND (",@QuantityTo," IS NULL OR ",@QuantityTo," >= `Quantity`)
            AND (",@TotalFrom," IS NULL OR ",@TotalFrom," <= `Total`)
            AND (",@TotalTo," IS NULL OR ",@TotalTo," >= `Total`)
    ");
    SET @TotalStmt = CONCAT('SELECT COUNT(`OrderID`) FROM `cart_detail` ',@WhereStmt);
    SET @SortStmt = CONCAT('ORDER BY ', @Sorting, ' ');
    SET @LimitStmt = CONCAT('LIMIT ',@Offset_,', ',@Size);
    SET @QueryStmt = CONCAT('SELECT (',@TotalStmt,') AS TotalRows, `cart_detail`.* FROM `cart_detail` ',@WhereStmt, @SortStmt, @LimitStmt);
    -- call query statement
    PREPARE stmt FROM @QueryStmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- create product_table_search procedure
DROP procedure IF EXISTS `product_table_search`;

DELIMITER $$
CREATE PROCEDURE `product_table_search` (
    _Code VARCHAR(8), _Title VARCHAR(32), _CategoryID INT, _PriceFrom INT, _PriceTo INT,
    _Search VARCHAR(32), _Sorting VARCHAR(32), _PageNo INT, _PageSize INT
)
BEGIN
    -- preprocessing input params
    SET _Code = LTRIM(RTRIM(_Code));
    SET _Title = LTRIM(RTRIM(_Title));
    SET _Search = LTRIM(RTRIM(_Search));
    IF _Code IS NULL THEN SET @Code = "''"; ELSE SET @Code = CONCAT("'",_Code,"'"); END IF;
    IF _Title IS NULL THEN SET @Title = "''"; ELSE SET @Title = CONCAT("'",_Title,"'"); END IF;
    IF _CategoryID IS NULL THEN SET @CategoryID = "NULL"; ELSE SET @CategoryID = _CategoryID; END IF;
    IF _PriceFrom IS NULL THEN SET @PriceFrom = "NULL"; ELSE SET @PriceFrom = _PriceFrom; END IF;
    IF _PriceTo IS NULL THEN SET @PriceTo = "NULL"; ELSE SET @PriceTo = _PriceTo; END IF;
    IF _Search IS NULL THEN SET @Search = "''"; ELSE SET @Search = CONCAT("'",_Search,"'"); END IF;
    IF _Sorting IS NULL OR NOT (
        (_Sorting LIKE 'Code%' OR _Sorting LIKE 'ProductTitle%' OR _Sorting LIKE 'CategoryTitle%' OR _Sorting LIKE 'Price%')
        AND (_Sorting LIKE '%ASC' OR _Sorting LIKE '%DESC')
    )THEN SET @Sorting = 'Code ASC'; ELSE SET @Sorting = _Sorting; END IF;
    IF (_PageSize IS NULL OR _PageSize = 0) THEN SET @Size = 1; ELSEIF _PageSize > 50 THEN SET @Size = 50; ELSE SET @Size = _PageSize; END IF;
    IF _PageNo IS NULL OR _PageNo = 0 THEN SET @Offset_ = 0; ELSE SET @Offset_ = @Size * (_PageNo - 1); END IF;
    -- build statements
    SET @WhereStmt = CONCAT("
                is_substr(",@Code,", `Code`) > 0
            AND is_substr(",@Title,", `ProductTitle`) > 0
            AND (",@CategoryID," IS NULL OR ",@CategoryID," = `CategoryID`)
            AND (",@PriceFrom," IS NULL OR ",@PriceFrom," <= `Price`)
            AND (",@PriceTo," IS NULL OR ",@PriceTo," >= `Price`)
            AND (1 = `RecordStatus`)
            AND (
                is_substr(",@Search,", `Code`) > 0
                OR is_substr(",@Search,", `ProductTitle`) > 0
            )
    ");
    SET @TotalStmt = CONCAT('SELECT COUNT(`ID`) FROM `product` WHERE ',@WhereStmt);
    SET @SortStmt = CONCAT('ORDER BY ', @Sorting, ' ');
    SET @LimitStmt = CONCAT('LIMIT ',@Offset_,', ',@Size);
    SET @QueryStmt = CONCAT('SELECT (',@TotalStmt,') AS TotalRows, `product`.*, `CategoryTitle`
        FROM `product`, `category` WHERE `product`.`CategoryID` = `category`.`ID` AND
    ',@WhereStmt, @SortStmt, @LimitStmt);
    -- call query statement
    PREPARE stmt FROM @QueryStmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- create order_table_create procedure
DROP procedure IF EXISTS `order_table_create`;

DELIMITER $$
CREATE PROCEDURE `order_table_create` (
    _Firstname VARCHAR(32), _Lastname VARCHAR(32), _Phone VARCHAR(16), _ProvinceID INT, _DistrictID INT, _CommuneID INT, _Address VARCHAR(256), _Note VARCHAR(256),
    _Subtotal INT, _Delivery INT, _Discount INT, _Total INT
)
order_create:BEGIN
    -- preprocessing input params
    SET _Firstname = LTRIM(RTRIM(_Firstname));
    SET _Lastname = LTRIM(RTRIM(_Lastname));
    SET _Phone = LTRIM(RTRIM(_Phone));
    SET _Address = LTRIM(RTRIM(_Address));
    SET _Note = LTRIM(RTRIM(_Note));
    IF _Firstname IS NULL THEN SET _Firstname = ''; END IF;
    IF _Lastname IS NULL THEN SET _Lastname = ''; END IF;
    IF _Phone IS NULL THEN SET _Phone = ''; END IF;
    IF _Address IS NULL THEN SET _Address = ''; END IF;
    IF _Note IS NULL THEN SET _Note = ''; END IF;

    -- checking parameters
    IF NOT EXISTS (SELECT 1 FROM `order_status` WHERE 1 = `ID`) THEN
		SELECT -1 Result, 'Not found order status for insert order' ErrorDesc;
		LEAVE order_create;
	END IF;
    IF (
        _Firstname IS NULL OR _Firstname = '' OR
        _Lastname IS NULL OR _Lastname = '' OR
        _Phone IS NULL OR _Phone = '' OR
        _ProvinceID IS NULL OR
        _DistrictID IS NULL OR
        _CommuneID IS NULL OR
        _Address IS NULL OR _Address = '' OR
        _Subtotal IS NULL OR
        _Delivery IS NULL OR
        _Discount IS NULL OR
        _Total IS NULL
    ) THEN
		SELECT -2 Result, 'Invalid Order information' ErrorDesc;
        LEAVE order_create;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM `administrative_division` WHERE _ProvinceID = `ID` AND 'Tỉnh/Thành' = `Level`) THEN
		SELECT -3 Result, 'Not found province for insert order' ErrorDesc;
		LEAVE order_create;
	END IF;
	IF NOT EXISTS (SELECT 1 FROM `administrative_division` WHERE _DistrictID = `ID` AND 'Quận/Huyện' = `Level`) THEN
		SELECT -4 Result, 'Not found district for insert order' ErrorDesc;
		LEAVE order_create;
	END IF;
	IF NOT EXISTS (SELECT 1 FROM `administrative_division` WHERE _CommuneID = `ID` AND 'Phường/Xã' = `Level`) THEN
		SELECT -5 Result, 'Not found commune for insert order' ErrorDesc;
		LEAVE order_create;
	END IF;
    -- reset auto increment id number
	ALTER TABLE `order` AUTO_INCREMENT = 1;
    -- create order using insert into order table
    INSERT INTO `order` (`Firstname`, `Lastname`, `StatusID`, `Phone`, `ProvinceID`, `DistrictID`, `CommuneID`, `Address`, `Note`) 
    VALUES (_Firstname, _Lastname, 1, _Phone, _ProvinceID, _DistrictID, _CommuneID, _Address, _Note);
	SET @OrderID = (SELECT LAST_INSERT_ID());
    -- create cart using insert into cart table with OrderID
    INSERT INTO `cart` (`OrderID`, `Subtotal`, `Delivery`, `Discount`, `Total`)
    VALUES (@OrderID, _Subtotal, _Delivery, _Discount, _Total);

    SELECT @OrderID Result, 'Last order ID inserted' ErrorDesc;
END$$

DELIMITER ;

-- create order_table_delete procedure
DROP procedure IF EXISTS `order_table_delete`;

DELIMITER $$
CREATE PROCEDURE `order_table_delete` (_ID INT)
order_delete:BEGIN
    IF NOT EXISTS (SELECT 1 FROM `order` WHERE _ID = `ID`) THEN
		SELECT -6 Result, 'Not found order for delete order' ErrorDesc;
		LEAVE order_delete;
	END IF;
    DELETE FROM `order` WHERE _ID = `ID`;
    DELETE FROM `cart` WHERE _ID = `OrderID`;
    DELETE FROM `cart_detail` WHERE _ID = `OrderID`;

    SELECT _ID Result, 'Last order ID deleted' ErrorDesc;
END$$

DELIMITER ;

-- create cart_detail_table_create procedure
DROP procedure IF EXISTS `cart_detail_table_create`;

DELIMITER $$
CREATE PROCEDURE `cart_detail_table_create` (
	_OrderID INT, _ProductID INT, _Price INT, _Quantity INT, _Total INT
)
cart_detail_create:BEGIN
    -- preprocessing input params
    IF _Price IS NULL THEN SET _Price = 0; END IF;
    IF _Quantity IS NULL THEN SET _Quantity = 0; END IF;
    IF _Total IS NULL THEN SET _Total = 0; END IF;

    IF NOT EXISTS (SELECT 1 FROM `cart`, `order` WHERE `cart`.`OrderID` = `order`.`ID` AND _OrderID = `ID`) THEN
		SELECT -6 Result, 'Not found order for insert cart detail' ErrorDesc;
        CALL order_table_delete(_OrderID);
		LEAVE cart_detail_create;
	END IF;
    IF NOT EXISTS (SELECT 1 FROM `product` WHERE _ProductID = `ID`) THEN
		SELECT -7 Result, 'Not found product for insert cart detail' ErrorDesc;
        CALL order_table_delete(_OrderID);
		LEAVE cart_detail_create;
	END IF;
    IF EXISTS (SELECT 1 FROM `cart_detail` WHERE _OrderID = `OrderID` AND _ProductID = `ProductID`) THEN
		SELECT -8 Result, 'Duplicated product for insert cart detail' ErrorDesc;
        CALL order_table_delete(_OrderID);
		LEAVE cart_detail_create;
	END IF;
    INSERT INTO `cart_detail` VALUES (_OrderID, _ProductID, _Price, _Quantity, _Total);
	SELECT 0 Result, 'Insert cart detail successfull' ErrorDesc;
END$$

DELIMITER ;

-- create account_table_get_account procedure
DROP procedure IF EXISTS `account_table_get_account`;

DELIMITER $$
CREATE PROCEDURE `account_table_get_account` (_Username VARCHAR(32))
BEGIN
    SELECT * FROM `account` WHERE CONVERT(_Username,BINARY) = CONVERT(`Username`,BINARY);
END$$

DELIMITER ;

-- create order_table_search procedure
DROP procedure IF EXISTS `order_table_search`;

DELIMITER $$
CREATE PROCEDURE `order_table_search` (
    _ID INT, _Fullname VARCHAR(64), _Phone VARCHAR(16), _StatusID INT, _TotalFrom INT, _TotalTo INT, 
    _Search VARCHAR(32), _Sorting VARCHAR(32), _PageNo INT, _PageSize INT
)
BEGIN
    -- preprocessing input params
    SET _Fullname = LTRIM(RTRIM(_Fullname));
    SET _Phone = LTRIM(RTRIM(_Phone));
    SET _Search = LTRIM(RTRIM(_Search));
    IF _ID IS NULL THEN SET @ID = "NULL"; ELSE SET @ID = _ID; END IF;
    IF _Fullname IS NULL THEN SET @Fullname = "''"; ELSE SET @Fullname = CONCAT("'",_Fullname,"'"); END IF;
    IF _Phone IS NULL THEN SET @Phone = "''"; ELSE SET @Phone = CONCAT("'",_Phone,"'"); END IF;
    IF _StatusID IS NULL THEN SET @StatusID = "NULL"; ELSE SET @StatusID = _StatusID; END IF;
    IF _TotalFrom IS NULL THEN SET @TotalFrom = "NULL"; ELSE SET @TotalFrom = _TotalFrom; END IF;
    IF _TotalTo IS NULL THEN SET @TotalTo = "NULL"; ELSE SET @TotalTo = _TotalTo; END IF;
    IF _StatusID IS NULL THEN SET @StatusID = "NULL"; ELSE SET @StatusID = _StatusID; END IF;
    IF _Search IS NULL THEN SET @Search = "''"; ELSE SET @Search = CONCAT("'",_Search,"'"); END IF;
    IF _Sorting IS NULL OR NOT (
        (_Sorting LIKE 'ID%' OR _Sorting LIKE 'Firstname%' OR _Sorting LIKE 'Lastname%' OR _Sorting LIKE 'Status%' OR _Sorting LIKE 'Phone%' OR 'Total%')
        AND (_Sorting LIKE '%ASC' OR _Sorting LIKE '%DESC')
    ) THEN SET @Sorting = 'ID ASC'; ELSE SET @Sorting = _Sorting; END IF;
    IF (_PageSize IS NULL OR _PageSize = 0) THEN SET @Size = 1; ELSEIF _PageSize > 50 THEN SET @Size = 50; ELSE SET @Size = _PageSize; END IF;
    IF _PageNo IS NULL OR _PageNo = 0 THEN SET @Offset_ = 0; ELSE SET @Offset_ = @Size * (_PageNo - 1); END IF;
    -- build statements
    SET @WhereStmt = CONCAT("
            (",@ID," IS NULL OR ",@ID," = `order`.`ID`)
            AND is_substr(",@Fullname,", CONCAT(`Firstname`,' ',`Lastname`)) > 0
            AND is_substr(",@Phone,", `Phone`) > 0
            AND (",@StatusID," IS NULL OR ",@StatusID," = `StatusID`)
            AND (",@TotalFrom," IS NULL OR ",@TotalFrom," <= `Total`)
            AND (",@TotalTo," IS NULL OR ",@TotalTo," >= `Total`)
            AND (
                is_substr(",@Fullname,", CONCAT(`Firstname`,' ',`Lastname`)) > 0
                AND is_substr(",@Phone,", `Phone`) > 0
            )
    ");
    SET @TotalStmt = CONCAT('SELECT COUNT(`ID`) FROM `order` WHERE ',@WhereStmt);
    SET @SortStmt = CONCAT('ORDER BY ', @Sorting, ' ');
    SET @LimitStmt = CONCAT('LIMIT ',@Offset_,', ',@Size);
    SET @QueryStmt = CONCAT('SELECT (',@TotalStmt,') AS TotalRows, `order`.*, `cart`.*, `order_status`.`Status` FROM `order`, `cart`, `order_status`
		WHERE `order`.`ID` = `cart`.`OrderID` AND `order`.`StatusID` = `order_status`.`ID` AND '
        ,@WhereStmt, @SortStmt, @LimitStmt);
    -- call query statement
    PREPARE stmt FROM @QueryStmt;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- create product_table_create procedure
DROP procedure IF EXISTS `product_table_create`;

DELIMITER $$
CREATE PROCEDURE `product_table_create` (
    _Code VARCHAR(8), _Title VARCHAR(32), _Description VARCHAR(1024), _CategoryID INT, _Price INT, _ImageURL VARCHAR(256)
)
product_create:BEGIN
    -- preprocessing input params
    SET _Code = LTRIM(RTRIM(_Code));
    SET _Title = LTRIM(RTRIM(_Title));
    SET _Description = LTRIM(RTRIM(_Description));
    SET _ImageURL = LTRIM(RTRIM(_ImageURL));
    IF _Code IS NULL THEN SET _Code = ''; END IF;
    IF _Title IS NULL THEN SET _Title = ''; END IF;
    IF _Description IS NULL THEN SET _Description = ''; END IF;
    IF _ImageURL IS NULL THEN SET _ImageURL = ''; END IF;
    -- checking parameters
    IF (
        _Code IS NULL OR _Code = '' OR
        _Title IS NULL OR _Title = '' OR
        _CategoryID IS NULL OR
        _Price IS NULL OR
        _ImageURL IS NULL OR _ImageURL = ''
    ) THEN
		SELECT -15 Result, 'Invalid Product information' ErrorDesc;
		LEAVE product_create;
    END IF;
    IF EXISTS (SELECT 1 FROM `product` WHERE _Code = `Code` AND 1 = `RecordStatus`) THEN
		SELECT -8 Result, 'Duplicated product code for insert product' ErrorDesc;
		LEAVE product_create;
	END IF;
    IF EXISTS (SELECT 1 FROM `product` WHERE _Title = `ProductTitle` AND 1 = `RecordStatus`) THEN
		SELECT -8 Result, 'Duplicated product title for insert product' ErrorDesc;
		LEAVE product_create;
	END IF;
    IF NOT EXISTS (SELECT 1 FROM `category` WHERE _CategoryID = `ID`) THEN
		SELECT -16 Result, 'Not found category for insert product' ErrorDesc;
		LEAVE product_create;
	END IF;
    -- reset auto increment id number
	ALTER TABLE `product` AUTO_INCREMENT = 1;
    -- create new product
    INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`)
    VALUES (_Code, _Title, _Description, _CategoryID, _Price, _ImageURL);
	SET @ProductID = (SELECT LAST_INSERT_ID());

    SELECT @ProductID Result, 'Last product ID inserted' ErrorDesc;
END$$

DELIMITER ;

-- create product_table_delete procedure
DROP procedure IF EXISTS `product_table_delete`;

DELIMITER $$
CREATE PROCEDURE `product_table_delete` (_ID INT)
product_delete:BEGIN
    IF NOT EXISTS (SELECT 1 FROM `product` WHERE _ID = `ID` AND 1 = `RecordStatus`) THEN
		SELECT -7 Result, 'Not found product for delete product' ErrorDesc;
		LEAVE product_delete;
	END IF;
    UPDATE `product` SET `RecordStatus` = 0 WHERE _ID = `ID` AND 1 = `RecordStatus`;

    SELECT _ID Result, 'Last product ID deleted' ErrorDesc;
END$$

DELIMITER ;

-- create product_table_update procedure
DROP procedure IF EXISTS `product_table_update`;

DELIMITER $$
CREATE PROCEDURE `product_table_update` (
    _ID INT, _Code VARCHAR(8), _Title VARCHAR(32), _Description VARCHAR(1024), _CategoryID INT, _Price INT, _ImageURL VARCHAR(256)
)
product_update:BEGIN
    -- preprocessing input params
    SET _Code = LTRIM(RTRIM(_Code));
    SET _Title = LTRIM(RTRIM(_Title));
    SET _Description = LTRIM(RTRIM(_Description));
    SET _ImageURL = LTRIM(RTRIM(_ImageURL));
    IF _Code IS NULL THEN SET _Code = ''; END IF;
    IF _Title IS NULL THEN SET _Title = ''; END IF;
    IF _Description IS NULL THEN SET _Description = ''; END IF;
    IF _ImageURL IS NULL THEN SET _ImageURL = ''; END IF;
    -- checking parameters
    IF (
        _ID IS NULL OR
        _Code IS NULL OR _Code = '' OR
        _Title IS NULL OR _Title = '' OR
        _CategoryID IS NULL OR
        _Price IS NULL OR
        _ImageURL IS NULL OR _ImageURL = ''
    ) THEN
		SELECT -15 Result, 'Invalid Product information' ErrorDesc;
		LEAVE product_update;
    END IF;
        IF NOT EXISTS (SELECT 1 FROM `product` WHERE _ID = `ID` AND 1 = `RecordStatus`) THEN
		SELECT -7 Result, 'Not found product for update product' ErrorDesc;
		LEAVE product_update;
	END IF;
    IF EXISTS (SELECT 1 FROM `product` WHERE _Code = `Code` AND 1 = `RecordStatus` AND _ID <> `ID`) THEN
		SELECT -8 Result, 'Duplicated product code for update product' ErrorDesc;
		LEAVE product_update;
	END IF;
    IF EXISTS (SELECT 1 FROM `product` WHERE _Title = `ProductTitle` AND 1 = `RecordStatus` AND _ID <> `ID`) THEN
		SELECT -8 Result, 'Duplicated product title for update product' ErrorDesc;
		LEAVE product_update;
	END IF;
    IF NOT EXISTS (SELECT 1 FROM `category` WHERE _CategoryID = `ID`) THEN
		SELECT -16 Result, 'Not found category for update product' ErrorDesc;
		LEAVE product_update;
	END IF;
    -- create new product
    UPDATE `product` SET `Code` = _Code, `ProductTitle` = _Title, `Description` = _Description, `CategoryID` = _CategoryID, `Price` = _Price, `ImageURL` = _ImageURL
    WHERE _ID = `ID` AND 1 = `RecordStatus`;

    SELECT _ID Result, 'Last product ID updated' ErrorDesc;
END$$

DELIMITER ;

-- create cart_detail_table_search procedure
DROP procedure IF EXISTS `cart_detail_table_search`;

DELIMITER $$
CREATE PROCEDURE `cart_detail_table_search` (_OrderID INT)
BEGIN
    SELECT `cart_detail`.*, `product`.`Code`, `product`.`ProductTitle`, `CategoryTitle` 
    FROM awakecup.cart_detail, awakecup.product, awakecup.category 
    WHERE `product`.`ID` = `cart_detail`.`ProductID` AND `category`.`ID` = `product`.`CategoryID` AND _OrderID = `OrderID`;
END$$

DELIMITER ;

-- create order_table_update_status procedure
DROP procedure IF EXISTS `order_table_update_status`;

DELIMITER $$
CREATE PROCEDURE `order_table_update_status` (
    _ID INT, _StatusID INT
)
order_update:BEGIN
    -- checking parameters
    IF NOT EXISTS (SELECT 1 FROM `order` WHERE _ID = `ID`) THEN
		SELECT -6 Result, 'Not found order for update status' ErrorDesc;
		LEAVE order_update;
	END IF;
    IF NOT EXISTS (SELECT 1 FROM `order_status` WHERE _StatusID = `ID`) THEN
		SELECT -1 Result, 'Not found order status for insert order' ErrorDesc;
		LEAVE order_update;
	END IF;
    
    UPDATE `order` SET `StatusID` = _StatusID WHERE `ID` = _ID;
    SELECT _ID Result, 'Last order ID updated' ErrorDesc;
END$$

DELIMITER ;