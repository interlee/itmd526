SELECT p.prod_code, p.category, p.product_desc, c.first_name, c.last_name, 
       c.city, c.state, p.unit_price, f.unit_price, f.order_qty, f.discount_pct, 
       ROUND(f.extended_order_total,2) AS extended_order_total
  FROM fact_order f
 INNER JOIN dim_product_scd1 p
    ON f.product_key = p.product_key
 INNER JOIN dim_customer_scd1 c
    ON f.customer_key = c.customer_key
 INNER JOIN dim_date d
    ON f.date_key = d.date_key