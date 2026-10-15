-- =====================================================================================================================================
-- TASK-1
-- =====================================================================================================================================
SELECT 
     SUM(quantity * selling_price) AS total_sales_revenue
FROM orders_v2;

SELECT *
FROM products_v2
LIMIT 12;

SELECT * 
FROM orders_v2
LIMIT 12;

SELECT 
	FORMAT(SUM(o.quantity * o.selling_price),2) AS total_sales_revenue,
    FORMAT(SUM(o.quantity * p.cost_price),2) AS total_cost,
    FORMAT(SUM(o.quantity * (o.selling_price - p.cost_price)),2) AS total_profit,
    CONCAT(FORMAT((SUM(o.quantity * (o.selling_price - p.cost_price)) / SUM(o.quantity * o.selling_price)) * 100, 2), '%') AS total_profit_percentage
FROM
    orders_v2 o 
JOIN
    products_v2 p ON o.product_id = p.product_id;
    
-- ==================================================================================================================================================    
-- TASK-2
-- ==================================================================================================================================================
SELECT
	 p.category,
     FORMAT(SUM(o.quantity * o.selling_price),2) AS total_sales,
     FORMAT(SUM(o.quantity * p.cost_price),2) AS total_cost,
     FORMAT(SUM(o.quantity * (o.selling_price - p.cost_price)),2) AS total_profit,
     CONCAT(FORMAT((SUM(O.quantity * (o.selling_price - p.cost_price)) / SUM(o.quantity * o.selling_price)) * 100, 2), '%') AS profit_percentage
FROM orders_v2 o
JOIN products_v2 p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- =====================================================================================================================================================
-- TASK-3
-- =====================================================================================================================================================
SELECT
	 p.product_id,
     p.brand,
     p.category,
     SUM((o.selling_price - p.cost_price) * o.quantity) AS total_profit
FROM
    orders_v2 o
JOIN
    products_v2 p ON o.product_id = p.product_id
GROUP BY
	p.product_id, p.brand, p.category
HAVING
    SUM((o.selling_price - p.cost_price) * o.quantity) <0
ORDER BY
    total_profit ASC;
    
SELECT COUNT(*) AS total_negative_profit_rows
FROM (
	SELECT 
		p.product_id,
        p.brand,
        p.category,
        SUM((o.selling_price - p.cost_price) * o.quantity) AS total_profit
FROM
    orders_v2 o
JOIN
    products_v2 p ON o.product_id = p.product_id
GROUP BY
    p.product_id, p.brand, p.category
HAVING
    SUM((o.selling_price - p.cost_price) * o.quantity) <0
) AS negatve_profit_products;

-- ============================================================================================================================================
-- TASK-4
-- ============================================================================================================================================
DESCRIBE discounts_v2;

SELECT * FROM discounts_v2;

SELECT
    FORMAT(COUNT(DISTINCT order_id), 0) AS total_discounted_orders,
	FORMAT(SUM(discount_amount), 0) AS total_discount_amount,
    FORMAT(SUM(discount_amount) / COUNT(DISTINCT order_id) / 100, 2) AS avg_discount_amount
FROM
    discounts_v2
WHERE
    discount_amount > 0;
    
-- =============================================================================================================================================================
-- TASK-5
-- =============================================================================================================================================================
SELECT 
	payment_method,
    FORMAT(COUNT(order_id),0) AS total_orders,
    FORMAT(SUM(quantity * selling_price),2) AS total_sales_value
FROM
    orders_v2
GROUP BY
     payment_method;
     
-- ===============================================================================================================================================================
-- TASK-6
-- ===============================================================================================================================================================
SELECT 
	CASE
	   WHEN d.discount_id IS NOT NULL THEN 'Discounted Order'
       ELSE 'Non-Discounted Order'
	END AS order_type,
    AVG((o.selling_price - p.cost_price) * o.quantity) AS average_profit,
    CONCAT( 
	   ROUND(
            (SUM((o.selling_price - p.cost_price)* o.quantity) / SUM(o.selling_price * o.quantity)) * 100,
            2
            ),
            '%'
            ) AS profit_percentage
FROM orders_v2 o
JOIN products_v2 p ON o.product_id = p.product_id
LEFT JOIN discounts_v2 d ON o.order_id = d.order_id
GROUP BY
	CASE
       WHEN d.discount_id IS NOT NULL THEN 'Discounted Order'
       ELSE 'Non-Discounted Order'
	END;
    
