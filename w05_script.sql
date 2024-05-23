
-- ------------------------------------------
-- Step 1: Joins ----------------------------
-- ------------------------------------------

-- v_art Database:
USE v_art;

-- Query #1
SELECT artfile 
FROM artwork
WHERE period = "Impressionism";

-- Query #2
SELECT artfile
FROM artwork
	JOIN artwork_keyword
		ON artwork.artwork_id = artwork_keyword.artwork_id
	JOIN keyword
		ON artwork_keyword.keyword_id = keyword.keyword_id
WHERE keyword REGEXP "flower";

-- Query #3
SELECT fname, lname, title
FROM artist
	LEFT JOIN artwork
		ON artist.artist_id = artwork.artist_id;

-- Magazine Database:
USE magazine;

-- Query #4
SELECT magazineName, subscriberLastName, subscriberFirstName
FROM subscription
	LEFT JOIN subscriber
		ON subscriber.subscriberKEY = subscription.subscriberKEY
	LEFT JOIN magazine
		ON magazine.magazineKey = subscription.magazineKey
ORDER BY magazineName;

-- Query #5
SELECT magazineName
FROM magazine
	JOIN subscription
		ON magazine.magazineKey = subscription.magazineKey
	JOIN subscriber
		ON subscriber.subscriberKEY = subscription.subscriberKEY
WHERE subscriberFirstName = "Samantha" AND subscriberLastName = "Sanders"
ORDER BY magazineName;
        
-- Employee Database::
USE employees;

-- Query #6
SELECT first_name, last_name
FROM employees
	JOIN dept_emp
		ON employees.emp_no = dept_emp.emp_no
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
WHERE dept_name = "Customer Service"
ORDER BY last_name
LIMIT 5;

-- Query #7
SELECT first_name, last_name, dept_name, salary, salaries.from_date
FROM employees
	JOIN dept_emp
		ON employees.emp_no = dept_emp.emp_no
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	JOIN salaries
		ON employees.emp_no = salaries.emp_no
WHERE first_name = "Berni" AND last_name = "Genin"
ORDER BY salaries.from_date DESC
LIMIT 1;

-- ------------------------------------------
-- Step 2: Summary Queries ------------------
-- ------------------------------------------

-- bike Database:
USE bike;

-- Query #8
SELECT ROUND(AVG(quantity)) AS "Stock Average" 
FROM stock;

-- Query #9
SELECT DISTINCT product_name
FROM product
	JOIN stock
		ON product.product_id = stock.product_id
WHERE quantity = 0
ORDER BY product_name;

-- Query #10
SELECT category_name, SUM(quantity) AS instock
FROM product
	JOIN stock
		ON product.product_id = stock.product_id
	JOIN store
		ON store.store_id = stock.store_id
	JOIN category
		ON category.category_id = product.category_id
WHERE store.store_id = 2 AND quantity != 0 
GROUP BY category_name
ORDER BY instock;

-- Employee Database::
USE employees;

-- Query #11
SELECT COUNT(*) AS "Number of Employees"
FROM employees;

-- Query #12
SELECT dept_name,  FORMAT(AVG(ALL salary), 2) AS "average_salary"
FROM employees
	JOIN dept_emp
		ON employees.emp_no = dept_emp.emp_no
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	JOIN salaries
		ON employees.emp_no = salaries.emp_no
GROUP BY dept_name 
	HAVING AVG(ALL salary) < 60000;
    
-- Query #13
SELECT dept_name, COUNT(gender) AS "Number of Females"
FROM employees
	JOIN dept_emp
		ON employees.emp_no = dept_emp.emp_no
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
WHERE gender = "F"
GROUP BY dept_name
ORDER BY dept_name;	