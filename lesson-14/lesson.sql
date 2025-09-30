create database class14
go
use class14

select ascii('C')


select ascii(Right('SQL', 2))

SELECT LEN('SQL')

SELECT CHAR(88)



SELECT 'A' as Letter, ASCII('A') as AsciiCode, CHAR(ASCII('A') + 1) AS NextLetter

select replace('Test', 't', 'b')

select 'Open AI', len('Open AI'), len(replace('Open AI', ' ', ''))

select REVERSE('SQL')

select concat('Hello', ' world')

select 'SQL' + Space(5) + 'Server'

select ltrim('    trr   tr       ')
select rtrim('    trr   tr       ')
select trim('    trr   tr        ')


select LOWER('HeLlo AgAiN jOhN'), UPPER('HeLlo AgAiN jOhN')

select char(Ascii('a') - 32) 

select substring('Software engineering', 4, 4)

select charindex('a' ,'Software engineering')

select SUBSTRING('nematjonovmuhammadilyas@gmail.com', 1, CHARINDEX('@', 'nematjonovmuhammadilyas@gmail.com') - 1)


select concat_ws('/', '2025', '03', '05')
 

 select string_agg (Name, ', ')
 from (Values('John'), ('Jani'), ('Alice')) as T(Name)


 create table Table1 (name varchar(50))

 insert into Table1 values 
 ('John'), ('Jani'), ('Alice')

 select STRING_AGG(Name, ', ') from Table1