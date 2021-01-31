    /* Create a specific type to be used while creating tables later */
	
	CREATE TYPE gender AS ENUM('M', 'F');
	
	/* Create a Employees Table */
	
	CREATE TABLE employees (
	    emp_no      INT             NOT NULL,
	    birth_date  DATE            NOT NULL,
	    first_name  VARCHAR(14)     NOT NULL,
	    last_name   VARCHAR(16)     NOT NULL,
	    gender      gender 		NULL,
		address     VARCHAR(30)     NOT NULL,
		contact     VARCHAR(30)     NOT NULL,
	    hire_date   DATE            NOT NULL,
	    PRIMARY KEY (emp_no)
	);
	
	/* Create a Departments Table */
	
	CREATE TABLE departments (
	    dept_no     CHAR(4)         NOT NULL,
	    dept_name   VARCHAR(40)     NOT NULL,
	    PRIMARY KEY (dept_no),
	    UNIQUE   	(dept_name)
	);
	
	/* Create Indexes for Departments Table */
	
	CREATE INDEX departments_dept_no_idx ON departments(dept_no);
	
	/* Create a Department's Manager Table */
	
	CREATE TABLE dept_manager (
	   dept_no      CHAR(4)         NOT NULL,
	   emp_no       INT             NOT NULL,
	   from_date    DATE            NOT NULL,
	   to_date      DATE            NOT NULL,
	   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no)    ON DELETE CASCADE,
	   FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
	   PRIMARY KEY (emp_no,dept_no)
	); 
	
	/* Create Indexes for Department's Manager Table */
	
	CREATE INDEX dept_manager_dept_no_idx ON dept_manager(dept_no);
	CREATE INDEX dept_manager_emp_no_idx ON dept_manager(emp_no);
	
	/* Create Department's Employees Table */
		
	CREATE TABLE dept_emp (
	    emp_no      INT             NOT NULL,
	    dept_no     CHAR(4)         NOT NULL,
	    from_date   DATE            NOT NULL,
	    to_date     DATE            NOT NULL,
	    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no)  ON DELETE CASCADE,
	    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
	    PRIMARY KEY (emp_no,dept_no)
	);

	/* Create Indexes for Department's Employees Table */
	
	CREATE INDEX dept_emp_dept_no_idx ON dept_emp(dept_no);
	CREATE INDEX dept_emp_emp_no_idx ON dept_emp(emp_no);
	
	/* Create Titles Table */
	
	CREATE TABLE titles (
	    emp_no      INT             NOT NULL,
	    title       VARCHAR(50)     NOT NULL,
	    from_date   DATE            NOT NULL,
	    to_date     DATE,
	    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
	    PRIMARY KEY (emp_no,title, from_date)
	); 
	
	/* Create Indexes for Titles Table */
	
	CREATE INDEX titles_emp_no_idx ON titles(emp_no);
	CREATE INDEX titles_title_idx ON titles(title);
	
	/* Create Title Description Table */
	
	CREATE TABLE titles_description (
		title 				INT 		NOT NULL,
	    title_description	VARCHAR		NOT NULL,
		PRIMARY KEY (title)
	);
	
	/* Create Indexes for Title Description Table */
	
	CREATE INDEX titles_description_title_idx ON titles_description(title);
	
	/* Create Salary Table */	
	
	CREATE TABLE salaries (
	    emp_no      INT             NOT NULL,
	    salary      INT             NOT NULL,
	    from_date   DATE            NOT NULL,
	    to_date     DATE            NOT NULL,
	    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
	    PRIMARY KEY (emp_no, from_date)
	);

	/* Create Indexes for Salary Table */	
	
	CREATE INDEX salaries_emp_no_idx ON salaries(emp_no);
	
	/* Create Appraisal Table */
	
	CREATE TABLE appraisal (
		appraisal_id	INT			NOT NULL,
	    objective 		VARCHAR		NOT NULL,
		year 			INT			NOT NULL,
		dept_no     	CHAR(4)     NOT NULL,
		emp_no		    INT			NOT NULL,
	    rating			INT			NOT NULL,
		FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
		FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
		PRIMARY KEY (emp_no,dept_no,appraisal_id)
	);
	
	/* Create Objective Table */
	
	CREATE TABLE objective (
		objective 				VARCHAR		NOT NULL,
	    objective_description 	VARCHAR		NOT NULL,
		PRIMARY KEY (objective)
	);
	
	/* Create Indexes for Objective Table */
	
	CREATE INDEX objective_objective_idx ON objective(objective);
	
	/* Create Rating Table */
		
	CREATE TABLE rating (
		rating 				INT			NOT NULL,
	    rating_description 	VARCHAR		NOT NULL,
		PRIMARY KEY (rating)
	);
	
	/* Create Indexes for Rating Table */
		
	CREATE INDEX rating_rating_idx ON rating(rating);
	
	/* Alter Appraisal Table */
	
	ALTER Table appraisal
		ADD FOREIGN KEY (objective) REFERENCES objective (objective) ON DELETE CASCADE,
		ADD FOREIGN KEY (rating) REFERENCES rating (rating) ON DELETE CASCADE;
	
	CREATE INDEX appraisal_emp_no_idx ON appraisal(emp_no);
	CREATE INDEX appraisal_dept_no_idx ON appraisal(dept_no);
	CREATE INDEX appraisal_appraisal_id_idx ON appraisal(appraisal_id);
	CREATE INDEX appraisal_objective_idx ON appraisal(objective);
	CREATE INDEX appraisal_rating_idx ON appraisal(rating);
	
	/* Load data into employees table */
	
	INSERT INTO employees VALUES
	(10001,'1953-09-02','Georgi','Facello','M','Singapore','+6591544890','1986-06-26'),
	(10002,'1964-06-02','Bezalel','Simmel','F','Singapore','+6591544891','1985-11-21'),
	(10003,'1959-12-03','Parto','Bamford','M','Singapore','+6591544892','1986-08-28'),
	(10004,'1954-05-01','Chirstian','Koblick','M','Singapore','+6591544893','1986-12-01'),
	(10005,'1955-01-21','Kyoichi','Maliniak','M','Singapore','+6591544894','1989-09-12'),
	(10006,'1953-04-20','Anneke','Preusig','F','Singapore','+6591544895','1989-06-02'),
	(10007,'1957-05-23','Tzvetan','Zielinski','F','Singapore','+6591544896','1989-02-10'),
	(10008,'1958-02-19','Saniya','Kalloufi','M','Singapore','+6591544897','1994-09-15'),
	(10009,'1952-04-19','Sumant','Peac','F','Singapore','+6591544898','1985-02-18'),
	(10010,'1963-06-01','Duangkaew','Piveteau','F','Singapore','+6591544899','1989-08-24'),
	(10011,'1953-11-07','Mary','Sluis','F','Singapore','+6591544900','1990-01-22'),
	(10012,'1960-10-04','Patricio','Bridgland','M','Singapore','+6591544901','1992-12-18'),
	(10013,'1963-06-07','Eberhardt','Terkki','M','Singapore','+6591544902','1985-10-20'),
	(10014,'1956-02-12','Berni','Genin','M','Singapore','+6591544903','1987-03-11'),
	(10015,'1959-08-19','Guoxiang','Nooteboom','M','Singapore','+6591544904','1987-07-02'),
	(10016,'1961-05-02','Kazuhito','Cappelletti','M','Singapore','+6591544905','1995-01-27'),
	(10017,'1958-07-06','Cristinel','Bouloucos','F','Singapore','+6591544906','1993-08-03'),
	(10018,'1954-06-19','Kazuhide','Peha','F','Singapore','+6591544907','1987-04-03'),
	(10019,'1953-01-23','Lillian','Haddadi','M','Singapore','+6591544908','1999-04-30'),
	(10020,'1952-12-24','Mayuko','Warwick','M','Singapore','+6591544909','1991-01-26'),
	(10021,'1960-02-20','Ramzi','Erde','M','Singapore','+6591544910','1988-02-10'),
	(10022,'1952-07-08','Shahaf','Famili','M','Singapore','+6591544911','1995-08-22'),
	(10023,'1953-09-29','Bojan','Montemayor','F','Singapore','+6591544912','1989-12-17'),
	(10024,'1958-09-05','Suzette','Pettey','F','Singapore','+6591544913','1997-05-19'),
	(10025,'1958-10-31','Prasadram','Heyers','M','Singapore','+6591544914','1987-08-17'),
	(10026,'1953-04-03','Yongqiao','Berztiss','M','Singapore','+6591544915','1995-03-20'),
	(10027,'1962-07-10','Divier','Reistad','F','Singapore','+6591544916','1989-07-07'),
	(10028,'1963-11-26','Domenick','Tempesti','M','Singapore','+6591544917','1991-10-22'),
	(10029,'1956-12-13','Otmar','Herbst','M','Singapore','+6591544918','1985-11-20'),
	(10030,'1958-07-14','Elvis','Demeyer','M','Singapore','+6591544919','1994-02-17'),
	(10031,'1959-01-27','Karsten','Joslin','M','Singapore','+6591544920','1991-09-01'),
	(10032,'1960-08-09','Jeong','Reistad','F','Singapore','+6591544921','1990-06-20'),
	(10033,'1956-11-14','Arif','Merlo','M','Singapore','+6591544922','1987-03-18'),
	(10034,'1962-12-29','Bader','Swan','M','Singapore','+6591544923','1988-09-21'),
	(10035,'1953-02-08','Alain','Chappelet','M','Singapore','+6591544924','1988-09-05'),
	(10036,'1959-08-10','Adamantios','Portugali','M','Singapore','+6591544925','1992-01-03'),
	(10037,'1963-07-22','Pradeep','Makrucki','M','Singapore','+6591544926','1990-12-05'),
	(10038,'1960-07-20','Huan','Lortz','M','Singapore','+6591544927','1989-09-20'),
	(10039,'1959-10-01','Alejandro','Brender','M','Singapore','+6591544928','1988-01-19'),
	(10040,'1959-09-13','Weiyi','Meriste','F','Singapore','+6591544929','1993-02-14');
	
	
	/* Load data into departments table */
	
	INSERT INTO departments VALUES ('d001','Marketing'),
	('d002','Finance'),
	('d003','Human Resources'),
	('d004','Production'),
	('d005','Development'),
	('d006','Quality Management'),
	('d007','Sales'),
	('d008','Research'),
	('d009','Customer Service');
	
	
	/* Load data into dept_manager table */
		
	INSERT INTO dept_manager VALUES
	('d001',10005,'2000-01-01','9999-01-01'),
	('d002',10010,'2000-01-01','9999-01-01'),
	('d003',10015,'2000-01-01','9999-01-01'),
	('d004',10020,'2000-03-21','9999-01-01'),
	('d005',10025,'2000-01-01','9999-01-01'),
	('d006',10030,'2000-09-09','9999-01-01'),
	('d007',10022,'2000-08-02','9999-01-01'),
	('d008',10032,'2000-08-30','9999-01-01'),
	('d009',10007,'2000-01-01','9999-01-01');
	
	/* Load data into dept_emp table */
	
	INSERT INTO dept_emp VALUES
	(10001,'d005','1986-06-26','9999-01-01'),
	(10002,'d002','1996-08-03','9999-01-01'),
	(10003,'d004','1995-12-03','9999-01-01'),
	(10004,'d004','1986-12-01','9999-01-01'),
	(10005,'d001','1989-09-12','9999-01-01'),
	(10006,'d005','1990-08-05','9999-01-01'),
	(10007,'d009','1989-02-10','9999-01-01'),
	(10008,'d005','1998-03-11','9999-01-01'),
	(10009,'d006','1985-02-18','9999-01-01'),
	(10010,'d002','2000-06-26','9999-01-01'),
	(10011,'d009','1990-01-22','9999-01-01'),
	(10012,'d005','1992-12-18','9999-01-01'),
	(10013,'d003','1985-10-20','9999-01-01'),
	(10014,'d005','1993-12-29','9999-01-01'),
	(10015,'d003','1992-09-19','9999-01-01'),
	(10016,'d007','1998-02-11','9999-01-01'),
	(10017,'d001','1993-08-03','9999-01-01'),
	(10018,'d004','1992-07-29','9999-01-01'),
	(10019,'d008','1999-04-30','9999-01-01'),
	(10020,'d004','1997-12-30','9999-01-01'),
	(10021,'d005','1988-02-10','9999-01-01'),
	(10022,'d007','1999-09-03','9999-01-01'),
	(10023,'d005','1999-09-27','9999-01-01'),
	(10024,'d004','1998-06-14','9999-01-01'),
	(10025,'d005','1987-08-17','9999-01-01'),
	(10026,'d004','1995-03-20','9999-01-01'),
	(10027,'d005','1995-04-02','9999-01-01'),
	(10028,'d002','1991-10-22','9999-01-01'),
	(10029,'d006','1999-07-08','9999-01-01'),
	(10030,'d006','1994-02-17','9999-01-01'),
	(10031,'d008','1991-09-01','9999-01-01'),
	(10032,'d008','1990-06-20','9999-01-01'),
	(10033,'d006','1987-03-18','9999-01-01'),
	(10034,'d007','1995-04-12','9999-01-01'),
	(10035,'d004','1988-09-05','9999-01-01'),
	(10036,'d003','1992-04-28','9999-01-01'),
	(10037,'d005','1990-12-05','9999-01-01'),
	(10038,'d009','1989-09-20','9999-01-01'),
	(10039,'d003','1988-01-19','9999-01-01'),
	(10040,'d001','2002-01-22','9999-01-01');
	
	/* Load data into titles_description table */
	
	INSERT INTO titles_description VALUES
	(1,'Staff'),
	(2,'Senior Staff'),
	(3,'Assistant Engineer'),
	(4,'Engineer'),
	(5,'Senior Engineer'),
	(6,'Suprevisor'),
	(7,'Manager'),
	(8,'Senior Manager'),
	(9,'Director'),
	(10,'Senior Director'),
	(11,'Managing Director');
	
	/* Load data into titles table */
	
	INSERT INTO titles VALUES
	(10001,2,'1986-06-26','9999-01-01'),
	(10002,2,'1996-08-03','9999-01-01'),
	(10003,2,'1995-12-03','9999-01-01'),
	(10004,2,'1986-12-01','9999-01-01'),
	(10005,9,'1989-09-12','9999-01-01'),
	(10006,2,'1990-08-05','9999-01-01'),
	(10007,9,'1989-02-10','9999-01-01'),
	(10008,2,'1998-03-11','9999-01-01'),
	(10009,2,'1985-02-18','9999-01-01'),
	(10010,10,'2000-06-26','9999-01-01'),
	(10011,2,'1990-01-22','9999-01-01'),
	(10012,2,'1992-12-18','9999-01-01'),
	(10013,2,'1985-10-20','9999-01-01'),
	(10014,2,'1993-12-29','9999-01-01'),
	(10015,11,'1992-09-19','9999-01-01'),
	(10016,2,'1998-02-11','9999-01-01'),
	(10017,2,'1993-08-03','9999-01-01'),
	(10018,2,'1992-07-29','9999-01-01'),
	(10019,2,'1999-04-30','9999-01-01'),
	(10020,9,'1997-12-30','9999-01-01'),
	(10021,2,'1988-02-10','9999-01-01'),
	(10022,9,'1999-09-03','9999-01-01'),
	(10023,2,'1999-09-27','9999-01-01'),
	(10024,2,'1998-06-14','9999-01-01'),
	(10025,9,'1987-08-17','9999-01-01'),
	(10026,2,'1995-03-20','9999-01-01'),
	(10027,2,'1995-04-02','9999-01-01'),
	(10028,2,'1991-10-22','9999-01-01'),
	(10029,2,'1999-07-08','9999-01-01'),
	(10030,9,'1994-02-17','9999-01-01'),
	(10031,2,'1991-09-01','9999-01-01'),
	(10032,9,'1990-06-20','9999-01-01'),
	(10033,2,'1987-03-18','9999-01-01'),
	(10034,2,'1995-04-12','9999-01-01'),
	(10035,2,'1988-09-05','9999-01-01'),
	(10036,2,'1992-04-28','9999-01-01'),
	(10037,2,'1990-12-05','9999-01-01'),
	(10038,2,'1989-09-20','9999-01-01'),
	(10039,2,'1988-01-19','9999-01-01'),
	(10040,2,'2002-01-22','9999-01-01');
	
	
	/* Load data into Salaries table */
	
	INSERT INTO salaries VALUES
	(10001,8000,'1986-06-26','9999-01-01'),
	(10002,8000,'1996-08-03','9999-01-01'),
	(10003,8000,'1995-12-03','9999-01-01'),
	(10004,8000,'1986-12-01','9999-01-01'),
	(10005,8000,'1989-09-12','9999-01-01'),
	(10006,8000,'1990-08-05','9999-01-01'),
	(10007,8000,'1989-02-10','9999-01-01'),
	(10008,8000,'1998-03-11','9999-01-01'),
	(10009,8000,'1985-02-18','9999-01-01'),
	(10010,8000,'2000-06-26','9999-01-01'),
	(10011,8000,'1990-01-22','9999-01-01'),
	(10012,8000,'1992-12-18','9999-01-01'),
	(10013,8000,'1985-10-20','9999-01-01'),
	(10014,8000,'1993-12-29','9999-01-01'),
	(10015,8000,'1992-09-19','9999-01-01'),
	(10016,8000,'1998-02-11','9999-01-01'),
	(10017,8000,'1993-08-03','9999-01-01'),
	(10018,8000,'1992-07-29','9999-01-01'),
	(10019,8000,'1999-04-30','9999-01-01'),
	(10020,8000,'1997-12-30','9999-01-01'),
	(10021,8000,'1988-02-10','9999-01-01'),
	(10022,8000,'1999-09-03','9999-01-01'),
	(10023,8000,'1999-09-27','9999-01-01'),
	(10024,8000,'1998-06-14','9999-01-01'),
	(10025,8000,'1987-08-17','9999-01-01'),
	(10026,8000,'1995-03-20','9999-01-01'),
	(10027,8000,'1995-04-02','9999-01-01'),
	(10028,8000,'1991-10-22','9999-01-01'),
	(10029,8000,'1999-07-08','9999-01-01'),
	(10030,8000,'1994-02-17','9999-01-01'),
	(10031,8000,'1991-09-01','9999-01-01'),
	(10032,8000,'1990-06-20','9999-01-01'),
	(10033,8000,'1987-03-18','9999-01-01'),
	(10034,8000,'1995-04-12','9999-01-01'),
	(10035,8000,'1988-09-05','9999-01-01'),
	(10036,8000,'1992-04-28','9999-01-01'),
	(10037,8000,'1990-12-05','9999-01-01'),
	(10038,8000,'1989-09-20','9999-01-01'),
	(10039,8000,'1988-01-19','9999-01-01'),
	(10040,8000,'2002-01-22','9999-01-01');
	
	
	/* Load data into Salaries table */
	
	INSERT INTO rating VALUES
	(1,'Excellent'),
	(2,'Very Good'),
	(3,'Good'),
	(4,'Average'),
	(5,'Below Average');
	
	
	/* Load data into Objective table */
	
	INSERT INTO objective VALUES
	(1,'Exceed All Expectation'),
	(2,'Exceed Most Expectation'),
	(3,'Met all Expectation'),
	(4,'Met most Expectation'),
	(5,'Did not meet certain Expectation');
	
	
	/* Load data into appraisal table */
	
	INSERT INTO appraisal VALUES
	(1,1,2020,'d005',10001,1),
	(2,2,2020,'d002',10002,2),
	(3,3,2020,'d004',10003,3),
	(4,1,2020,'d004',10004,1),
	(5,2,2020,'d001',10005,2),
	(6,3,2020,'d005',10006,3),
	(7,1,2020,'d009',10007,1),
	(8,2,2020,'d005',10008,2),
	(9,3,2020,'d006',10009,3),
	(10,1,2020,'d002',10010,1),
	(11,2,2020,'d009',10011,2),
	(12,3,2020,'d005',10012,3),
	(13,1,2020,'d003',10013,1),
	(14,2,2020,'d005',10014,2),
	(15,3,2020,'d003',10015,3),
	(16,1,2020,'d007',10016,1),
	(17,2,2020,'d001',10017,2),
	(18,3,2020,'d004',10018,3),
	(20,2,2020,'d004',10020,2),
	(21,3,2020,'d005',10021,3),
	(22,1,2020,'d007',10022,1),
	(19,1,2020,'d008',10019,1),
	(23,2,2020,'d005',10023,2),
	(24,3,2020,'d004',10024,3),
	(25,1,2020,'d005',10025,1),
	(26,2,2020,'d004',10026,2),
	(27,3,2020,'d005',10027,3),
	(28,1,2020,'d002',10028,1),
	(29,2,2020,'d006',10029,2),
	(30,3,2020,'d006',10030,3),
	(31,1,2020,'d008',10031,1),
	(32,2,2020,'d008',10032,2),
	(33,3,2020,'d006',10033,3),
	(34,1,2020,'d007',10034,1),
	(35,2,2020,'d004',10035,2),
	(36,3,2020,'d003',10036,3),
	(37,1,2020,'d005',10037,1),
	(38,2,2020,'d009',10038,2),
	(39,3,2020,'d003',10039,3),
	(40,2,2020,'d001',10040,2);