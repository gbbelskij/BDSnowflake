CREATE TABLE fact_sales (
    sale_sk SERIAL PRIMARY KEY,
    sale_id INT,
    date_sk INT,
    customer_sk INT,
    seller_sk INT,
    product_sk INT,
    store_sk INT,
    supplier_sk INT,
    product_quantity INT,
    sale_quantity INT,
    sale_total_price DECIMAL(10,2),
    FOREIGN KEY (date_sk) REFERENCES dim_date(date_sk),
    FOREIGN KEY (customer_sk) REFERENCES dim_customer(customer_sk),
    FOREIGN KEY (seller_sk) REFERENCES dim_seller(seller_sk),
    FOREIGN KEY (product_sk) REFERENCES dim_product(product_sk),
    FOREIGN KEY (store_sk) REFERENCES dim_store(store_sk),
    FOREIGN KEY (supplier_sk) REFERENCES dim_supplier(supplier_sk)
);
