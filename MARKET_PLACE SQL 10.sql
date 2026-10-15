select * from products_v2;

select *
FROM products_v2
WHERE cost_price <=0
     OR cost_price > mrp;
     
SET SQL_SAFE_UPDATES =0;

-- discounts_v2, returns_v2, logistics_cost_v2, orders_v2, products_v2

DELETE FROM discounts_v2
WHERE order_id IN (
	  SELECT order_id
      FROM orders_v2
	  WHERE product_id IN (
          SELECT product_id
          FROM products_v2
          WHERE cost_price <= 0
          OR cost_price > mrp
	)
);

SELECT * FROM discounts_v2;

DELETE FROM returns_v2
WHERE order_id IN (
	  SELECT order_id
      FROM orders_v2
	  WHERE product_id IN (
          SELECT product_id
          FROM products_v2
          WHERE cost_price <= 0
          OR cost_price > mrp
	)
);

DELETE FROM logistics_cost_v2
WHERE order_id IN (
	  SELECT order_id
      FROM orders_v2
	  WHERE product_id IN (
          SELECT product_id
          FROM products_v2
          WHERE cost_price <= 0
          OR cost_price > mrp
	)
);

DELETE FROM orders_v2
WHERE product_id IN (
      SELECT product_id
      FROM products_v2
      WHERE cost_price <= 0
         OR cost_price > mrp
);

DELETE FROM products_v2
WHERE cost_price <= 0
     OR  cost_price > mrp;
     
SELECT COUNT(*)
FROM products_v2
WHERE cost_price <= 0
     OR cost_price > mrp;
     
-- adjustable data should not be deleted

SELECT product_id, category
FROM products_v2
WHERE category IS NULL;

SELECT product_id, brand
FROM products_v2
WHERE brand IS NULL;

SELECT product_id, weight_kg
FROM products_v2
WHERE weight_kg IS NULL
     OR weight_kg <= 0;
     
SELECT * FROM products_v2;

SELECT product_id, brand
FROM products_v2
WHERE brand = '';

UPDATE products_v2
SET brand = 'UNKNOWN'
WHERE brand = '';

SELECT product_id, category
FROM products_v2
WHERE category = '';

UPDATE products_v2
SET category = 'UNKNOWN'
WHERE category = '';

SELECT * FROM products_v2;

SELECT * 
FROM products_v2
WHERE product_id IS NULL OR category = ''
      OR category IS NULL OR sub_category = ''
      OR brand IS NULL OR brand = ''
      OR supplier_id IS NULL
      OR cost_price IS NULL
      OR mrp IS NULL
      OR launch_date IS NULL;

SELECT * FROM returns_v2;

SELECT *
FROM returns_v2
WHERE return_id IS NULL OR return_id <=0;

SELECT * 
FROM returns_v2
WHERE order_id IS NULL;

SELECT order_id, COUNT(*)
FROM returns_v2
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT *
FROM returns_v2
WHERE return_flag IS NULL
     OR return_flag = ''
     OR TRIM(return_flag) = '';
     
SELECT *
FROM returns_v2
WHERE return_reason IS NULL
      OR TRIM(return_reason) = '';
      
UPDATE returns_v2
SET return_reason = 'Unknown'
WHERE return_reason IS NULL
      OR TRIM(return_reason) = '';
      
SELECT *
FROM returns_v2
WHERE return_initiated_date is NUll
      OR TRIM(return_initiated_date) = '';
      
SELECT *
FROM returns_v2
WHERE return_initiated_date IS NULL;

SELECT COUNT(*) AS empty_or_null_count
FROM returns_v2
WHERE refund_mode IS NULL
      OR TRIM(refund_mode) = '';
      
UPDATE returns_v2
SET refund_mode= 'Unknown'
WHERE refund_mode IS NULL
      OR TRIM(refund_mode) = '';
      
