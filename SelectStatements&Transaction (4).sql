USE DATABASES_PROJECT;


--Select statement to return the diffrent types of companys registered with the taxi company 
SELECT Company_Name FROM COMPANY;


--Select statement to return all employee details from google that are Customers
SELECT  Customer_Name, Phone_no , Employer_Name  FROM CUSTOMER WHERE Employer_Name = 'Google';

--Select and count all the phone numbers we are holding in the DB
SELECT Phone_no FROM CUSTOMER
UNION 
SELECT Company_ContactNo FROM COMPANY
UNION 
SELECT Employee_Phone FROM DRIVER;

--Select all the Taxi Numbers that are assigned to a journey 
SELECT Taxi_No FROM JOURNEY
INTERSECT 
SELECT Journey_No FROM JOURNEY ;

--Select all the drivers EXCEPT the ones that are already assigned to a journey on the 12th of Feb
SELECT Employee_No FROM DRIVER
EXCEPT
SELECT Employee_No FROM Journey WHERE CAST(Time_Date AS date) = CONVERT(VARCHAR(10), '2022/02/12' , 111); 



--Select Companys Name , Address and Phone Number from COMPANY table and join it to Customer name from CUSTOMER table 
SELECT COMPANY.Company_Name , Company_Address , COMPANY.Company_ContactNo ,CUSTOMER.Customer_Name 
FROM COMPANY
INNER JOIN CUSTOMER ON COMPANY.Company_Name = CUSTOMER.Employer_Name;
use DATABASES_PROJECT;

--Select All Customers and Drivers and see if they have any journeys  
SELECT JOURNEY.Journey_No , CUSTOMER.Customer_Name , DRIVER.Employee_Name , JOURNEY.Origin, JOURNEY.Destination
FROM JOURNEY
FULL OUTER JOIN CUSTOMER ON CUSTOMER.Customer_Id = JOURNEY.Customer_Id
FULL OUTER JOIN DRIVER ON DRIVER.Employee_No = JOURNEY.Employee_No
ORDER BY Journey.Journey_No;

--Aggregation , Using Sum to count the fares collected by on the 2nd of Feb
SELECT SUM(Fare) FROM JOURNEY WHERE CAST(Time_Date AS date) = '2022/02/12';           

--Aggregation , Using Sum to count the fares collected by each driver
SELECT Employee_No ,
SUM(Fare) FROM JOURNEY  GROUP BY Employee_No;

--Update an existing customer record so a sick employee can be replaced by a new employee details for a journey, Both name and number must succeed or fail
--Transaction can be Rolledback when the sick employee returns
BEGIN TRAN T1
UPDATE CUSTOMER 
SET Customer_Name = 'Liam Sweeney'
WHERE Customer_Id =  4
UPDATE CUSTOMER 
SET Phone_no = '0879387261'
WHERE Customer_Id =  4
SAVE TRAN T1; ;

--Selection to check the Transaction is sucessful and check all details are correct
SELECT JOURNEY.Journey_No,  JOURNEY.Customer_Id , CUSTOMER.Customer_Id , CUSTOMER.Customer_Name FROM JOURNEY
LEFT JOIN CUSTOMER ON CUSTOMER.Customer_Id = JOURNEY.Customer_Id;




