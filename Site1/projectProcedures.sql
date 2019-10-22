set serveroutput on;
--- 1
create or replace procedure createUser(user_name in USERS.user_name%TYPE, user_gender in USERS.gender%TYPE, user_age in 
USERS.age%TYPE, user_mobile in USERS.mobile_no%TYPE, user_email in USERS.email%TYPE, user_pass in USERS.password%TYPE)
is

begin 
    INSERT INTO USERS VALUES(user_sequence.nextval, user_name, user_gender, user_age, user_mobile, user_email, user_pass);
    dbms_output.put_line('User Successfully Created');
end; 
/

--- 2
create or replace procedure createTrain(train_name in TRAIN.train_name%TYPE, total_seats in TRAIN.total_seats%TYPE, total_ac_seats in TRAIN.total_ac_seats%TYPE, total_gen_seats in TRAIN.total_gen_seats%TYPE,
ac_seat_fair in TRAIN.ac_seat_fair%TYPE, gen_seat_fair in TRAIN.gen_seat_fair%TYPE)
is 

begin 
    INSERT INTO TRAIN VALUES(train_sequence.nextval, train_name, total_seats, total_ac_seats, total_gen_seats, ac_seat_fair, gen_seat_fair);
end;

/

--- 3
create or replace procedure updateTrainTime(delay in number)
is 
 
train_no TRAIN_STATION.train_no%TYPE;
station_no TRAIN_STATION.station_no%TYPE;
departure_time TRAIN_STATION.departure_time%TYPE;

cursor ts_tbl is 
select train_no, station_no, departure_time from TRAIN_STATION;

begin 
    open ts_tbl;
    loop 
        fetch ts_tbl into train_no, station_no, departure_time;
        exit when ts_tbl%notfound;
        update TRAIN_STATION set departure_time = (departure_time + (delay / 6)) where TRAIN_STATION.train_no = train_no and TRAIN_STATION.station_no = station_no;
    end loop;
    close ts_tbl;
end updateTrainTime; 
/

--- 4
create or replace procedure updateTrainFare(amount in number)
is 

cursor t_tbl is 
select train_no, ac_seat_fair, gen_seat_fair from TRAIN;

train_no TRAIN.train_no%TYPE;
ac_seat_fair TRAIN.ac_seat_fair%TYPE;
gen_seat_fair TRAIN.gen_seat_fair%TYPE;

begin
    open t_tbl;
    loop 
        fetch t_tbl into train_no, ac_seat_fair, gen_seat_fair;
        exit when t_tbl%notfound;
        update TRAIN set ac_seat_fair = ac_seat_fair - ((ac_seat_fair * amount ) / 100) where TRAIN.train_no = train_no;
        update TRAIN set gen_seat_fair = gen_seat_fair - ((gen_seat_fair * amount) / 100) where TRAIN.train_no = train_no;
    end loop;
    close t_tbl;
end updateTrainFare;

/

-- 5
create or replace procedure findTrain(dest in TRAIN_STATION.destinaton_station%TYPE)
is

cursor ts_tbl(st TRAIN_STATION.destinaton_station%TYPE) is 
select train_no, departure_time from TRAIN_STATION where destinaton_station = st;

cursor sts_tbl(tn TRAIN_STATION.train_no%TYPE) is
select total_avail, ac_avail, g_avail from train_status where train_no = tn;

cursor ts_tbl2(st2 TRAIN_STATION.destinaton_station%TYPE) is 
select train_no, departure_time from TRAIN_STATION@site_link where destinaton_station = st2;

cursor sts_tbl2(tn2 TRAIN_STATION.train_no%TYPE) is
select total_avail, ac_avail, g_avail from train_status@site_link where train_no = tn2;

begin

    dbms_output.put_line('The trains available' || chr(13) || chr(10));

    if dest = 2 then
        for t in ts_tbl(dest) loop
            dbms_output.put_line(t.train_no || ' ' || t.departure_time);
            for st in sts_tbl(t.train_no) loop
                dbms_output.put_line('Total Available Seats: ' || st.total_avail);
                dbms_output.put_line('AC Seats Avaialbe: ' || st.ac_avail);
                dbms_output.put_line('General Seats Available: ' || st.g_avail);
            end loop;
            dbms_output.put_line(chr(13) || chr(10));
        end loop;
        --close ts_tbl;
        --close sts_tbl;

    else 
        --dbms_output.put_line('ashtese');
        for t2 in ts_tbl2(dest) loop
            dbms_output.put_line(t2.train_no || ' ' || t2.departure_time);
            for st2 in sts_tbl2(t2.train_no) loop
                dbms_output.put_line('Total Available Seats: ' || st2.total_avail);
                dbms_output.put_line('AC Seats Avaialbe: ' || st2.ac_avail);
                dbms_output.put_line('General Seats Available: ' || st2.g_avail);
            end loop;
            dbms_output.put_line(chr(13) || chr(10));
        end loop;
        --close ts_tbl2;
        --close sts_tbl2;
    end if;

end findTrain;

/

-- 6
create or replace procedure showTickets(t_id in BOOKS.id%TYPE)
is 

cursor tk_tbl(tk_id TICKET.id%TYPE) is
select user_id, status, no_of_passengers, train_no from TICKET where id = t_id;

cursor ps_tbl(tk_id TICKET.id%TYPE, u_id TICKET.user_id%TYPE) is 
select seat_number from passenger where ticket_id = tk_id and user_id = u_id;

cursor tk_tbl2(tk_id TICKET.id%TYPE) is
select user_id, status, no_of_passengers, train_no from TICKET@site_link where id = t_id;

cursor ps_tbl2(tk_id TICKET.id%TYPE, u_id TICKET.user_id%TYPE) is 
select seat_number from passenger@site_link where ticket_id = tk_id and user_id = u_id;


begin 
    for tk in tk_tbl(t_id) loop 
        dbms_output.put_line('Status: ' || tk.status);
        dbms_output.put_line('No of Passengers: ' || tk.no_of_passengers);
        dbms_output.put_line('Train No.: ' || tk.train_no);
        dbms_output.put_line('Reserved Seats: ');
        for ps in ps_tbl(t_id, tk.user_id) loop
            dbms_output.put_line(ps.seat_number || ' ');
        end loop;
    end loop;

    for tk in tk_tbl2(t_id) loop 
        dbms_output.put_line('Status: ' || tk.status);
        dbms_output.put_line('No of Passengers: ' || tk.no_of_passengers);
        dbms_output.put_line('Train No.: ' || tk.train_no);
        dbms_output.put_line('Reserved Seats: ');
        for ps in ps_tbl2(t_id, tk.user_id) loop
            dbms_output.put_line(ps.seat_number || ' ');
        end loop;
    end loop;
end showTickets;

/

create or replace procedure showProfile(id USERS.user_id%TYPE)
is 

u_id USERS.user_id%TYPE;
u_name USERS.user_name%TYPE;
u_gender USERS.gender%TYPE;
u_age USERS.age%TYPE;
u_mobile USERS.mobile_no%TYPE;
u_email USERS.email%TYPE;

begin 
    select user_id, user_name, gender, age, mobile_no, email into u_id, u_name, u_gender, u_age, u_mobile, u_email from users where user_id = id;
    dbms_output.put_line('User Name: ' || u_name);
    dbms_output.put_line('Gender: ' || u_gender);
    dbms_output.put_line('Age: ' || u_age);
    dbms_output.put_line('Contact No. ' || u_mobile);
    dbms_output.put_line('Email: ' || u_email);

end showProfile;

/