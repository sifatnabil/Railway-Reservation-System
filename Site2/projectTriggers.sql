create or replace trigger ticketCreateTrigger
after insert on TICKET for each row
begin 
	dbms_output.put_line('Ticket booked Successfully');
end;
/

create or replace trigger ticketCancelTrigger
after delete on TICKET for each row
begin
	dbms_output.put_line('Ticket Cancelled Successfully');
end;
/

create or replace trigger updateTrainFairTrigger
after update on TRAIN for each row
begin
	dbms_output.put_line('Train Fare updated Successfully');
end;
/

create or replace trigger updateTrainTimeTrigger
after update on TRAIN_STATION for each row
begin
	dbms_output.put_line('Train delayed Successfully');
end;
/
