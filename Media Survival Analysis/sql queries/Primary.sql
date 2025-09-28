USE bharat_herald_clean;

-- ==================================================
-- 1. Print Circulation Trend (2019–2024)
-- ==================================================
SELECT 
    YEAR(month_start) AS year,
    SUM(copies_sold) AS total_sold,
    SUM(net_circulation) AS total_circulation
FROM fact_print_sales
GROUP BY YEAR(month_start)
ORDER BY year;

-- ==================================================
-- 2. Ad Revenue Trend by Year & Category
-- ==================================================
SELECT 
    year,
    standard_ad_category,
    SUM(ad_revenue_inr) AS total_revenue
FROM fact_ad_revenue
GROUP BY year, standard_ad_category
ORDER BY year, total_revenue DESC;

-- ==================================================
-- 3. Print Efficiency by City (2024)
-- ==================================================
SELECT 
    fps.city_id,
    dc.city,
    dc.state,
    SUM(copies_sold) AS total_sold,
    SUM(net_circulation) AS total_circulation,
    ROUND(SUM(net_circulation) / NULLIF(SUM(copies_sold),0), 2) AS efficiency_ratio
FROM fact_print_sales fps
JOIN dim_city dc ON fps.city_id = dc.city_id
WHERE YEAR(month_start) = 2024
GROUP BY fps.city_id, dc.city, dc.state
ORDER BY efficiency_ratio DESC;

-- ==================================================
-- 4. Digital Pilot Performance (by Platform & Year)
-- ==================================================
SELECT 
    platform,
    YEAR(month_start) AS year,
    SUM(users_reached) AS total_users,
    SUM(downloads_or_accesses) AS total_downloads,
    ROUND(AVG(avg_bounce_rate),2) AS avg_bounce
FROM fact_digital_pilot
GROUP BY platform, YEAR(month_start)
ORDER BY year, platform;

-- ==================================================
-- 5. City Readiness Scores (Top 10)
-- ==================================================
SELECT 
    cr.city_id,
    dc.city,
    dc.state,
    cr.year,
    cr.qtr,
    ROUND((cr.literacy_rate + cr.smartphone_penetration + cr.internet_penetration)/3, 2) AS readiness_score
FROM fact_city_readiness cr
JOIN dim_city dc ON cr.city_id = dc.city_id
ORDER BY readiness_score DESC
LIMIT 10;
