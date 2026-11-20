--DROP VIEW IF EXISTS v_daily_agg;

CREATE OR REPLACE VIEW v_daily_agg AS
SELECT 
    d.date,
    g.group_label,
    COUNT(DISTINCT d.user_id) AS active_users,
    SUM(d.converted) AS total_conversions,
    ROUND(SUM(d.converted)::NUMERIC / COUNT(DISTINCT d.user_id), 4) AS conversion_rate
FROM daily d
JOIN "user" u USING(user_id)
JOIN "group" g ON u.group_id = g.group_id
GROUP BY d.date, g.group_label
ORDER BY d.date ASC, g.group_label ASC;

--DROP VIEW IF EXISTS v_user_summary;

CREATE OR REPLACE VIEW v_user_summary AS
SELECT 
    u.user_id,
    g.group_label,
    c.country_code,
    dev.device_name,
    u.days_on_product,
    COALESCE(MAX(d.converted), 0) AS has_converted
FROM "user" u
LEFT JOIN country c USING(country_id)
LEFT JOIN device dev USING(device_id)
LEFT JOIN daily d USING(user_id)
JOIN "group" g USING(group_id) 
GROUP BY u.user_id, g.group_label, c.country_code, dev.device_name, u.days_on_product;

--DROP VIEW IF EXISTS v_segment_agg;

CREATE OR REPLACE VIEW v_segment_agg AS
SELECT 
    country_code,
    device_name,
    group_label,
    COUNT(DISTINCT user_id) AS total_users,
    SUM(has_converted) AS total_conversions,
    ROUND(SUM(has_converted)::NUMERIC / COUNT(DISTINCT user_id), 4) AS conversion_rate
FROM v_user_summary
GROUP BY country_code, device_name, group_label
ORDER BY country_code, device_name, group_label;