-- ===============================================================================================================================================================
-- TASK-7
-- ===============================================================================================================================================================
SELECT 
     FORMAT(SUM(o.quantity * o.selling_price),2) AS total_revenue_lost,
     FORMAT(SUM((o.selling_price - p.cost_price) * o.quantity),2) AS total_profit_lost,
     CONCAT(FORMAT((SUM((o.selling_price - p.cost_price) * o.quantity) / SUM(o.quantity * o.selling_price)) * 100,2),'%') AS profit_l0ss_percentage
FROM orders_v2 o 
INNER JOIN returns_v2 r 
     ON o.order_id = r.order_id
INNER JOIN products_v2 p 
     ON o.product_id = p.product_id;
     
-- ===============================================================================================================================================================
-- TASK-8
-- ===============================================================================================================================================================
SELECT DISTINCT return_flag,
     refund_mode,
     refund_status,
     customer_fault_flag
FROM returns_v2;
     
SELECT
     r.return_reason,
     COUNT(r.return_id) AS total_returns,
     FORMAT(SUM(o.selling_price),2) AS total_revenue_lost,
     FORMAT(SUM(o.selling_price) / COUNT(r.return_id),2) as avg_loss_per_return
FROM 
    returns_v2 r 
JOIN 
    orders_v2 o ON r.order_id = o.order_id
GROUP BY
    r.return_reason
ORDER BY
    SUM(o.selling_price) DESC;
    
-- ============================================================================================================================================================
-- TASK-9
-- ============================================================================================================================================================
SELECT
      o.order_id,
      (o.quantity * o.selling_price) AS order_value,
      (l.shipping_cost + l.reverse_shipping_cost) AS total_logistics_cost,
      CASE
		WHEN(o.quantity * o.selling_price) = 0 THEN NULL
		ELSE ROUND(((l.shipping_cost + l.reverse_shipping_cost) / (o.quantity * o.selling_price)) * 100, 2) 
        END AS logistics_cost_percentage
FROM
     orders_v2 o 
JOIN
     logistics_cost_v2 l ON o.order_id = l.order_id
WHERE
     (l.shipping_cost + l.reverse_shipping_cost)> 0.20*(o.quantity * o.selling_price);
     
SELECT
      FORMAT(COUNT(*),0) AS total_orders,
      FORMAT(SUM(CASE WHEN (o.quantity * o.selling_price) = 0 THEN 1 ELSE 0 END),0) AS zero_value_orders,
      FORMAT(SUM(CASE WHEN (o.quantity * o.selling_price) IS NULL OR (o.quantity * o.selling_price) = 0 THEN 1 ELSE 0 END),0)
      AS null_or_undefined_percentage_orders,
      FORMAT(SUM(CASE WHEN ((l.shipping_cost + l.reverse_shipping_cost) / NULLIF(o.quantity * o.selling_price,0)) * 100>20
      THEN 1 ELSE 0 END),0) AS high_cost_burden_orders,
      FORMAT(SUM(CASE WHEN (o.quantity * o.selling_price) = 0
      THEN(l.shipping_cost + l.reverse_shipping_cost) ELSE 0 END),0)
      AS total_money_lost_on_zero_value
FROM orders_v2 o 
join logistics_cost_v2 l ON o.order_id = l.order_id;

-- =====================================================================================================================================================
-- TASK-10
-- =====================================================================================================================================================
SELECT
      o.payment_method,
      FORMAT(SUM(o.quantity * o.selling_price),2) AS total_revenue,
      FORMAT(SUM(o.quantity * o.selling_price *(f.fee_percentage / 100.0)),2) AS total_gateway_fee,
      FORMAT(SUM(o.quantity * p.cost_price),2) AS total_cost_price,
      FORMAT(SUM(o.quantity * o.selling_price - o.quantity * p.cost_price),2) AS gross_profit,
      FORMAT(SUM(o.quantity * o.selling_price - o.quantity * p.cost_price - (o.quantity *  o.selling_price * f.fee_percentage / 100.0)),2) AS net_profit,
      CONCAT(
         ROUND(
           SUM(o.quantity * o.selling_price * (f.fee_percentage / 100.0)) /
           NULLIF((SUM(o.quantity * o.selling_price) - SUM(o.quantity * p.cost_price)),0) * 100, 2
		),'%'
	 ) AS fee_impact_percentage
FROM orders_v2 o 
LEFT JOIN payment_fees_v2 f 
      ON o.payment_method = f.payment_method
