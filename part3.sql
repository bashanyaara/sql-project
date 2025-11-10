DROP TABLE IF EXISTS SearchResults;
DROP TABLE IF EXISTS Searches;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS CartItems;
DROP TABLE IF EXISTS Versions;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ShoppingCarts;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS CreditCards;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Finishes;
DROP TABLE IF EXISTS Materials;
DROP TABLE IF EXISTS Shapes;
DROP TABLE IF EXISTS Colors;


CREATE TABLE Customers (
    Email VARCHAR(50) NOT NULL PRIMARY KEY,
    Name VARCHAR(50),
    PhoneNumber VARCHAR(20)
);

CREATE TABLE Guests (
    GuestID Int PRIMARY KEY,
    IP VARCHAR(20),
    StartTime DATETIME
);

CREATE TABLE CreditCards (
    CardNumber VARCHAR(30) PRIMARY KEY,
    ExpireDate DATE NOT NULL,
    CVV VARCHAR(4) NOT NULL,
    CardHolderID varchar(20) NOT NULL,
);

CREATE TABLE ShoppingCarts (
    CartID int PRIMARY KEY,
    Email varchar(50) NULL,
    GuestID Int NULL,
    CONSTRAINT FK_Email_ FOREIGN KEY (Email) REFERENCES Customers(Email),
    CONSTRAINT FK_guestID FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);

CREATE TABLE Orders (
    OrderNumber int PRIMARY KEY,
    DT DATETIME,
    DueDate DATE,
    DeliveryType VARCHAR(20),
    ShippingAddressStreet VARCHAR(20),
    ShippingAddressNumber VARCHAR(20),
    ShippingAddressCity VARCHAR(20),
    ShippingAddressZipCode VARCHAR(20),
    BillingAddressStreet VARCHAR(20),
    BillingAddressNumber VARCHAR(20),
    BillingAddressCity VARCHAR(20),
    BillingAddressZipCode VARCHAR(20),
    Email varchar(50) NOT NULL,
    CardNumber VARCHAR(30) NOT NULL,
	cartID int null,
    CONSTRAINT FK_Email FOREIGN KEY (Email) REFERENCES Customers(Email),
    CONSTRAINT FK_cardNumber FOREIGN KEY (CardNumber) REFERENCES CreditCards(CardNumber),
	CONSTRAINT FK_cartID FOREIGN KEY (CartID) REFERENCES ShoppingCarts(CartID)
);



CREATE TABLE Products (
    Name VARCHAR(50),
    Size VARCHAR(20),
    Price MONEY,
    PRIMARY KEY (Name, Size)
);


CREATE TABLE Versions (
    Name VARCHAR(50),
	Size VARCHAR(20),
    VersionID Int,
    ColorName VARCHAR(20),
    ShapeName VARCHAR(20),
    MaterialName VARCHAR(20),
    FinishType VARCHAR(20),
    DrainageHoles BIT,
    PRIMARY KEY (Name, Size, VersionID),
    FOREIGN KEY (Name, Size) REFERENCES Products(Name, Size)
);

CREATE TABLE CartItems (
    CartID int,
    Name varchar(50),
    VersionID Int,
    Size varchar(20),
    Quantity tinyInt NOT NULL CHECK (Quantity > 0),
    PRIMARY KEY (CartID, Name, Size, VersionID),
    FOREIGN KEY (CartID) REFERENCES ShoppingCarts(CartID),
    FOREIGN KEY (Name, Size, VersionID) REFERENCES Versions(Name, Size, VersionID)
);


CREATE TABLE OrderItems (
    OrderNumber Int,
    Name varchar(50),
	size varchar(20),
    VersionID Int,
    Quantity tinyInt NOT NULL CHECK (Quantity>0),
    PRIMARY KEY (OrderNumber, Name, VersionID, size),
    CONSTRAINT FK_orderNum FOREIGN KEY (OrderNumber) REFERENCES Orders(OrderNumber),
	CONSTRAINT FK_OrderItems_Versions FOREIGN KEY (Name, size, VersionID) REFERENCES Versions(Name, size, VersionID)

);

CREATE TABLE Searches (
    SearchID int PRIMARY KEY,
    SearchTime DATETIME,
    SearchTerm VARCHAR(20),
    Email varchar(50) NULL,
    GuestID Int NULL,
    CONSTRAINT FK_Email__ FOREIGN KEY (Email) REFERENCES Customers(Email),
    CONSTRAINT FK_Guest_ID FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);

