p_id := 1;

for p in p_view(p_id) loop
	--dbms_output.put_line(p.user_id || ' ' || p.reservation_status || ' ' || p.ticket_id);
	dbms_output.put_line('User id: ' || p.user_id);
	dbms_output.put_line('Reservation Status: ' || p.reservation_status);
	dbms_output.put_line('Ticket id: ' || p.ticket_id);
end loop;