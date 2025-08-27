select *
from airbnb_table;

Select count(*)
from airbnb_table;

-- 1. Remove Duplicates 
-- 2. Standarze the data
-- 3. Null values or blank values
-- 4. Remove unnecasry columns
-- 5. clean numerics column


Create table airbnb_staging
like airbnb_table;

select * 
from airbnb_staging;

Insert airbnb_staging
select *
from airbnb_table;

Select *
from airbnb_staging;


--- Remove Duplicates

Select *,
Row_number() Over(
Partition by id, host_name, country, room_type, price, service_fee) AS Row_num
from airbnb_staging
;

With duplicate_cte AS
(
Select *,
Row_number() Over(
Partition by id, host_name, country, room_type, price, service_fee) AS Row_num
from airbnb_staging
)
Select * 
from duplicate_cte
where row_num > 1;


Select * 
from airbnb_staging
where name = 'Relaxing bedroom in 6br apartment'
;

With duplicate_cte AS
(
Select *,
Row_number() Over(
Partition by id, host_name, country, room_type, price, service_fee) AS Row_num
from airbnb_staging
)

delete  
from duplicate_cte
where row_num > 1; ---- this is not woorking. so we need to create another table


select * 
from airbnb_staging2;

insert into airbnb_staging2
Select *,
Row_number() Over(
Partition by id, name, host_identity_verified, host_name, neighbourhood_group, 
neighbourhood, lat, country, instant_bookable, cancellation_policy, room_type, price, last_review,
 service_fee, minimum_nights, number_of_reviews, id, name, host_identity_verified, host_name, neighbourhood_group, 
 neighbourhood, lat, country, instant_bookable, cancellation_policy, room_type, price, service_fee, minimum_nights, 
 number_of_reviews, last_review, reviews_per_month, review_rate_number, 
calculated_host_listings_count) AS Row_num
from airbnb_staging;

Select * 
from airbnb_staging2
where row_num > 1;

Select * 
from airbnb_staging2
where id = 1318909;


delete
from airbnb_staging2
where row_num > 1;

-----
-- Step 1: Insert with row numbers
INSERT INTO airbnb_staging2
SELECT *,
       ROW_NUMBER() OVER(
           PARTITION BY id
           ORDER BY last_review DESC   -- decide which one to keep
       ) AS row_num
FROM airbnb_staging;

select * 
from airbnb_staging2
where row_num >1;

-- Step 2: Delete duplicates (keep row_num = 1)
DELETE
FROM airbnb_staging2
WHERE row_num > 1;

Select distinct *
from airbnb_staging2
where id = 1318909;

----
Select * 
from airbnb_staging2
where row_num > 1;

Select * 
from airbnb_staging2;

--- Standardizing data

select name, (Trim(name))
from airbnb_staging2;

update airbnb_staging2
set name = trim(name);

select *
from airbnb_staging2;

select distinct host_name
 from airbnb_staging2
 Order by 1;

Select *
from airbnb_staging2;

select distinct country
 from airbnb_staging2
 Order by 1;
 
 select distinct price
 from airbnb_staging2
 Order by 1;
 
 select distinct Count(neighbourhood)
 from airbnb_staging2
 Order by 1;
 
Select last_review
str_to_date (`last_review`, %m/%d/%Y)
from airbnb_staging2;

SELECT STR_TO_DATE(last_review, '%m/%d/%Y') 
FROM airbnb_staging2;

update airbnb_staging2
set last_review = STR_TO_DATE(last_review, '%m/%d/%Y') ;

UPDATE airbnb_staging2
SET last_review = STR_TO_DATE(last_review, '%m/%d/%Y')
WHERE last_review <> '' AND last_review IS NOT NULL;

Select *
from airbnb_staging2;

--- Nulls and Blank Values

Select *
from airbnb_staging2
where host_name = Null
Or host_name = '';

Select *
from airbnb_staging2
where id = Null
Or id= '';

Select *
from airbnb_staging2
where country = Null
Or country = '';

select t1.neighbourhood, t2.neighbourhood
from airbnb_staging2 as t1
join airbnb_staging2 as t2
	on t1.host_name = t2.host_name
    And t1.country = t2.country
where (t1.neighbourhood is null or t1.neighbourhood = '' )
And t2.neighbourhood is not Null;

Update airbnb_staging2 t1
join airbnb_staging2 t2
	on t1.host_name = t2.host_name
Set t1.neighbourhood = t2.neighbourhood
where (t1.neighbourhood is null or t1.neighbourhood = '' )
And t2.neighbourhood is not Null;
;
    
select * 
from airbnb_staging2;

Alter table airbnb_staging2
drop column row_num;

Alter table airbnb_staging2
drop column instant_bookable;




