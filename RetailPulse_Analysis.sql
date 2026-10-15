USE retailpulse;

CREATE TABLE IF NOT EXISTS superstore (
    `Row ID` INT,
    `Order ID` VARCHAR(20),
    `Order Date` VARCHAR(20),
    `Ship Date` VARCHAR(20),
    `Ship Mode` VARCHAR(30),
    `Customer ID` VARCHAR(20),
    `Customer Name` VARCHAR(100),
    Segment VARCHAR(30),
    Country VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    `Postal Code` VARCHAR(20),
    Region VARCHAR(30),
    `Product ID` VARCHAR(30),
    Category VARCHAR(50),
    `Sub-Category` VARCHAR(50),
    `Product Name` VARCHAR(255),
    Sales DECIMAL(12,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(12,2)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 26.7/Uploads/Sample - Superstore.csv'
INTO TABLE superstore
CHARACTER SET latin1
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(`Row ID`, `Order ID`, `Order Date`, `Ship Date`, `Ship Mode`,
 `Customer ID`, `Customer Name`, Segment, Country, City, State,
 `Postal Code`, Region, `Product ID`, Category, `Sub-Category`,
 `Product Name`, Sales, Quantity, Discount, Profit);

SELECT COUNT(*) AS total_records FROM superstore;

SELECT *
FROM superstore
LIMIT 10;

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT `Row ID`) AS unique_row_ids
FROM superstore;

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT `Row ID`) AS unique_row_ids
FROM superstore;

TRUNCATE TABLE superstore;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 26.7/Uploads/Sample - Superstore.csv'
INTO TABLE superstore
CHARACTER SET latin1
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(`Row ID`, `Order ID`, `Order Date`, `Ship Date`, `Ship Mode`,
 `Customer ID`, `Customer Name`, Segment, Country, City, State,
 `Postal Code`, Region, `Product ID`, Category, `Sub-Category`,
 `Product Name`, Sales, Quantity, Discount, Profit);

 SELECT COUNT(*) AS total_records FROM superstore;

 SELECT
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    AVG(Discount) AS average_discount,
    COUNT(*) AS total_orders
FROM superstore;

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY Category
ORDER BY total_profit DESC;

SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY `Sub-Category`
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY Region
ORDER BY profit_margin_pct DESC;

SELECT
    COUNT(*) AS high_discount_records,
    SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END) AS loss_records,
    ROUND(
        100.0 * SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS loss_rate_pct
FROM superstore
WHERE Discount >= 0.30;

SELECT
    `Customer ID`,
    `Customer Name`,
    COUNT(*) AS transaction_count,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY `Customer ID`, `Customer Name`
ORDER BY total_profit DESC
LIMIT 10;