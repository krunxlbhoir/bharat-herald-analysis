-- Create Database
DROP DATABASE IF EXISTS bharat_herald_clean;
CREATE DATABASE bharat_herald_clean;
USE bharat_herald_clean;

-- ============================
-- DIMENSION TABLES
-- ============================

-- Cities Dimension
CREATE TABLE dim_city (
    city_id VARCHAR(20) PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    tier VARCHAR(10)
);

-- Advertisement Categories
CREATE TABLE dim_ad_category (
    ad_category_id VARCHAR(20) PRIMARY KEY,
    standard_ad_category VARCHAR(100),
    category_group VARCHAR(100),
    example_brands VARCHAR(255)
);

-- ============================
-- FACT TABLES
-- ============================

-- Print Sales Fact
CREATE TABLE fact_print_sales (
    edition_id VARCHAR(20),
    city_id VARCHAR(20),
    month_start DATE,
    copies_sold INT,
    net_circulation INT,
    FOREIGN KEY (city_id) REFERENCES dim_city(city_id)
);

-- Ad Revenue Fact
CREATE TABLE fact_ad_revenue (
    edition_id VARCHAR(20),
    ad_category VARCHAR(255),
    standard_ad_category VARCHAR(100),
    category_group VARCHAR(100),
    year INT,
    quarter INT,
    ad_revenue_inr DECIMAL(18,2)
);

-- City Readiness Fact
CREATE TABLE fact_city_readiness (
    city_id VARCHAR(20) PRIMARY KEY,
    year INT,
    qtr INT,
    literacy_rate DECIMAL(5,2),
    smartphone_penetration DECIMAL(5,2),
    internet_penetration DECIMAL(5,2),
    FOREIGN KEY (city_id) REFERENCES dim_city(city_id)
);

-- Digital Pilot Fact
CREATE TABLE fact_digital_pilot (
    city_id VARCHAR(20) PRIMARY KEY,
    platform VARCHAR(100),
    month_start DATE,
    ad_category_id VARCHAR(20),
    dev_cost DECIMAL(18,2),
    marketing_cost DECIMAL(18,2),
    users_reached INT,
    downloads_or_accesses INT,
    avg_bounce_rate DECIMAL(5,2),
    FOREIGN KEY (city_id) REFERENCES dim_city(city_id),
    FOREIGN KEY (ad_category_id) REFERENCES dim_ad_category(ad_category_id)
);

-- ============================
-- END OF SCHEMA
-- ============================