SELECT COUNT(*) AS total_wrong_values
FROM returns_v2
WHERE refund_status IS NULL
      OR TRIM(refund_status) = '';
      
UPDATE returns_v2
SET refund_status = 'Unknown'
WHERE refund_status IS NULL
      OR TRIM(refund_status)= '';
      
SELECT COUNT(*)
FROM returns_v2
WHERE customer_fault_flag IS NULL
      OR TRIM(customer_fault_flag) = '';
      
UPDATE returns_v2
SET customer_fault_flag = 'U'
WHERE customer_fault_flag IS NULL OR customer_fault_flag = '';

SELECT * FROM discounts_v2;

SELECT *
FROM discounts_v2
WHERE discount_id IS NULL OR discount_id <=0;

SELECT *
FROM discounts_v2
WHERE order_id IS NULL
      OR order_id = ''
      OR TRIM(order_id)= '';
      
SELECT * 
FROM discounts_v2
WHERE discount_amount IS NULL
      OR discount_amount = ''
      OR TRIM(discount_amount) = '';
      
SELECT *
FROM discounts_v2
WHERE discount_type IS NULL
	 OR discount_type =''
     OR TRIM(discount_type)= '';

UPDATE discounts_v2
SET discount_type = 'Unknown'
WHERE discount_type IS NULL
      OR TRIM(discount_type) = '';
      
SELECT COUNT(*) AS total_empty_or_null_coupons
FROM discounts_v2
WHERE coupon_code IS NULL
      OR COUPON_CODE = ''
      OR TRIM(coupon_code)= '';
      
UPDATE discounts_v2
SET coupon_code = 'Unknown'
WHERE coupon_code IS NULL
      OR coupon_code = ''
      OR TRIM(coupon_code) = '';
      
SELECT COUNT(*) AS empty_or_null_count
FROM discounts_v2
WHERE is_stackable IS NULL
      OR is_stackable = ''
      OR TRIM(is_stackable) = '';
      
UPDATE discounts_v2
SET is_stackable = 'U'
WHERE is_stackable IS NULL
      OR TRIM(is_stackable) = '';
      
SELECT * FROM logistics_cost_v2;

SELECT COUNT(*) AS blank_or_null_count
FROM logistics_cost_v2
WHERE logistics_id IS NULL
      OR logistics_id = ''
      OR TRIM(logistics_id) = '';
      
SELECT COUNT(*) AS blank_or_null_count
FROM logistics_cost_v2
WHERE order_id IS NULL
      OR order_id = ''
      OR TRIM(order_id) = '';
      
SELECT COUNT(*) AS blank_or_null_count
FROM logistics_cost_v2
WHERE shipping_cost IS NULL
      OR shipping_cost = ''
      OR TRIM(shipping_cost) = '';
      
SELECT COUNT(*) AS blank_or_null_count
FROM logistics_cost_v2
WHERE reverse_shipping_cost IS NULL
      OR reverse_shipping_cost = ''
      OR TRIM(reverse_shipping_cost) = '';

 SELECT * 
 FROM logistics_cost_v2;    

SELECT COUNT(*) AS null_count
FROM logistics_cost_v2
WHERE reverse_shipping_cost IS NULL;

SELECT COUNT(*) AS zero_count
FROM logistics_cost_v2
WHERE reverse_shipping_cost = 0;

DESCRIBE logistics_cost_v2;

SELECT COUNT(*) AS nonzero_count
FROM logistics_cost_v2
WHERE reverse_shipping_cost <> 0
      AND reverse_shipping_cost IS NOT NULL;
      
SELECT
     reverse_shipping_cost,
     COUNT(*) AS total_rows
FROM logistics_cost_v2
GROUP BY reverse_shipping_cost
ORDER BY total_rows DESC;

SELECT COUNT(*) AS total_missing_or_blank
FROM logistics_cost_v2
WHERE delivery_days IS NULL
      OR TRIM(delivery_days) = '';
      
