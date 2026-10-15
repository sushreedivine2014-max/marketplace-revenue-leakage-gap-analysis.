# Marketplace Revenue Leakage & Gap Analysis Using SQL

## 🎯 Project Goal
Modern marketplaces often experience rising top-line sales alongside declining bottom-line profits due to hidden operational costs. This SQL-based project builds a comprehensive database analysis to pinpoint exactly where **revenue leakage** occurs, evaluate the direct impacts of aggressive discount strategies, and protect critical profitability margins.

---

## 🏗️ Marketplace Database Architecture (ER Diagram)
The relational database design integrates data models across multiple marketplace nodes to expose hidden cost gaps:
* **Products & Sellers:** Tracking category-specific margins, inventory sources, and missing vendor data.
* **Orders & Discounts:** Analyzing total revenue generation versus promotional price degradation.
* **Logistics & Fees:** Quantifying the operational toll of freight charges and payment gateway transaction fees.

---

## 🛠️ Task-by-Task Analysis & Strategic Breakdown

### 📊 Task 1: Revenue vs. Profit Reality
* **Objective:** Validate the exact relationship between gross transactional volume and actual net profits.
* **Key Finding:** Successfully verified that a high-sales volume of **\$38.4M** efficiently translates into an actual profit of **\$23.6M**. 
* **Recommendation:** The business model safely retains over **55 cents of every dollar sold**. Scale target marketing operations immediately to capture additional market share.

### 🗂️ Task 2: Category-wise Sales & Profit
* **Objective:** Breakdown revenue performance and structural efficiency across product categories.
* **Key Insights:**
  * **Electronics:** Leading category with the highest sales (**\$7,775,191.00**) and highest profit (**\$4,222,548.83**), yielding a **54.31%** margin.
  * **Power & Grocery:** Exceptional structural efficiency, boasting top-tier profit margins at **65.09%** and **61.12%**.
  * **Fashion:** Second in total sales (**\$6,236,777.40**) but suffers from the lowest profit margin (**31.84%**), driven by high return rates.
  * **Data Quality Alert:** A massive **\$1,349,074.00** in revenue is trapped under `UNKNOWN` categories, requiring an immediate data entry audit.

### 📉 Task 3: Loss-Making Products
* **Objective:** Isolate specific SKUs actively bleeding operational capital.
* **Key Insights:**
  * **High Deficit:** **58 unique SKUs** are structurally unprofitable across the Fashion, Grocery, and Electronics branches.
  * **Top Drains:** `Product 521` (-\$768,000) and `Product 1601` (-\$214,000) demand instant price or supply corrections.
  * **Action Plan:** Audit discount limits on these top 5 loss-making items, phase out uncooperative suppliers, and ban `UNKNOWN` brands.

### 🏷️ Task 4: Discount Usage Overview
* **Objective:** Evaluate the frequency and business health of promotional offerings.
* **Key Insights:** 
  * Metrics reveal **6,245 discounted orders** using over **3,018 distinct discount units**.
  * **Action Plan:** Cap dynamic discount triggers to optimize the current **7.76% average discount**, eliminate underperforming product bundles, and run cohort segmentation to target high-discount customer groups.

### 💳 Task 5: Payment Method Popularity & Data Cleaning
* **Objective:** Track transaction channel performance while clearing system anomalies.
* **Data Cleaning:** Filtered out erroneous records containing zero quantities and zero selling prices marked as 'Delivered' or 'Shipped'.
* **Volume Distribution:** 
  * **UPI:** Highest revenue channel (**\$10.8M**).
  * **Wallet:** Highest order volume (**5,409 orders**).
  * **Credit:** Lowest volume (**4,520 orders**) and lowest revenue (**\$5.84M**).
* **Recommendation:** Launch strategic bank partnerships to optimize transaction fees and introduce targeted wallet loyalty rewards to incentivize repeat checkouts.

### 📈 Task 6: Discount vs. Profit Gap
* **Objective:** Measure the point where discount thresholds aggressively cannibalize profits.
* **Recommendation:** Eliminate sweeping flat discount rules on structurally low-margin items. Implement dynamic, basket-size-dependent threshold triggers to protect the marketplace's baseline **54.91% profit margin**.

### 🔄 Task 7: Return Impact on Revenue
* **Objective:** Assess the financial damage caused by customer product returns.
* **Financial Impact:** 
  * Gross Revenue Loss: **\$8,603,539.00**
  * Direct Profit Loss: **\$3,781,723.00**
  * Average Margin Drop: **15.65%**
* **Recommendation:** Tighten return windows for high-risk categories and enhance digital product display pages (clearer sizing guides and 3D visual assets) to drastically cut down mismatched expectations.

### 🔍 Task 8: Return Reason Analysis
* **Objective:** Classify and resolve explicit triggers behind product returns.
* **Breakdown & Fixes:**
  * **Unknown Causes (38.64% / \$3.32M):** Launch an automated, mandatory post-return reason survey.
  * **Buyer Remorse (20% / \$540K):** Retarget with selective exchange incentives.
  * **Incorrect Sizing (16% / \$391K):** Roll out dynamic AI size-matching modules.
  * **Damaged Items (12% / \$310K):** Upgrade logistics fulfillment protective packaging.
  * **Late Delivery (7.57% / \$120K):** Penalize underperforming regional delivery carriers.

### 🚛 Task 9: Logistics Cost Burden
* **Objective:** Investigate how freight charges influence order-level profitability.
* **Recommendation:** Enforce a minimum order value (MOV) for free shipping. Audit zero-value deliveries, optimize regional carrier routing zones, and realign logistics surcharges dynamically based on package weight.

### 💸 Task 10: Payment Fee Leakage
* **Objective:** Calculate margins lost to payment gateway processing operations.
* **Recommendation:** Renegotiate processing interchange rates with top-performing provider networks. Actively steer users towards lower-fee methods (like UPI) through subtle checkout interface optimizations.

### 🔀 Task 11: Revenue Leakage Breakdown
* **Objective:** Quantify aggregate losses across processing anomalies, return damage, and untracked items.
* **Recommendation:** Create automated data pipelines to capture untracked transactions, implement direct supplier account chargebacks for poor-quality inventory, and systematically clear data field anomalies.

### ⚖️ Tasks 12 & 13: Product Profitability & Category Margin Stability
* **Objective:** Secure stable cross-quarter margins across major category verticals.
* **Strategic Initiatives:** Stabilize pricing baselines in the Home category (currently fluctuating at **48.9%**), capitalize on high-performing Beauty items, and immediately delist return-prone leather and low-performing western wear items.

### 👥 Tasks 14 & 15: Customer Risk, Executive Profitability & Project Conclusion
* **Objective:** Construct a final risk-profile matrix for users and output executive margin takeaways.
* **Key Results:** Identified a volatile cluster of **1,959 high-risk customers** responsible for a significant share of returns. 
* **Executive Summary:** Adjusted product listings successfully captured **\$23.59M in net profit** out of **\$38.4M in total revenue**. The business model is highly resilient but requires disciplined control over logistical leakages and promotional exploitation.

---

## 📈 Strategic Next Steps & Action Plan
1. **Automate Leakage Monitoring:** Deploy scheduled cron-jobs for these analytical SQL models to catch margin slips in real-time.
2. **Supplier Quality Enforcement:** Institute automated penalties for vendors generating high return rates.
3. **Dynamic Pricing Integration:** Embed automated thresholds to restrict coupons from stacking on low-margin products.
