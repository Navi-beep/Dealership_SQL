CREATE TABLE Customer(
customer_id SERIAL PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
address VARCHAR(200),
city VARCHAR(100),
state VARCHAR(20)
);


CREATE TABLE Sales_Employee(
sales_employee_id SERIAL PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(100)
);



CREATE TABLE Service(
service_id SERIAL PRIMARY KEY,
name_ VARCHAR(100),
description VARCHAR(200),
rate INTEGER
);



CREATE TABLE Car(
car_id SERIAL PRIMARY KEY,
make VARCHAR(50),
model VARCHAR(50),
color VARCHAR(30),
year_ INTEGER,
serial VARCHAR(200)
);


CREATE TABLE Invoice(
invoice_id SERIAL PRIMARY KEY,
date_ TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
invoice_number INTEGER,
invoice_amount INTEGER,
sales_employee_id INTEGER NOT NULL,
FOREIGN KEY(sales_employee_id) REFERENCES  Sales_Employee(sales_employee_id),
customer_id INTEGER NOT NULL,
FOREIGN KEY(customer_id) REFERENCES  Customer(customer_id),
car_id INTEGER NOT NULL,
FOREIGN KEY(car_id) REFERENCES  Car(car_id)
);


CREATE TABLE Mechanic(
mechanic_id SERIAL PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(100),
service_id INTEGER NOT NULL,
FOREIGN KEY(service_id) REFERENCES Service(service_id),
ticket_id INTEGER NOT NULL,
FOREIGN KEY(ticket_id) REFERENCES Ticket(ticket_id)
);

CREATE TABLE Ticket(
ticket_id SERIAL PRIMARY KEY,
date_ TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ticket_number INTEGER,
customer_id INTEGER NOT NULL,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
car_id INTEGER NOT NULL,
FOREIGN KEY (car_id) REFERENCES Car(car_id)
);


CREATE TABLE Payment(
payment_id SERIAL PRIMARY KEY,
amount INTEGER,
date_ TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
customer_id INTEGER NOT NULL,
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
ticket_id INTEGER NOT NULL,
FOREIGN KEY(ticket_id) REFERENCES Ticket(ticket_id),
invoice_id INTEGER NOT NULL,
FOREIGN KEY(invoice_id) REFERENCES Invoice(invoice_id)
);


CREATE TABLE Service_history(
service_history_id SERIAL PRIMARY KEY,
service_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
car_id INTEGER NOT NULL,
FOREIGN KEY (car_id) REFERENCES Car(car_id),
dealership_id INTEGER NOT NULL,
FOREIGN KEY (dealership_id) REFERENCES Dealership(dealership_id)
);



CREATE TABLE Dealership(
dealership_id SERIAL PRIMARY KEY,
location_ VARCHAR (200),
mechanic_id INTEGER NOT NULL,
FOREIGN KEY (mechanic_id) REFERENCES Mechanic(mechanic_id),
sales_employee_id INTEGER NOT NULL,
FOREIGN KEY (sales_employee_id) REFERENCES Sales_Employee(sales_employee_id)
);

SELECT*
FROM customer;


CREATE OR REPLACE PROCEDURE add_customer(
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	address VARCHAR(200),
	city VARCHAR(100),
	state VARCHAR(20)
)
LANGUAGE plpgsql 
AS $$ 
BEGIN 
	INSERT INTO Customer(first_name, last_name, address, city, state)
	VALUES(first_name, last_name, address, city, state);
END
$$

--add 2 more customers via procedure---

INSERT INTO Customer(first_name, last_name, address, city, state)
	VALUES('Harrison', 'Ford', '254 Leaf Street', 'Chicago', 'Illinois');

INSERT INTO Customer(first_name, last_name, address, city, state)
	VALUES('Christopher', 'Walken', '588 Coffee Road', 'Chicago', 'Illinois');


SELECT*
FROM Car;


INSERT INTO Car(make, model, color, year_, serial)
VALUES('Volkswagen', 'Jetta', 'Black', 2016, '739H3DCSAFDW3GCB3');


INSERT INTO Car(make, model, color, year_, serial)
VALUES('Lamborghini', 'Diablo VT', 'Red', 1990, '139Z3DVSAFKW3GCL3');


SELECT*
FROM ticket;


INSERT INTO ticket(date_, ticket_number, customer_id, car_id)
VALUES(current_timestamp, 1,1,1);


INSERT INTO ticket(date_, ticket_number, customer_id, car_id)
VALUES(current_timestamp, 2,2,2);


SELECT*
FROM service;


INSERT INTO Service(name_, description, rate)
	VALUES('Oil change', '5W-40 for VW Jetta 2016', 50);

INSERT INTO Service(name_, description, rate)
	VALUES('Ignition cylinder replacment', 'Faulty ignition cylinder lock for 2019 Subaru Impreza', 400);


SELECT*
FROM sales_employee;

CREATE OR REPLACE PROCEDURE add_sales_employee(
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(100)
)
LANGUAGE plpgsql 
AS $$ 
BEGIN 
	INSERT INTO sales_employee(first_name, last_name, email)
	VALUES(first_name, last_name, email);
END
$$

CALL add_sales_employee('James', 'McGill', 'Jmcgill@chicagodealership.com');

CALL add_sales_employee('Marty', 'McFly', 'Mmcfly@chicagodealership.com');


INSERT INTO Mechanic(first_name, last_name, email, service_id, ticket_id)
VALUES('Michael', 'Scott', 'Mscott@chicagodealership.com', 1, 1);

INSERT INTO Mechanic(first_name, last_name, email, service_id, ticket_id)
VALUES('Peanut', 'Cocoteel', 'Pcoco@chicagodealership.com', 2, 3);

SELECT *
FROM Mechanic;

INSERT INTO Dealership(location_, mechanic_id, sales_employee_id)
VALUES('Chicago', 3 , 1);

INSERT INTO Dealership(location_, mechanic_id, sales_employee_id)
VALUES('Chicago', 1 , 1);

SELECT*
FROM Dealership;


SELECT*
FROM Invoice;

INSERT INTO Invoice(date_, invoice_number, invoice_amount, sales_employee_id, customer_id, car_id)
VALUES (current_timestamp, 1, 400, 1, 1, 1);


INSERT INTO Invoice(date_, invoice_number, invoice_amount, sales_employee_id, customer_id, car_id)
VALUES (current_timestamp, 2, 50, 2, 2, 2);


SELECT*
FROM payment;


INSERT INTO Payment(amount, date_, customer_id, ticket_id, invoice_id)
VALUES (50, current_timestamp, 1, 1, 2);


INSERT INTO Payment(amount, date_, customer_id, ticket_id, invoice_id)
VALUES (350, current_timestamp, 1, 1, 2);


INSERT INTO Payment(amount, date_, customer_id, ticket_id, invoice_id)
VALUES (50, current_timestamp, 2, 3, 1);


SELECT*
FROM service_history;

SELECT*
FROM Car;


INSERT INTO service_history (service_date, car_id, dealership_id)
VALUES (current_timestamp, 1, 5);

INSERT INTO service_history (service_date, car_id, dealership_id)
VALUES (current_timestamp, 2, 5);






SELECT*
FROM invoice;


--count payments by customer--



SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id, payment.amount
ORDER BY SUM(amount) DESC;



CREATE OR REPLACE FUNCTION total_payments_by_customer(your_num INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE payments_by_customer INTEGER;
BEGIN
	SELECT SUM(amount) INTO payments_by_customer
	FROM payment
	WHERE customer_id = your_num;
	RETURN payments_by_customer;
END;
$$;


SELECT total_payments_by_customer('1');













