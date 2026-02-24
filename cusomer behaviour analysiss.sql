select * from customer limit(20)
select gender,
SUM(purchase_amount) as revenue from customer
group by gender;








select customer_id,purchase_amount 
from customer
where discount_applied='yes' and purchase_amount>=(select AVG(purchase_amount::numeric)
from customer);
SELECT customer_id, purchase_amount
FROM customer
WHERE LOWER(discount_applied) = 'yes'
  AND purchase_amount::numeric >= (
      SELECT AVG(purchase_amount::numeric)
      FROM customer );
	  

	  
  select item_purchased,ROUND(AVG(review_rating::numeric),2)
  as "Average Product Rating"
  from customer
  group by item_purchased
  order by avg (review_rating) desc
  limit 5;

  
  select shipping_type,
  ROUND(AVG(purchase_amount::numeric),2) 
  from customer
  where shipping_type IN('Standard','Express')
  group by shipping_type
  ;

  select subscription_status,
  Count (customer_id ) as total_customers,
  ROUND(AVG(purchase_amount),2)as avg_spend,
  ROUND(SUM(purchase_amount),2)as total_revenue
   from customer
   group by subscription_status
   order by total_revenue, avg_spend desc;

  
   SELECT item_purchased,
       ROUND( 100.0 * COUNT(*) FILTER (
  WHERE LOWER(TRIM(discount_applied)) = 'yes') / COUNT(*),
       2) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;




with customer_type as(select customer_id,previous_purchases,CASE WHEN
previous_purchases=1
THEN 'NEW'
WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returnig 'ELSE 'Target' END AS customer_segment 
from customer)
select customer_segment,
COUNT(*) as " Number of Customer"
from customer_type
group  by customer_segment


WITH item_counts AS (
    SELECT 
        category,
        item_purchased,
        COUNT(customer_id) AS total_orders,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY COUNT(customer_id) DESC
        ) AS item_rank
    FROM customer
    GROUP BY category, item_purchased
)

SELECT 
    item_rank,
    category,
    item_purchased,
    total_orders
FROM item_counts
where item_rank<=3;




select subscription_status,
COUNT(customer_id)as repeated_buyers
from customer
where previous_purchases>5
group by subscription_status





select age_group,
SUM(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc;
