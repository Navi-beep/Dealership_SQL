CREATE TABLE Customer(
customer_id SERIAL PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
address VARCHAR(200),
city VARCHAR(100),
state VARCHAR(20)
);


SELECT*
FROM customer;

CREATE TABLE Sales_Employee(
sales_employee_id SERIAL PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(100)
);

SELECT*
FROM sales_employee;


CREATE TABLE Service(
service_id SERIAL PRIMARY KEY,
name_ VARCHAR(100),
description VARCHAR(200),
rate INTEGER
);

SELECT*
FROM Sales_Employee;


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


