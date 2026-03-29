INSERT INTO fact_sales (sale_id, date_sk, customer_sk, seller_sk, product_sk, store_sk, supplier_sk, product_quantity, sale_quantity, sale_total_price)
SELECT DISTINCT
    sale_id,
    d.date_sk,
    c.customer_sk,
    s.seller_sk,
    p.product_sk,
    st.store_sk,
    sup.supplier_sk,
    product_quantity,
    sale_quantity,
    sale_total_price
FROM your_table t
JOIN dim_date d ON d.full_date = TO_DATE(t.sale_date, 'MM/DD/YYYY')
JOIN dim_customer c ON c.customer_id = t.sale_customer_id
JOIN dim_seller s ON s.seller_id = t.sale_seller_id
JOIN dim_product p ON p.product_id = t.sale_product_id
JOIN dim_store st ON st.store_id = t.sale_seller_id
JOIN dim_supplier sup ON sup.supplier_name = t.supplier_name;
