USE bharat_herald_clean;

-- ==================================================
-- 1. Ad Revenue vs Circulation Correlation
-- ==================================================

SELECT 
    fps.city_id,
    dc.city,
    SUM(fps.net_circulation) AS total_circulation,
    SUM(far.ad_revenue_inr) AS total_revenue
FROM fact_print_sales fps
JOIN fact_ad_revenue far ON fps.edition_id = far.edition_id
JOIN dim_city dc ON fps.city_id = dc.city_id
GROUP BY fps.city_id, dc.city
ORDER BY total_revenue DESC;

-- ==================================================
-- 2. Quarterly Trends in Ad Revenue
-- ==================================================

SELECT 
    year,
    quarter,
    SUM(ad_revenue_inr) AS total_revenue
FROM fact_ad_revenue
GROUP BY year, quarter
ORDER BY year, quarter;

-- ==================================================
-- 3. Top Ad Categories by Year
-- ==================================================

SELECT 
    year,
    standard_ad_category,
    SUM(ad_revenue_inr) AS total_revenue
FROM fact_ad_revenue
GROUP BY year, standard_ad_category
ORDER BY year, total_revenue DESC;

-- ==================================================
-- 4. City Readiness vs Circulation
-- ==================================================

SELECT 
    cr.city_id,
    dc.city,
    ROUND(AVG((cr.literacy_rate + cr.smartphone_penetration + cr.internet_penetration)/3),2) AS readiness_score,
    SUM(fps.net_circulation) AS total_circulation
FROM fact_city_readiness cr
JOIN dim_city dc ON cr.city_id = dc.city_id
JOIN fact_print_sales fps ON cr.city_id = fps.city_id
GROUP BY cr.city_id, dc.city
ORDER BY readiness_score DESC;