LEFT JOIN products_v2 p 
      ON o.product_id = p.product_id
WHERE o.order_status NOT IN ('CANCELLED', 'UNKNOWN')
GROUP BY o.payment_method
ORDER BY total_gateway_fee DESC;

-- =========================================================================================================================================================
-- TASK-11
-- =========================================================================================================================================================
WITH Order_leakage AS (
      SELECT 
           o.order_id,
           o.selling_price * o.quantity AS gross_revenue,
           COALESCE(d.total_discount, 0) AS discount_leakage,
           CASE WHEN r.return_flag IN ('X' 'Y') THEN (o.selling_price * o.quantity) ELSE 0 END AS return_leakage,
		   COALESCE(l.shipping_cost,0) + COALESCE(l.reverse_shipping_cost,0) AS logistics_leakage,
		   ROUND((o.selling_price * o.quantity) * (COALESCE(p.fee_percentage,0) / 100.0),2) AS payment_fee_leakage
		FROM orders_v2 o 
        LEFT JOIN (SELECT order_id, SUM(discount_amount) AS total_discount FROM discounts_v2 GROUP BY order_id) d ON o.order_id = d.order_id
        LEFT JOIN returns_v2 r ON o.order_id = r.order_id
        LEFT JOIN logistics_cost_v2 l ON o.order_id = l.order_id
        LEFT JOIN payment_fees_v2 p ON o.payment_method = p.payment_method
	)
SELECT
      order_id,
      CONCAT('$', FORMAT(gross_revenue, 2)) AS gross_revenue,
	  CONCAT('$', FORMAT(discount_leakage,2)) AS discount_leakage,
	  CONCAT('$', FORMAT(return_leakage, 2)) AS return_leakage,
	  CONCAT('$', FORMAT(Logistics_leakage,2)) AS logistics_leakage,
	  CONCAT('$', FORMAT(payment_fee_leakage,2)) AS payment_fee_leakage,
      CONCAT('$', FORMAT(discount_leakage + return_leakage + logistics_leakage + payment_fee_leakage,2)) AS total_leakage
FROM order_leakage;

WITH Order_leakage AS (
      SELECT 
           o.order_id,
           o.selling_price * o.quantity AS gross_revenue,
           COALESCE(d.total_discount, 0) AS discount_leakage,
           CASE
               WHEN r.return_flag IN ('X' 'Y') THEN (o.selling_price * o.quantity)
               ELSE 0
			END AS return_leakage,
		    COALESCE(l.shipping_cost,0) + COALESCE(l.reverse_shipping_cost,0) AS logistics_leakage,
		    ROUND((o.selling_price * o.quantity) * (COALESCE(p.fee_percentage,0) / 100.0),2) AS payment_fee_leakage
		FROM orders_v2 o 
        LEFT JOIN (
            SELECT order_id, SUM(discount_amount) AS total_discount
            FROM discounts_v2
            GROUP BY order_id
		) d ON o.order_id = d.order_id
        LEFT JOIN returns_v2 r ON o.order_id = r.order_id
        LEFT JOIN logistics_cost_v2 l ON o.order_id = l.order_id
        LEFT JOIN payment_fees_v2 p ON o.payment_method = p.payment_method
	 )
     SELECT
          FORMAT(SUM(discount_leakage),2) AS total_discount_leakage,
          FORMAT(SUM(return_leakage),2) AS total_return_leakage,
          FORMAT(SUM(logistics_leakage),2) AS total_logistics_leakage,
          FORMAT(SUM(payment_fee_leakage),2) AS total_payment_fee_leakage,
          FORMAT(SUM(discount_leakage + return_leakage + logistics_leakage + payment_fee_leakage),2) AS cumulative_overall_leakage
     FROM Order_leakage;
     
-- ===========================================================================================================================================================================================
-- TASK-12
-- ===========================================================================================================================================================================================
SELECT 
	 p.product_id,
	 p.category,
     p.brand,
	 SUM((o.selling_price - p.cost_price) * quantity) AS total_net_profit,
     DENSE_RANK() OVER (ORDER BY SUM((o.selling_price - p.cost_price) * o.quantity) DESC) AS profit_rank
FROM
	products_v2 p 
JOIN
    orders_v2 o ON p.product_id = o.product_id
WHERE
    o.order_status <>'CANCELLED'
GROUP BY
	p.product_id, p.category, p.brand
ORDER BY
    profit_rank ASC;
    
