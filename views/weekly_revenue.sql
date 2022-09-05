-- Revenue by traffic source by week, by month in June 2017
SELECT
    'week' as time_type,
    format_date('%Y%W',(parse_date('%Y%m%d',date))) as time,
    trafficSource.source as source,
    (sum(totals.totalTransactionRevenue))/(1000000) as revenue
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`
    GROUP BY source, time
UNION DISTINCT
SELECT 
    'month' as time_type,
     format_date('%Y%m',(parse_date('%Y%m%d',date))) as time,
     trafficSource.source as source,
    (sum(totals.totalTransactionRevenue))/(1000000) as revenue
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`
GROUP BY source, time
ORDER BY revenue DESC