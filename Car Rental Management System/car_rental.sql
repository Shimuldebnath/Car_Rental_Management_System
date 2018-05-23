-- Car rental agency management system

--delete these table if exists

drop table Reservation;
drop table Car;
drop table Customers;
drop table Chauffeur;
 
--creation nof table Customers

CREATE TABLE Customers
 (
CID varchar2(5) ,
FIRST_NAME varchar2(20),
LAST_NAME varchar2(15),
GENDER varchar2(10),
PHONENO   varchar2(20),
ADDRESS varchar2(30)
 );

alter table customers add constraint customersPKey
primary key(CID);

--end of customers table

--Creation of table Car

CREATE TABLE Car
 (
 VID varchar2(5) ,
MILEAGE NUMBER(7,2),
LOCATION varchar2(20),
COLOR varchar2(10),
VSIZE varchar2(30) CHECK (VSIZE IN('COMPACT','MID-SIZE','FULL-SIZE','PREMIUM','LUXURY'))
 );


alter table car add constraint carPKey
primary key(VID);

--end of customer table


--Creatioin of table Reservation


  CREATE TABLE Reservation
 (
 CID varchar2(5) ,
VID varchar2(5) ,
START_DATE DATE,
END_DATE DATE,
--CHARGE varchar2(10),
PRIMARY KEY(CID,VID)
 );
alter table reservation add constraint reservationPKey FOREIGN KEY(VID) references Car(VID);

alter table reservation add constraint reservationKey FOREIGN KEY(CID) references Customers(CID);

 alter table Reservation add charge varchar2(10);


--end of customer table


 --creation of table chauffer
create table chauffeur
	(
		ChauffeurId varchar2(10),
		name varchar2(20),
		GENDER varchar2(10),
		ADDRESS varchar2(20),
		status varchar2(10)
		);

alter table chauffeur add constraint chauffeurPKey
primary key(ChauffeurId);

alter table chauffeur modify  status varchar2(20);

--end of chauffeur table

---Triggering for checking minimum charge at Insertion and Update for reservation  TABLE
--SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER RESERVATIONcharge BEFORE INSERT OR UPDATE ON Reservation
FOR EACH ROW
DECLARE
	minCharge Reservation.Charge%type := 1000;
	
BEGIN
	IF :new.Charge<minCharge THEN
	 	RAISE_APPLICATION_ERROR(-20000,'Car Charge is too small');
	END IF;
END;
/



SET SERVEROUTPUT ON
BEGIN




--Insertion values in table Customers

 INSERT INTO Customers  VALUES ('101','MUKIMUZZAMAN','SHUVOM','MALE','01711111111','HARAGACHA,RANGPUR');

 INSERT INTO Customers  VALUES ('102','RAFI','SHAQUE','MALE','01722111222','DINAJPUR');

 INSERT INTO Customers  VALUES ('103','RAFI','RAHMAN','MALE','01833111333','BOGURA');

 INSERT INTO Customers  VALUES ('104','SONALI','AKTER','FEMALE','01955123456','DHAKA');

 INSERT INTO Customers  VALUES ('105','RAJIA','KHATUN','FEMALE','01756111999','DHAKA');

 INSERT INTO Customers  VALUES ('106','MOHAMMOD','KARIM','MALE','01555124456','KHULNA');

 INSERT INTO Customers  VALUES ('107','KALI','DAS','MALE','01955123123','RANGPUR');

 INSERT INTO Customers  VALUES ('108','RIYA','SHAFIQ','FEMALE','01855123456','DHAKA');



--Insertion values in table Car


 INSERT INTO Car (VID,MILEAGE,LOCATION,COLOR,VSIZE)  VALUES ('V-101','70','DHAKA','GREEN','COMPACT');

 INSERT INTO Car (VID,MILEAGE,LOCATION,COLOR,VSIZE)  VALUES ('V-102','50','KHULNA','BLUE','COMPACT');

 INSERT INTO Car (VID,MILEAGE,LOCATION,COLOR,VSIZE)   VALUES ('V-103','10','RONGPUR','YELLOW','MID-SIZE');

 INSERT INTO Car (VID,MILEAGE,LOCATION,COLOR,VSIZE)   VALUES ('V-104','30','DHAKA','BLACK','MID-SIZE');

 INSERT INTO Car (VID,MILEAGE,LOCATION,COLOR,VSIZE)   VALUES ('V-105','45','KHULNA','WHITE','MID-SIZE');

 INSERT INTO Car (VID,MILEAGE,LOCATION,COLOR,VSIZE)   VALUES ('V-106','40','DHAKA','BLACK','COMPACT');

 INSERT INTO Car (VID,MILEAGE,LOCATION,COLOR,VSIZE)   VALUES ('V-107','55','RANGPUR','RED','MID-SIZE');

 INSERT INTO Car (VID,MILEAGE,LOCATION,COLOR,VSIZE)   VALUES ('V-108','30','DHAKA','BLACK','COMPACT');




