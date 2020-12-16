{{ config(
    materialized='table'
)}}

{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2020-01-01' as date)",
    end_date="date_add('2020-01-01', interval 1 year)"
   )
}}