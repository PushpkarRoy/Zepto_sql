CREATE TABLE zepto(
Category VARCHAR(100),
name VARCHAR(500),
mrp	INT,
discount_Percent INT,
available_Quantity INT,
discounted_Selling_Price INT,
weightIn_Gms INT,
out_Of_Stock VARCHAR(50),
quantity INT
)

--  Data Set
SELECT * FROM zepto

-- Data Count

SELECT COUNT(*)
FROM zepto

-- Find null 
SELECT * FROM zepto
WHERE Category is null  
or 
 name is null 
or
 mrp is null 
or
 discount_Percent is null 
or
 available_Quantity is null 
or
 discounted_Selling_Price is null 
or
 weightIn_Gms is null 
or
 out_of_stock is null 
or
 quantity is null 

-- Data Cleaning 

SELECT * FROM zepto 
WHERE mrp = 0

-- Drop column 

DELETE FROM zepto 
WHERE mrp = 0

-- Change mrp paise into rs 
SELECT * FROM zepto 

UPDATE zepto 
SET mrp = mrp / 100.0,
discounted_selling_price = discounted_selling_price / 100.0

-- Problem Analysis 

-- Quest 1. Find the top best value product based on the discount percentage.

SELECT  DISTINCT name AS product_name, mrp,
		ROUND(AVG(discount_percent):: NUMERIC,0) as discount_percent
FROM zepto 
GROUP BY product_name, mrp
ORDER BY discount_percent DESC
LIMIT 10

-- Quest 2. What are the product with high MRP but out of stock.

SELECT DISTINCT name, mrp
FROM zepto
WHERE out_of_stock = 'TRUE'
ORDER BY mrp DESC
LIMIT 5

-- Quest 3. Calculate estimated revenue from each category.

SELECT  category,
		SUM(discounted_selling_price * quantity) AS estimated_total_revenue,
		ROUND(AVG(discounted_selling_price * quantity):: NUMERIC ,2) AS estimated_Avg_revenue
FROM zepto
GROUP BY category
ORDER BY estimated_total_revenue DESC
		
-- Quest 4. Find all product where MRP is greater then 500 and discount less then 10%. 

SELECT DISTINCT name, mrp, discount_percent 
FROM zepto 
WHERE mrp > 500 AND discount_percent < 10
ORDER BY mrp DESC

-- Quest 5. Identify the top 5 category offering the highest discount percentage.

SELECT category, ROUND(AVG(discount_percent):: NUMERIC, 2) AS discount_percent
FROM zepto
GROUP BY category
ORDER BY discount_percent DESC
LIMIT 5

-- Quest 6. Find the price per gram from product over 100g and sort by best value 

SELECT  DISTINCT name, discounted_selling_price, weightin_gms,
		ROUND((discounted_selling_price:: NUMERIC / weightin_gms ):: NUMERIC , 3) AS price_per_gram
FROM zepto
WHERE weightin_gms >= 100
ORDER BY price_per_gram DESC

-- Quest 7. Group the prducts into category like low, medium and bulk.

SELECT  name AS product_name, quantity,
			CASE 
				WHEN quantity > 0 AND quantity < 500 THEN 'low'
				WHEN quantity >= 500 AND quantity < 1000 THEN 'medium'
				WHEN quantity >= 1000 THEN 'bulk'
			END AS quantity_category 
FROM zepto 

-- Quest 8. What is the total inventory weight per category 
SELECT * FROM zepto 

SELECT category, SUM(weightin_gms * available_Quantity ) AS total_inventory_weight
FROM zepto 
WHERE out_of_stock = 'FALSE'
GROUP BY category 
ORDER BY total_inventory_weight DESC
