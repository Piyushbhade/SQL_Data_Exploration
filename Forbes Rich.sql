CREATE DATABASE Richman; /* Created the database.*/

USE Richman; /* Made the Richman as default dataset*/

/*Imported the data through file import wizard.*/ 
 /* Describe the table showing its properties.*/
 DESC mytable;
 
 /* List the name of billionaires from India"*/
 Select *
 From mytable
 where country like '%India%';
 
 /* List the name of billionaires whose age is below 40, net woth higher then 10 and 
 industry is technology, healthcare or manufacturing*/
SELECT name, age, net_worth, country, industry
FROM mytable
WHERE age < 40 
  AND net_worth > 10 
  AND industry IN ('technology', 'healthcare', 'manufacturing');
 
/* Who are the top 10 billionaires in the dataset, and what is their net worth?*/
SELECT name, Net_worth
FROM mytable
ORDER BY Net_worth DESC
LIMIT 10;

/* Show list of 5th to 10th billionarires of Technology industry.*/
SELECT name,net_worth,industry
FROM mytable
WHERE industry = 'Technology'
ORDER BY net_worth DESC
LIMIT 5 OFFSET 5;


/* Which country has the highest number of billionaires in the dataset?*/
SELECT country, COUNT(name) AS Total_billionaries
FROM mytable
GROUP BY country
ORDER BY Total_billionaries DESC
LIMIT 1;

/* What is the average age of billionaires in the dataset?*/
SELECT AVG(age) AS Average_Age
FROM mytable;

/* Which industries have the highest concentration of billionaires in the dataset?*/
SELECT industry, COUNT(name) AS total_count_of_billionars
FROM mytable
GROUP BY industry
ORDER BY total_count_of_billionars DESC

/* How many billionaires are there in each country represented in the dataset?*/
SELECT country, COUNT(Name) AS total_billionaries
FROM mytable
GROUP BY country
ORDER BY total_billionaries DESC

/* Which age group has the highest concentration of billionaires in the dataset?*/
SELECT 
  SUM(CASE WHEN age >= 80 THEN 1 ELSE 0 END) AS '100-80years',
  SUM(CASE WHEN age >= 60 AND age < 80 THEN 1 ELSE 0 END) AS '60-79years',
  SUM(CASE WHEN age >= 40 AND age < 60 THEN 1 ELSE 0 END) AS '40-59years',
  SUM(CASE WHEN age >= 20 AND age < 40 THEN 1 ELSE 0 END) AS '20-39years',
  SUM(CASE WHEN age >= 0 AND age < 20 THEN 1 ELSE 0 END) AS '0-19years'
FROM mytable;

/* How does the industry distribution of billionaires compare across 
different countries in the dataset?*/
SELECT industry, country, SUM(net_worth) AS worth
FROM mytable
GROUP BY industry,country
ORDER BY worth DESC;

/* What percentage of billionaires in the dataset have a background in finance or investment?*/
SELECT industry, 
       COUNT(industry)*100/(SELECT count(*) FROM mytable)
FROM mytable
GROUP BY industry;

/* List all the sources of income of billionaires as per the industries.*/
SELECT industry, 
	GROUP_CONCAT(DISTINCT source ORDER BY source DESC SEPARATOR " ,")
    AS Income_Sources
FROM mytable
GROUP BY industry;

/*Add coloumn to the table showing the net worth club as 100 Billion club , 
50-100 B and 10-50B and 10 B club. */
ALTER TABLE mytable     /* Adding blank cloumn by the name of club */
ADD COLUMN Club varchar(100);

SET sql_safe_updates = 0; /* Setting the safe upadate off */

UPDATE mytable /* Updating the Club column */
SET Club =
         (CASE WHEN net_worth >= 100 THEN '100B-Club'
					WHEN net_worth >= 50 AND net_worth < 100 THEN '50-100B-Club'
                    WHEN net_worth >= 10 AND net_worth < 50 THEN '10-50B-Club'
                    WHEN net_worth >= 1 AND net_worth < 10 THEN '10B-Club'
                    END)
                    
                    


