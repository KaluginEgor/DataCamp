SELECT COUNT(*), gender 
FROM u_sa_customers_data.sa_customers 
GROUP BY gender;

SELECT COUNT(*), age 
FROM u_sa_customers_data.sa_customers 
GROUP BY age;

SELECT COUNT(*), category_id
FROM u_sa_pizzas_data.sa_pizzas
GROUP BY category_id;

SELECT COUNT(*), promotion_type_id
FROM u_sa_promotions_data.sa_promotions
GROUP BY promotion_type_id;

SELECT COUNT(*), store_id
FROM u_sa_employees_data.sa_employees
GROUP BY store_id
HAVING COUNT(*) > 1; 

SELECT COUNT(*), promotion_percent
FROM u_sa_promotions_data.sa_promotions
GROUP BY promotion_percent
ORDER BY promotion_percent DESC;


create table u_sa_customers_data.example_sa_customers (
   CUSTOMER_ID          NUMBER                not null,
   FIRST_NAME           VARCHAR2(128)         not null,
   LAST_NAME            VARCHAR2(128)         not null,
   GENDER               VARCHAR2(10)          not null,
   AGE                  NUMBER                not null,
   EMAIL                VARCHAR2(128)         not null,
   PHONE                VARCHAR2(128)         not null,
   constraint PK_EXAMPLE_SA_CUSTOMERS primary key (CUSTOMER_ID)
)
tablespace ts_sa_customers_data_01;


INSERT INTO u_sa_customers_data.example_sa_customers(customer_id, first_name, last_name, gender, age, email, phone)
SELECT ROWNUM, 
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))),
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))),
        decode(round(dbms_random.value), 1, 'F', 'M'),
        round((DBMS_RANDOM.VALUE(1, 100)),0),
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))) || '@gmail.com',
        DBMS_RANDOM.STRING('L', 7)
  FROM DUAL
  CONNECT BY LEVEL <= 100000;
  
MERGE INTO u_sa_customers_data.example_sa_customers EC
USING (SELECT age, count(*) cntage FROM u_sa_customers_data.sa_customers GROUP BY AGE) C
ON (EC.age = C.age)
WHEN MATCHED THEN UPDATE SET email = to_char(cntage) || '_people_with_age_like_me@gmail.com';

select * from u_sa_customers_data.example_sa_customers;