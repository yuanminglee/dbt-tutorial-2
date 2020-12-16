{%- set payment_methods = ['credit_card', 'bank_transfer', 'coupon', 'gift_card'] -%}

with payments as (
    select * from {{ ref('stg_payments') }}
),

pivoted as (
    select
        order_id,
        {%- for payment in payment_methods %}
        sum(case when payment_method = '{{ payment }}' then amount else 0 end) as {{ payment }}_amount
        {%- if not loop.last -%},{% endif %}
        {%- endfor %}
    from payments
    where status = 'success'
    group by 1
)

select * from pivoted