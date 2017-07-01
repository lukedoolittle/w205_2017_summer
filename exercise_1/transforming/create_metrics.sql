DROP TABLE metrics;
CREATE TABLE metrics AS SELECT 
measure_id metric_id,
measure_name description,
cast(concat(
	substr(measure_start_date, 7, 4), 
	'-', 
	substr(measure_start_date, 1, 2),
	 '-', 
	substr(measure_start_date, 4, 2))
as date) start_date,
cast(concat(
	substr(measure_end_date, 7, 4), 
	'-', 
	substr(measure_end_date, 1, 2),
	 '-', 
	substr(measure_end_date, 4, 2))
as date) end_date
FROM measures

UNION
SELECT 
measure_id metric_id,
measure_name description,
cast(concat(
	substr(measure_start_date, 7, 4), 
	'-', 
	substr(measure_start_date, 1, 2),
	 '-', 
	substr(measure_start_date, 4, 2))
as date) start_date,
cast(concat(
	substr(measure_end_date, 7, 4), 
	'-', 
	substr(measure_end_date, 1, 2),
	 '-', 
	substr(measure_end_date, 4, 2))
as date) end_date
FROM infections
GROUP BY measure_id, measure_name, measure_start_date, measure_end_date
;