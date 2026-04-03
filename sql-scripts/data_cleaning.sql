--Data Cleaning & Standardization
--Raw HR data often has inconsistent naming or missing values. This script prepares the table for the dashboard.

-- Standardizing the dataset for HR Analysis
CREATE OR REPLACE TABLE `hr_analytics.cleaned_employees` AS
SELECT 
    EmployeeID,
    Age,
    -- Creating Age Groups for the Pie/Bar charts
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE 'Over 55'
    END AS age_group,
    Gender,
    Department,
    JobRole,
    EducationField,
    -- Standardizing Attrition to a numeric flag for easier math
    CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END AS attrition_flag,
    JobSatisfaction, -- Numeric 1-4
    PerformanceRating
FROM 
    `hr_analytics.raw_hr_data`
WHERE 
    EmployeeID IS NOT NULL;