CREATE TABLE SearchResults (
    SearchID int,
    Name varchar(50),
	size varchar(20),
    VersionID Int,
    PRIMARY KEY (SearchID, Name, VersionID),
    CONSTRAINT FK_searchID FOREIGN KEY (SearchID) REFERENCES Searches(SearchID),
    CONSTRAINT FK_SearchResults FOREIGN KEY (Name, size, VersionID) REFERENCES Versions(Name, size, VersionID)
);


ALTER TABLE Customers
ADD CONSTRAINT ck_name
CHECK (name NOT LIKE '%[^A-Za-z]%');

ALTER TABLE Customers
ADD CONSTRAINT ck_phoneNumber
CHECK (phoneNumber LIKE '+%' AND LEN(phoneNumber) BETWEEN 10 AND 20 AND phoneNumber NOT LIKE '%[^0-9+]%');

ALTER TABLE Customers
ADD CONSTRAINT ck_email
CHECK (Email LIKE '%@%');

ALTER TABLE Guests
ADD CONSTRAINT ck_GuestID
CHECK (GuestID >= 1);

ALTER TABLE Guests 
ADD CONSTRAINT ck_startTime
CHECK (startTime <= GETDATE());


ALTER TABLE CreditCards
ADD CONSTRAINT ck_cardNumber
CHECK (LEN(cardNumber) between 13 and 19 AND cardNumber NOT LIKE '%[^0-9]%');

ALTER TABLE CreditCards
ADD CONSTRAINT ck_expireDate
CHECK (expireDate > GETDATE());

ALTER TABLE CreditCards
ADD CONSTRAINT ck_cardHolderId
CHECK (LEN(cardHolderId) = 9 AND cardHolderId NOT LIKE '%[^0-9]%');

ALTER TABLE CreditCards
ADD CONSTRAINT ck_CVV
CHECK (LEN(CVV) between 3 and 4 AND CVV NOT LIKE '%[^0-9]%');

ALTER TABLE ShoppingCarts
ADD CONSTRAINT ck_CartID
CHECK (CartID >= 1);

ALTER TABLE Orders
ADD CONSTRAINT ck_orderNumber
CHECK (orderNumber >=1);

ALTER TABLE Orders
ADD CONSTRAINT ck_dueDate
CHECK (dueDate >= DT);

ALTER TABLE Orders
ADD CONSTRAINT ck_deliveryType
CHECK (deliveryType like 'express' or deliveryType like 'standard');

ALTER TABLE Orders
ADD CONSTRAINT ck_ShippingAddressStreet
CHECK (
        ShippingAddressStreet NOT LIKE '%0%' AND
        ShippingAddressStreet NOT LIKE '%1%' AND
        ShippingAddressStreet NOT LIKE '%2%' AND
        ShippingAddressStreet NOT LIKE '%3%' AND
        ShippingAddressStreet NOT LIKE '%4%' AND
        ShippingAddressStreet NOT LIKE '%5%' AND
        ShippingAddressStreet NOT LIKE '%6%' AND
        ShippingAddressStreet NOT LIKE '%7%' AND
        ShippingAddressStreet NOT LIKE '%8%' AND
        ShippingAddressStreet NOT LIKE '%9%'
 );

ALTER TABLE Orders
ADD CONSTRAINT ck_ShippingAddressCity
CHECK (
        ShippingAddressCity NOT LIKE '%0%' AND
        ShippingAddressCity NOT LIKE '%1%' AND
        ShippingAddressCity NOT LIKE '%2%' AND
        ShippingAddressCity NOT LIKE '%3%' AND
        ShippingAddressCity NOT LIKE '%4%' AND
        ShippingAddressCity NOT LIKE '%5%' AND
        ShippingAddressCity NOT LIKE '%6%' AND
        ShippingAddressCity NOT LIKE '%7%' AND
        ShippingAddressCity NOT LIKE '%8%' AND
        ShippingAddressCity NOT LIKE '%9%'
 );

ALTER TABLE Orders
ADD CONSTRAINT ck_ShippingAddressZipCode
CHECK (ShippingAddressZipCode NOT LIKE '%[^0-9]%');

