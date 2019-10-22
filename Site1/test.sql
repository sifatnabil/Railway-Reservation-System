set serveroutput on;

declare

begin
	dbms_output.put_line('(1) to create an account: ');
	dbms_output.put_line('(2) to book ticket: ');
	dbms_output.put_line('(3) to watch tickets that you booked already: ');
	dbms_output.put_line('(4) to cancel ticket(s): ');
	dbms_output.put_line('(5) check your profile: ');
	dbms_output.put_line('(6) show cheapest train: ');
end;

/

Accept x number prompt 'Enter Your Choice: '

set serveroutput on;

declare 

-- user table variables.
u_id users.user_id%TYPE;
user_name users.user_name%TYPE;
user_gender users.gender%TYPE;
user_age users.age%TYPE;
user_mobile users.mobile_no%TYPE;
user_email users.email%TYPE;
user_pass users.password%TYPE;

-- ticket table variables.
ticket_id ticket.id%TYPE;
user_id users.user_id%TYPE;
status ticket.status%TYPE;
no_of_passenger ticket.no_of_passengers%TYPE;
t_no ticket.train_no%TYPE;
seat_type number;
ticket_start ticket.id%TYPE;

-- train table variables.
t_ac_seats TRAIN.total_ac_seats%TYPE;
t_gen_seats TRAIN.total_gen_seats%TYPE;
t_ac_avail TRAIN_STATUS.ac_avail%TYPE;
t_g_avail TRAIN_STATUS.g_avail%TYPE;

-- site variable.
dest number;
p_id PASSENGER.passenger_id%TYPE;
found number:= 0;
cheapest_fair number;

-- books cursor
cursor b_tbl(u_id USERS.user_id%TYPE) is 
select user_id, id from BOOKS where user_id = u_id;

cursor b_tbl2(u_id USERS.user_id%TYPE) is 
select user_id, id from BOOKS@site_link where user_id = u_id;

no_seat_available EXCEPTION;

begin

	if &x = 1 then
		@@userCreate.sql;
	elsif &x = 2 then
		@@bookTicket.sql;
	elsif &x = 3 then
		@@showBookings.sql;
	elsif &x = 4 then
		@@deleteTicket.sql;
	elsif &x = 5 then
		@@profileShow.sql;
	elsif &x = 6 then
		cheapest_fair := minimumFair(1);
		dbms_output.put_line('Cheapest train available at the station right now: ' || cheapest_fair);
	end if;

EXCEPTION 
	when no_data_found then
		dbms_output.put_line('Not found');
	when no_seat_available then
		dbms_output.put_line('No seat Available');
	when others then
		dbms_output.put_line('Error');

end;

/


