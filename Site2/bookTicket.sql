dest := 2;
findTrain(dest);
u_id := 101;
status := 'c';
no_of_passenger := 1;
seat_type := 1; -- 1 for ac , 2 for non-ac
--ticket_id := ticket_sequence.nextval;
if dest = 1 then
	t_no := 2;
	select total_ac_seats into t_ac_seats from TRAIN where train_no = t_no;
	select ac_avail into t_ac_avail from TRAIN_STATUS where train_no = t_no;
	ticket_start := t_ac_seats - t_ac_avail + 1;

	--dbms_output.put_line('start from ' || ticket_start);

	insert into ticket (id, user_id, status, no_of_passengers, train_no) 
	values(ticket_sequence.nextval, u_id, status, no_of_passenger, t_no);
	--returning id into ticket_id;

	insert into books values(u_id, ticket_sequence.currval);

	update train_status set total_avail = total_avail - no_of_passenger where train_status.train_no = t_no;

	if seat_type = 1 then
		update train_status set ac_avail = ac_avail - no_of_passenger where train_status.train_no = t_no;
	else
		-- if (train_status.g_avail - no_of_passenger < 0) then 
		-- 	RAISE no_seat_available; 
		-- end if;
		update train_status set g_avail = g_avail - no_of_passenger where train_status.train_no = t_no;
	end if;

	--dbms_output.put_line(ticket_id);
	for i in 1..no_of_passenger loop
		insert into PASSENGER values(passenger_sequence.nextval, u_id, status, ticket_start, ticket_sequence.currval);
		ticket_start := ticket_start + 1;	
	end loop;
else 
	t_no := 3;

	select count(*) into found from users@nabil where user_id = u_id;

	if found < 1 then
		select user_id, user_name, gender, age, mobile_no, email, password into user_id, user_name, user_gender, user_age, user_mobile, user_email, user_pass from users where user_id = u_id;
		insert into users@nabil values(user_id, user_name, user_gender, user_age, user_mobile, user_email, user_pass);
	end if;

	select total_ac_seats into t_ac_seats from TRAIN@nabil where train_no = t_no;
	select ac_avail into t_ac_avail from TRAIN_STATUS@nabil where train_no = t_no;
	ticket_start := t_ac_seats - t_ac_avail + 1;

	--dbms_output.put_line('start from ' || ticket_start);

	select count(id) into ticket_id from ticket@nabil;

	ticket_id := ticket_id + 1;

	insert into ticket@nabil(id, user_id, status, no_of_passengers, train_no) 

	values(ticket_id, u_id, status, no_of_passenger, t_no);
	--returning id into ticket_id;

	insert into books@nabil values(u_id, ticket_id);

	update train_status@nabil set total_avail = total_avail - no_of_passenger where train_status.train_no = t_no;

	if seat_type = 1 then
		-- if (train_status.ac_avail@nabil - no_of_passenger < 0) then 
		-- 	RAISE no_seat_available; 
		-- end if;
		update train_status@nabil set ac_avail = ac_avail - no_of_passenger where train_status.train_no = t_no;
	else
		-- if (train_status.g_avail@nabil - no_of_passenger < 0) then 
		-- 	RAISE no_seat_available; 
		-- end if;
		update train_status@nabil set g_avail = g_avail - no_of_passenger where train_status.train_no = train_no;
	end if;

	select count(passenger_id) into p_id from PASSENGER@nabil;
	p_id := p_id + 1;

	--dbms_output.put_line(ticket_id);
	for i in 1..no_of_passenger loop
		insert into PASSENGER@nabil values(p_id, u_id, status, ticket_start, ticket_id);
		p_id := p_id + 1;
		ticket_start := ticket_start + 1;	
	end loop;

end if;

commit;

