USE DATABASES_PROJECT

-- run DROP TABLE without conditional logic
DROP TABLE IF EXISTS TAXI
DROP TABLE IF EXISTS DRIVER
DROP TABLE IF EXISTS JOURNEY
DROP TABLE IF EXISTS COMPANY
DROP TABLE IF EXISTS CUSTOMER

-- Create first layer of tables - no dependencies
CREATE TABLE COMPANY (
	Company_Id        numeric (7) identity (1, 1),
	Company_Name      varchar(25) PRIMARY KEY,
	Company_Address   varchar(100),
	Company_ContactNo	varchar(15)
);

CREATE TABLE TAXI (
	Taxi_No          numeric(7)  identity(1,1)  PRIMARY KEY,
	Taxi_Make		varchar(20),
	Taxi_Model 	     varchar(20),
	Last_Inspection  DATE  ,
	Seat_Count        numeric(9) 
);

CREATE TABLE DRIVER (
	Employee_No       numeric(12)  identity(1,1) PRIMARY KEY,
	Employee_Name     varchar(40) not null,
	Employee_Phone  varchar(10)  ,
	Hire_Date			DATE,  
	Licence_Last_Renewed DATE
);

-- Create second layer of tables - dependent on the first layer

CREATE TABLE CUSTOMER (
	Customer_Id        numeric(7)  identity(1,1) PRIMARY KEY ,
	Customer_Name	   varchar(25) ,
	Employer_Name	   varchar(25) REFERENCES COMPANY NOT NULL,
	Phone_no		   varchar(15)
	
);

CREATE TABLE JOURNEY (
	Employee_No       numeric(12)  REFERENCES DRIVER not null ,
	Journey_No		  numeric(7) identity (1,1) PRIMARY KEY ,
	Customer_Id       numeric(7) REFERENCES CUSTOMER not null ,
	Origin            varchar(40) not null,
	Destination       varchar(40) not null,
	Taxi_No           numeric(7) REFERENCES TAXI not null,
	Time_Date			smalldatetime, 
	Fare              smallmoney,
);




--Enter in data 


INSERT INTO COMPANY VALUES ( 'Google' , 'Gordon House, Barrow Street, Dublin 4, Dublin, D04e5w5, Ireland' , '015749392');
INSERT INTO COMPANY VALUES (  'Facebook', '4 Grand Canal Square, Grand Canal Harbour, Dublin 2, Dublin, D02x525, Ireland', '047489928');
INSERT INTO COMPANY VALUES ( 'Cisco' , 'Alfie Byrne Rd, North Dock, Dublin' , '028746732');
INSERT INTO COMPANY VALUES ('SquareSpace' , 'Squarespace House, Ship Street Great, Dublin 8' , '028934751')


SELECT * FROM COMPANY;


INSERT INTO CUSTOMER VALUES ('John O Sullivan', 'Google' , '0874324591');
INSERT INTO CUSTOMER VALUES ('Conor McFadden ', 'Facebook', '0863940281');
INSERT INTO CUSTOMER VALUES ('Jimmy Tide' , 'Facebook' , '0878387291' );
INSERT INTO CUSTOMER VALUES ('Steven Johnson' , 'Google' , '0876354182');
INSERT INTO CUSTOMER VALUES ('Ben Stewart' , 'Cisco' , '0870287291' );
INSERT INTO CUSTOMER VALUES ('Anthony Woodworth' , 'Cisco' , '0864182264');
INSERT INTO CUSTOMER VALUES('Eleanor McFadden' , 'SquareSpace' , '0876381232');

SELECT * FROM CUSTOMER;

INSERT INTO TAXI VALUES('Honda' , 'i40' , '2020/06/26' , '5');
INSERT INTO TAXI VALUES('Honda' , 'Civic' , '2019/04/8' , '5');
INSERT INTO TAXI VALUES('Mercedes' , 'C-Class' , '2017/04/3' , '5');
INSERT INTO TAXI VALUES('Mercedes' , 'V-Class' , '2020/11/2' , '8');

SELECT * FROM TAXI

INSERT INTO DRIVER VALUES('Phil Marryland' , '0864368372' , '2018/01/02' , '2017/04/12');
INSERT INTO DRIVER VALUES('Tony McCarthy' , '0865468372' , '2020/11/21' , '2016/11/3');
INSERT INTO DRIVER VALUES('Max Croft' , '0864368372' , '2018/01/02' , '2017/04/12');
INSERT INTO DRIVER VALUES('Estaban OSullivan' , '0873234701' , '2021/6/22' , '2020/03/07');

SELECT * FROM DRIVER

INSERT INTO JOURNEY VALUES('1' ,'1' , 'Grafton St' , 'Grangegorman' , '4' , '2022/02/12 13:33:00' , '12.92');
INSERT INTO JOURNEY VALUES('2' , '2' , 'Tallaght' , 'Terenure' , '3' , '2022/03/13 15:00:00' , '18.43');
INSERT INTO JOURNEY VALUES('1' , '1' , 'Grangegorman' , 'Grafton St' , '4' , '2022/02/12 18:00:00' , '16.21');
INSERT INTO JOURNEY VALUES('3' , '4' , 'Marley Park' , 'Stephens Green' , '1' , '2022/05/02' , null);
INSERT INTO JOURNEY VALUES('3' , '6' , '3 Arena' , 'Drumcondra' , '2' , '2022/02/01 18:00:00' , null);
INSERT INTO JOURNEY VALUES('2' , '5' , 'Bolton St' , 'Dundrum' , '2' , '2022/02/13' , null);


SELECT * FROM JOURNEY


