create database prj1
use prj1

create table course
(
course_id int auto_increment primary key,
course_name varchar(50)not null
)

desc course

insert into course values
(1,'JAVA' ),
(2, 'SQL'),
(3,'PYTHON'),
(4,'HTML'),
(5,'C'),
(6,'DATA STRUCTURES')

select*from course

create table student
(
student_id int auto_increment primary key,
student_name varchar(50) not null,
dob date not null,
street varchar(120) default null,
city varchar(30) not null,
state varchar(30) not null,
pin varchar(30) default null,
course_id int not null,
foreign key (course_id) references course(course_id)
)

desc student

select*from student

insert into student values
( 100,'Vinay', '2001-09-3','Kalabadavi','Mumbai','Maharastra','400002',1 ),
( 101,'Manasa','2007-01-17','Arumbakkam','Chennai','Tamilnadu','600106',4 ),
( 102,'Akshata','2002-05-10','Chembur','Mumbai','Maharastra','4000074',1 ),
( 103,'Jackson','2002-07-22','Malleshwaram','Bengalore','Karnataka','560003',5 ),
( 104,'Shreyas','2002-07-12','Balanagar','Hyderabad','Telangana','560037',6 ),
( 105,'Peter','2001-03-20','Afzalgun','Hyderabad','Teleangana','560012',2 ),
( 106,'Sneha','2001-12-30','Greater kailash','Delhi','Delhi','110048',3 ),
( 107,'Ankita','2000-08-20','Fatroda','Margo','Goa','403601',2 ),
( 108,'Shreya','2001-06-28','Pathnoolpet','Bengalore','Karnataka','560003',5 ),
( 109,'Aishwarya','2002-04-19','Jodhpur park','Kolkata','West Bengal','700019',5 ),
( 110,'Neha','2001-01-05','Ashram Road','Ahemadabad','Gujarat','380009',6 ),
( 111,'Harshita','2000-11-23','Ashram Jaiandhar by pass','Ludhina','Punjab','141001',1 )

select*from student

create table hobby
(
student_id int not null,
hobby varchar(50) default null,
foreign key (student_id) references student(student_id)
)

desc hobby

insert into hobby values
( 109, 'Cooking' ),
( 101, 'Art' ),
( 100, 'Swimming' ),
( 105, 'Dance' ),
( 107, 'Singing' ),
( 103, 'Sleeping' ),
( 111, 'Travelling')
 
select*from hobby

create table lecturer
(
lecturer_id int auto_increment,
lecturer_name varchar(30) not null,
course_id int not null,
primary key (lecturer_id),
foreign key (course_id) references course(course_id)
)

desc lecturer

insert into lecturer values
( 200, 'Prisha', 4 ),
( 201, 'Aadhya', 2 ),
( 202, 'Isha', 1 ),
( 203, 'Siya', 5 ),
( 204, 'Anjali', 3 ),
( 205, 'Kamala', 6 )

select*from lecturer


create table subject
(
subject_id int auto_increment,
subject_name varchar(30) default null,
lecturer_id int not null,
primary key(subject_id),
foreign key(lecturer_id) references lecturer(lecturer_id)
)

desc subject

insert into subject values
( 15,'OOP',204 ),
( 16,'VARIABLE',203 ),
( 17,'CONSTRAINTS',205 ),
( 18,'LOOPS',200 ),
( 19,'NUMPY',202 ),
( 20,'MATPLOTIB',202 ),
( 21,'PANDA',204 ),
( 22,'STATS',205 ),
( 23,'JOINS',205 )

select*from subject

/*retrive student_id and student_name */

select student_name, student_id from student

/*retrive student_id and student_name whose name starts with N*/

select student_ID, student_name from student
where student_name like 'n%%'

/* retrive only student name with aliyas from student table*/

select student_name as new_name from student

/*display top 5 lecturer_id*/

select*from lecturer
limit 5

/* dec student_id in hobby table */

select * from hobby
order by student_id desc

/* left join lecturer id from lecturer and subject, select column lecturer id,lecturer_name, subject_name */

select lecturer . lecturer_id,lecturer_name,subject_id
from lecturer
left join subject
on lecturer . lecturer_id = subject . lecturer_id

/* full outer join student and course */

select * from student
left join course
on student . course_id = course . course_id
union
select*from student
right join course
on student . course_id = course . course_id

/*inner join lec, course, subject and retrive data of lec id 201 202 and 203 */

select lecturer . lecturer_id, lecturer . lecturer_name, course_name, subject . subject_name from lecturer
inner join subject
on lecturer.lecturer_id = subject.lecturer_id
inner join course
on lecturer.course_id = course.course_id
where lecturer . lecturer_id in (201,202,203)

/*retrive students who are born after june 20 2002*/

select*from student
where dob > '2002-06-20'

/*retrive number of students in each course*/

select course_name, count(student_name) from student
left join course
on student . course_id = course . course_id
group by course_name

select course_name, count(student_name) from student
inner join course
on student . course_id = course . course_id
group by course_name

/* inner join student and course, retrive course id from course pin and student_name from student*/

select course . course_id, student . pin, student_name from student
inner join course
on student . course_id = course . course_id
order by pin desc

/*find the lecturer who teaches specfic subject*/
select lecturer.lecturer_name,subject.subject_name from lecturer
inner join subject
on lecturer . lecturer_id = subject.lecturer_id
where subject_id = '17'

/* find the lecturers who are not correctly assigned to teach any subject*/
select lecturer.lecturer_name, subject.subject_name from lecturer
inner join subject
on lecturer . lecturer_id = subject . lecturer_id
where lecturer . lecturer_id is null

select*from subject

/* retrive the top 3 most popular hobbies amoung students */

select hobby, count(hobby) from student
inner join hobby
on student . student_id = hobby . student_id
group by hobby
order by count(hobby) desc
limit 3

/*retrive the lecturers teaching the max number of subjects*/

select lecturer_name, count(subject_id) from lecturer
inner join subject
on lecturer . lecturer_id = subject . lecturer_id
group by lecturer_name
order by count(subject_id) desc

select*from subject

/*find the students who are enroled in multiple subjects*/
select student_name, count(subject_id) from student
inner join lecturer
on student.course_id = lecturer.course_id
inner join subject
on lecturer.lecturer_id = subject . lecturer_id 
group by student_name
order by count(subject_id) desc

Select
Lecturer_name, count(subject_id) -- or count(*)
From lecturer l
left join subject s
on l.lecturer_id = s. lecturer_id
group by Lecturer_name
order by count(subject_id) desc

select lecturer.lecturer_id,lecturer_name, count(*) from lecturer
inner join subject
on lecturer . lecturer_id = subject . lecturer_id
group by lecturer_id
order by count(*) desc