create or replace procedure createTrain(train_name in TRAIN.train_name%TYPE, total_seats in TRAIN.total_seats%TYPE, total_ac_seats in TRAIN.total_ac_seats%TYPE, total_gen_seats in TRAIN.total_gen_seats%TYPE,
ac_seat_fair in TRAIN.ac_seat_fair%TYPE, gen_seat_fair in TRAIN.gen_seat_fair%TYPE)
is 

begin 
    INSERT INTO TRAIN VALUES(train_sequence.nextval, train_name, total_seats, total_ac_seats, total_gen_seats, ac_seat_fair, gen_seat_fair);
end;

/