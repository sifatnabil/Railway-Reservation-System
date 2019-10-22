create or replace function minimumFair(st_no in TRAIN_STATUS.station_no%TYPE)
return TRAIN.ac_seat_fair%TYPE
is 

view_str varchar(200) := 'create or replace view myview as 
select train_status.train_no, ac_seat_fair, ac_avail, train_status.station_no from train_status 
join train on train_status.train_no = train.train_no';

f TRAIN.ac_seat_fair%TYPE;

begin 

    EXECUTE IMMEDIATE view_str;

    select min(ac_seat_fair) into f from ( select train_status.train_no, ac_seat_fair, ac_avail, train_status.station_no from train_status 
    join train on train_status.train_no = train.train_no) where station_no = st_no;

    return f;
end; 

/