ALTER TABLE Orders
ADD CONSTRAINT ck_BillingAddressStreet
CHECK (
        BillingAddressStreet NOT LIKE '%0%' AND
        BillingAddressStreet NOT LIKE '%1%' AND
        BillingAddressStreet NOT LIKE '%2%' AND
        BillingAddressStreet NOT LIKE '%3%' AND
        BillingAddressStreet NOT LIKE '%4%' AND
        BillingAddressStreet NOT LIKE '%5%' AND
        BillingAddressStreet NOT LIKE '%6%' AND
        BillingAddressStreet NOT LIKE '%7%' AND
        BillingAddressStreet NOT LIKE '%8%' AND
        BillingAddressStreet NOT LIKE '%9%'
 );

ALTER TABLE Orders
ADD CONSTRAINT ck_BillingAddressCity
CHECK (
        BillingAddressCity NOT LIKE '%0%' AND
        BillingAddressCity NOT LIKE '%1%' AND
        BillingAddressCity NOT LIKE '%2%' AND
        BillingAddressCity NOT LIKE '%3%' AND
        BillingAddressCity NOT LIKE '%4%' AND
        BillingAddressCity NOT LIKE '%5%' AND
        BillingAddressCity NOT LIKE '%6%' AND
        BillingAddressCity NOT LIKE '%7%' AND
        BillingAddressCity NOT LIKE '%8%' AND
        BillingAddressCity NOT LIKE '%9%'
 );

ALTER TABLE Orders
ADD CONSTRAINT ck_BillingAddressZipCode
CHECK (BillingAddressZipCode NOT LIKE '%[^0-9]%');

CREATE TABLE Colors (
    ColorName VARCHAR(20) NOT NULL PRIMARY KEY
);

CREATE TABLE Shapes (
    ShapeName VARCHAR(20) NOT NULL PRIMARY KEY
);

CREATE TABLE Materials (
    MaterialName VARCHAR(20) NOT NULL PRIMARY KEY
);

CREATE TABLE Finishes (
    FinishType VARCHAR(20) NOT NULL PRIMARY KEY
);

INSERT INTO Colors (ColorName) VALUES
('White'),
('Black'),
('Blue'),
('Yellow'),
('Red'),
('Silver'),
('Brown'),
('Grey'),
('Orange');

INSERT INTO Shapes (ShapeName) VALUES
('Rectangle'),
('Square'),
('Round'),
('Large Planters'),
('Tall Planters'),
('Long Planters');

INSERT INTO Materials (MaterialName) VALUES
('Fiberglass'),
('Fiberstone');

INSERT INTO Finishes (FinishType) VALUES
('High Gloss'),
('Low Gloss'),
('Distressed'),
('Sand');

ALTER TABLE Products
ADD CONSTRAINT ck_size
CHECK ((Size LIKE '[0-9]%X[0-9]%') OR (Size LIKE '[0-9]%X[0-9]%X[0-9]%'));

alter table Products
ADD CONSTRAINT ck_price_positive
CHECK (price >= 0);

ALTER TABLE Versions
ADD CONSTRAINT fk_color
FOREIGN KEY (ColorName) REFERENCES colors(ColorName);

ALTER TABLE Versions
ADD CONSTRAINT fk_shape
FOREIGN KEY (ShapeName) REFERENCES shapes(ShapeName);

ALTER TABLE Versions
ADD CONSTRAINT fk_material
FOREIGN KEY (MaterialName) REFERENCES materials(MaterialName);

ALTER TABLE versions
ADD CONSTRAINT fk_finish
FOREIGN KEY (FinishType) REFERENCES finishes(FinishType);

ALTER TABLE Searches
ADD CONSTRAINT ck_SearchID
CHECK (SearchID >= 1);

ALTER TABLE Searches
ADD CONSTRAINT ck_searchTime
CHECK (searchTime <= getdate());


--------------------------------------------------
BULK INSERT SearchResults
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\searchesresults.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT Versions
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\versions.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT Searches
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\searches.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT ShoppingCarts
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\shoppingcarts.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT Products
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\products.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT Orders
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\orders.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT OrderItems
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\orderitems.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT CartItems
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\cartitems.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);


BULK INSERT CreditCards
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\creditcards.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"',
    FIRSTROW = 2
);

