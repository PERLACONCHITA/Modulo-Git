use grocery_store;

create view venta_utilidad_margen as
select month(str_to_date(day_, "%d/%m/%Y")) AS MES,
product_group, 
(sum(net_value_sale)) as venta_total, 
(sum(IFNULL(quantity_margin_sold_products,0))) as utilidad_neta,
(sum(ifnull(net_value_sale,0)))/(sum(IFNULL(quantity_margin_sold_products,0))) as margen_utilidad 
from sell 
group by product_group  order by utilidad_neta ASC limit 5;

create view venta_utilidad_margen_total as
select month(str_to_date(day_, "%d/%m/%Y")) AS MES,
product_group, 
(sum(net_value_sale)) as venta_total, 
(sum(IFNULL(quantity_margin_sold_products,0))) as utilidad_neta,
(sum(ifnull(net_value_sale,0)))/(sum(IFNULL(quantity_margin_sold_products,0))) as margen_utilidad 
from sell;

select MES, product_group, venta_total, utilidad_neta, margen_utilidad
from venta_utilidad_margen_total
group by product_group
order by utilidad_neta;



create view venta_margen_utilidad as
select month(str_to_date(day_, "%d/%m/%Y")) AS MES,
product_group, (sum(net_value_sale)) as venta_total, 
(sum(quantity_margin_sold_products)) as utilidad_neta,
(avg(porcent_margin)) as margen_utilidad 
from sell;

select product_name, MAX(net_price) as cantidad
from sell ;

select *
FROM sell
left join rotation_products
on sell.product_code = rotation_products.product_code;

select (str_to_date(day_, "%d/%m/%Y")) AS día,
product_group, product_name, product_quantity, quantity_net_purchase, net_value_sale, porcent_margin, quantity_margin_sold_products
from sell;


create view sell_detail as
select (str_to_date(day_, "%d/%m/%Y")) AS día,
product_group, product_name, product_quantity, quantity_net_purchase, net_value_sale, porcent_margin, quantity_margin_sold_products
from sell;

select * from sell;

select product_group, sum(product_quantity) as cantidad, sum(quantity_net_purchase) as costo, sum(net_value_sale) as venta 
from sell_detail group by product_group order by sum(quantity_net_purchase) desc limit 5;

select *
from sell;

select  s.product_group as categoria,
sum(s.quantity_net_purchase) as costo, 
sum(s.net_value_sale) as venta, 
sum(s.quantity_margin_sold_products) as utilidad, avg(rotation_time) as rotacion
from sell as s
join rotation_products as r
on s.product_code = r.product_code
group by s.product_group order by rotacion;

select 
product_group,
sum(net_purchase) as costo, 
sum(net_value_sale) as venta,
sum(quantity_margin_sold_products) as margen_utilidad 
from sell  group by product_group order by margen_utilidad desc;

select * from sell;