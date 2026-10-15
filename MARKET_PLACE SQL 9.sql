create database Market_Place;
use Market_Place;


CREATE TABLE product_v2 (
       product_id INT PRIMARY KEY,
       category VARCHAR(50),
       sub_category VARCHAR(50),
       brand VARCHAR(50),
       supplier_id INT,
       cost_price Decimal(10,2),
       mrp DECIMAL(10,2),
       weight_kg Decimal(6,2),
       launch_date DATE
 );      
 

 
 select * from product_v2;
 
 SELECT COUNT(*) AS total_products
 FROM product_v2;
 
 SET FOREIGN_KEY_CHECKS = 0;
 
 CREATE TABLE payment_fees_v2 (
		payment_method VARCHAR(20) PRIMARY KEY,
        fee_percentage DECIMAL(5,2),
        settlement_days INT 
);
 
 select * from payment_fees_v2;
 
 SET FOREIGN_KEY_CHECKS = 0;
 
 
 CREATE TABLE orders_v2 (
        order_id INT PRIMARY KEY,
        order_date DATE,
        customer_id INT,
        product_id INT,
        quantity INT,
        selling_price DECIMAL(10,2),
        order_status VARCHAR(20),
        payment_method VARCHAR(20),
        order_channel VARCHAR(20),
        warehouse_id INT,
        
        CONSTRAINT fk_orders_product
            FOREIGN KEY (product_id)
            REFERENCES products_v2(product_id),
            
		CONSTRAINT fk_orders_payment
			 FOREIGN KEY (payment_method)
             REFERENCES payment_fees_v2(payment_method)
);


SELECT COUNT(*) FROM orders_v2;

RENAME TABLE product_v2 to products_v2;

SELECT * FROM products_v2;

SELECT COUNT(*) FROM products_v2;

 TRUNCATE TABLE orders_v2;
 
 INSERT INTO orders_v2 (
          order_id,
          order_date,
          customer_id,
          product_id,
          quantity,
          selling_price,order_status,
          payment_method,
          order_channel,warehouse_id
)
SELECT 
      order_id,
      order_date,
      customer_id,
      product_id,
      quantity,
      selling_price,
      order_status,
      payment_method,
      order_channel,
      warehouse_id
from orders_v2;

SELECT COUNT(*) FROM orders_v2;

SELECT * FROM orders_v2;

CREATE TABLE returns_v2 (
       return_id INT PRIMARY KEY,
       order_id INT NOT NULL,
       return_flag VARCHAR(10),
       return_reason VARCHAR(50),
       return_initiated_date DATE,
       refund_mode VARCHAR(30),
       refund_status VARCHAR(20),
       customer_fault_flag CHAR(1)
);

SELECT * FROM returns_v2;

SELECT COUNT(*) AS TOTAL_ROWS
FROM returns_v2;

CREATE TABLE discounts_v2 (
		discount_id INT PRIMARY KEY,
        order_id INT NOT NULL,
        discount_amount INT NOT NULL,
        discount_type VARCHAR(50) NOT NULL,
        coupon_code VARCHAR(50),
        is_stackable CHAR(1) DEFAULT 'N'
);
        
SELECT * FROM discounts_v2;

SELECT COUNT(*) AS TOTAL_ROWS
FROM discounts_v2;

CREATE TABLE logistics_cost_v2 (
       logistics_id INT PRIMARY KEY,
       order_id INT NOT NULL,
       shipping_cost INT NOT NULL,
       reverse_shipping_cost INT DEFAULT 0,
       delivery_days INT NOT NULL,
       delivery_status VARCHAR(20) DEFAULT NULL
);

SELECT * FROM logistics_cost_v2;

SELECT COUNT(*) AS TOTAL_ROWS
FROM logistics_cost_v2;	