BULK INSERT Customers
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\Customers.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT Guests
FROM 'C:\Users\yehud\OneDrive\שולחן העבודה\יערה\לימודים\בסיסי נתונים\פרויקט\New folder\guests.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);


---- not nested query
SELECT 
    C.Name AS CustomerName,
    O.DT AS OrderDate,
    P.Name AS ProductName,
    V.ColorName,
    OI.Quantity,
    GETDATE() AS CurrentDate 
FROM Orders O
JOIN Customers C ON O.Email = C.Email
JOIN OrderItems OI ON O.OrderNumber = OI.OrderNumber
JOIN Versions V ON OI.Name = V.Name AND OI.VersionID = V.VersionID
JOIN Products P ON V.Name = P.Name
WHERE O.DT >= DATEADD(DAY, -7, GETDATE())
ORDER BY O.DT DESC;



---- not nested query
SELECT C.Name AS CustomerName, O.Email, COUNT(O.OrderNumber) AS NumOrders
FROM Orders O JOIN Customers C ON O.Email = C.Email
GROUP BY C.Name, O.Email
HAVING COUNT(O.OrderNumber) > 1
ORDER BY COUNT(O.OrderNumber) DESC;




---- nested query
SELECT 
    CAST(COUNT(*) AS FLOAT) * 100 / 
    (SELECT COUNT(DISTINCT Email) 
     FROM Searches 
     WHERE Email IS NOT NULL) 
    AS PercentOfCustomersWith3SearchesAndNoOrder
FROM (
    SELECT Email
    FROM Searches
    WHERE Email IS NOT NULL
    GROUP BY Email
    HAVING COUNT(*) >= 3
       AND Email NOT IN (
            SELECT DISTINCT SC.Email
            FROM ShoppingCarts SC
            JOIN Orders O ON SC.CartID = O.CartID
            WHERE SC.Email IS NOT NULL
       )
) AS FilteredCustomers;


--- nested query

SELECT 
    YQ.OrderYear,
    YQ.OrderQuarter,

    (SELECT TOP 1 OI.Name + ' (' + OI.Size + ')'
     FROM Orders O2
     JOIN OrderItems OI ON O2.OrderNumber = OI.OrderNumber
     WHERE DATEPART(YEAR, O2.DT) = YQ.OrderYear AND DATEPART(QUARTER, O2.DT) = YQ.OrderQuarter
     GROUP BY OI.Name, OI.Size
     ORDER BY SUM(OI.Quantity) DESC
    ) AS TopProduct,

    (SELECT TOP 1 V.ColorName
     FROM Orders O2
     JOIN OrderItems OI ON O2.OrderNumber = OI.OrderNumber
     JOIN Versions V ON OI.Name = V.Name AND OI.Size = V.Size AND OI.VersionID = V.VersionID
     WHERE DATEPART(YEAR, O2.DT) = YQ.OrderYear AND DATEPART(QUARTER, O2.DT) = YQ.OrderQuarter
     GROUP BY V.ColorName
     ORDER BY COUNT(*) DESC
    ) AS TopColor,

    
    (SELECT TOP 1 V.FinishType
     FROM Orders O2
     JOIN OrderItems OI ON O2.OrderNumber = OI.OrderNumber
     JOIN Versions V ON OI.Name = V.Name AND OI.Size = V.Size AND OI.VersionID = V.VersionID
     WHERE DATEPART(YEAR, O2.DT) = YQ.OrderYear AND DATEPART(QUARTER, O2.DT) = YQ.OrderQuarter
     GROUP BY V.FinishType
     ORDER BY COUNT(*) DESC
    ) AS TopFinish,

    (SELECT TOP 1 V.MaterialName
     FROM Orders O2
     JOIN OrderItems OI ON O2.OrderNumber = OI.OrderNumber
     JOIN Versions V ON OI.Name = V.Name AND OI.Size = V.Size AND OI.VersionID = V.VersionID
     WHERE DATEPART(YEAR, O2.DT) = YQ.OrderYear AND DATEPART(QUARTER, O2.DT) = YQ.OrderQuarter
     GROUP BY V.MaterialName
     ORDER BY COUNT(*) DESC
    ) AS TopMaterial

FROM (
    SELECT DISTINCT 
        DATEPART(YEAR, DT) AS OrderYear,
        DATEPART(QUARTER, DT) AS OrderQuarter
    FROM Orders
) AS YQ
ORDER BY OrderYear, OrderQuarter;



