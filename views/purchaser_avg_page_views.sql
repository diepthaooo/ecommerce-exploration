-- Average number of product pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017
-- Note: totals.transactions >=1 for purchaser and totals.transactions is null for non-purchaser
with purchase as (
    SELECT
        format_date('%Y%m',(parse_date('%Y%m%d',date))) month,
        sum(totals.pageviews) total_pageviews_pur,      
        count(distinct fullVisitorId) total_userid_pur,     
        round((sum(totals.pageviews)/count(distinct fullVisitorId)),8) avg_pageviews_purchase
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
    WHERE (_table_suffix between '20170601' and '20170731') and totals.transactions >= 1
    GROUP BY month
),
non_purchase as (
    SELECT
        format_date('%Y%m',(parse_date('%Y%m%d',date))) month,
        sum(totals.pageviews) total_pageviews_nonpur,
        count(distinct fullVisitorId) total_userid_nonpur,  
        round((sum(totals.pageviews)/count(distinct fullVisitorId)),9) avg_pageviews_non_purchase
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
    WHERE (_table_suffix between '20170601' and '20170731') and totals.transactions IS NULL
    GROUP BY month
)
SELECT
    p.month,
    avg_pageviews_purchase,
    avg_pageviews_non_purchase
FROM purchase p
JOIN non_purchase np ON p.month = np.month
ORDER BY month