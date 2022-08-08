create database if not exists uvr; -- creating database
use uvr;

-- creating location table

select * from uvr.protection;

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
drop table if exists `uvr`.`severity`;

create table `uvr`.`severity` (
`severity_id` int not null auto_increment,
`severity_type` varchar(20) not null,
primary key (`severity_id`)
);
-- Filling up data for location table
insert into uvr.severity (`severity_type`) values ('low');
insert into uvr.severity (`severity_type`) values ('medium');
insert into uvr.severity (`severity_type`) values ('high');
insert into uvr.severity (`severity_type`) values ('very high');
insert into uvr.severity (`severity_type`) values ('extreme');


-- creating severity table
drop table if exists `uvr`.`protection`;

create table `uvr`.`protection` (
`protection_id` int not null auto_increment,
`required_protections` varchar(300) not null,
primary key (`protection_id`)
);
-- Filling up data for location table
insert into `uvr`.`protection` (`required_protections`) values ('No protection required');
insert into `uvr`.`protection` (`required_protections`) values ('No protection required');
insert into `uvr`.`protection` (`required_protections`) values ('No protection required');
insert into `uvr`.`protection` (`required_protections`) values ('No protection required');
insert into `uvr`.`protection` (`required_protections`) values ('No protection required');