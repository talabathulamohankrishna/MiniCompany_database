CREATE DATABASE companydata;
SHOW DATABASES;

USE companydata;

CREATE TABLE employee (
  emp_id INT primary key,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT primary key,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  foreign key(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD foreign key(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD foreign key(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT primary key,
  client_name VARCHAR(40),
  branch_id INT,
  foreign key(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  primary key(emp_id, client_id),
  foreign key(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  foreign key(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  primary key(branch_id, supplier_name),
  foreign key(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);