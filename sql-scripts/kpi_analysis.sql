--Core KPI Calculations
--These queries generate the "Hero Metrics" at the top of our dashboard.

-- Calculating Employee Count, Attrition Count, and Attrition Rate
SELECT 
    COUNT(*) AS total_employee_count,
    SUM(attrition_flag) AS attrition_count,
    (COUNT(*) - SUM(attrition_flag)) AS active_employees,
    ROUND(AVG(attrition_flag) * 100, 2) AS attrition_rate,
    ROUND(AVG(Age), 0) AS avg_age
FROM 
    `hr_analytics.cleaned_employees`;


--Attrition by Department & Gender
--This powers the Department-wise Attrition pie chart and the Attrition by Gender bar chart.

-- Attrition Breakdown by Department
SELECT 
    Department,
    SUM(attrition_flag) AS attrition_volume,
    ROUND(SUM(attrition_flag) * 100.0 / SUM(SUM(attrition_flag)) OVER(), 2) AS dept_attrition_pct
FROM 
    `hr_analytics.cleaned_employees`
WHERE 
    attrition_flag = 1
GROUP BY 1;

-- Attrition by Gender (Top Right Bar Chart)
SELECT 
    Gender,
    SUM(attrition_flag) AS total_attrition
FROM 
    `hr_analytics.cleaned_employees`
GROUP BY 1;


--Job Satisfaction Matrix (Pivoted)
--To create the Job Satisfaction Ratings table seen in our screenshot, we need to count occurrences of each rating level (1-4) per role.

-- Generating the Satisfaction Matrix
SELECT 
    JobRole,
    COUNT(CASE WHEN JobSatisfaction = 1 THEN 1 END) AS satisfaction_1,
    COUNT(CASE WHEN JobSatisfaction = 2 THEN 1 END) AS satisfaction_2,
    COUNT(CASE WHEN JobSatisfaction = 3 THEN 1 END) AS satisfaction_3,
    COUNT(CASE WHEN JobSatisfaction = 4 THEN 1 END) AS satisfaction_4,
    COUNT(*) AS grand_total
FROM 
    `hr_analytics.cleaned_employees`
GROUP BY 
    JobRole
ORDER BY 
    grand_total DESC;


--Education Field Breakdown
--This powers the horizontal bar chart on the bottom left.

-- Top Education Fields by Attrition Volume
SELECT 
    EducationField,
    SUM(attrition_flag) AS attrition_count
FROM 
    `hr_analytics.cleaned_employees`
WHERE 
    attrition_flag = 1
GROUP BY 1
ORDER BY attrition_count DESC;
