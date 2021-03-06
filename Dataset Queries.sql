/*These queries were written to understand how many constituents are present and how many
constituents made donations. It was inferred that even though the database 
has 2000 constituents only 1000 of them have made donations*/
SELECT COUNT(DISTINCT(CONSTITUENT_ID)) FROM CONSTITUENT;
SELECT COUNT(DISTINCT(CONSTITUENT_ID)) FROM TRANSACTIONS;

/*This query was written to understand which constituent donated how much*/
select B.CONSTITUENT_ID , SUM(B.AMOUNT) AS AMT, A.GENDER from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
GROUP BY B.CONSTITUENT_ID;

/*This query was written to understand which gender contributed how much. 
It was inferred that Females have contributed more than Males*/
SELECT A.GENDER,SUM(B.AMOUNT) from CONSTITUENT A join TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
GROUP BY A.GENDER;

/*The above query gives us a list of events that have occurred 
along with the count of attendees and on which date it happened.*/
SELECT A.EVENT_ID, count(A.EVENT_ATTENDEE_ID),  B.EVENT_DATE
FROM EVENT_ATTENDEE A, EVENT B
WHERE A.EVENT_ID = B.EVENT_ID
GROUP BY A.EVENT_ID;

/*The above query gives us a list of constituent ids, 
count of events that constituent has attended along with their age and 
gender.*/
SELECT A.CONSTITUENT_ID, COUNT(B.EVENT_ID), A.GENDER, A.AGE FROM
CONSTITUENT A, EVENT_ATTENDEE B
WHERE A.CONSTITUENT_ID = B.CONSTITUENT_ID
GROUP BY A.CONSTITUENT_ID;

/*The age was divided into various buckets from Below 20, 20-29, 30-39 and so on 
till 90-99, 100+ to understand which age group donated the most.*/
SELECT COUNT(*) FROM CONSTITUENT
WHERE CONSTITUENT_ID NOT IN (SELECT DISTINCT(CONSTITUENT_ID) FROM TRANSACTIONS);

select SUM(B.AMOUNT) AS AMT_19 from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
WHERE (A.AGE < 20);

select SUM(B.AMOUNT) AS AMT_20_29 from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
WHERE (A.AGE >= 20 and A.AGE <= 29);

select SUM(B.AMOUNT) AS AMT_30_39 from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
WHERE (A.AGE >= 30 and A.AGE <= 39);

select SUM(B.AMOUNT) AS AMT_40_49 from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
WHERE (A.AGE >= 40 and A.AGE <= 49);

select SUM(B.AMOUNT) AS AMT_50_59 from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
WHERE (A.AGE >= 50 and A.AGE <= 59);

select SUM(B.AMOUNT) AS AMT_60_69 from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
WHERE (A.AGE >= 60 and A.AGE <= 69);

select SUM(B.AMOUNT) AS AMT_70_79 from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
WHERE (A.AGE >= 70 and A.AGE <= 79);

select SUM(B.AMOUNT) AS AMT_80_89 from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
WHERE (A.AGE >= 80 and A.AGE <= 89);

select SUM(B.AMOUNT) AS AMT_90_99 from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
WHERE (A.AGE >= 90 and A.AGE <= 99);

select SUM(B.AMOUNT) AS AMT_100 from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
WHERE (A.AGE >= 100);

/*The above query was written to understand which state donates how much amount 
based on the sum of constituents who belong to that state. 
After the sum was calculated the results were displayed based on the 
descending order.*/
SELECT A.STATE,SUM(B.AMOUNT) from CONSTITUENT A join TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
GROUP BY A.STATE
ORDER BY sum(B.AMOUNT) DESC;


/*This query gives the list of people who volunteered in any event and the number of 
events they have volunteered in*/
select A.CONSTITUENT_ID, COUNT(A.VOLUNTEER_ID) FROM VOLUNTEER A JOIN CONSTITUENT B
ON A.CONSTITUENT_ID = B.CONSTITUENT_ID
GROUP BY A.CONSTITUENT_ID
ORDER BY COUNT(A.VOLUNTEER_ID) DESC;

/*logistic dataset query*/
SELECT A.CONSTITUENT_ID , A.AGE , A.GENDER , A.MARRIED ,  '1' AS 'DONOR'
from CONSTITUENT A  JOIN TRANSACTIONS B
ON B.CONSTITUENT_ID = A.CONSTITUENT_ID
GROUP BY B.CONSTITUENT_ID
UNION
SELECT  A.CONSTITUENT_ID, A.AGE, A.GENDER , A.MARRIED, '0' AS 'DONOR'
FROM CONSTITUENT A
WHERE A.CONSTITUENT_ID NOT IN (SELECT DISTINCT CONSTITUENT_ID FROM TRANSACTIONS);

SELECT CONSTITUENT_ID, 'Yes' AS 'EVENT_ATTENDED' FROM CONSTITUENT WHERE CONSTITUENT_ID IN (SELECT DISTINCT(CONSTITUENT_ID) FROM EVENT_ATTENDEE)
UNION
SELECT CONSTITUENT_ID, 'No' AS 'EVENT_ATTENDED' FROM CONSTITUENT WHERE CONSTITUENT_ID NOT IN (SELECT DISTINCT(CONSTITUENT_ID) FROM EVENT_ATTENDEE);


/*Alternative query*/
SELECT *,
               CASE 
               WHEN CONSTITUENT_ID IN (SELECT CONSTITUENT_ID FROM TRANSACTIONS)
               THEN 1 ELSE 0 
               END AS DONOR,
               CASE 
               WHEN CONSTITUENT_ID IN (SELECT CONSTITUENT_ID FROM EVENT_ATTENDEE)
               THEN 1 ELSE 0
               END AS EVENT_ATTENDEE
FROM CONSTITUENT;


 
 









