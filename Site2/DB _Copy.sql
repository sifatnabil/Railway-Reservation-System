DROP TABLE USERS CASCADE CONSTRAINTS;
DROP TABLE TRAIN CASCADE CONSTRAINTS;
DROP TABLE STATION CASCADE CONSTRAINTS;
DROP TABLE TRAIN_STATION CASCADE CONSTRAINTS;
DROP TABLE TRAIN_STATUS CASCADE CONSTRAINTS;
DROP TABLE TICKET CASCADE CONSTRAINTS;
DROP TABLE PASSENGER CASCADE CONSTRAINTS;
DROP TABLE BOOKS CASCADE CONSTRAINTS;
DROP TABLE CANCEL CASCADE CONSTRAINTS;

DROP sequence user_sequence;
DROP sequence train_sequence;
DROP sequence ticket_sequence;
DROP sequence passenger_sequence;

@@conn.sql;


create table USERS(
	user_id int primary key,
	user_name varchar(50),
	gender varchar(10),
	age int,
	mobile_no varchar(50),
	email varchar(50),
	password varchar(50)
);

create sequence user_sequence start with 106;


create table TRAIN(
	train_no int primary key,
	train_name varchar(50),
	total_seats int,
	total_ac_seats int, 
	total_gen_seats int,
	ac_seat_fair number,
	gen_seat_fair number
);

create sequence train_sequence start with 10;

create table STATION(
	station_no int primary key,
	name varchar(50)
);

create table TRAIN_STATION(
	id int primary key,
	station_no int,
	train_no int,
	departure_time date,
	destinaton_station int,
	foreign key(train_no) references TRAIN(train_no) on delete CASCADE,
	foreign key(station_no) references STATION(station_no) on delete CASCADE,
	foreign key(destinaton_station) references STATION(station_no) on delete CASCADE
);

create table TRAIN_STATUS(
	train_no int,
	total_avail int,
	ac_avail int,
	g_avail int,
	station_no int,
	foreign key(train_no) references TRAIN(train_no) on delete CASCADE,
	foreign key(station_no) references STATION(station_no) on delete CASCADE,
	primary key(train_no, station_no)
);

create table TICKET(
	id int primary key,
	user_id int,
	status char,
	no_of_passengers int,
	train_no int,
	foreign key(user_id) references USERS(user_id) on delete CASCADE,
	foreign key(train_no) references TRAIN(train_no) on delete CASCADE
);

create sequence ticket_sequence start with 102;

create table PASSENGER(
	passenger_id int primary key,
	user_id int,
	reservation_status varchar(10),
	seat_number varchar(5),
	ticket_id int,
	foreign key(user_id) references USERS(user_id) on delete CASCADE,
	foreign key(ticket_id) references TICKET(id) on delete CASCADE
);

create sequence passenger_sequence start with 104;

create table BOOKS( 
	user_id int,
	id int,
	foreign key(user_id) references USERS(user_id) on delete CASCADE,
	foreign key(id) references TICKET(id) on delete CASCADE
);

create table CANCEL(
	user_id int,
	id int,
	passenger_id int,
	foreign key(id) references TICKET(id) on delete CASCADE,
	foreign key(passenger_id) references PASSENGER(passenger_id) on delete CASCADE,
	foreign key(user_id) references USERS(user_id) on delete CASCADE
);


-- Insert Data


INSERT INTO USERS VALUES(101, 'Md. Shaon Mahbub', 'Male', 23, '01714095499', 'shaon.mahbub@gmail.com', '12345678');
INSERT INTO USERS VALUES(102, 'Tonmoy Debnath', 'Male', 19, '01627695155', 'debnath.tonmoy@gmail.com', '12345678');
INSERT INTO USERS VALUES(103, 'Bayezid Hasan', 'Male', 50, '01624343432', 'bayezid.hasan@gmail.com', '12345678');
INSERT INTO USERS VALUES(104, 'Farhan Shahriar', 'Male', 43, '01777258585', 'shahriar.farhan@gmail.com', '12345678');
INSERT INTO USERS VALUES(105, 'Istiak Ahmed', 'Male', 33, '01797201337', 'ahmed.istiak@gmail.com', '12345678');


INSERT INTO TRAIN VALUES(1, 'Ekaroshindur Godhuli', 10, 5, 5, 200, 150);
INSERT INTO TRAIN VALUES(2, 'Ekaroshindur Provati', 10, 3, 7, 200, 120);
INSERT INTO TRAIN VALUES(3, 'Suborna Express', 10, 3, 7, 300, 200);
INSERT INTO TRAIN VALUES(4, 'Turna Nishita', 10, 4, 6, 200, 100);

INSERT INTO STATION VALUES(1, 'Dhaka');
INSERT INTO STATION VALUES(2, 'Chittagong');

INSERT INTO TRAIN_STATION VALUES(1, 2, 2, to_date('2019/09/30:12:00:00AM', 'yyyy/mm/dd:hh:mi:ssam'), 1);
INSERT INTO TRAIN_STATION VALUES(2, 2, 4, to_date('2019/09/30:12:00:00AM', 'yyyy/mm/dd:hh:mi:ssam'), 1);

INSERT INTO TRAIN_STATUS VALUES(2, 10, 5, 5, 2);
INSERT INTO TRAIN_STATUS VALUES(4, 10, 3, 7, 2);

INSERT INTO TICKET VALUES(101, 102, 'c', 3, 4);

INSERT INTO BOOKS VALUES(102, 101);

UPDATE	TRAIN_STATUS SET total_avail = total_avail - 3 WHERE train_no = 4;
UPDATE	TRAIN_STATUS SET ac_avail = ac_avail - 3 WHERE train_no = 4;	

INSERT INTO PASSENGER VALUES(101, 102, 'c', 1, 101);
INSERT INTO PASSENGER VALUES(102, 102, 'c', 2, 101);
INSERT INTO PASSENGER VALUES(103, 102, 'c', 3, 101);

commit;