--- WINDOW
SELECT 
    CI.Name,
    FORMAT(G.StartTime, 'yyyy-MM') AS Month,
    COUNT(*) AS MonthlyCount,

    LAG(COUNT(*)) OVER (
        PARTITION BY CI.Name 
        ORDER BY FORMAT(G.StartTime, 'yyyy-MM')
    ) AS PrevMonthCount,

    ROW_NUMBER() OVER (
        PARTITION BY CI.Name 
        ORDER BY FORMAT(G.StartTime, 'yyyy-MM')
    ) AS AppearanceNumber

FROM CartItems CI
JOIN ShoppingCarts SC ON CI.CartID = SC.CartID
JOIN Guests G ON SC.GuestID = G.GuestID

WHERE G.StartTime IS NOT NULL

GROUP BY CI.Name, FORMAT(G.StartTime, 'yyyy-MM')
ORDER BY CI.Name, Month;




--- WINDOW
SELECT O.Email, O.OrderNumber, O.DT,
    SUM(OrderPrices.TotalOrderPrice) OVER (
        PARTITION BY O.Email 
        ORDER BY O.DT 
        ROWS UNBOUNDED PRECEDING
    ) AS CumulativeSpent,
    LAG(O.DT) OVER (
        PARTITION BY O.Email 
        ORDER BY O.DT
    ) AS PreviousOrderDate,
    RANK() OVER (
        PARTITION BY O.Email 
        ORDER BY O.DT
    ) AS OrderRank,
    NTILE(4) OVER (
        ORDER BY OrderPrices.TotalOrderPrice
    ) AS SpendingQuartile
FROM Orders O JOIN (
    SELECT OI.OrderNumber, SUM(OI.Quantity * P.Price) AS TotalOrderPrice
    FROM OrderItems OI JOIN Products P ON OI.Name = P.Name AND OI.Size = P.Size
    GROUP BY OI.OrderNumber
) AS OrderPrices ON O.OrderNumber = OrderPrices.OrderNumber
ORDER BY O.Email, O.DT;


--- CTE
WITH CustomerCarts AS (
    SELECT CartID, Email
    FROM ShoppingCarts
    WHERE Email IS NOT NULL
),
CartsWithItems AS (
    SELECT DISTINCT CartID
    FROM CartItems
),
CartsWithOrders AS (
    SELECT DISTINCT CartID
    FROM Orders
    WHERE CartID IS NOT NULL
),
AbandonedCustomerCarts AS (
    SELECT CC.Email, CC.CartID
    FROM CustomerCarts CC
    JOIN CartsWithItems CI ON CC.CartID = CI.CartID
    LEFT JOIN CartsWithOrders CWO ON CC.CartID = CWO.CartID
    WHERE CWO.CartID IS NULL
)


SELECT 
    ACC.Email,
    C.Name,
    ACC.CartID
FROM AbandonedCustomerCarts ACC
JOIN Customers C ON ACC.Email = C.Email
ORDER BY C.Name;


--- VIEW
DROP VIEW if exists vw_PopularSearchResults
GO
CREATE VIEW vw_PopularSearchResults AS
SELECT SR.Name, SR.Size, SR.VersionID, COUNT(*) AS AppearanceCount
FROM SearchResults SR
GROUP BY SR.Name, SR.Size, SR.VersionID
HAVING COUNT(*) > 5;
GO

SELECT TOP 5 Name, Size, VersionID, AppearanceCount
FROM vw_PopularSearchResults
ORDER BY AppearanceCount DESC;


--- function
DROP FUNCTION IF EXISTS dbo.GetTotalOrderValueByEmail;
GO
CREATE FUNCTION dbo.GetTotalOrderValueByEmail (@Email VARCHAR(50))
RETURNS MONEY
AS
BEGIN
    DECLARE @TotalValue MONEY;

    SELECT @TotalValue = SUM(P.Price * OI.Quantity)
    FROM Orders O
    JOIN OrderItems OI ON O.OrderNumber = OI.OrderNumber
    JOIN Versions V ON OI.Name = V.Name AND OI.Size = V.Size AND OI.VersionID = V.VersionID
    JOIN Products P ON V.Name = P.Name AND V.Size = P.Size
    WHERE O.Email = @Email;

    RETURN ISNULL(@TotalValue, 0);
