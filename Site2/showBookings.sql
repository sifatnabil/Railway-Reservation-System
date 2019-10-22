user_id := 1;

for b in b_tbl(user_id) loop
	showTickets(b.id);
end loop;

for b in b_tbl2(user_id) loop
	showTickets(b.id);
end loop;
