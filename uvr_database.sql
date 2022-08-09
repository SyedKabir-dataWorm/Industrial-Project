create database if not exists uvr; -- creating database
use uvr;

-- creating location table

drop table if exists `uvr`.`location`;

create table if not exists `uvr`.`location` (
`location_id` int not null auto_increment,
`city_name` varchar(20) not null,
primary key (`location_id`)
);
-- Filling up data for location table
insert into uvr.location (`city_name`) values ('Adelaide');
insert into uvr.location (`city_name`) values ('Melbourne');
insert into uvr.location (`city_name`) values ('Sydney');
insert into uvr.location (`city_name`) values ('Hobart');
insert into uvr.location (`city_name`) values ('Darwin');
insert into uvr.location (`city_name`) values ('Brisbane');
insert into uvr.location (`city_name`) values ('Perth');
insert into uvr.location (`city_name`) values ('Canberra');

-- creating month table
drop table if exists `uvr`.`month`;

create table if not exists `uvr`.`month` (
`month_id` int not null auto_increment,
`month_name` varchar(20) not null,
primary key (`month_id`)
);
-- Filling up data for location table
insert into uvr.month (`month_name`) values ('Jan');
insert into uvr.month (`month_name`) values ('Feb');
insert into uvr.month (`month_name`) values ('Mar');
insert into uvr.month (`month_name`) values ('Apr');
insert into uvr.month (`month_name`) values ('May');
insert into uvr.month (`month_name`) values ('June');
insert into uvr.month (`month_name`) values ('July');
insert into uvr.month (`month_name`) values ('Aug');
insert into uvr.month (`month_name`) values ('Sept');
insert into uvr.month (`month_name`) values ('Oct');
insert into uvr.month (`month_name`) values ('Nov');
insert into uvr.month (`month_name`) values ('Dec');

-- creating severity table
drop table if exists `uvr`.`protection`;

create table `uvr`.`protection` (
`severity_id` int not null auto_increment,
`severity_type` varchar(20) not null,
`required_protections` varchar(300) not null,
primary key (`severity_id`)
);
-- Filling up data for location table
insert into uvr.protection (`severity_type`,`required_protections`) values ('low','no protection required');
insert into uvr.protection (`severity_type`,`required_protections`) values ('medium', 'stay in shade in midday, use sunscreen, wear hat and long sleeves, avoid bright surface');
insert into uvr.protection (`severity_type`,`required_protections`) values ('high','Be catuous between 10 to 4 pm, stay in shade, use sunscreen, wear hat and long sleeves, avoid bright surface.');
insert into uvr.protection (`severity_type`,`required_protections`) values ('very high','Reduce sun exposure between 10 to 4 pm, use sunscreen, wear hat and long sleeves, avoid bright surface.');
insert into uvr.protection (`severity_type`,`required_protections`) values ('extreme','Avoid sun exposure between 10 to 4 pm, stay indoor, use sunscreen, wear hat and long sleeves, avoid bright surface.');

select * from uvr.protection;

-- creating a temporary table temp_uvr to import data from csv file generated from live data of cancer council webpage
-- Importing a tempUVR table

select * from uvr.tempUVR;

alter table uvr.tempUVR add
(`location_id` int,
`month_id` int,
`severity_id` int);

-- updating month_id column

update uvr.tempUVR
set month_id = 1 where tempUVR.`Month` = 'Jan';

update uvr.tempUVR
set month_id = 2 where tempUVR.`Month` = 'Feb';

update uvr.tempUVR
set month_id = 3 where tempUVR.`Month` = 'Mar';

update uvr.tempUVR
set month_id = 4 where tempUVR.`Month` = 'Apr';

update uvr.tempUVR
set month_id = 5 where tempUVR.`Month` = 'May';

update uvr.tempUVR
set month_id = 6 where tempUVR.`Month` = 'June';

update uvr.tempUVR
set month_id = 7 where tempUVR.`Month` = 'July';

update uvr.tempUVR
set month_id = 8 where tempUVR.`Month` = 'Aug';

update uvr.tempUVR
set month_id = 9 where tempUVR.`Month` = 'Sept';

update uvr.tempUVR
set month_id = 10 where tempUVR.`Month` = 'Oct';

update uvr.tempUVR
set month_id = 11 where tempUVR.`Month` = 'Nov';

update uvr.tempUVR
set month_id = 12 where tempUVR.`Month` = 'Dec';

update uvr.tempUVR
set month_id = 1 where tempUVR.`Month` = 'Jan';

-- updating location_id column
update uvr.tempUVR
set location_id = 1 where tempUVR.`Location` = 'Adelaide';

update uvr.tempUVR
set location_id = 2 where tempUVR.`Location` = 'Melbourne';

update uvr.tempUVR
set location_id = 3 where tempUVR.`Location` = 'Sydney';

update uvr.tempUVR
set location_id = 4 where tempUVR.`Location` = 'Hobart';

update uvr.tempUVR
set location_id = 5 where tempUVR.`Location` = 'Darwin';

update uvr.tempUVR
set location_id = 6 where tempUVR.`Location` = 'Brisbane';

update uvr.tempUVR
set location_id = 7 where tempUVR.`Location` = 'Perth';

update uvr.tempUVR
set location_id = 8 where tempUVR.`Location` = 'Canberra';


-- updating severity_id

update uvr.tempUVR
set severity_id = 1 where tempUVR.`UV_Index` in (0,1,2);

update uvr.tempUVR
set severity_id = 2 where tempUVR.`UV_Index` in (3,4,5);

update uvr.tempUVR
set severity_id = 3 where tempUVR.`UV_Index` in (6,7,8);

update uvr.tempUVR
set severity_id = 4 where tempUVR.`UV_Index` in (9,10);

update uvr.tempUVR
set severity_id = 5 where tempUVR.`UV_Index` in (11,12,13,14,15);

-- Creating UVR table

create table uvr.UVR as
select location_id, month_id, severity_id, UV_Index from uvr.tempUVR;


ALTER TABLE uvr.UVR ADD PRIMARY KEY(location_id, month_id);

ALTER TABLE uvr.UVR ADD FOREIGN KEY (severity_id) REFERENCES uvr.protection(`severity_id`) ON DELETE SET NULL;

commit;


-- Querry: What is the uv lebel in melbourne in november

select p.`severity_type`, l.`city_name`, m.`month_name`
from uvr.protection p, uvr.location l, uvr.month m, uvr.UVR u
where l.location_id = u.location_id
and m.month_id = u.month_id
and p.severity_id = u.severity_id
and l.city_name = 'Melbourne'
and m.month_name = 'Nov'
order by l.city_name, m.month_name, p.severity_type;