END;
GO

SELECT 
    C.Email,
    C.Name,
    dbo.GetTotalOrderValueByEmail(C.Email) AS TotalSpent
FROM Customers C;


--- function
DROP FUNCTION IF EXISTS dbo.GetPopularityRank;
GO
CREATE FUNCTION dbo.GetPopularityRank (
    @Name VARCHAR(50),
    @Size VARCHAR(20),
    @VersionID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Rank INT;

    WITH RankedSearches AS (
        SELECT 
            Name,
            Size,
            VersionID,
            AppearanceCount,
            RANK() OVER (ORDER BY AppearanceCount DESC) AS PopularityRank
        FROM vw_PopularSearchResults
    )
    SELECT @Rank = PopularityRank
    FROM RankedSearches
    WHERE Name = @Name AND Size = @Size AND VersionID = @VersionID;

    RETURN ISNULL(@Rank, -1); 
END;
GO

SELECT 
    V.Name,
    V.Size,
    V.VersionID,
    dbo.GetPopularityRank(V.Name, V.Size, V.VersionID) AS PopularityRank
FROM Versions V;


--- TRIGGER
DROP TABLE if exists SearchTracking
CREATE TABLE SearchTracking (
    SearchTerm VARCHAR(100) PRIMARY KEY,
    NumSearches INT DEFAULT 1,
    LastSearchTime DATETIME
);

GO
CREATE TRIGGER trg_UpdateSearchTracking
ON Searches
AFTER INSERT
AS
BEGIN
      UPDATE ST
    SET 
        ST.NumSearches = ST.NumSearches + 1,
        ST.LastSearchTime = I.SearchTime
    FROM SearchTracking ST
    JOIN INSERTED I ON ST.SearchTerm = I.SearchTerm;

   
    INSERT INTO SearchTracking (SearchTerm, NumSearches, LastSearchTime)
    SELECT I.SearchTerm, 1, I.SearchTime
    FROM INSERTED I
    WHERE NOT EXISTS (
        SELECT 1
        FROM SearchTracking ST
        WHERE ST.SearchTerm = I.SearchTerm
    );
END;
GO

--- procedure
IF OBJECT_ID('dbo.SentDiscounts', 'U') IS NOT NULL
    DROP TABLE dbo.SentDiscounts;

CREATE TABLE dbo.SentDiscounts (
    Email VARCHAR(50),
    ProductName VARCHAR(50),
    Size VARCHAR(20),
    VersionID TINYINT,
    DiscountPercent INT,
    SentTime DATETIME DEFAULT GETDATE()
);


DROP PROCEDURE IF EXISTS SendTargetedDiscounts;
GO

CREATE PROCEDURE SendTargetedDiscounts
    @MaxPopularity INT = 5

AS
BEGIN
    SET NOCOUNT ON;

    ;WITH RankedSearches AS (
        SELECT 
            S.Email, 
            SR.Name, SR.Size, SR.VersionID,
            ROW_NUMBER() OVER (PARTITION BY S.Email ORDER BY S.SearchTime DESC) AS SearchRank
        FROM Searches S
        JOIN SearchResults SR ON S.SearchID = SR.SearchID
        WHERE S.Email IS NOT NULL
    ),

    Popularity AS (
        SELECT 
            R.Email, R.Name, R.Size, R.VersionID, R.SearchRank,
            ISNULL(VPS.AppearanceCount, 0) AS PopularityScore
        FROM RankedSearches R
        LEFT JOIN vw_PopularSearchResults VPS
            ON R.Name = VPS.Name AND R.Size = VPS.Size AND R.VersionID = VPS.VersionID  AND VPS.AppearanceCount >= @MaxPopularity
        WHERE R.SearchRank IN (1, 2)
    ),

    Search1 AS (
        SELECT * FROM Popularity WHERE SearchRank = 1
    ),
    Search2 AS (
        SELECT * FROM Popularity WHERE SearchRank = 2
    ),

    SelectedProducts AS (
        SELECT 
            S1.Email,

            CASE 
                WHEN S1.PopularityScore = 0 THEN S1.Name
                WHEN ISNULL(S2.PopularityScore, 0) < S1.PopularityScore THEN S2.Name
                ELSE S1.Name
            END AS ProductName,

            CASE 
                WHEN S1.PopularityScore = 0 THEN S1.Size
                WHEN ISNULL(S2.PopularityScore, 0) < S1.PopularityScore THEN S2.Size
                ELSE S1.Size
            END AS ProductSize,

            CASE 
                WHEN S1.PopularityScore = 0 THEN S1.VersionID
                WHEN ISNULL(S2.PopularityScore, 0) < S1.PopularityScore THEN S2.VersionID
                ELSE S1.VersionID
            END AS ProductVersionID

        FROM Search1 S1
        LEFT JOIN Search2 S2 ON S1.Email = S2.Email
    )

    INSERT INTO SentDiscounts (Email, ProductName, Size, VersionID, DiscountPercent)
    SELECT 
        Email,
        ProductName,
        ProductSize,
        ProductVersionID,
        CASE 
            WHEN TotalSpent >= 10000 THEN 20
            WHEN TotalSpent = 0 THEN 5
            ELSE 10
        END AS DiscountPercent
    FROM (
        SELECT 
            SP.Email,
            SP.ProductName,
            SP.ProductSize,
            SP.ProductVersionID,
            dbo.GetTotalOrderValueByEmail(SP.Email) AS TotalSpent
        FROM SelectedProducts SP
    ) AS FinalData;
END;
GO
---
SELECT * FROM SentDiscounts;
---
EXEC SendTargetedDiscounts;
---
SELECT * FROM SentDiscounts
ORDER BY SentTime DESC;





--- deshboards

drop view if exists vw_OrdersWithSearches
GO
CREATE VIEW vw_OrdersWithSearches AS
SELECT 
    O.DT AS OrderTime,                         -- זמן ההזמנה
    O.DeliveryType,                            -- סוג המשלוח

    OI.Name AS ProductName,                    -- שם המוצר
    SUM(OI.Quantity) AS TotalUnits,            -- סך היחידות

    V.ColorName,                               -- צבע
    SUM(P.Price * OI.Quantity) AS TotalSales,  -- סכום מכירה הכולל

    COUNT(DISTINCT SR.SearchID) AS SearchResultsCount -- כמות הופעות בתוצאות חיפוש
FROM Orders O
JOIN OrderItems OI ON O.OrderNumber = OI.OrderNumber
JOIN Versions V ON OI.Name = V.Name AND OI.VersionID = V.VersionID AND OI.Size = V.Size
JOIN Products P ON V.Name = P.Name AND V.Size = P.Size

-- חיפושים
LEFT JOIN Searches S ON O.Email = S.Email
LEFT JOIN SearchResults SR 
    ON S.SearchID = SR.SearchID 
    AND SR.Name = OI.Name 
    AND SR.Size = OI.Size 
    AND SR.VersionID = OI.VersionID

GROUP BY 
    O.DT,
    O.DeliveryType,
    OI.Name,
    V.ColorName;
GO


--- business report
-- best selling
drop view if exists BestSellingProducts
GO
CREATE VIEW BestSellingProducts AS
SELECT 
    OI.Name AS ProductName,
    SUM(OI.Quantity) AS TotalQuantitySold,
    SUM(OI.Quantity * P.Price) AS TotalRevenue,
    COUNT(DISTINCT OI.OrderNumber) AS NumOrders
FROM OrderItems OI
JOIN Versions V 
    ON OI.Name = V.Name AND OI.Size = V.Size AND OI.VersionID = V.VersionID
JOIN Products P 
    ON V.Name = P.Name AND V.Size = P.Size
GROUP BY OI.Name;
GO

-- popularity of features
drop view if exists AttributePopularity
GO
CREATE VIEW AttributePopularity AS
SELECT 
    V.ColorName AS Attribute,
    'Color' AS AttributeType,
    SUM(OI.Quantity) AS TotalSold
FROM OrderItems OI
JOIN Versions V ON OI.Name = V.Name AND OI.Size = V.Size AND OI.VersionID = V.VersionID
WHERE V.ColorName IS NOT NULL
GROUP BY V.ColorName

UNION ALL

SELECT 
    V.MaterialName,
    'Material',
    SUM(OI.Quantity)
FROM OrderItems OI
JOIN Versions V ON OI.Name = V.Name AND OI.Size = V.Size AND OI.VersionID = V.VersionID
WHERE V.MaterialName IS NOT NULL
GROUP BY V.MaterialName

UNION ALL

SELECT 
    V.FinishType,
    'Finish',
    SUM(OI.Quantity)
FROM OrderItems OI
JOIN Versions V ON OI.Name = V.Name AND OI.Size = V.Size AND OI.VersionID = V.VersionID
WHERE V.FinishType IS NOT NULL
GROUP BY V.FinishType;
GO

-- common searches that didnt led to purchase
drop view if exists UnUsefulSearches
GO
CREATE VIEW UnUsefulSearches AS
SELECT 
    S.SearchTerm,
    COUNT(*) AS NumTimesSearched
FROM Searches S
LEFT JOIN SearchResults SR ON S.SearchID = SR.SearchID
LEFT JOIN OrderItems OI 
    ON SR.Name = OI.Name AND SR.Size = OI.Size AND SR.VersionID = OI.VersionID
WHERE OI.OrderNumber IS NULL
GROUP BY S.SearchTerm;
GO

-- orders by days
drop view if exists OrdersByWeekday
GO
CREATE VIEW OrdersByWeekday AS
SELECT 
    DATENAME(WEEKDAY, DT) AS Weekday,
    COUNT(*) AS NumOrders
FROM Orders
WHERE DT IS NOT NULL
GROUP BY DATENAME(WEEKDAY, DT);
GO


----- Bonus part
-- temporary tables
SELECT 
    ShippingAddressCity AS City,
    SUM(P.Price * OI.Quantity) AS TotalSales,
    COUNT(DISTINCT O.OrderNumber) AS NumOrders
INTO #CitySalesSummary
FROM Orders O
JOIN OrderItems OI ON O.OrderNumber = OI.OrderNumber
JOIN Versions V ON OI.Name = V.Name AND OI.Size = V.Size AND OI.VersionID = V.VersionID
JOIN Products P ON V.Name = P.Name AND V.Size = P.Size
WHERE O.DT BETWEEN '2024-01-01' AND '2024-12-31' 
GROUP BY ShippingAddressCity;

SELECT * FROM #CitySalesSummary
ORDER BY TotalSales DESC;

DROP TABLE #CitySalesSummary;


----- Merge
drop table if exists CustomerLifecycleStatus
CREATE TABLE CustomerLifecycleStatus (
    Email VARCHAR(50) PRIMARY KEY,
    Status VARCHAR(20),
    LastPurchaseDate DATETIME
);

MERGE INTO CustomerLifecycleStatus AS Target
USING (
    SELECT 
        C.Email,
        MAX(O.DT) AS LastPurchaseDate,
        COUNT(O.OrderNumber) AS TotalOrders,
        DATEDIFF(DAY, MAX(O.DT), GETDATE()) AS DaysSinceLastOrder
    FROM Customers C
    LEFT JOIN Orders O ON C.Email = O.Email
    GROUP BY C.Email
) AS Source
ON Target.Email = Source.Email

WHEN MATCHED THEN
    UPDATE SET 
        Target.LastPurchaseDate = Source.LastPurchaseDate,
        Target.Status = 
            CASE 
                WHEN Source.TotalOrders = 0 THEN 'New'
                WHEN Source.TotalOrders >= 5 AND Source.DaysSinceLastOrder <= 60 THEN 'Loyal'
                WHEN Source.DaysSinceLastOrder > 60 THEN 'Inactive'
                ELSE 'Active'
            END

WHEN NOT MATCHED THEN
    INSERT (Email, LastPurchaseDate, Status)
    VALUES (
        Source.Email,
        Source.LastPurchaseDate,
        CASE 
            WHEN Source.TotalOrders = 0 THEN 'New'
            WHEN Source.TotalOrders >= 5 AND Source.DaysSinceLastOrder <= 60 THEN 'Loyal'
            WHEN Source.DaysSinceLastOrder > 60 THEN 'Inactive'
            ELSE 'Active'
        END
    );
SELECT 
    C.Email,
    C.Name,
    MAX(O.DT) AS LastOrderDate,
    CLS.Status
FROM Customers C
LEFT JOIN Orders O ON C.Email = O.Email
LEFT JOIN CustomerLifecycleStatus CLS ON C.Email = CLS.Email
GROUP BY C.Email, C.Name, CLS.Status
ORDER BY LastOrderDate DESC;
