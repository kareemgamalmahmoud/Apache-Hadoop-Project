CREATE DATABASE whquestiondb;
show databases;
use whquestiondb;
create external table if not exists  whquestion
(Wh string) 
row format delimited
fields terminated by ' '
location '/user/osboxes/Lab3_21kgmm';
Describe  whquestion;
load data inpath '/user/osboxes/Lab3_21kgmm/whquestion.txt' into table whquestion;
select Wh, count(Wh)
from whquestion 
where Wh REGEXP "^Wh*" group by (Wh) ;
