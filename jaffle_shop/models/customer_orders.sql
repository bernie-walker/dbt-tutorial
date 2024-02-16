select
    user_id as customer_id,
    count(id) as number_of_orders,
    sum(order_total) as spend_total
from
    {{ ref('raw_orders') }}
group by
    user_id

