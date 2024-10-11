create database cnn;
use cnn;

select * from laptop;

# alter column name 
alter table laptop
change MyUnknownColumn Sno int;

# Total no of brand available and there count 
select brand, count(*) as whole
from laptop 
group by 1
order by 2 desc;


# Total no of display type
select distinct display_type
from laptop;


# Ram info 
select RAM, count(*) 
from laptop 
group by 1;


# GPU used in laptop
select GPU, count(*) 
from laptop 
group by 1
order by 2 desc;


select distinct display , Battery_Life, count(Battery_Life)
from laptop
group by 1,2
order by 3 desc;


select distinct Processor_Brand
from laptop;







# avg price of  laptop

select round(avg(price),1) as avg_pri
from laptop;

# laptop price range below avg

select * from
laptop
where  price <
(
select avg(price)
from laptop);



# most affordable laptop
select * from 
laptop where price =
(select min(price)
from laptop);



# most afordable laptop brand 
WITH AffordableLaptop AS (
    SELECT 
  
        brand,
        MIN(price) AS min_price
    FROM 
        laptop
    GROUP BY 
        1
),
MostAffordable AS (
    SELECT 
     
        a.brand, 
      
    FROM 
        laptop l
    JOIN 
        AffordableLaptop a ON l.brand = a.brand AND l.price = a.min_price
    GROUP BY 
    1

        order by 2 desc
)

SELECT 
    ma.brand, 
    ma.total_laptop
FROM 
    MostAffordable ma
    ;
    
    
    


SELECT `name` , brand, price 
FROM laptop
WHERE price IN (
    SELECT price
    FROM laptop
    GROUP BY 1 
    HAVING MIN(Price) = (SELECT MIN(Price) FROM laptop) OR MAX(Price) = (SELECT MAX(Price) FROM laptop)
)
LIMIT 100;
  





# processor comparision ---

# How does the price of laptops vary by processor brand 
select distinct Processor_Brand , avg(price) as avg_pr , 
min(price) as min_pr , max(price) as mx_pr
from laptop 
group by 1;


# What is the average processor speed (GHz) across different processor brands

select distinct processor_brand 
, round(avg(ghz),1)
from laptop 
group by 1;




# What is the relationship between the amount of RAM and the laptop price?

select distinct ram  , avg(price) as avg_pr , 
min(price) as min_pr , max(price) as mx_pr,
count(*) as total_lap
from laptop 
group by 1
order by 1 desc;


select `name` , RAM_Expandable
from laptop 
where RAM_Expandable not in ('Not Expandable');



select distinct RAM_Expandable  , RAM , `name` ,price,
count(*) as total_lap
from laptop 
where RAM_Expandable  not in ('Not Expandable')
group by 1,2,3,4
order by 1,2,3 ,4
;


# Which laptops have the longest battery life, and is there a correlation with price or other specifications?
SELECT 
GPU,
    processor_brand,
    AVG(battery_life) AS avg_battery_life,
    round (AVG(price),1) AS avg_price,
    COUNT(*) AS total_laptops
FROM
    laptop
GROUP BY 1,2
ORDER BY avg_battery_life desc;



# Which laptops have the longest battery life, and is there a correlation with price or other specifications
SELECT 
GPU,
    processor_brand,
    max(battery_life) AS mx_battery_life,
    round (AVG(price),1) AS avg_price,
    COUNT(*) AS total_laptops
FROM
    laptop
GROUP BY 1,2
ORDER BY mx_battery_life desc
limit 5;



# What display sizes are most common, and does display size influence price?

select display , count(*) total_laptop,

round(  AVG(price),1) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
from laptop
group by 1
order by 2 desc;

