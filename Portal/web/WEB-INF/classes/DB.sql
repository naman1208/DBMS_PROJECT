#use portal;
drop table if exists UserLogin;
drop table if exists Teacher;
drop table if exists Courses;
drop table if exists Areas;
drop table if exists Education;
drop table if exists MtechThesis;
drop table if exists Membership;
drop table if exists ExpertLecture;
drop table if exists WorkshopSeminarOrganised;
drop table if exists Conferences;
drop table if exists PhdThesis;
drop table if exists ConferencesAndWorkshopsAttended;
drop table if exists Books;
drop table if exists Chapters;


create table UserLogin
(
	TID varchar(10),
	UserPass varchar(20),
	Type varchar(10),
        primary key (TID)

);



create table Teacher
(
        TID varchar(10),
	Name varchar(30),
	Email varchar(50),
	Mobile bigint(10),
	Designation varchar(25),
	PermAddress varchar(40),
	CorrAddress varchar(40),
	DOB date,
        primary key (TID)
);



create table Education
(
        TID varchar(10),
        B_tech varchar(200),
        BYear integer(4),
        M_tech varchar(200),
        MYear integer(4),
	Phd varchar(200),
	PYear integer(4),
        primary key (TID)
);

create table MtechThesis
(
        TID varchar(10),
	EnrollmentNo varchar(10),
	Name varchar(30),
	Title varchar(90),
	YearStart integer(4),
	YearEnd integer(4),
        primary key (EnrollmentNo,TID,Title)
        
);

create table Courses
(
	TID varchar(10),
	Name varchar(200),
	primary key (TID,Name)
);

create table Areas
(
	TID varchar(10),
	Name varchar(200),
	primary key (TID,Name)
);

create table Membership
(
        TID varchar(10),
	Professional varchar(30),
	code varchar(50),
	organisation varchar(40)
);

create table ExpertLecture
(
        TID varchar(10), 
	Role varchar(30),
	Topic varchar(90),
	Location varchar(100),
	YearStart integer(4),
	YearEnd integer(4),
        primary key (TID,Topic,Location)
);

create table WorkshopSeminarOrganised
(
        TID varchar(10),
	CapacityOf bigint(30),
	Title varchar(50),
	Start date,
	End date,
	OrganizedAt varchar(40),
	Sponsor varchar(40),
        primary key (TID,Title,OrganizedAt)
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
        TID varchar(10),
        Enroll varchar(10),
        Name varchar(30),
	Title varchar(100),
	SYear integer(4),
        EYear integer(4),
        primary key (TID,Enroll,Title)
);

create table PhdThesis
(
        TID varchar(10),
        Name varchar(30),
        primary key (TID,Name)
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