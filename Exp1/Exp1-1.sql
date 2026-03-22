CREATE DATABASE `S-C-SC`;
USE `S-C-SC`;

CREATE TABLE `Student` (
  `Sno` CHAR(8) NOT NULL COMMENT '学号',
  `Sname` VARCHAR(20) NOT NULL COMMENT '姓名',
  `Ssex` VARCHAR(2) NOT NULL COMMENT '性别',
  `Sbirthdate` DATE NOT NULL COMMENT '出生日期',
  `Smajor` VARCHAR(50) NOT NULL COMMENT '主修专业',
  PRIMARY KEY (`Sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生表';

INSERT INTO `Student` (`Sno`, `Sname`, `Ssex`, `Sbirthdate`, `Smajor`) VALUES
('20180001', '李勇',   '男', '2000-03-08', '信息安全'),
('20180002', '刘晨',   '女', '1999-09-01', '计算机科学与技术'),
('20180003', '王敏',   '女', '2001-08-01', '计算机科学与技术'),
('20180004', '张立',   '男', '2000-01-08', '计算机科学与技术'),
('20180005', '陈新奇', '男', '2001-11-01', '信息管理与信息系统'),
('20180006', '赵明',   '男', '2000-06-12', '数据科学与大数据技术'),
('20180007', '王佳佳', '女', '2001-12-07', '数据科学与大数据技术');

CREATE TABLE `Course` (
  `Cno` CHAR(5) NOT NULL COMMENT '课程号',
  `Cname` VARCHAR(50) NOT NULL COMMENT '课程名',
  `Credit` INT NOT NULL COMMENT '学分',
  `Cpno` CHAR(5) DEFAULT NULL COMMENT '先修课',
  PRIMARY KEY (`Cno`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程表';

INSERT INTO `Course` (`Cno`, `Cname`, `Credit`, `Cpno`) VALUES
('81001', '程序设计基础与C语言', 4, NULL),
('81007', '离散数学', 4, NULL);

INSERT INTO `Course` (`Cno`, `Cname`, `Credit`, `Cpno`) VALUES
('81002', '数据结构', 4, '81001'),
('81005', '操作系统', 4, '81001'),
('81003', '数据库系统概论', 4, '81002'),
('81006', 'Python语言', 3, '81002'),
('81004', '信息系统概论', 4, '81003'),
('81008', '大数据技术概论', 4, '81003');


CREATE TABLE `SC` (
  `Sno` CHAR(8) NOT NULL COMMENT '学号',
  `Cno` CHAR(5) NOT NULL COMMENT '课程号',
  `Grade` INT DEFAULT NULL COMMENT '成绩',
  `Semester` CHAR(5) NOT NULL COMMENT '开课学期',
  `Teachingclass` VARCHAR(10) NOT NULL COMMENT '教学班',
  PRIMARY KEY (`Sno`, `Cno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生选课表';

INSERT INTO `SC` (`Sno`, `Cno`, `Grade`, `Semester`, `Teachingclass`) VALUES
('20180001', '81001', 85, '20192', '81001-01'),
('20180001', '81002', 96, '20201', '81002-01'),
('20180001', '81003', 87, '20202', '81003-01'),
('20180002', '81001', 80, '20192', '81001-02'),
('20180002', '81002', 98, '20201', '81002-01'),
('20180002', '81003', 71, '20202', '81003-02'),
('20180003', '81001', 81, '20192', '81001-01'),
('20180003', '81002', 76, '20201', '81002-02'),
('20180004', '81001', 56, '20192', '81001-02'),
('20180004', '81002', 97, '20201', '81002-02'),
('20180005', '81003', 68, '20202', '81003-01');

USE `S-C-SC`;

ALTER TABLE `Course`
  ADD CONSTRAINT `fk_course_cpno`
  FOREIGN KEY (`Cpno`) REFERENCES `Course` (`Cno`)
  ON UPDATE CASCADE
  ON DELETE SET NULL;

ALTER TABLE `SC`
  ADD CONSTRAINT `fk_sc_student`
  FOREIGN KEY (`Sno`) REFERENCES `Student` (`Sno`)
  ON UPDATE CASCADE
  ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_sc_course`
  FOREIGN KEY (`Cno`) REFERENCES `Course` (`Cno`)
  ON UPDATE CASCADE
  ON DELETE RESTRICT;
  
SHOW CREATE TABLE `Course`;
SHOW CREATE TABLE `SC`;
SHOW CREATE TABLE `Student`;

SELECT Sno,Sname FROM Student;

SELECT Sname,Sno,Smajor FROM Student;

SELECT * FROM Student;

SELECT Sname,(extract(year from current_date)-extract(year from Sbirthdate))"年龄"
FROM Student;

SELECT Sname,'Date of Birth:',Sbirthdate, Smajor FROM Student;

SELECT DISTINCT Sno
FROM SC;


SELECT Sname FROM Student WHERE Smajor = '计算机科学与技术';

SELECT Sname,Ssex
FROM Student
WHERE extract( year from Sbirthdate) >= 2000;

SELECT DISTINCT Sno
FROM SC
WHERE Grade<60;

SELECT Sname,Sbirthdate,Smajor
FROM Student
WHERE extract(year from current_date) - extract( year from Sbirthdate) 
BETWEEN 20 AND 23;

SELECT Sname,Sbirthdate,Smajor
FROM Student
WHERE extract( year from current_date) - extract( year from Sbirthdate)
NOT BETWEEN 20 AND 23;

SELECT Sname,Ssex
FROM Student
WHERE Smajor IN ('计算机科学与技术','信息安全');

SELECT Sname,Ssex
FROM Student
WHERE Smajor NOT IN ('计算机科学与技术','信息安全');

SELECT *
FROM Student
WHERE Sno LIKE '20180003';

SELECT Sname,Sno,Ssex
FROM Student
WHERE Sname LIKE '刘%';

SELECT Sno,Sname
FROM Student
WHERE Sno LIKE '2018%';

SELECT Cname,Cno
FROM Course
WHERE Cno LIKE '81__6';

SELECT Sname,Sno,Ssex
FROM Student
WHERE Sname NOT LIKE '刘%';

INSERT INTO `Course` (`Cno`, `Cname`, `Credit`, `Cpno`)
VALUES ('81009', 'DB_Design', 4, '81003');

SELECT Cno, Credit
FROM Course
WHERE Cname LIKE 'DB\_Design' ESCAPE '\\' ;

SELECT *
FROM Course
WHERE Cname LIKE 'DB\_%i__' ESCAPE '\\' ;

SELECT Sno, Cno
FROM SC
WHERE Grade IS NULL;

SELECT Sno, Cno
FROM SC
WHERE Grade IS NOT NULL;

SELECT Sno,Sname,Ssex
FROM Student
WHERE Smajor='计算机科学与技术' AND extract(year from Sbirthdate)>=2000;

SELECT Sno, Grade
FROM SC
WHERE Cno='81003'
ORDER BY Grade DESC;

SELECT *
FROM SC
ORDER BY Cno,Grade DESC;

SELECT COUNT(*)
FROM Student;

SELECT COUNT(DISTINCT Sno)
FROM SC;

SELECT AVG( Grade)
FROM SC
WHERE Cno='81001';

SELECT MAX( Grade)
FROM SC
WHERE Cno='81001';

SELECT SUM(Credit)
FROM SC, Course
WHERE Sno='20180003' AND SC.Cno=Course.Cno;

SELECT Cno, COUNT(Sno)
FROM SC
GROUP BY Cno;

SELECT Sno
FROM SC
WHERE Semester='20192'
GROUP BY Sno
HAVING COUNT(*)>10;

SELECT Sno,AVG(Grade)
FROM SC
GROUP BY Sno
HAVING AVG(Grade) >= 90;

SELECT Sno
FROM SC,Course
WHERE Course.Cname='数据库系统概论' AND SC.Cno=Course.Cno
ORDER BY Grade DESC
LIMIT 10;

SELECT Sno,AVG(Grade)
FROM SC
GROUP BY Sno
ORDER BY AVG(Grade) DESC
LIMIT 5 OFFSET 2;

SELECT Student.*, SC.*
FROM Student,SC
WHERE Student.Sno=SC.Sno;

SELECT Student.Sno,Sname,Ssex,Sbirthdate, Smajor, Cno, Grade
FROM Student,SC
WHERE Student.Sno= SC.Sno;

SELECT Student.Sno, Sname
FROM Student,SC
WHERE Student. Sno=SC. Sno AND
SC. Cno='81002' AND SC. Grade>90;

SELECT FIRST. Cno,SECOND. Cpno
FROM Course FIRST,Course SECOND
WHERE FIRST. Cpno=SECOND. Cno and SECOND. Cpno IS NOT NULL;

SELECT Student. Sno,Sname,Ssex,Sbirthdate,Smajor,Cno,Grade
FROM Student LEFT OUTER JOIN SC ON (Student. Sno=SC. Sno);

SELECT Student. Sno, Sname, Cname, Grade
FROM Student,SC, Course
WHERE Student. Sno=SC. Sno AND SC. Cno= Course. Cno;

SELECT Sno,Sname, Smajor
FROM Student
WHERE Smajor IN
	(SELECT Smajor
	 FROM Student
	 WHERE Sname='刘晨');


SELECT Student. Sno, Sname
FROM Student, SC, Course
WHERE Student. Sno=SC. Sno AND
SC. Cno= Course. Cno AND
Course.Cname='信息系统概论';

SELECT Sno,Cno
FROM SC x
WHERE Grade >=(SELECT AVG(Grade)
		FROM SC y
		WHERE y. Sno=x. Sno);

SELECT Sname, Sbirthdate,Smajor
FROM Student
WHERE Sbirthdate>ANY (SELECT Sbirthdate
                  FROM Student
                  WHERE Smajor='计算机科学与技术')
AND Smajor <> '计算机科学与技术';

SELECT Sname,Sbirthdate
FROM Student
	WHERE Sbirthdate > ALL
		(SELECT Sbirthdate
		 FROM Student
		 WHERE Smajor='计算机科学与技术')
	AND Smajor <> '计算机科学与技术';

SELECT Sname
FROM Student
WHERE EXISTS
	(SELECT *
	 FROM SC
	 WHERE Sno=Student. Sno AND Cno='81001');
     
SELECT Sname
FROM Student
WHERE NOT EXISTS
     (SELECT *
      FROM SC
      WHERE Sno=Student. Sno AND Cno='81001');
      
SELECT Sname
FROM Student
WHERE NOT EXISTS
	(SELECT *
	 FROM Course
	 WHERE NOT EXISTS
		(SELECT*
		 FROM SC
		 WHERE Sno= Student. Sno AND Cno= Course. Cno)) ;
         
SELECT Sno
FROM Student
WHERE NOT EXISTS
   (SELECT *
    FROM SC SCX
    WHERE SCX. Sno='20180002' AND
       NOT EXISTS
       (SELECT *
        FROM SC SCY
        WHERE SCY.Sno=Student.Sno AND
              SCY. Cno= SCX. Cno)) ;

SELECT *
FROM Student
WHERE Smajor='计算机科学与技术'
UNION
SELECT * FROM Student
WHERE (extract(year from current_date) - extract( year from Sbirthdate)) <=19;

SELECT Sno
FROM SC
WHERE Semester = '20202' AND Cno = '81001' 
UNION SELECT Sno
FROM SC
WHERE Semester = '20202' AND Cno = '81002';

SELECT Sno
FROM SC
WHERE Cno='81001' AND Sno IN
	(SELECT Sno
	 FROM SC
	 WHERE Cno='81002');
     
SELECT *
FROM Student
WHERE Smajor='计算机科学与技术' AND
      (extract(year from current_date)-extract( year from Sbirthdate) )>19;







































