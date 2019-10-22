set serveroutput on;

declare

begin
	dbms_output.put_line('(1) See all Train Information: ');
	dbms_output.put_line('(2) Reduce Train Fare: ');
	dbms_output.put_line('(3) Delay Train Times: ');
	dbms_output.put_line('(4) Search a Passenger: ');
end;

/

Accept x number prompt 'Enter Your Choice: '

set serveroutput on;

declare 

amount number;
delay number;
p_id Passenger.passenger_id%TYPE;

cursor t_view is 
select train_name, total_seats, total_ac_seats, total_gen_seats, ac_seat_fair, gen_seat_fair from traintbl;

cursor p_view(p_id Passenger.passenger_id%TYPE) is 
select passenger_id, user_id, reservation_status, seat_number, ticket_id from passengertbl where user_id = p_id;

begin
	
	if &x = 1 then
		for t in t_view loop
			dbms_output.put_line(t.train_name || ' ' || t.total_seats || ' ' || t.total_ac_seats || ' ' || t.total_gen_seats || ' ' || t.ac_seat_fair || ' ' || t.gen_seat_fair);
		end loop;
	elsif &x = 2 then
		@@updateTrainFare.sql;
	elsif &x = 3 then
		@@updateTrainTime.sql;
	elsif &x = 4 then
		@@searchPassanger.sql;
	end if;


end;

/