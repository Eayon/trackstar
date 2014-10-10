CREATE TABLE tbl_user (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(128) NOT NULL,
    password VARCHAR(128) NOT NULL,
    email VARCHAR(128) NOT NULL
);

INSERT INTO tbl_user (username, password, email) VALUES ('test1', 'pass1', 'test1@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test2', 'pass2', 'test2@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test3', 'pass3', 'test3@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test4', 'pass4', 'test4@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test5', 'pass5', 'test5@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test6', 'pass6', 'test6@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test7', 'pass7', 'test7@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test8', 'pass8', 'test8@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test9', 'pass9', 'test9@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test10', 'pass10', 'test10@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test11', 'pass11', 'test11@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test12', 'pass12', 'test12@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test13', 'pass13', 'test13@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test14', 'pass14', 'test14@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test15', 'pass15', 'test15@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test16', 'pass16', 'test16@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test17', 'pass17', 'test17@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test18', 'pass18', 'test18@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test19', 'pass19', 'test19@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test20', 'pass20', 'test20@example.com');
INSERT INTO tbl_user (username, password, email) VALUES ('test21', 'pass21', 'test21@example.com');


Create Table tbl_project
(
id integer NOT NULL primary KEY auto_increment,
name varchar(128),
description text,
create_time datetime,
create_user_id integer,
update_time datetime,	
update_user_id integer
);

create table IF not exists tbl_issue
(
id integer not null primary key auto_increment,
name varchar(256) not null,
description varchar(2000),
project_id integer,
type_id integer,
status_id integer,
owner_id integer,
requester_id integer,
create_time datetime,
create_user_id integer,
update_time datetime,
update_user_id integer,
INDEX(project_id)
)engine = InnoDB;

create table if not exists tbl_user
(
id integer not null primary key auto_increment,
email varchar(256) not null,
username varchar(256),
password varchar(256),
last_login_time datetime,
create_time datetime,
create_user_id integer,
update_time datetime,
update_user_id integer
)engine = InnoDB;


create table if not exists tbl_project_user_assignment
(
project_id int(11) not null,
user_id int(11) not null,
create_time datetime,
create_user_id integer,
update_time datetime,
update_user_id integer,
primary key(project_id,user_id)
)engine = innoDB;

alter table tbl_issue add constraint fk_issue_project
foreign key(project_id) references tbl_project (id)
on delete cascade on update restrict;



ALTER TABLE `tbl_issue` ADD CONSTRAINT `FK_issue_owner` FOREIGN KEY (`owner_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT; 
ALTER TABLE `tbl_issue` ADD CONSTRAINT `FK_issue_requester` FOREIGN KEY (`requester_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT; 
ALTER TABLE `tbl_project_user_assignment` ADD CONSTRAINT `FK_project_user` FOREIGN KEY (`project_id`) REFERENCES `tbl_project` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT; 
ALTER TABLE `tbl_project_user_assignment` ADD CONSTRAINT `FK_user_project` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT; 
-- Insert some seed data so we can just begin
INSERT INTO `tbl_user` (`email`, `username`, `password`) VALUES
('test1@notanaddress.com','Test_User_One', MD5('test1')), 
('test2@notanaddress.com','Test_User_Two', MD5('test2'));


create table AuthItem 
(
 name varchar(64) not null, 
type integer not null, 
description text, 
bizrule text, 
data text, 
primary key (name) 
); 
create table AuthItemChild 
(
 parent varchar(64) not null, 
child varchar(64) not null, 
primary key (parent,child), 
foreign key (parent) references AuthItem (name) on delete cascade on update cascade, 
foreign key (child) references AuthItem (name) on delete cascade on update cascade 
);
create table AuthAssignment 
(
 itemname varchar(64) not null,
 userid varchar(64) not null,
 bizrule text,
 data text,
 primary key (itemname,userid), 
foreign key (itemname) references AuthItem (name) on delete cascade on update cascade 
);


create table tbl_project_user_role 
(
 project_id INTEGER NOT NULL,
 user_id INTEGER NOT NULL,
 role VARCHAR(64) NOT NULL,
 primary key (project_id,user_id,role), 
foreign key (project_id) references tbl_project (id), 
foreign key (user_id) references tbl_user (id), 
foreign key (role) references AuthItem (name) 
);


CREATE TABLE tbl_comment 
( `id` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `content` TEXT NOT NULL,
 `issue_id` INTEGER,
 `create_time` DATETIME,
 `create_user_id` INTEGER,
 `update_time` DATETIME,
 `update_user_id` INTEGER 
)

ALTER TABLE `tbl_comment` ADD CONSTRAINT `FK_comment_issue` FOREIGN KEY (`issue_id`)
REFERENCES `tbl_issue` (`id`); ALTER TABLE `tbl_comment` ADD CONSTRAINT `FK_comment_author` FOREIGN KEY (`create_user_id`) REFERENCES `tbl_user` (`id`);