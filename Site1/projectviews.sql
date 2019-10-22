create or replace view booktbl as 
select user_id, id from books union
select user_id, id from books@site_link;

create or replace view tickettbl as 
select id, user_id, status, no_of_passengers, train_no from ticket union
select id, user_id, status, no_of_passengers, train_no from ticket@site_link;

create or replace view passengertbl as
select passenger_id, user_id, reservation_status, seat_number, ticket_id from passenger union
select passenger_id, user_id, reservation_status, seat_number, ticket_id from passenger@site_link;

create or replace view traintbl as 
select train_name, total_seats, total_ac_seats, total_gen_seats, ac_seat_fair, gen_seat_fair from TRAIN;
