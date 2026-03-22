CREATE DATABASE `SPJ`;
USE `SPJ`;

-- 供应商表
CREATE TABLE `S` (
  `SNO` CHAR(2) NOT NULL,
  `SNAME` VARCHAR(20) NOT NULL,
  `STATUS` INT NOT NULL,
  `CITY` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`SNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 零件表
CREATE TABLE `P` (
  `PNO` CHAR(2) NOT NULL,
  `PNAME` VARCHAR(20) NOT NULL,
  `COLOR` VARCHAR(10) NOT NULL,
  `WEIGHT` INT NOT NULL,
  PRIMARY KEY (`PNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 工程项目表
CREATE TABLE `J` (
  `JNO` CHAR(2) NOT NULL,
  `JNAME` VARCHAR(20) NOT NULL,
  `CITY` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`JNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 供应情况表
CREATE TABLE `SPJ` (
  `SNO` CHAR(2) NOT NULL,
  `PNO` CHAR(2) NOT NULL,
  `JNO` CHAR(2) NOT NULL,
  `QTY` INT NOT NULL,
  PRIMARY KEY (`SNO`, `PNO`, `JNO`),
  CONSTRAINT `fk_spj_s`
    FOREIGN KEY (`SNO`) REFERENCES `S`(`SNO`),
  CONSTRAINT `fk_spj_p`
    FOREIGN KEY (`PNO`) REFERENCES `P`(`PNO`),
  CONSTRAINT `fk_spj_j`
    FOREIGN KEY (`JNO`) REFERENCES `J`(`JNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `S` (`SNO`, `SNAME`, `STATUS`, `CITY`) VALUES
('S1', '精益',   20, '天津'),
('S2', '盛锡',   10, '北京'),
('S3', '东方红', 30, '北京'),
('S4', '丰泰盛', 20, '天津'),
('S5', '为民',   30, '上海');

INSERT INTO `P` (`PNO`, `PNAME`, `COLOR`, `WEIGHT`) VALUES
('P1', '螺母',   '红', 12),
('P2', '螺栓',   '绿', 17),
('P3', '螺丝刀', '蓝', 14),
('P4', '螺丝刀', '红', 14),
('P5', '凸轮',   '蓝', 40),
('P6', '齿轮',   '红', 30);

INSERT INTO `J` (`JNO`, `JNAME`, `CITY`) VALUES
('J1', '三建',     '北京'),
('J2', '一汽',     '长春'),
('J3', '弹簧厂',   '天津'),
('J4', '造船厂',   '天津'),
('J5', '机车厂',   '唐山'),
('J6', '无线电厂', '常州'),
('J7', '半导体厂', '南京');

INSERT INTO `SPJ` (`SNO`, `PNO`, `JNO`, `QTY`) VALUES
('S1', 'P1', 'J1', 200),
('S1', 'P1', 'J3', 100),
('S1', 'P1', 'J4', 700),
('S1', 'P2', 'J2', 100),
('S2', 'P3', 'J1', 400),
('S2', 'P3', 'J2', 200),
('S2', 'P3', 'J4', 500),
('S2', 'P3', 'J5', 400),
('S2', 'P5', 'J1', 400),
('S2', 'P5', 'J2', 100),
('S3', 'P1', 'J1', 200),
('S3', 'P3', 'J1', 200),
('S4', 'P5', 'J1', 100),
('S4', 'P6', 'J3', 300),
('S4', 'P6', 'J4', 200),
('S5', 'P2', 'J4', 100),
('S5', 'P3', 'J1', 200),
('S5', 'P6', 'J2', 200),
('S5', 'P6', 'J4', 500);


SELECT DISTINCT SNO
FROM SPJ
WHERE JNO = 'J1';

SELECT DISTINCT SNO
FROM SPJ
WHERE JNO = 'J1' AND PNO = 'P1';

SELECT DISTINCT SPJ.SNO
FROM SPJ
JOIN P ON SPJ.PNO = P.PNO
WHERE SPJ.JNO = 'J1'
  AND P.COLOR = '红';
  
SELECT J.JNO
FROM J
WHERE NOT EXISTS (
  SELECT 1
  FROM SPJ
  JOIN S ON SPJ.SNO = S.SNO
  JOIN P ON SPJ.PNO = P.PNO
  WHERE SPJ.JNO = J.JNO
    AND S.CITY = '天津'
    AND P.COLOR = '红'
);

SELECT DISTINCT X.JNO
FROM SPJ AS X
WHERE NOT EXISTS (
  SELECT 1
  FROM (
    SELECT DISTINCT PNO
    FROM SPJ
    WHERE SNO = 'S1'
  ) AS Y
  WHERE NOT EXISTS (
    SELECT 1
    FROM SPJ AS Z
    WHERE Z.JNO = X.JNO
      AND Z.PNO = Y.PNO
  )
);
