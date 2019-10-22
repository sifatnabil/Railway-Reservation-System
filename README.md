# Railway-Reservation-System
A simple PL/SQL project that implements a few functionalities of a Railway Reservation System

Software Requirement: Oracle 10g, SQL* PLUS

About the project: 
There are two stations available in the system. Dhaka and Chittagong.
User can book ticket from one site to another site. The booking information is stored in the source station.
User can select tickets based on price and timing.

There is also an admin system.
Admin can delay train times and reduce train fare.

A prompt is shown to the user to choose what they want to do.
Due to some limitations of Oracle 10g we are only taking the first input and the rest of variables are kept static.

Each site has a conn.sql file where the username and password of other site's oracle client and the ip address is written.