SELECT COUNT(*) AS total_missing_or_blank
FROM logistics_cost_v2
WHERE delivery_status IS NULL
      OR TRIM(delivery_status) = '';

UPDATE logistics_cost_v2
SET delivery_status = 'UNKNOWN'
WHERE delivery_status IS NULL
      OR TRIM(DELIVERY_STATUS) ='';
      
SELECT * FROM orders_v2;

SELECT COUNT(*) AS missing_order_ids
FROM orders_v2
WHERE order_id IS NULL
      OR order_id = ''
      OR TRIM(order_id) = '';
      
SELECT COUNT(*) AS total_missing_dates
FROM orders_v2
WHERE order_date IS NULL
      OR order_date = 0;
      
SELECT COUNT(*) AS missing_customer_ids
FROM orders_v2
WHERE customer_id IS NULL
      OR customer_id = '';
      
SELECT * FROM orders_v2; 
     
SELECT COUNT(*) AS total_empty_or_null
FROM orders_v2
WHERE product_id IS NULL
      OR product_id = ''
      OR TRIM(product_id) = '';
 
SELECT COUNT(*) AS total_empty_or_null
FROM orders_v2
WHERE quantity IS NULL
      OR LENGTH(TRIM(quantity)) = 0;
 
 SELECT *
 FROM orders_v2
 WHERE selling_price IS NULL
       OR selling_price = '';
       
SELECT * 
FROM orders_v2
WHERE quantity = 0
    AND selling_price > 0;
 
SELECT 
    order_id,
    order_date,
    customer_id,
    product_id,
	quantity,
    selling_price,
	order_status, 
    payment_method
FROM orders_v2
WHERE quantity = 0 
   AND selling_price = 0 
ORDER BY order_status;

SELECT 
    order_id,
    order_date,
    customer_id,
    product_id,
	quantity,
    selling_price,
	order_status, 
    payment_method
FROM orders_v2
WHERE (quantity = 0 OR quantity IS NULL OR TRIM(quantity) = '')
   AND(selling_price = 0 OR selling_price IS NULL OR selling_price <0.01 OR TRIM(selling_price) = '')
ORDER BY order_status;

SELECT *
FROM orders_v2
WHERE quantity = 0
    AND selling_price = 0
    AND order_status IN ('DELIVERED', 'SHIPPED');
    
DELETE FROM orders_v2
WHERE order_id IN (1710, 3420, 5130);

SELECT * FROM orders_v2 WHERE order_id IN (1710, 3420, 5130);

 SELECT * FROM orders_v2;     

 SELECT *
 FROM orders_v2
 WHERE selling_price IS NULL
       OR TRIM(selling_price) = '';
       
SELECT *
FROM orders_v2
WHERE TRIM(selling_price) = '';

SELECT COUNT(*)
FROM orders_v2
WHERE order_status IS NULL
      OR TRIM(order_status) IN ('','0');

UPDATE orders_v2
SET order_status = 'UNKNOWN'
WHERE order_status IS NULL
      OR TRIM(order_status) IN ('','0');
      
SELECT COUNT(*)
FROM orders_v2
WHERE payment_method IS NULL
      OR TRIM(payment_method) IN ('','0');
      
SELECT COUNT(*)
FROM orders_v2
WHERE order_channel IS NULL
      OR TRIM(order_channel) IN ('','0'); 
      
UPDATE orders_v2
SET order_channel = 'UNKNOWN'
WHERE order_channel IS NULL
      OR TRIM(order_channel) IN ('','0');
      
SELECT COUNT(*)
FROM orders_v2
WHERE warehouse_id IS NULL
      OR TRIM(warehouse_id) IN ('','0');

SELECT * FROM discounts_v2;

SELECT *FROM logistics_cost_v2;

SELECT * FROM orders_v2;
      
SELECT * FROM payment_fees_v2; 

SELECT * FROM products_v2;     
 
SELECT * FROM returns_v2;     