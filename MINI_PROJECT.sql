CREATE DATABASE movie_booking;
USE movie_booking;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) UNIQUE
);

CREATE TABLE movie (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(100) NOT NULL,
    genre VARCHAR(30),
    duration INT CHECK (duration > 0),
    language VARCHAR(30) DEFAULT 'Hindi'
);

CREATE TABLE theatre (
    theatre_id INT PRIMARY KEY,
    theatre_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    total_seats INT CHECK (total_seats > 0)
);

CREATE TABLE movie_show (
    show_id INT PRIMARY KEY,
    movie_id INT,
    theatre_id INT,
    show_date DATE,
    show_time TIME,
    ticket_price DECIMAL(10,2) CHECK (ticket_price > 0),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (theatre_id) REFERENCES theatre(theatre_id)
);

CREATE TABLE booking (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    show_id INT,
    tickets INT CHECK (tickets > 0),
    booking_date DATE,
    status VARCHAR(20) DEFAULT 'Confirmed',
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (show_id) REFERENCES movie_show(show_id)
);

CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    booking_id INT UNIQUE,
    amount DECIMAL(10,2) CHECK (amount > 0),
    payment_method VARCHAR(20) DEFAULT 'UPI',
    payment_status VARCHAR(20) DEFAULT 'Paid',
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
);

INSERT INTO customer VALUES
(101,'Rahul Sharma','rahul@gmail.com','9876543210'),
(102,'Simran Kaur','simran@gmail.com','9876543211'),
(103,'Arjun Singh','arjun@gmail.com','9876543212'),
(104,'Priya Verma','priya@gmail.com','9876543213'),
(105,'Aman Kumar','aman@gmail.com','9876543214');

SELECT * FROM customer;

INSERT INTO movie VALUES
(201,'The Last Journey','Action',145,'Hindi'),
(202,'Dream City','Drama',130,'Hindi'),
(203,'Space Mission','Sci-Fi',150,'English'),
(204,'Love Again','Romance',125,'Hindi'),
(205,'Mystery House','Thriller',140,'English');

INSERT INTO theatre VALUES
(301,'PVR Cinemas','Chandigarh',200),
(302,'INOX','Mohali',180),
(303,'Cinepolis','Ludhiana',220);

SELECT * FROM movie;
SELECT * FROM theatre;


INSERT INTO movie_show VALUES
(401,201,301,'2026-10-10','10:00:00',250),
(402,202,301,'2026-10-10','14:00:00',220),
(403,203,302,'2026-10-10','18:00:00',300),
(404,204,303,'2026-10-11','19:00:00',200),
(405,205,302,'2026-10-11','21:00:00',280);

SELECT * FROM movie_show;

INSERT INTO booking
(booking_id,customer_id,show_id,tickets,booking_date)
VALUES
(501,101,401,2,'2026-10-08'),
(502,102,402,3,'2026-10-08'),
(503,103,403,2,'2026-10-08'),
(504,104,404,4,'2026-10-08'),
(505,105,405,1,'2026-10-08');

INSERT INTO payment
(payment_id,booking_id,amount)
VALUES
(601,501,500),
(602,502,660),
(603,503,600),
(604,504,800),
(605,505,280);

SELECT * FROM booking;
SELECT * FROM payment;


SELECT COUNT(*) AS total_bookings
FROM booking;


SELECT SUM(amount) AS total_revenue
FROM payment;

SELECT AVG(amount) AS average_payment
FROM payment;


SELECT m.movie_name, ms.ticket_price
FROM movie m
JOIN movie_show ms ON m.movie_id=ms.movie_id
WHERE ms.ticket_price > 250;


SELECT c.customer_name, SUM(b.tickets) AS total_tickets
FROM customer c
JOIN booking b ON c.customer_id=b.customer_id
GROUP BY c.customer_name;

INSERT INTO customer
VALUES (101,'Ravi Kumar','ravi@gmail.com','9876500000');

INSERT INTO customer
VALUES (106,'Ravi Kumar','rahul@gmail.com','9876500000');


INSERT INTO booking
VALUES (506,101,401,0,'2026-10-08','Confirmed');

INSERT INTO booking
VALUES (507,999,401,2,'2026-10-08','Confirmed');
