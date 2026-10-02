\# Zepto Inventory Analysis



\## 📌 Project Overview

Analyzed Zepto's e-commerce inventory dataset to identify supply chain gaps, pricing patterns, and category-level performance issues. This project covers the full data analysis workflow: data cleaning in MySQL, exploratory analysis using SQL, and visualization in Power BI.



\## 🛠️ Tools Used

\- \*\*MySQL\*\* — data cleaning, transformation, and business queries

\- \*\*Power BI\*\* — dashboard and data visualization

\- \*\*DAX\*\* — calculated measures (inventory value, out-of-stock %, etc.)



\## 📂 Dataset

\- \*\*Source:\*\* Kaggle — Zepto Inventory Dataset

\- \*\*Original rows:\*\* 3,727

\- \*\*Cleaned rows:\*\* 1,798

\- \*\*Columns:\*\* category, name, mrp, discountPercent, availableQuantity, discountedSellingPrice, weightInGms, outOfStock, quantity



\## 🧹 Data Cleaning Steps

1\. Imported raw CSV into MySQL (`zepto\_analysis` database).

2\. Checked for null values across all columns — none found.

3\. Identified one row with `mrp = 0` and removed it.

4\. Detected duplicate products tagged under inconsistent categories (e.g., the same product appeared under "Cooking Essentials," "Munchies," and "Packaged Food").

5\. Deduplicated by product name, keeping the alphabetically first category as a placeholder.

6\. Created a cleaned table (`zepto\_clean`) with \*\*1,798 unique products\*\*.



\## 📊 Key Findings

\- \*\*Biscuits\*\* have the highest out-of-stock rate (\*\*28.57%\*\*), indicating supply chain gaps in a high-demand category.

\- \*\*Overall out-of-stock rate:\*\* 12.07% (1 in 8 products unavailable).

\- \*\*Cooking Essentials\*\* holds the largest inventory value (\*\*₹3.07 lakh\*\*), followed by Paan Corner and Chocolates \& Candies.

\- \*\*Top discounts (50–51%)\*\* are concentrated in premium branded items, suggesting clearance-driven pricing.

\- \*\*Fresh categories\*\* (Fruits \& Vegetables, Meats) show low out-of-stock but also low revenue potential — likely traffic drivers.



\## 💡 Recommendations

\- Prioritize restocking for \*\*Biscuits, Beverages, and Meats/Fish/Eggs\*\*.

\- Review procurement strategy for premium brands with consistent 50%+ discounts.

\- Monitor turnover in \*\*Cooking Essentials\*\* to reduce holding costs.

\- Consider bundling fresh items with high-margin products to increase average order value.



\## 📁 Files in This Repository

\- `zepto\_cleaning.sql` — SQL queries for cleaning and analysis

\- `zapato\_dashboard.pbix` — Power BI dashboard file

\- `dashboard\_screenshot.png` — image of the final dashboard

\- `README.md` — this file



\## 📸 Dashboard Preview

!\[Zepto Dashboard](dashboard\_screenshot.png)

&#x20;

