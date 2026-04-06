CREATE TABLE DEPT (
  Deptno INT PRIMARY KEY,
  Dname VARCHAR(50),
  Loc VARCHAR(50)
);

INSERT INTO DEPT (Deptno, Dname, Loc) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO');

CREATE TABLE EMP (
  EMPNO INT PRIMARY KEY,
  ENAME VARCHAR(50),
  JOB VARCHAR(20),
  MGR INT,
  HIREDATE DATE,
  SAL DECIMAL(10,2) CHECK (SAL > 0),
  COMM DECIMAL(10,2),
  DEPTNO INT,
  FOREIGN KEY (DEPTNO) REFERENCES DEPT(Deptno)
);


INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10),
(7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20),
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20);



# Q3: List the names and salary of the employee whose salary is greater than 1000

select ename,sal
from emp
where sal>1000;


# Q4: List the details of the employees who have joined before end of September 81

select *
from emp
where hiredate<'1981-10-01';


# Q5: List employee names having I as second character

select *
from emp
where ename like '_i%';


# Q6: List Employee Name, Salary, Allowances (40% of Sal), P.F. (10% of Sal) and Net Salary

select ename as emp_name, 
sal as salary,
sal*40/100 as Allowances, 
sal*10/100 as PF,
sal+(sal*.4)-(sal*.1) as Net_sal
from emp;


# Q7: List Employee Names with designations who do not report to anybody

select ename,job
from emp
where mgr is null;


# Q8: List EMPNO, ENAME and Salary in ascending order of salary

select empno,ename, sal
from emp
order by sal asc;


# Q9: How many jobs are available in the organization?

select count(distinct job) as 'job count'
from emp;


# Q10: Determine total payable salary of salesman category

select job, sum(sal) as Total_sal
from emp
where job='salesman';


# Q11: List average monthly salary for each job within each department

select job,deptno,avg(sal)
from emp
group by job, deptno;


# Q12: Display EMPNAME, SALARY and DEPTNAME in which the employee is working

SELECT E.ENAME, E.SAL, D.DNAME 
FROM EMp E 
JOIN DEPT D ON E.DEPTNO = D.DEPTNO;


# Q13: Create the Job Grades Table as below

create table Job_Grades(
grade char(1),
losal int,
hisal int);

INSERT INTO Job_Grades (grade, losal, hisal) VALUES
('A', 0, 999),
('B', 1000, 1999),
('C', 2000, 2999),
('D', 3000, 3999),
('E', 4000, 5000);


# Q14: Display the last name, salary and corresponding Grade

SELECT E.ENAME, E.SAL, G.GRADE 
FROM EMP E
JOIN JOB_GRADES G ON E.SAL BETWEEN G.LOSAL AND G.HISAL;


# Q15: Display the Emp name and the Manager name under whom the Employee works

SELECT E.ENAME AS Employee, M.ENAME AS Manager
FROM EMP E
LEFT JOIN EMP M ON E.MGR = M.EMPNO;



# 16. Display Empname and Total sal where Total Sal (sal + Comm)

select ename, sal+comm as total_sal
from emp;


# Q17: Display Empname and Sal whose empno is an odd number

select ename,sal
from emp
where mod(empno,2)=1


# Q18: Display Empname, Rank of sal in Organisation, Rank in their department

SELECT 
  ENAME,
  SAL,
  DENSE_RANK() OVER (ORDER BY SAL DESC) AS Org_Rank,
  DENSE_RANK() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC) AS Dept_Rank
FROM EMP;


# Q19: Display Top 3 Empnames based on their Salary

SELECT ENAME, SAL
FROM EMP
ORDER BY SALARY DESC
LIMIT 3;


# Q20: Display Empname who has highest Salary in Each Department

SELECT ENAME, SAL, DEPTNO 
FROM EMP E 
WHERE SAL = (
  SELECT MAX(SAL) 
  FROM EMP
  WHERE DEPTNO = E.DEPTNO
);




