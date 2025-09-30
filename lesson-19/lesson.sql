--create database class19
--go
--use class19

CREATE TABLE employees (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone_number NVARCHAR(20),
    hire_date DATE NOT NULL,
    job_title NVARCHAR(50),
    salary DECIMAL(10,2),
    department NVARCHAR(50)
);

INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_title, salary, department)
VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '2021-05-10', 'Software Engineer', 65000.00, 'IT'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '2020-03-15', 'Data Analyst', 55000.00, 'Analytics'),
('Michael', 'Brown', 'michael.brown@example.com', '345-678-9012', '2019-07-01', 'HR Manager', 60000.00, 'HR'),
('Emily', 'Davis', 'emily.davis@example.com', '456-789-0123', '2022-01-20', 'Project Manager', 72000.00, 'Operations'),
('David', 'Wilson', 'david.wilson@example.com', '567-890-1234', '2023-09-01', 'Intern', 25000.00, 'IT');

select * from employees;

create procedure get_people @Depname varchar(50)
as
begin
	select * from employees
	where department = @Depname
end

exec get_people 'IT'


alter procedure get_people @Depname varchar(50)
as
begin
	select * from employees
	where department = @Depname

	select 'this people salary will increase to 10%!'

	update employees
	set salary = salary * 1.1
	where department = @Depname

	select * from employees
	where department = @Depname
end

get_people 'IT'

