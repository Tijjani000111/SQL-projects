-- Data cleaning

SELECT *
FROM layoffs;

--- 1. Removes Duplicates
--- 2. Standardize the Data
--- 3. Null Values or Blank Values
--- 4. Remove unneccessary columns and rows

Create table layoffs_staging
Like layoffs;

Insert layoffs_staging
Select *
from layoffs;

select *
From layoffs_staging;

select count(*)
From layoffs_staging;

Select *,
row_number() Over(
partition by Company, industry,total_laid_off, percentage_laid_off, 'date') AS row_num
from layoffs_staging;

With duplicate_cte AS
(
Select *,
row_number() Over(
partition by Company, location, industry,total_laid_off, percentage_laid_off, stage,
country, funds_raised_millions, 'date') AS row_num
from layoffs_staging
)
Select * 
From duplicate_cte
where row_num > 1;


Select *
from layoffs_staging
where company = 'casper';

With duplicate_cte AS
(
Select *,
row_number() Over(
partition by Company, location, industry,total_laid_off, percentage_laid_off, stage,
country, funds_raised_millions, 'date') AS row_num
from layoffs_staging
)

Delete 
From duplicate_cte
where row_num > 1;




CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` datetime DEFAULT NULL,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select *
from layoffs_staging2
where row_num > 1;

Insert into layoffs_staging2
Select *,
row_number() Over(
partition by Company, location, industry,total_laid_off, percentage_laid_off, stage,
country, funds_raised_millions, 'date') AS row_num
from layoffs_staging;


Select *
from layoffs_staging2
where row_num > 1;

Select *
from layoffs_staging2
where company = 'Zymergen';

delete
from layoffs_staging2
where row_num > 1;


select * 
from layoffs_staging2;


-- Standardizing data

select distinct (company)
from layoffs_staging2;

select company, Trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = Trim(company);


select distinct industry
from layoffs_staging2
order by 1;

Select *
from layoffs_staging2
where industry like  'crypto%'
;

Update layoffs_staging2
set industry = 'crypto'
where industry like 'crypto%'
;

select distinct industry
from layoffs_staging2
order by 1;

select distinct location
from layoffs_staging2
order by 1;

select distinct country
from layoffs_staging2
order by 1;

select distinct country, Trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = Trim(trailing '.' from country)
where country like 'united state%'
;

select date
from layoffs_staging2;

SELECT DATE(`date`) AS clean_date
FROM layoffs_staging2;


ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

UPDATE layoffs_staging2
SET `date` = DATE(`date`);


--- Remove Nulls and blank 

select *
from layoffs_staging2;

select *
from layoffs_staging2
where total_laid_off is Null
And percentage_laid_off is Null;


select * 
from layoffs_staging2
where industry is Null
Or industry = ''
;

select * 
from layoffs_staging2
where company = 'Airbnb'
;

select * 
from layoffs_staging2
where company LIKE 'bally%'
;




select * 
from layoffs_staging2 AS t1
join layoffs_staging2 AS t2
	on t1.company = t2.company
    And t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null
;

select t1.industry, t2.industry 
from layoffs_staging2 AS t1
join layoffs_staging2 AS t2
	on t1.company = t2.company
    And t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null
;


Update layoffs_staging2 AS t1
join layoffs_staging2 AS t2
on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null
;

select * 
from layoffs_staging2 ;


--- 4. Remove unneccessary columns and rows


select *
from layoffs_staging2
where total_laid_off is Null
And percentage_laid_off is Null;

delete
from layoffs_staging2
where total_laid_off is Null
And percentage_laid_off is Null;

select * 
from layoffs_staging2 ;

Alter table layoffs_staging2 
drop column row_num;

select count(*)
from layoffs_staging2 ;



