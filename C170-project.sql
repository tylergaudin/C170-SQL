CREATE TABLE COFFEE_SHOP (
  shop_id INT,
  shop_name VARCHAR(50),
  city VARCHAR(50),
  state CHAR(2),
  PRIMARY KEY (shop_id)
);

CREATE TABLE SUPPLIER (
  supplier_id INT,
  company_name VARCHAR(50),
  country VARCHAR(30),
  sales_contact_name VARCHAR(60),
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY (supplier_id)
);

CREATE TABLE EMPLOYEE (
  employee_id INT UNSIGNED,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  hire_date DATE,
  job_title VARCHAR(30),
  shop_id int,
  PRIMARY KEY (employee_id),
  FOREIGN KEY (shop_id) REFERENCES COFFEE_SHOP(shop_id)
  );

CREATE TABLE COFFEE (
  coffee_id INT UNSIGNED,
  shop_id INT,
  supplier_id INT,
  coffee_name VARCHAR(30),
  price_per_pound NUMERIC(5, 2),
  PRIMARY KEY (coffee_id),
  FOREIGN KEY (shop_id) REFERENCES COFFEE_SHOP(shop_id)
    ON DELETE RESTRICT,
  FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id)
    ON DELETE RESTRICT
);

INSERT INTO COFFEE_SHOP (shop_id, shop_name, city, state)
VALUES (1, 'Cool Shop', 'Chicago', 'IL'),
(2, 'Neat Shop', 'Austin', 'TX'),
(3, 'New Shop', 'Dallas', 'TX');

INSERT INTO SUPPLIER (supplier_id, company_name, country, sales_contact_name, email)
VALUES (11, 'Coffee Guys', 'Argentina', 'Manu Ginobli', 'gospurs@gmail.com'),
(12, 'Coffee Girls', 'Colombia', 'Shakira', 'whenever@gmail.com'),
(13, 'Coffee People', 'Brasil', 'Neymar', 'goals@gmail.com');

INSERT INTO EMPLOYEE (employee_id, first_name, last_name, hire_date, job_title, shop_id)
VALUES (21, 'Kylian', 'Mbappe', '2018-07-15', 'Register', '2'),
(22, 'Lionel', 'Messi', '2010-07-15', 'Manager', '2'),
(23, 'Cristian', 'Ronaldo', '2005-07-15', 'General Manager', '2');

INSERT INTO COFFEE (coffee_id, shop_id, supplier_id, coffee_name, price_per_pound)
VALUES (101, 2, 12, 'Football Roast', 17.50),
(102, 3, 11, 'OMG Roast', 18.50),
(103, 1, 13, 'The Hat Trick', 15.75);

CREATE VIEW EMPLOYEE_LIST
AS SELECT employee_id, CONCAT(first_name, ' ', last_name)AS employee_full_name, hire_date, job_title, shop_id
  FROM EMPLOYEE;

CREATE INDEX coffee_index ON COFFEE(coffee_name);

SELECT * FROM EMPLOYEE
WHERE last_name LIKE 'm%';

SELECT COFFEE_SHOP.shop_name, COFFEE_SHOP.city,
COFFEE.coffee_name, COFFEE.price_per_pound, EMPLOYEE.first_name,
EMPLOYEE.last_name
FROM COFFEE_SHOP
INNER JOIN COFFEE ON COFFEE_SHOP.shop_id = COFFEE.shop_id
INNER JOIN EMPLOYEE ON COFFEE.shop_id = EMPLOYEE.shop_id
ORDER BY COFFEE_SHOP.shop_name;
