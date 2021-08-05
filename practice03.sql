-- Q1
SELECT employee_id 사번,
    first_name 이름,
    last_name 성,
    department_name 부서명
FROM employees e, departments d
WHERE e.department_id = d.department_id
ORDER BY department_name, employee_id DESC;

-- Q2: 3개 테이블 JOIN
SELECT employee_id 사번,
    first_name 이름,
    salary 급여,
    department_name 부서명,
    job_title 업무명
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id AND
    e.job_id = j.job_id
ORDER BY employee_id;

-- Q2-1: 3개 테이블 JOIN (LEFT OUTER JOIN)
SELECT employee_id 사번,
    first_name 이름,
    salary 급여,
    department_name 부서명,
    job_title 업무명
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id (+) AND
    e.job_id = j.job_id
ORDER BY employee_id;

-- ANSI
SELECT employee_id 사번,
    first_name 이름,
    salary 급여,
    department_name 부서명,
    job_title 업무명
FROM employees e LEFT OUTER JOIN departments d
        ON e.department_id = d.department_id,
    jobs j
WHERE e.job_id = j.job_id;

-- Q3
SELECT loc.location_id, city,
    department_name, department_id
FROM departments d JOIN locations loc
    ON d.location_id = loc.location_id
ORDER BY loc.location_id;

-- Q3-1
SELECT loc.location_id, city,
    department_name, department_id
FROM locations loc LEFT OUTER JOIN departments d
    ON loc.location_id = d.location_id
ORDER BY loc.location_id;

-- Q4
SELECT region_name 지역이름,
    country_name 나라이름
FROM regions r, countries c
WHERE r.region_id = c.region_id
ORDER BY r.region_name, country_name DESC;

-- Q5: SELF JOIN
SELECT e.employee_id,
    e.first_name,
    e.hire_date,
    m.first_name,
    m.hire_date
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND
    e.hire_date < m.hire_date;
    
-- Q6
SELECT country_name,
    c.country_id,
    city,
    l.location_id,
    department_name,
    department_id
FROM countries c, locations l, departments d
WHERE c.country_id = l.country_id AND
    l.location_id = d.location_id
ORDER BY c.country_name;

-- Q7
SELECT e.employee_id 사번,
    first_name || ' ' || last_name 이름,
    j.job_id 업무아이디,
    start_date 시작일,
    end_date 종료일
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id AND
    j.job_id = 'AC_ACCOUNT';
    
-- Q8.
SELECT d.department_id,
    department_name,
    first_name 매니저이름,
    city 도시명,
    country_name 나라명,
    region_name 지역명
FROM departments d,
    employees e,
    locations l,
    countries c,
    region g
WHERE d.manager_id = e.employee_id AND
    d.location_id = l.location_id AND
    l.country_id = c.country_id AND
    c.region_id = r.region_id
ORDER BY d.department_id;
