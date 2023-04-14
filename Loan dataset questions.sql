USE loan_db;

/*1. Creat a new column by New_Date with date data type and 
insert the application date data.*/

ALTER TABLE loans
ADD COLUMN New_date date; /*Adding new column with DATE data type*/

SET sql_safe_updates = 0; /* switching Safe update off */

UPDATE loans
SET New_date= Str_to_date(applicationdate,"%d-%m-%Y");/* Filling the data into date column */

/* 2. Find the loans that are rejected and with amount greater than 200.*/
SELECT *
FROM loans
WHERE Loan_Status = 'N' AND 
      LoanAmount > 200 ;

/*4. Find the female customers from rural area */ 
SELECT *
FROM customers
WHERE Gender = 'Female' AND
      Property_Area = 'Rural';

/*5. List the married customers with no credit history or 
un-married customers with income < 5000*/
SELECT *
FROM customers
WHERE Credit_History = 0 OR
      ( Married = 'No' AND
       ApplicantIncome < 5000);


/*6. CreditIndex = Credit_History * ApplicantIncome * (Dependent * 0.5)
Show this CreditIndex for all the customers. */
SELECT *, Credit_History * ApplicantIncome * (Dependents * 0.5) AS  CreditIndex
FROM customers;

/*7. CreditIndex = Credit_History * ApplicantIncome * (Dependent * 0.5)
Round up the CreditIndex to the next whole number. 
Round down the CreditIndex to the previous whole number. */
SELECT custID, Credit_History * ApplicantIncome * (Dependents * 0.5) AS  CreditIndex,
      ceil(Credit_History * ApplicantIncome * (Dependents * 0.5)) AS Nextwholenumber,
      floor(Credit_History * ApplicantIncome * (Dependents * 0.5)) AS previouswholenumber
FROM customers;

/*8. How old is each loan in the loans table? Show the loan age in months.Where loan is approved*/

SELECT Loan_ID, Loan_Status, 
       timestampdiff(Month,New_date, Current_date()) AS Loan_Age
FROM loans
WHERE Loan_Status ='Y';


/*9. Show the loan age in number of years and extra months. Eg: 
   LoanID  | Yr | Month
   LP00011 | 3  | 9        */
   
SELECT Loan_ID,
       timestampdiff(Year,New_date, Current_date()) AS Yr,
       New_date MOD 12 AS 'Month'
FROM loans;


/* 10. List the customers who have dependents and credit history
but with rejected loans. */
SELECT custID 
from customers c
INNER JOIN Loans l ON c.Loan_ID= l.Loan_ID
WHERE Dependents > 0 AND Credit_History  = 1
AND l.loan_status = 'N';
	

