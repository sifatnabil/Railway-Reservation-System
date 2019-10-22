user_name := 'Shaon Mahbub';
user_gender := 'Male';
user_age := 23;
user_mobile := '01949802548';
user_email := 'shaonmahbub@gmail.com';
user_pass := '12345678';

insert into users values(user_sequence.nextval, user_name, user_gender,
user_age, user_mobile, user_email, user_pass);

dbms_output.put_line('User Created Successfully');