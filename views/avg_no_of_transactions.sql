-- Average number of transactions per user that made a purchase in July 2017
SELECT
    format_date('%Y%m',(parse_date('%Y%m%d',date))) month,
    round((sum(totals.transactions)/count(distinct fullVisitorId)),9) Avg_total_transactions_per_user
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
WHERE totals.transactions >= 1
GROUP BY month