-- ==================================================================================================================================================================================
-- TASK-13
-- ==================================================================================================================================================================================
SELECT
      p.category,
      ROUND(STDDEV(((o.selling_price - p.cost_price) / o.selling_price) * 100), 2) AS margin_standard_deviation,
      CONCAT(ROUND(AVG(((o.selling_price - p.cost_price) / o.selling_price) * 100), 2), '%') AS average_margin_percentage,
	  COUNT(o.order_id) AS total_orders
FROM
      orders_v2 o 
JOIN 
      products_v2 p ON o.product_id = p.product_id
WHERE 
      o.order_status = 'SHIPPED'
GROUP BY
      p.category
ORDER BY
      STDDEV(((o.selling_price - p.cost_price) / o.selling_price) * 100) DESC;
      
-- ==================================================================================================================================================================================
-- TASK-14
-- ==================================================================================================================================================================================
WITH CustomerStats AS (
    SELECT 
        o.customer_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(DISTINCT r.order_id) AS total_returns,
        (CAST(COUNT(DISTINCT r.order_id) AS FLOAT) / COUNT(DISTINCT o.order_id)) * 100 AS customer_return_rate
    FROM orders_v2 o
    LEFT JOIN returns_v2 r ON o.order_id = r.order_id
    GROUP BY o.customer_id
),
MarketplaceAverage AS (
    SELECT 
        (CAST(COUNT(DISTINCT r.order_id) AS FLOAT) / COUNT(DISTINCT o.order_id)) * 100 AS avg_market_return_rate
    FROM orders_v2 o
    LEFT JOIN returns_v2 r ON o.order_id = r.order_id
)
SELECT 
    c.customer_id,
    c.total_orders,
    c.total_returns,
    CONCAT(ROUND(c.customer_return_rate, 2), '%') AS customer_return_rate_percentage,
    CONCAT(ROUND(m.avg_market_return_rate, 2), '%') AS market_average_percentage
FROM CustomerStats c
CROSS JOIN MarketplaceAverage m
WHERE c.customer_return_rate >= (m.avg_market_return_rate * 3)
  AND c.total_orders >= 3
ORDER BY c.total_returns DESC, 4 DESC;

-- ===================================================================================================================================================================================== 
-- TASK-15
-- =====================================================================================================================================================================================
WITH order_items_summary AS (
    SELECT 
        o.order_id,
        SUM(o.quantity * o.selling_price) AS order_sales,
        SUM(o.quantity * pr.cost_price) AS order_cost,
        SUM((o.quantity * o.selling_price) * (COALESCE(p.fee_percentage, 0) / 100.0)) AS order_payment_fees
    FROM orders_v2 o
    LEFT JOIN products_v2 pr ON o.product_id = pr.product_id
    LEFT JOIN payment_fees_v2 p ON o.payment_method = p.payment_method
    GROUP BY o.order_id
),
discounts_summary AS (
    SELECT order_id, SUM(discount_amount) AS total_order_discount 
    FROM discounts_v2 
    GROUP BY order_id
),
logistics_summary AS (
    SELECT order_id, SUM(COALESCE(shipping_cost, 0) + COALESCE(reverse_shipping_cost, 0)) AS total_order_logistics 
    FROM logistics_cost_v2 
    GROUP BY order_id
),
returns_summary AS (
    SELECT DISTINCT order_id FROM returns_v2
)
SELECT 
    FORMAT(SUM(oi.order_sales), 2) AS total_sales,
    FORMAT(SUM(COALESCE(d.total_order_discount, 0)), 2) AS total_discounts,
    FORMAT(SUM(CASE WHEN r.order_id IS NOT NULL THEN oi.order_sales ELSE 0 END), 2) AS total_returns_loss,
    FORMAT(SUM(COALESCE(l.total_order_logistics, 0)), 2) AS total_logistics_cost,
    FORMAT(SUM(oi.order_payment_fees), 2) AS total_payment_fees,
    FORMAT(SUM(
        oi.order_sales 
        - oi.order_cost
        - COALESCE(d.total_order_discount, 0)
        - (CASE WHEN r.order_id IS NOT NULL THEN oi.order_sales ELSE 0 END)
        - COALESCE(l.total_order_logistics, 0)
        - oi.order_payment_fees
    ), 2) AS total_profit
FROM order_items_summary oi
LEFT JOIN discounts_summary d ON oi.order_id = d.order_id
LEFT JOIN logistics_summary l ON oi.order_id = l.order_id
LEFT JOIN returns_summary r ON oi.order_id = r.order_id;
