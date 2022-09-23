select * from [dbo].[Data1];

select * from [dbo].[Data2];

-- number of rows into our dataset

select count(*) from [dbo].[Data1]
select count(*) from [dbo].[Data2]

-- dataset for jharkhand and bihar

select * from [dbo].[Data1] where state in ('Jharkhand' ,'Bihar')

-- population of India

select sum(population) as Population 
from [dbo].[Data2]

-- avg growth 

select state,avg(growth)*100 avg_growth 
from [dbo].[Data1] group by state;

-- avg sex ratio

select state,round(avg(sex_ratio),0) avg_sex_ratio 
from  [dbo].[Data1]
group by state 
order by avg_sex_ratio desc;

-- avg literacy rate
 
select state,round(avg(literacy),0) avg_literacy_ratio 
from [dbo].[Data1]
group by state having round(avg(literacy),0)>90 order by avg_literacy_ratio desc ;


-- top 3 state showing highest growth ratio

select top 3 state,avg(growth)*100 avg_growth 
from [dbo].[Data1]
group by state order by avg_growth desc;


--bottom 3 state showing lowest sex ratio

select top 3 state,round(avg(sex_ratio),0) as avg_sex_ratio 
from [dbo].[Data1]
group by state 
order by avg(sex_ratio) asc;



-- states starting with letter a or b

select distinct state 
from [dbo].[Data1]
where lower(state) like 'a%' or lower(state) like 'b%'


--states starting with letter a and ending with letter m

select distinct state 
from [dbo].[Data1] 
where state like 'a%m'


--showing district and population from gujarat

select district, population from [dbo].[Data2] where state = 'Gujarat' 