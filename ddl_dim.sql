-- 1. Время (дата продаж)
CREATE TABLE dim_date (
    date_sk SERIAL PRIMARY KEY,
    full_date DATE,
    year INT,
    month INT,
    day INT,
    quarter INT
);

-- 2. Клиенты (с подтаблицей стран)
CREATE TABLE dim_customer (
    customer_sk SERIAL PRIMARY KEY,
    customer_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    email VARCHAR(100),
    country_sk INT
);

CREATE TABLE dim_country_customer (
    country_sk SERIAL PRIMARY KEY,
    country VARCHAR(50),
    postal_code VARCHAR(20)
);

-- 3. Продукты (снежинка: бренд → категория → продукт)
CREATE TABLE dim_product_category (
    category_sk SERIAL PRIMARY KEY,
    pet_category VARCHAR(20),  -- Cats, Fish, Reptiles
    product_category VARCHAR(20)  -- Food, Cage
);

CREATE TABLE dim_product_brand (
    brand_sk SERIAL PRIMARY KEY,
    product_brand VARCHAR(50)
);

CREATE TABLE dim_product (
    product_sk SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(100),
    category_sk INT,
    brand_sk INT,
    weight DECIMAL(10,2),
    color VARCHAR(20),
    size VARCHAR(20),
    material VARCHAR(50),
    rating DECIMAL(3,2),
    reviews INT,
    release_date DATE,
    expiry_date DATE,
    FOREIGN KEY (category_sk) REFERENCES dim_product_category(category_sk),
    FOREIGN KEY (brand_sk) REFERENCES dim_product_brand(brand_sk)
);

-- Продавцы, Магазины, Поставщики (аналогично)
CREATE TABLE dim_seller (
    seller_sk SERIAL PRIMARY KEY,
    seller_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE dim_store (
    store_sk SERIAL PRIMARY KEY,
    store_id INT,
    store_name VARCHAR(100),
    location VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(200)
);

CREATE TABLE dim_supplier (
    supplier_sk SERIAL PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50)
);
