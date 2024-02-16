select
    cu.id as customer_id,
    cu.first_name,
    cu.last_name,
    coalesce(co.number_of_orders, 0) as number_of_orders,
    coalesce(co.spend_total, 0) as spend_total
from
    {{ ref('raw_customers') }} as cu
    left join {{ ref('customer_orders') }} as co on cu.id = co.customer_id