--Insertion values in table Reservation


 INSERT INTO Reservation (CID,VID,START_DATE,END_DATE,CHARGE) VALUES ('101','V-101','10-JAN-2001','10-FEB-2005','32400');

 INSERT INTO Reservation (CID,VID,START_DATE,END_DATE,CHARGE) VALUES ('102','V-102','12-MAR-2001','10-JUN-2006','12000');

 INSERT INTO Reservation (CID,VID,START_DATE,END_DATE,CHARGE) VALUES ('103','V-103','15-FEB-1999','09-SEP-2005','20000');

 INSERT INTO Reservation (CID,VID,START_DATE,END_DATE,CHARGE) VALUES ('104','V-104','15-FEB-2003','09-SEP-2005','30000');

 INSERT INTO Reservation (CID,VID,START_DATE,END_DATE,CHARGE) VALUES ('105','V-105','15-FEB-2011','09-SEP-2011','25000');

 INSERT INTO Reservation (CID,VID,START_DATE,END_DATE,CHARGE) VALUES ('106','V-106','20-DEC-2014','25-SEP-2015','50000');

 INSERT INTO Reservation (CID,VID,START_DATE,END_DATE,CHARGE) VALUES ('107','V-107','15-MAR-2009','09-SEP-2009','35000');

 INSERT INTO Reservation (CID,VID,START_DATE,END_DATE,CHARGE) VALUES ('108','V-108','29-FEB-2016','09-JUN-2016','30000');


 --Insertion values in table chauffeur


 INSERT INTO chauffeur VALUES('1001','KARIM HASAN','MALE','DHAKA','MARRIED');

 INSERT INTO chauffeur VALUES('1002','RASEDUL ISLAM','MALE','KHULNA','UNMARRIED');

 INSERT INTO chauffeur VALUES('1003','TRISHA KHAN','FEMALE','RAJSHAHI','UNMARRIED');

 INSERT INTO chauffeur VALUES('1004','SHUVOM HOSEN','MALE','DHAKA','MARRI9ED');

DBMS_OUTPUT.PUT_LINE('Data Inserted without problem');

update chauffeur set ADDRESS='COMILLA' where ChauffeurId='1004';


END;
/

describe Customers;

describe car;

describe Reservation;

describe chauffeur;

--describe records from customers table

select * from Customers;

--Describe records from Cars table

select * from Car;

--Describe records from Reservation table

select * from Reservation;

--dESCRIBE RECORDS FROM CHAUFFEUR TABLE

select * from chauffeur;


--Different types of operation

--agregation function

select count(*) from customers;

select AVG(CHARGE) from Reservation; 

select SUM(CHARGE) from Reservation where START_DATE='12-MAR-2001'; 

select max(charge) from Reservation;

select min(charge) from Reservation;

--Select distinct customers name

SELECT DISTINCT(FIRST_NAME)  FROM Customers;

select all FIRST_NAME from customers;

SELECT ADDRESS FROM Customers WHERE GENDER ='MALE';

SELECT DISTINCT(name)  FROM Chauffeur;


--Cars which are reserved for maximum times 

SELECT * FROM Car WHERE VID =
     ( 
   SELECT VID FROM RESERVATION WHERE ROUND((END_DATE-START_DATE)/365) =
    (SELECT  MAX(ROUND((END_DATE-START_DATE)/365)) AS "MAXIMUM TIME"FROM RESERVATION)
     );

-----numbers of cars that are
--Display cars size is the most preferred.

SELECT VSIZE,VID FROM Car WHERE MILEAGE = (SELECT MAX(MILEAGE) FROM Car);

--Find location and total mileage of all vehicles specific to each respective location. 


----order by instruction

select cid,vid,charge from reservation order by charge; 


--Find average mileage of vehicles for each location, which has at least three vehicles. 

SELECT AVG(MILEAGE),COUNT(VID),LOCATION FROM Car GROUP BY LOCATION HAVING COUNT(VID) >= 3;

--Find names of customers whose lastname starts with ‘S’ and who has reserved
-- more vehicles than the customer with CID as 101. 

SELECT LAST_NAME,FIRST_NAME FROM CUSTOMERS WHERE LAST_NAME like 'S%';

--Delete all the reservations for customer whose last name starts with ‘S’.

--DELETE FROM RESERVATION WHERE CID IN (SELECT CID FROM CUSTOMERS WHERE LAST_NAME LIKE 'S%');


--join operation

--inner join

--Iinner join using on

