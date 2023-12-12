create database data_1;
use data_1;
show tables;
select count(*) from data_csv;


/*1.Need Manager wise count of employee by number of kids employee is having.
 Refer below table.*/
 
SELECT e.MNGR_CODE, No_of_Kids, COUNT(*) AS employee_count
FROM data_csv e
GROUP BY e.MNGR_CODE, No_of_Kids
ORDER BY e.MNGR_CODE, No_of_Kids;


/*2.Need Count of Employee basis number of years experience in this company.*/

SELECT COUNT(*), A.Work_Exp_in_this_Company FROM (SELECT 
CASE
WHEN Total_Work_Exp_Before_Joining_This_Company_Yrs<=1 THEN '<=1 Yr'
WHEN Total_Work_Exp_Before_Joining_This_Company_Yrs<=2 THEN '<=2 Yr'
WHEN Total_Work_Exp_Before_Joining_This_Company_Yrs<=3 THEN '<=3 Yr'
WHEN Total_Work_Exp_Before_Joining_This_Company_Yrs<=4 THEN '<=4 Yr'
WHEN Total_Work_Exp_Before_Joining_This_Company_Yrs<=5 THEN '<=5 Yr'
WHEN Total_Work_Exp_Before_Joining_This_Company_Yrs>5 THEN '>5 Yr'
END Work_Exp_in_this_Company,
COUNT(EMP_CODE) AS NO_OF_EMP
FROM data_csv e
GROUP BY e.Total_Work_Exp_Before_Joining_This_Company_Yrs) AS A
GROUP BY Work_Exp_in_this_Company;


/*3.Need count of Male and Female Employee in the company*/

SELECT 
CASE 
WHEN Name LIKE 'Miss%' THEN 'Female'
WHEN Name LIKE 'Mr%' THEN 'Male'
WHEN Name LIKE 'Mrs%' THEN 'Female'
END Gender,
COUNT(EMP_CODE) AS NO_OF_EMP
FROM data_csv e
GROUP BY Gender;

SELECT 
    CASE
        WHEN Name LIKE 'Miss%' THEN 'Female'
        WHEN Name LIKE 'Mr%' THEN 'Male'
        WHEN Name LIKE 'Mrs%' THEN 'Female'
    END Gender,
    COUNT(EMP_CODE) AS NO_OF_EMP
FROM
    data_csv e
GROUP BY Gender 
UNION SELECT 
    'Total' Gender, COUNT(EMP_CODE) AS NO_OF_EMP
FROM
    data_csv e;


/*4.Need Manager wise top and bottom employee basis salary*/    
    
SELECT 
    derived.mngr_code,
    data_csv.EMP_CODE,
    derived.salary,
    derived.Category
FROM
    (SELECT 
        mngr_code,
            MAX(EMP_SLRY_PM) salary,
            'HighestSalary' AS Category
    FROM
        data_csv
    GROUP BY mngr_code UNION ALL SELECT 
        mngr_code, MIN(EMP_SLRY_PM), 'LowestSalary' AS Category
    FROM
        data_csv
    GROUP BY mngr_code) derived
        JOIN
    data_csv ON derived.salary = data_csv.EMP_SLRY_PM
        AND derived.mngr_code = data_csv.mngr_code
ORDER BY 4,1; 
    





    




