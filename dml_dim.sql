-- =====================================================
-- 1. dim_date (даты продаж)
-- =====================================================
INSERT INTO dim_date (full_date, year, month, day, quarter)
SELECT DISTINCT
    TO_DATE(sale_date, 'MM/DD/YYYY') as full_date,
    EXTRACT(YEAR FROM TO_DATE(sale_date, 'MM/DD/YYYY'))::INT as year,
    EXTRACT(MONTH FROM TO_DATE(sale_date, 'MM/DD/YYYY'))::INT as month,
    EXTRACT(DAY FROM TO_DATE(sale_date, 'MM/DD/YYYY'))::INT as day,
    EXTRACT(QUARTER FROM TO_DATE(sale_date, 'MM/DD/YYYY'))::INT as quarter
FROM mock_data
WHERE sale_date IS NOT NULL;

-- =====================================================
-- 2. dim_country_customer
-- =====================================================
INSERT INTO dim_country_customer (country, postal_code)
SELECT DISTINCT
    customer_country as country,
    customer_postal_code as postal_code
FROM mock_data
WHERE customer_country IS NOT NULL;

-- =====================================================
-- 3. dim_product_category (pet_category + product_category)
-- =====================================================
INSERT INTO dim_product_category (pet_category, product_category)
SELECT DISTINCT
    pet_category,
    product_category
FROM mock_data
WHERE pet_category IS NOT NULL AND product_category IS NOT NULL;

-- =====================================================
-- 4. dim_product_brand
-- =====================================================
INSERT INTO dim_product_brand (product_brand)
SELECT DISTINCT product_brand
FROM mock_data
WHERE product_brand IS NOT NULL;

-- =====================================================
-- 5. dim_customer
-- =====================================================
INSERT INTO dim_customer (customer_id, first_name, last_name, age, email, country_sk)
SELECT DISTINCT
    sale_customer_id as customer_id,
    customer_first_name as first_name,
    customer_last_name as last_name,
    customer_age::INT as age,
    customer_email as email,
    cc.country_sk as country_sk
FROM mock_data t
JOIN dim_country_customer cc ON cc.country = t.customer_country
WHERE sale_customer_id IS NOT NULL;

-- =====================================================
-- 6. dim_seller
-- =====================================================
INSERT INTO dim_seller (seller_id, first_name, last_name, email)
SELECT DISTINCT
    sale_seller_id as seller_id,
    seller_first_name as first_name,
    seller_last_name as last_name,
    seller_email as email
FROM mock_data
WHERE sale_seller_id IS NOT NULL;

-- =====================================================
-- 7. dim_store (используем sale_seller_id как store_id)
-- =====================================================
INSERT INTO dim_store (store_id, store_name, location, city, state, country, phone, email)
SELECT DISTINCT
    sale_seller_id as store_id,
    store_name,
    store_location as location,
    store_city as city,
    store_state as state,
    store_country as country,
    store_phone as phone,
    store_email as email
FROM mock_data
WHERE sale_seller_id IS NOT NULL AND store_name IS NOT NULL;

-- =====================================================
-- 8. dim_supplier
-- =====================================================
INSERT INTO dim_supplier (supplier_name, contact, email, phone, city, supplier_country)
SELECT DISTINCT
    supplier_name,
    supplier_contact as contact,
    supplier_email as email,
    supplier_phone as phone,
    supplier_city as city,
    supplier_country
FROM mock_data
WHERE supplier_name IS NOT NULL;

-- =====================================================
-- 9. dim_product (последняя, с FK)
-- =====================================================
INSERT INTO dim_product (
    product_id, product_name, category_sk, brand_sk, weight, color, size, 
    material, rating, reviews, release_date, expiry_date
)
SELECT DISTINCT
    sale_product_id as product_id,
    product_name,
    pc.category_sk,
    pb.brand_sk,
    product_weight::DECIMAL(10,2) as weight,
    product_color as color,
    product_size as size,
    product_material as material,
    product_rating::DECIMAL(3,2) as rating,
    product_reviews::INT as reviews,
    TO_DATE(product_release_date, 'MM/DD/YYYY') as release_date,
    TO_DATE(product_expiry_date, 'MM/DD/YYYY') as expiry_date
FROM mock_data t
JOIN dim_product_category pc ON pc.pet_category = t.pet_category AND pc.product_category = t.product_category
JOIN dim_product_brand pb ON pb.product_brand = t.product_brand
WHERE sale_product_id IS NOT NULL;
