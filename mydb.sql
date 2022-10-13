drop database if exists my_service;
create database if not exists my_service;
use my_service;

create table if not exists users
(
id int primary key auto_increment,
email varchar(50) not null,
phone varchar(15) not null,
password_hash varchar(30) not null,
registration_date datetime not null default now(),
first_name varchar(50) not null,
last_name varchar(50) null
);

create table if not exists favourite_shops
(
user_id int,
shop_id int,
primary key (user_id, shop_id)
);

create table if not exists favourite_products
(
user_id int,
product_id int,
primary key (user_id, product_id)
);

create table if not exists shops
(
id int primary key auto_increment,
title varchar(50) not null,
address varchar(70) not null,
working_hours varchar(10) not null
);

create table if not exists products
(
id int primary key auto_increment,
title varchar(50) not null,
price int unsigned not null,
discount tinyint unsigned not null default 0,
factory_id int 
);

create table if not exists factories
(
id int primary key auto_increment,
title varchar(100) not null,
address varchar(70) not null,
registration_date datetime not null default now()
);

create table if not exists buckets
(
user_id int,
product_id int,
primary key (user_id, product_id)
);

create table if not exists orders
(
id int primary key auto_increment,
total_without_discount int unsigned not null,
discount tinyint unsigned not null,
order_datetime datetime not null default now(),
user_id int
);

create table if not exists shops_products
(
shop_id int,
product_id int,
primary key (shop_id, product_id)
);

create table if not exists orders_products
(
order_id int,
product_id int,
primary key (order_id, product_id)
);

alter table orders
add constraint orders_users_fk
foreign key (user_id) references users(id);

alter table buckets
add constraint buckets_users_fk
foreign key (user_id) references users(id);

alter table favourite_products
add constraint favourite_products_users_fk
foreign key (user_id) references users(id);

alter table favourite_shops
add constraint favourite_shops_users_fk
foreign key (user_id) references users(id);

alter table favourite_shops
add constraint favourite_shops_shops_fk
foreign key (shop_id) references shops(id);

alter table favourite_products
add constraint favourite_products_products_fk
foreign key (product_id) references products(id);

alter table buckets
add constraint buckets_products_fk
foreign key (product_id) references products(id);

alter table products
add constraint factory_products_fk
foreign key (factory_id) references factories(id);

alter table orders_products
add constraint orders_products_fk_1
foreign key (order_id) references orders(id);

alter table orders_products
add constraint orders_products_fk
foreign key (product_id) references products(id);

alter table shops_products
add constraint shops_products_fk_1
foreign key (product_id) references products(id);

alter table shops_products
add constraint shops_products_fk
foreign key (shop_id) references shops(id);