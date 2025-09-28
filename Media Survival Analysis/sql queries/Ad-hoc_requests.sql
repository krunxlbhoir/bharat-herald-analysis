USE bharat_herald_clean;

-- ==================================================
-- 1. Top 5 Cities by Internet Penetration in 2021
-- ==================================================
/*SELECT 
    cr.city_id,
    dc.city,
    dc.state,
    ROUND(AVG(cr.internet_penetration),2) AS avg_internet_penetration
FROM fact_city_readiness cr
JOIN dim_city dc ON cr.city_id = dc.city_id
WHERE cr.year = '2021'
GROUP BY cr.city_id, dc.city, dc.state
ORDER BY avg_internet_penetration DESC
LIMIT 5;

-- ==================================================
-- 2. Quarterly Literacy & Smartphone Trends (2019–2024)
-- ==================================================
SELECT 
    year,
    qtr,
    ROUND(AVG(literacy_rate),2) AS avg_literacy_rate,
    ROUND(AVG(smartphone_penetration),2) AS avg_smartphone_penetration
FROM fact_city_readiness
GROUP BY year, qtr
ORDER BY year, qtr;

-- ==================================================
-- 3. Print Efficiency Ratio (2024)
-- ==================================================
SELECT 
    fps.city_id,
    dc.city,
    dc.state,
    SUM(fps.copies_sold) AS total_sold,
    SUM(fps.net_circulation) AS total_circulation,
    ROUND(SUM(fps.net_circulation) / NULLIF(SUM(fps.copies_sold),0), 2) AS efficiency_ratio
FROM fact_print_sales fps
JOIN dim_city dc ON fps.city_id = dc.city_id
WHERE YEAR(fps.month_start) = 2024
GROUP BY fps.city_id, dc.city, dc.state
ORDER BY efficiency_ratio DESC;

-- ==================================================
-- 4. Year-over-Year Ad Revenue Growth
-- ==================================================
SELECT 
    year,
    SUM(ad_revenue_inr) AS total_revenue,
    LAG(SUM(ad_revenue_inr)) OVER (ORDER BY year) AS prev_year_revenue,
    ROUND(((SUM(ad_revenue_inr) - LAG(SUM(ad_revenue_inr)) OVER (ORDER BY year)) / 
          NULLIF(LAG(SUM(ad_revenue_inr)) OVER (ORDER BY year),0)) * 100,2) AS yoy_growth_percent
FROM fact_ad_revenue
GROUP BY year
ORDER BY year;*/

-- ==================================================
-- 5. Digital Pilot Performance Summary
-- ==================================================
SELECT 
    platform,
    YEAR(month_start) AS year,
    SUM(users_reached) AS total_users_reached,
    SUM(downloads_or_accesses) AS total_downloads,
    ROUND(AVG(avg_bounce_rate),2) AS avg_bounce_rate
FROM fact_digital_pilot
GROUP BY platform, YEAR(month_start)
ORDER BY year, platform;

