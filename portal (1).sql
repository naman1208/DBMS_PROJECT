-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 05, 2019 at 08:50 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.2.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `Areas`
--

CREATE TABLE `Areas` (
  `TID` varchar(10) NOT NULL,
  `Name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Areas`
--

INSERT INTO `Areas` (`TID`, `Name`) VALUES
('DK111', 'ALGO'),
('DK111', 'ML'),
('DK111', 'Operating system'),
('DK111', 'OS'),
('DK111', 'SHELL'),
('DK111', 'SHell Programmmning'),
('SS123', 'Cryptography'),
('SS123', 'Data Structures'),
('SS123', 'Java'),
('SS123', 'Machine Learning'),
('SS123', 'ML'),
('SS123', 'WNS');

-- --------------------------------------------------------

--
-- Table structure for table `Books`
--

CREATE TABLE `Books` (
  `TID` varchar(10) NOT NULL,
  `Title` varchar(50) DEFAULT NULL,
  `Co-Author` varchar(30) DEFAULT NULL,
  `Year` int(4) DEFAULT NULL,
  `ISBN` varchar(30) NOT NULL,
  `Publisher` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Books`
--

INSERT INTO `Books` (`TID`, `Title`, `Co-Author`, `Year`, `ISBN`, `Publisher`) VALUES
('DK111', 'Algo', 'Divya Kumar', 2019, '34-6789', 'RoseIndia'),
('DK111', 'Data Structures', 'Shashank Srivastava', 2017, '978-81-203-4428-0', 'Prentice Hall of India'),
('SS123', 'WNS', 'NK', 2017, '1223-22', 'Sphinx'),
('SS123', 'Data Structures', 'Divya Kumar', 2017, '978-81-203-4428-0', 'Prentice Hall of India');

-- --------------------------------------------------------

--
-- Table structure for table `Chapters`
--

CREATE TABLE `Chapters` (
  `TID` varchar(10) NOT NULL,
  `Book_name` varchar(100) NOT NULL,
  `Chapters` varchar(500) NOT NULL,
  `Co-Authors` varchar(200) NOT NULL,
  `ISBN` varchar(50) NOT NULL,
  `Publisher` varchar(100) NOT NULL,
  `Page_start` varchar(10) NOT NULL,
  `Page_end` varchar(10) NOT NULL,
  `Year` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Chapters`
--

INSERT INTO `Chapters` (`TID`, `Book_name`, `Chapters`, `Co-Authors`, `ISBN`, `Publisher`, `Page_start`, `Page_end`, `Year`) VALUES
('SS123', 'Advances in Intelligent Systems and Computing', 'Analysis of Workloads for Cloud Infrastructure Capacity Planning', 'Eva Patel', '2194-5357', 'Springer', '23', '124', 2018);

-- --------------------------------------------------------

--
-- Table structure for table `Conferences`
--

CREATE TABLE `Conferences` (
  `TID` varchar(10) NOT NULL,
  `Title` varchar(300) NOT NULL,
  `Co-Authors` varchar(300) NOT NULL,
  `Type` varchar(30) NOT NULL,
  `Start_date` date NOT NULL,
  `End_date` date NOT NULL,
  `Location` varchar(200) NOT NULL,
  `ISBN` varchar(50) NOT NULL,
  `Publisher` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Conferences`
--

INSERT INTO `Conferences` (`TID`, `Title`, `Co-Authors`, `Type`, `Start_date`, `End_date`, `Location`, `ISBN`, `Publisher`) VALUES
('DK111', 'wchnwjrwh', 'wjfwbecgjwyrufhj', 'National', '2019-01-08', '2019-04-01', 'yuj efcwn', '132-5478', 'enrsukveihu'),
('SS123', 'Image Annotation Using Deep Learning: A Review', 'Utkarsh Ojha, Utsav Adhikari', 'International', '2017-06-23', '2017-06-24', 'Karpagam College of Engineering, Coimbatore (INDIA)', 'I2C2-2017', 'IEEE, Scopus');

-- --------------------------------------------------------

--
-- Table structure for table `ConferencesAndWorkshopsAttended`
--

CREATE TABLE `ConferencesAndWorkshopsAttended` (
  `TID` varchar(10) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Date` date DEFAULT NULL,
  `Location` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ConferencesAndWorkshopsAttended`
--

INSERT INTO `ConferencesAndWorkshopsAttended` (`TID`, `Name`, `Date`, `Location`) VALUES
('SS123', 'Data Science', '2018-06-13', 'MNNIT Allahabad'),
('SS123', 'Data Structures', '2019-02-14', 'IIIT Allahabad');

-- --------------------------------------------------------

--
-- Table structure for table `Courses`
--

CREATE TABLE `Courses` (
  `TID` varchar(10) NOT NULL,
  `Name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Courses`
--

INSERT INTO `Courses` (`TID`, `Name`) VALUES
('DK111', ' OS'),
('DK111', 'ALGO'),
('DK111', 'ML'),
('DK111', 'Operating system'),
('DK111', 'SHELL'),
('DKY222', 'Object Oriented Modelling'),
('RT1208', '  Operations Research'),
('RT1208', ' Computer Graphics'),
('RT1208', 'Scientific Computing'),
('SS123', ' Electronics'),
('SS123', 'Algorithm'),
('SS123', 'automata'),
('SS123', 'Cryptography'),
('SS123', 'Data Structures'),
('SS123', 'Embeddded syaytem'),
('SS123', 'Embedded System'),
('SS123', 'graph'),
('SS123', 'Graph Theory'),
('SS123', 'Kreedomania'),
('SS123', 'Mechanics'),
('SS123', 'ML'),
('SS123', 'OS'),
('SS123', 'WNS');

-- --------------------------------------------------------

--
-- Table structure for table `Education`
--

CREATE TABLE `Education` (
  `TID` varchar(10) NOT NULL,
  `B_tech` varchar(200) DEFAULT NULL,
  `BYear` int(4) DEFAULT NULL,
  `M_tech` varchar(200) DEFAULT NULL,
  `MYear` int(4) DEFAULT NULL,
  `Phd` varchar(200) DEFAULT NULL,
  `PYear` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Education`
--

INSERT INTO `Education` (`TID`, `B_tech`, `BYear`, `M_tech`, `MYear`, `Phd`, `PYear`) VALUES
('DK111', 'B.Tech CSE, moradabbad', 0, 'MNNIT Allahaabd', 0, '', 0),
('RT1208', 'Computer Science & Engg., H.B.T.I., Kanpur, U.P.', 1988, 'Motilal Nehru National Institute of Technology , Allahabad, U.P. INDIA', 2005, 'MNNIT, Allahabad', 2019),
('SBCSED1', 'B.Tech CSE,Feroze Gandhi Institute of Engineering and Technology Raebareli,U.P.', 2009, 'M.Tech Computer Appliances, Indian School of Mines Dhanbad', 2011, 'MNNIT Allahabad, U.P.', 2017),
('SK2303', '', 0, '', 0, '', 0),
('SS123', 'Computer Science and Engineering, Institute of Engineering and Rural Technology, U.P.T.U. Allahabad', 2009, 'MS in Information Security, Indian Institute of Information Technology-Allahabad', 2011, 'Secure Mobile Agent Based Communication for Real Time Applications, Indian Institute of Information Technology-Allahabad', 2015);

-- --------------------------------------------------------

--
-- Table structure for table `ExpertLecture`
--

CREATE TABLE `ExpertLecture` (
  `TID` varchar(10) NOT NULL,
  `Role` varchar(30) DEFAULT NULL,
  `Topic` varchar(90) NOT NULL,
  `Location` varchar(100) NOT NULL,
  `YearStart` int(4) DEFAULT NULL,
  `YearEnd` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ExpertLecture`
--

INSERT INTO `ExpertLecture` (`TID`, `Role`, `Topic`, `Location`, `YearStart`, `YearEnd`) VALUES
('DK111', 'Studhnet', 'Flow charts', 'IIIT', 2018, 2019),
('RT1208', 'Religious Speaker', 'Bhagwath Geeta', 'Ayodhya', 1997, 2000),
('RT1208', 'Teacher', 'Image Processing', 'G.B Pant University of Agriculture and Technology, Pantnagar', 2000, 2002),
('RT1208', 'Speaker', 'India\'s attack on Pakistan', 'Kumbh Mela, Sangam ,Allahabad', 2012, 2012),
('RT1208', 'Teacher', 'Wireless Security: Security Protocols (WPA3)', 'Allahabad University', 1990, 1992),
('SBCSED1', 'Speaker', 'DBMS', 'LPU', 2017, 2019),
('SS123', 'Counceller', 'JEE MAINS', 'ALLAHABAD', 2018, 2019),
('SS123', 'Tech-talker', 'Wireless Security: Possible Attacks', 'G.B Pant University of Agriculture and Technology, Pantnagar ', 2018, 2018);

-- --------------------------------------------------------

--
-- Table structure for table `Journals`
--

CREATE TABLE `Journals` (
  `TID` varchar(10) NOT NULL,
  `Paper_title` varchar(300) NOT NULL,
  `Name` varchar(300) NOT NULL,
  `Type` varchar(30) NOT NULL,
  `Co Author` varchar(100) NOT NULL,
  `ISBN` varchar(50) NOT NULL,
  `Publisher` varchar(200) NOT NULL,
  `page_start` varchar(10) NOT NULL,
  `page_end` varchar(10) NOT NULL,
  `Year` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Journals`
--

INSERT INTO `Journals` (`TID`, `Paper_title`, `Name`, `Type`, `Co Author`, `ISBN`, `Publisher`, `page_start`, `page_end`, `Year`) VALUES
('SS123', 'Analysis of face feature based human detection techniques', 'International Journal of Control Theory and Applications  (Scopus Indexed)', 'International', 'Dushyant Kumar Singh', '09745572', 'International Science Press', '173', '180', 2018),
('SS123', 'rgfdfyj', ' rdfujkhmim', 'SCI', 'askhfgjs', '2547-478', 'ehuvesun', '12', '45', 2017),
('SS123', 'Machine Learning', 'Data Structure', 'SCI', 'Divya kumar', '3456-78', 'Arihant', '23', '45', 2018);

-- --------------------------------------------------------

--
-- Table structure for table `Membership`
--

CREATE TABLE `Membership` (
  `TID` varchar(10) NOT NULL,
  `Professional` varchar(30) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `organisation` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Membership`
--

INSERT INTO `Membership` (`TID`, `Professional`, `code`, `organisation`) VALUES
('SS123', 'Member', '12345678', 'ACM'),
('SS123', 'Life Member', '56474738', 'CSI');

-- --------------------------------------------------------

--
-- Table structure for table `MtechThesis`
--

CREATE TABLE `MtechThesis` (
  `TID` varchar(10) NOT NULL,
  `EnrollmentNo` varchar(8) NOT NULL,
  `Name` varchar(30) DEFAULT NULL,
  `Title` varchar(40) NOT NULL,
  `YearStart` int(4) DEFAULT NULL,
  `YearEnd` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `MtechThesis`
--

INSERT INTO `MtechThesis` (`TID`, `EnrollmentNo`, `Name`, `Title`, `YearStart`, `YearEnd`) VALUES
('DK111', '20164035', 'Shiva,', 'hfdikslhq', 2018, 2019),
('RT1208', '20164035', 'Shivam Kumar', 'SDN', 2018, 2019),
('RT1208', '20164051', 'Shubham Yadav', 'Image Processing', 2019, 2020),
('SBCSED1', '20164035', 'Shivi Arya', 'SOftware ENGG', 2016, 2018),
('SS123', '20164022', 'Naman Chaurasia', 'ANFIS', 2017, 2018),
('SS123', '20164035', 'Shivam Kumar', 'Faculty portal', 2019, 2019),
('SS123', '20164086', 'Suraj patell', 'MNNIT NOTICE BOARD', 2018, 2019),
('SS123', '2016IS07', 'Renuka Sahu', 'Distributed SDN Controller System', 2017, 2018);

-- --------------------------------------------------------

--
-- Table structure for table `PhdThesis`
--

CREATE TABLE `PhdThesis` (
  `TID` varchar(10) NOT NULL,
  `Enroll` varchar(10) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Title` varchar(100) NOT NULL,
  `SYear` int(4) NOT NULL,
  `EYear` int(4) NOT NULL,
  `AwardYear` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PhdThesis`
--

INSERT INTO `PhdThesis` (`TID`, `Enroll`, `Name`, `Title`, `SYear`, `EYear`, `AwardYear`) VALUES
('DK111', '11223223', 'dascdax', 'cyqjefhgwkj', 2018, 2018, ''),
('DK111', '20164035', 'Shivam', 'SDN', 2017, 2019, 'Jaunary,2018'),
('SS123', '20124096', 'Divya Kumar', 'Operating System', 2012, 2014, 'October,2016'),
('SS123', '20164035', 'Shivam', 'SDN', 2017, 2019, 'Jaunary,2018'),
('SS123', '2016IS07', 'Renuka Sahu', 'MS in Information Security, Indian Institute of Information Technology-Allahabad', 2017, 2019, '');

-- --------------------------------------------------------

--
-- Table structure for table `Teacher`
--

CREATE TABLE `Teacher` (
  `TID` varchar(10) NOT NULL,
  `Name` varchar(30) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Mobile` bigint(10) DEFAULT NULL,
  `Designation` varchar(25) DEFAULT NULL,
  `PermAddress` varchar(40) DEFAULT NULL,
  `CorrAddress` varchar(40) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Image` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Teacher`
--

INSERT INTO `Teacher` (`TID`, `Name`, `Email`, `Mobile`, `Designation`, `PermAddress`, `CorrAddress`, `DOB`, `Image`) VALUES
('DK111', 'Divya Kumar', 'divyakumar@gmail.com', 9876543212, 'Assistant Professor', 'Moradabad', 'CSED', '2019-03-13', ''),
('RT1208', 'Dr. Rajesh Tripathi', 'rajesh.tripathi_MNNIT@gmail.com', 9876543210, 'Associate Professor', 'Allahabad', 'CSED', '1970-06-17', ''),
('SBCSED1', 'Dr. Shashwati  Banerjea', 'shashwati@mnnit.ac.in', 8564123972, 'Assistant Professor', 'Allahabad', 'CSED', '2018-05-16', ''),
('SK2303', 'Shivam Kumar', 'aryashivam852@gmail.com', 9876543210, 'Assistant Professor', 'CSED', 'Allahabad', '2019-04-03', 'facebook_cover_photo_2.png'),
('SS123', 'Shashank Srivastava', 'shashanksrivastava@mnnit.ac.in', 9988774562, 'Professor', 'Allahabad', 'CSED', '2014-06-11', '');

-- --------------------------------------------------------

--
-- Table structure for table `UserLogin`
--

CREATE TABLE `UserLogin` (
  `TID` varchar(10) NOT NULL,
  `UserPass` varchar(200) DEFAULT NULL,
  `Type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `UserLogin`
--

INSERT INTO `UserLogin` (`TID`, `UserPass`, `Type`) VALUES
('DK111', 'dk111', 'Teacher'),
('RT1208', 'Shivam@123', 'admin'),
('RT1208', 'rajeshT', 'Teacher'),
('SBCSED1', 'sb@123', 'Teacher'),
('SK2303', 'Shivam', 'Teacher'),
('SS123', 'ss@123', 'Teacher');

-- --------------------------------------------------------

--
-- Table structure for table `WorkshopSeminarOrganised`
--

CREATE TABLE `WorkshopSeminarOrganised` (
  `TID` varchar(10) NOT NULL,
  `CapacityOf` bigint(30) DEFAULT NULL,
  `Title` varchar(50) NOT NULL,
  `Start` date DEFAULT NULL,
  `End` date DEFAULT NULL,
  `OrganizedAt` varchar(40) NOT NULL,
  `Sponsor` varchar(40) DEFAULT NULL,
  `Type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `WorkshopSeminarOrganised`
--

INSERT INTO `WorkshopSeminarOrganised` (`TID`, `CapacityOf`, `Title`, `Start`, `End`, `OrganizedAt`, `Sponsor`, `Type`) VALUES
('DK111', 12000, 'SDN', '2018-04-11', '2019-04-12', 'Madras', 'Facebook', ''),
('SBCSED1', 3000, 'Saraswati Pooja', '2019-02-09', '2019-02-11', 'SAC', 'YONO', 'Workshop'),
('SS123', 11100, 'Cloud Computing', '2019-03-07', '2019-03-15', 'MP HALL', 'INNOVA', ''),
('SS123', 12000, 'Ethical hacking', '2016-07-16', '2016-07-17', 'NLH-1', 'Uber', ''),
('SS123', 12000, 'Hiroshima', '2019-02-27', '2019-03-14', 'MNNIT, Allahabad', 'Shivam', ''),
('SS123', 3000, 'Oracle: Resume Building', '2008-06-11', '2008-07-01', 'M.P  Hall, MNNIT Allahabad', 'State Bank Of India', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Areas`
--
ALTER TABLE `Areas`
  ADD PRIMARY KEY (`TID`,`Name`);

--
-- Indexes for table `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`TID`,`ISBN`);

--
-- Indexes for table `Chapters`
--
ALTER TABLE `Chapters`
  ADD PRIMARY KEY (`TID`,`ISBN`);

--
-- Indexes for table `Conferences`
--
ALTER TABLE `Conferences`
  ADD PRIMARY KEY (`TID`,`ISBN`);

--
-- Indexes for table `ConferencesAndWorkshopsAttended`
--
ALTER TABLE `ConferencesAndWorkshopsAttended`
  ADD PRIMARY KEY (`TID`,`Name`,`Location`);

--
-- Indexes for table `Courses`
--
ALTER TABLE `Courses`
  ADD PRIMARY KEY (`TID`,`Name`);

--
-- Indexes for table `Education`
--
ALTER TABLE `Education`
  ADD PRIMARY KEY (`TID`);

--
-- Indexes for table `ExpertLecture`
--
ALTER TABLE `ExpertLecture`
  ADD PRIMARY KEY (`TID`,`Topic`,`Location`);

--
-- Indexes for table `Journals`
--
ALTER TABLE `Journals`
  ADD PRIMARY KEY (`TID`,`ISBN`);

--
-- Indexes for table `Membership`
--
ALTER TABLE `Membership`
  ADD PRIMARY KEY (`TID`,`code`);

--
-- Indexes for table `MtechThesis`
--
ALTER TABLE `MtechThesis`
  ADD PRIMARY KEY (`TID`,`EnrollmentNo`,`Title`);

--
-- Indexes for table `PhdThesis`
--
ALTER TABLE `PhdThesis`
  ADD PRIMARY KEY (`TID`,`Enroll`,`Title`);

--
-- Indexes for table `Teacher`
--
ALTER TABLE `Teacher`
  ADD PRIMARY KEY (`TID`);

--
-- Indexes for table `UserLogin`
--
ALTER TABLE `UserLogin`
  ADD PRIMARY KEY (`TID`,`Type`);

--
-- Indexes for table `WorkshopSeminarOrganised`
--
ALTER TABLE `WorkshopSeminarOrganised`
  ADD PRIMARY KEY (`TID`,`Title`,`OrganizedAt`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