select cus.first_name,res.CHARGE from Customers cus join Reservation res on cus.CID=res.CID;

--inner join using clause

select cus.first_name,res.CHARGE from Customers cus join Reservation res USING (CID);

--natural join

select u.first_name,c.VSIZE from customers u natural join car c;

--cross join

select u.first_name,c.COLOR from customers u cross join car c;

--DISPLAY THE DISCOUNT OF THE CUSTOMER








SET SERVEROUTPUT ON
DECLARE
	
	totalCharge Reservation.CHARGE%type;
	CUSTOMERID   Reservation.CID%type;
	disCountCharge number(8,2);
BEGIN
	SELECT MAX(CHARGE) INTO totalCharge FROM Reservation;
	SELECT CID INTO CUSTOMERID FROM Reservation WHERE (CHARGE) IN(totalCharge);
	DBMS_OUTPUT.PUT_LINE('The maximum charge of a CUSTOMER is : '||totalCharge||' with CUSTOMERS CID : '||CUSTOMERID);
	IF totalCharge<=3000 THEN
		disCountCharge := totalCharge*0.10;
	ELSIF totalCharge<=5000 THEN
		disCountCharge := totalCharge*0.15;
	ELSIF totalCharge<=20000 THEN
		disCountCharge := totalCharge*0.20;
	ELSIF totalCharge<=400000 THEN
		disCountCharge := totalCharge*0.25;
	ELSE
		disCountCharge := totalCharge*0.25;
	END IF;
	DBMS_OUTPUT.PUT_LINE('THE MAXIMUM DISCOUNT OF A CUSTOMER IS : '||disCountCharge);

END;
/

SELECT c.CID FROM Customers c UNION ALL SELECT r.CID FROM reservation r WHERE r.charge>12000;


SELECT c.CID FROM Customers c UNION  SELECT r.CID FROM reservation r WHERE r.charge>12000;

SELECT c.CID FROM Customers c INTERSECT  SELECT r.CID FROM reservation r WHERE r.charge>20000;

SELECT c.CID FROM Customers c MINUS SELECT r.CID FROM reservation r WHERE r.charge>12000;



----cursor

set serveroutput on
declare
	cursor curs is select FIRST_NAME, LAST_NAME from customers;
	cusinfo curs%ROWTYPE;
begin
	OPEN curs;
	LOOP
		FETCH curs INTO cusinfo;
		EXIT WHEN curs%ROWCOUNT > 7;
		DBMS_OUTPUT.PUT_LINE('First Name : ' || cusinfo.FIRST_NAME || ' & ' || 'Last name : ' || cusinfo.LAST_NAME);
	END LOOP;
	CLOSE curs;
end;
/	
show errors;
 


set serveroutput on
declare
 timed number;
  cursor curses is select cid,vid, round((END_DATE-START_DATE)/365) as timed from reservation ;
  cusinfo curses%ROWTYPE;
begin
  OPEN curses;
  LOOP
    FETCH curses INTO cusinfo;
    EXIT WHEN curses%ROWCOUNT > 7;
     DBMS_OUTPUT.PUT_LINE('customer id : ' || cusinfo.cid || ' & ' || 'car id   :   ' || cusinfo.vid || '  &  ' || 'time   : ' || cusinfo.timed);
  END LOOP;
  CLOSE curses;
end;
/ 
show errors;



-- PL/SQL PROCEDURES
SET SERVEROUTPUT ON

create or replace procedure chauffeurinformation IS
	c_name chauffeur.name%type;
	c_adress chauffeur.ADDRESS%type;
	c_chauffeurid chauffeur.chauffeurid%type;

	begin
		c_chauffeurid :=1002;
		select name into c_name from chauffeur where ChauffeurId=c_chauffeurid;

		DBMS_OUTPUT.PUT_LINE('The chauffeur name is ' || c_name );
		end;
		/

show errors;


BEGIN
chauffeurinformation;
END;
/

----- Example of PL/SQL PROCEDURES with parameter
set serveroutput on
CREATE OR REPLACE PROCEDURE add_customer (
  customer_id Customers.CID%TYPE,
  cfname customers.FIRST_NAME%TYPE,
  clname customers.LAST_NAME%TYPE,
  cgender customers.GENDER%TYPE,
  cphoneno customers.PHONENO%type,
  caddress customers.ADDRESS%TYPE ) IS
BEGIN
  INSERT INTO customers(CID,FIRST_NAME,LAST_NAME,GENDER,PHONENO,ADDRESS) VALUES(customer_id, cfname,clname,cgender, cphoneno,caddress);

  COMMIT;
END add_customer;
/
SHOW ERRORS

BEGIN
   add_customer(109,'Rahim','Seikh','male','560','Sirajgonj');
   
END;
/