-- Average amount of money spent per session
#standardSQL
SELECT
    format_date('%Y%m',(parse_date('%Y%m%d',date))) month,
    format("%'.2f",sum(totals.totalTransactionRevenue)/count(totals.visits)) Avg_revenue_by_user_per_visit
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
WHERE totals.transactions IS NOT NULL
GROUP BY month