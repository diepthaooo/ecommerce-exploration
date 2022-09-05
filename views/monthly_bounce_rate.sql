-- Bounce rate per traffic source in July 2017
SELECT
    trafficSource.source source,
    sum(totals.visits) total_visits,
    sum(totals.bounces) total_no_of_bounces,
    round(((sum(totals.bounces)/sum(totals.visits))*100),8) bounce_rate
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
GROUP BY source
ORDER BY total_visits DESC