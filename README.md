# 🛒 Zepto Product Analysis using SQL

> 🔍 This project explores product-level data from **Zepto**, one of India's fastest-growing instant delivery platforms. The goal was to analyze discounts, stock availability, pricing strategies, and inventory categories using advanced **SQL queries**.



---

## 📦 Project Overview
 
In this project, I worked with a dataset simulating real-world product listings from Zepto, including:
- Product pricing  
- Discount percentages
- Stock availability       
- Weight and quantity         

The entire analysis was conducted using **SQL** (PostgreSQL syntax), focused on delivering insights that are valuable for **business decision-making** in e-commerce.

---     

## 🧾 Table Schema      
  
🧼 Data Cleaning & Preparation 
Checked for null values across all columns 
 
Removed invalid rows where mrp = 0

Converted mrp and discounted_selling_price from paise to rupees

Handled data type issues for accurate calculation

UPDATE zepto
SET mrp = mrp / 100.0,
    discounted_selling_price = discounted_selling_price / 100.0;

🔎 Key Business Questions & Queries
1️⃣ Top Products by Discount %
Identify the most heavily discounted products

SELECT name, mrp, ROUND(AVG(discount_percent), 0) AS discount_percent
FROM zepto
GROUP BY name, mrp
ORDER BY discount_percent DESC
LIMIT 10;


2️⃣ High MRP Products That Are Out of Stock
Products with high price but currently unavailable

3️⃣ Estimated Revenue by Category
Total and average potential revenue grouped by product category

4️⃣ Premium Products With Low Discounts
MRP > ₹500 and discount < 10%

5️⃣ Top Categories by Average Discount %
Grouped by category, showing top 5 value-driven segments

6️⃣ Best Price-per-Gram Products (Over 100g)
Helpful to identify cost-efficient items

7️⃣ Inventory Grouping (Low, Medium, Bulk)
Based on available quantity

8️⃣ Total Inventory Weight per Category
Analyzing which categories contribute the most to physical stock volume

SELECT category, SUM(weightin_gms * available_quantity) AS total_inventory_weight
FROM zepto
WHERE out_of_stock = 'FALSE'
GROUP BY category
ORDER BY total_inventory_weight DESC;

📊 Key Insights
Some products offer massive discounts despite having low weight/value.

High-MRP items are often out of stock, hinting at either popularity or poor inventory planning.

The "Snacks" and "Personal Care" categories contain many medium-discount, high-volume products.

Grouping products by stock level helps in inventory segmentation (low/medium/bulk).

Price-per-gram helps discover real value products — useful for pricing and promotion decisions.

🛠️ Tools Used
Tool	Purpose
PostgreSQL / SQL	Querying and analysis
DBeaver or pgAdmin	SQL interface (optional)

📂 Files in the Repository

📁 zepto_project/
├── zepto_analysis.sql         # Full SQL script
├── README.md                  # Project overview
└── /screenshots/              # Add Power BI / query images here

🔗 Project Use Cases
Inventory management and classification

Promotion strategy for high-discount categories

Pricing benchmarking (MRP vs discounted price vs weight)

Stock value estimation per category

👨‍💻 Author
Pushpkar Roy
📬 pushpkarroy880@gmail.com
🌐 LinkedIn | GitHub



