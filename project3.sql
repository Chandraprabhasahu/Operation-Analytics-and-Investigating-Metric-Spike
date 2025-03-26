create database project3;
show databases;
use project3;

# case study 1 : job data analysis

CREATE TABLE job_data
(ds DATE,
job_id INT NOT NULL,
actor_id INT NOT NULL,
event VARCHAR(15) NOT NULL,
language VARCHAR(15) NOT NULL,
time_spent INT NOT NULL,
org CHAR(2)
);

INSERT INTO job_data (ds, job_id, actor_id, event, language, time_spent, org)
 VALUES ('2020-11-30', 21, 1001, 'skip', 'English', 15, 'A'),
     ('2020-11-30', 22, 1006, 'transfer', 'Arabic', 25, 'B'),
     ('2020-11-29', 23, 1003, 'decision', 'Persian', 20, 'C'),
    ('2020-11-28', 23, 1005,'transfer', 'Persian', 22, 'D'),
    ('2020-11-28', 25, 1002, 'decision', 'Hindi', 11, 'B'),
     ('2020-11-27', 11, 1007, 'decision', 'French', 104, 'D'),
     ('2020-11-26', 23, 1004, 'skip', 'Persian', 56, 'A'),
     ('2020-11-25', 20, 1003, 'transfer', 'Italian', 45, 'C');
     
     Select * from job_data;
     
#Task A jobs reviewed over time

SELECT avg(t) as 'avg jobs reviewed per day per hour',
avg(p) as 'avg jobs reviewed per day per second'
from 
(select
ds,
((count(job_id)*3600)/sum(time_spent)) as t,
((count(job_id))/sum(time_spent)) as p
from
job_data
where
month(ds)=11
group by ds) a;


#Task B Throughput Analysis

SELECT ROUND(COUNT(event)/SUM(time_spent), 2) AS 'Weekly Throughput' FROM job_data;

SELECT ds as Dates, ROUND(COUNT(event)/SUM(time_spent),2) AS 'Daily Throughput' FROM job_data
GROUP BY ds ORDER BY ds;

#Task C Language share analysis

select language as Languages, ROUND(100 * COUNT(*)/total, 2) as Percentage, sub.total
from job_data
cross join (select COUNT(*) AS total from job_data) as sub
group by language, sub.total;

#Task D Duplicate rows detection

select actor_id, count(*) as Duplicates from job_data
group by actor_id having count(*) > 1;


# case study 2 : investigating metric spike

# table 1 users

create table users(
user_id int,
created_at varchar(100),
company_id int,
language varchar(50),
activated_at varchar(100),
state varchar(50));

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
INTO TABLE  users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from users;

alter table users add column temp_created_at datetime;

update users set temp_created_at = STR_TO_DATE(created_at, '%d-%m-%Y %H:%i');

alter table users DROP COLUMN created_at;

alter table users change column temp_created_at created_at datetime;


#table 2 events
create table events (
user_id int,
occurred_at varchar(100),
event_type varchar(50),
event_name varchar(100),
location varchar(50),
device varchar(50),
user_type int 
);


SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
INTO TABLE  events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from events;

alter table events add column temp_occurred_at datetime;

update events set temp_occurred_at = STR_TO_DATE(occurred_at, '%d-%m-%Y %H:%i');

alter table events drop column occurred_at;

alter table events change column temp_occurred_at occurred_at datetime;

#table 3 email events
create table emailEvents(
user_id int,
occurred_at varchar(100),
action varchar(100),
user_type int
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
INTO TABLE  emailEvents
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from emailEvents;

#Task A weekly user engagement
select extract(week from occurred_at) as week_number,
count(distinct user_id) as active_user
from events
where event_type='engagement'
group by week_number;

#Task B user growth analysis
select year, week_num,num_users, sum(num_users)
 over (order by year,week_num) as cum_users
from(
select extract(year from created_at) as year_num,
extract(week from activated_at) as week_num,
 count(distinct user_id) as num_users
from users
where state='active'
group by year, week_num
order by year, week_num)sub;


#Task C weekly retention analysis
select count(user_id) total_engaged_users,
       sum(case when retention_week = 1 then 1 else 0 end) as retained_users
from
(
select a.user_id,
       a.sign_up_week,
       b.engagement_week,
       b.engagement_week - a.sign_up_week as retention_week
from
(
(select distinct user_id, extract(week from occurred_at) as sign_up_week
from events
where event_type = 'signup_flow'
and event_name = 'complete_signup'
and extract(week from occurred_at)=18)a
left join
(select distinct user_id, extract(week from occurred_at) as engagement_week
from events
where event_type = 'engagement')b
on a.user_id = b.user_id
)
group by user_id
order by user_id;

#Task D weekly engagement per device
select extract(year from occurred_at) as year, extract(week from occurred_at) as week,
device, count(distinct user_id) as count
from events
where event_type = 'engagement'
group by 1,2,3
order by 1,2,3;

#Task E email engagement analysis
select
100 * sum(case when email_cat = 'email_open' then 1 else 0 end)/sum(case when email_cat = 'email sent' then 1 else 0 end) as email_open_rate,
100 * sum(case when email_cat = 'email clicked' then 1 else 0 end)/sum(case when email_cat = 'email sent' then 1 else 0 end) as email_click_rate
from (select*,
Case
When action in ('sent_weekly_digest','sent_reengagement_email') then 'email_sent'
when action in('email_open') then 'email_open'
when action in('email_clickthrough') then 'email_clicked'
end as email_cat
from emailEvents) sub;

















