with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from {{ ref('raw_customers') }}

),

orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_total

    from {{ ref('raw_orders') }}

),

customer_orders as (

    select
        customer_id,
        count(order_id) as number_of_orders,
        sum(order_total) as spend_total

    from orders

    group by customer_id

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(customer_orders.spend_total, 0) as spend_total

    from customers

    left join customer_orders using (customer_id)

)

select * from final
