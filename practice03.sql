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
    regions r
WHERE d.manager_id = e.employee_id AND
    d.location_id = l.location_id AND
    l.country_id = c.country_id AND
    c.region_id = r.region_id
ORDER BY d.department_id;

-- Q9 : OUTER JOIN + SELF JOIN
SELECT
    e.employee_id,
    e.first_name,
    department_name,
    m.first_name
FROM employees e LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id,
    employees m
WHERE e.manager_id = m.employee_id;

----------
-- SUBQUERY
----------
-- 하나의 질의문 안에 다른 질의문을 포함하는 형태
-- 전체 사원 중, 급여의 중앙값보다 많이 받는 사원

-- 1. 급여의 중앙값?
SELECT MEDIAN(salary) FROM employees;   --  6200
-- 2. 6200보다 많이 받는 사원 쿼리
SELECT first_name, salary FROM employees WHERE salary > 6200;

-- 3. 두 쿼리를 합친다.
SELECT first_name, salary FROM employees
WHERE salary > (SELECT MEDIAN(salary) FROM employees);

-- Den 보다 늦게 입사한 사원들
-- 1. Den 입사일 쿼리
SELECT hire_date FROM employees WHERE first_name = 'Den'; -- 02/12/07
-- 2. 특정 날짜 이후 입사한 사원 쿼리
SELECT first_name, hire_date FROM employees WHERE hire_date >= '02/12/07';
-- 3. 두 쿼리를 합친다.
SELECT first_name, hire_date 
FROM employees 
WHERE hire_date >= (SELECT hire_date FROM employees WHERE first_name = 'Den');

-- 다중행 서브 쿼리
-- 서브 쿼리의 결과 레코드가 둘 이상이 나올 때는 단일행 연산자를 사용할 수 없다
-- IN, ANY, ALL, EXISTS 등 집합 연산자를 활용
SELECT salary FROM employees WHERE department_id = 110; -- 2 ROW

SELECT first_name, salary FROM employees
WHERE salary = (SELECT salary FROM employees WHERE department_id = 110); -- ERROR

-- 결과가 다중행이면 집합 연산자를 활용
-- salary = 120008 OR salary = 8300
SELECT first_name, salary FROM employees
WHERE salary IN (SELECT salary FROM employees WHERE department_id = 110);

-- ALL(AND)
-- salary > 12008 AND salary > 8300
SELECT first_name, salary FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE department_id = 110);

-- ANY(OR)
SELECT first_name, salary FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 110);
