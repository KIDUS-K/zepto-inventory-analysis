-- ============================================
-- Zepto Inventory Analysis
-- Data Cleaning & Business Queries
-- Tools: MySQL
-- ============================================

-- Step 1: Create database and table

create DATABASE zepto_analysis;
create table zepto(
sku_id num auto_increment primary key,
name char(200),
category varchar(100),
mrp decimal(100,2),
dicountPercent decimal(5,2),
avliableQuantity int,
discountedSellingPrice decimal(10,2),
weightInGms int,
outOfStock varchar,
quantity int;

)


-- Note: Import the CSV via MySQL Workbench's Table Data Import Wizard
-- after creating this table.

-- ============================================
-- Step 2: Data Quality Checks
-- ============================================

-- Check for null values in all columns
select 
sum(case when name is null 1 else 0) as name_sum,
sum(case when category is null 1 else 0) as category_sum,
sum(case when mrp is null 1 else 0) as mrp_sum,
sum(case when dicountPercent is null 1 else 0) as dicountPercent_sum,
sum(case when avliableQuantity is null 1 else 0) as avliableQuantity_sum,
sum(case when discountedSellingPrice is null 1 else 0) as discountedSellingPrice_sum,
sum(case when weightInGms is null 1 else 0) as weightInGms_sum,
sum(case when outOfStock is null 1 else 0) as outOfStock_sum,
sum(case when quantity is null 1 else 0) as quantity_sum,
from Zepto;

-- Find invalid rows (mrp = 0)
select * from zepto where mrp=0 or discountedSellingPrice=0;

-- Remove the invalid row
delete from zepto where sku_id=3608;

-- Check for duplicate products with inconsistent categories
SELECT name, category, mrp, weightInGms, COUNT(*) AS cnt
FROM zepto
GROUP BY name, category, mrp, weightInGms
HAVING COUNT(*) > 1
ORDER BY cnt DESC;

-- ============================================
-- Step 3: Create Cleaned Table
-- ============================================

CREATE TABLE zepto_clean AS
SELECT
    MIN(sku_id) AS sku_id,
    name,
    MIN(category) AS category,
    mrp,
    discountPercent,
    availableQuantity,
    discountedSellingPrice,
    weightInGms,
    outOfStock,
    quantity
FROM zepto
GROUP BY name, mrp, discountPercent, availableQuantity,
         discountedSellingPrice, weightInGms, outOfStock, quantity;

-- Verify the cleaned table
SELECT COUNT(*) FROM zepto_clean;

-- ============================================
-- Step 4: Business Queries
-- ============================================

-- Q1: How many products per category?
SELECT category, COUNT(*) AS product_count
FROM zepto_clean
GROUP BY category
ORDER BY product_count DESC;

-- Q2: What is the price range?
SELECT
    MIN(mrp) AS min_price,
    MAX(mrp) AS max_price,
    AVG(mrp) AS avg_price
FROM zepto_clean;

-- Q3: How many products are out of stock?
SELECT outOfStock, COUNT(*) AS count
FROM zepto_clean
GROUP BY outOfStock;

-- Q4: Which categories have the highest out-of-stock rate?
SELECT
    category,
    COUNT(*) AS total_products,
    SUM(CASE WHEN outOfStock = 'TRUE' THEN 1 ELSE 0 END) AS out_of_stock_count,
    ROUND(SUM(CASE WHEN outOfStock = 'TRUE' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS out_of_stock_pct
FROM zepto_clean
GROUP BY category
ORDER BY out_of_stock_pct DESC;

-- Q5: Top 10 most discounted products
SELECT name, category, mrp, discountPercent, discountedSellingPrice
FROM zepto_clean
ORDER BY discountPercent DESC
LIMIT 10;

-- Q6: Potential revenue per category if all stock sold
SELECT
    category,
    SUM(discountedSellingPrice * availableQuantity) / 100 AS potential_revenue_rupees
FROM zepto_clean
GROUP BY category
ORDER BY potential_revenue_rupees DESC;