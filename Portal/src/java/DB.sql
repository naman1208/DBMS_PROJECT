use Portal;
drop table if exists UserLogin;
drop table if exists Teacher;
drop table if exists Education;
drop table if exists MtechThesis;
drop table if exists ReviewerOfJournal;
drop table if exists Membership;
drop table if exists ExpertLecture;
drop table if exists WorkshopSeminarOrganised;
drop table if exists Conferences;
drop table if exists PhdThesis;
drop table if exists ConferencesAndWorkshopsAttended;
drop table if exists Books;
drop table if exists Chapters;
#drop table if exists ;

create table UserLogin
(
	UserLogin varchar(30),
	UserPass varchar(10),
	Type varchar(30)
);

insert into UserLogin
values('shashwati@mnnit.ac.in','12345678','Teacher');
select * from UserLogin;

create table Teacher
(
	Name varchar(30),
	Email varchar(30),
	Mobile bigint(10),
	Designation varchar(25),
	PermAddress varchar(40),
	CorrAddress varchar(40),
	DOB date,
	AreasOfInterest varchar(30)
);

insert into Teacher
values('Dr.Shashwati Banerjea','shashwati@mnnit.ac.in','8948750947','Assistant Professor','Csed','CSED','1990-03-12','ML');
select * from Teacher;

create table Education
(
	Phd varchar(30),
	status varchar(50),
	Year integer(4)
);

create table MtechThesis
(
	EnrollmentNo integer(8),
	Name varchar(30),
	Thesis varchar(50),
	Title varchar(40),
	YearStart integer(4),
	YearEnd integer(4)
);

create table ReviewerOfJournal
(
	Name varchar(30),
	Year integer(4),
	Publisher varchar(50),
	Reviewer varchar(40)
);

create table Membership
(
	Professional varchar(30),
	code varchar(50),
	organisation varchar(40)
);

create table ExpertLecture
(
	Role varchar(30),
	Data varchar(50),
	Location varchar(40),
	YearStart integer(4),
	YearEnd integer(4)
);

create table WorkshopSeminarOrganised
(
	CapacityOf varchar(30),
	Title varchar(50),
	Start date,
	End date,
	OrganizedAt varchar(40),
	Sponsor varchar(40),
	Code varchar(40)
);

create table Conferences
(
	Name1 varchar(30),
	Name2 varchar(30),
	Name3 varchar(30),
	Name4 varchar(30),
	Name5 varchar(30),
	Date date,
	Location varchar(40),
	Title varchar(40),
	Status varchar(40)
);

create table PhdThesis
(
	Title varchar(40),
	Supervisor1 varchar(30),
	Supervisor2 varchar(30),
	Supervisor3 varchar(30),
	Description varchar(40),
	Status varchar(40)
);

create table ConferencesAndWorkshopsAttended
(
	Name varchar(30),
	Date date,
	Location varchar(40)
);

create table Books
(
	Chapters varchar(30),
	Volume integer(5),
	Year integer(4),
	Status varchar(40),
	PageStart integer(4),
	PageEnd integer(4),
	ISBN integer(10),
	Publisher varchar(40)
);