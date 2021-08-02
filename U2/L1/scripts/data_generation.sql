ALTER USER u_sa_customers_data QUOTA UNLIMITED ON ts_sa_customers_data_01;
GRANT UNLIMITED TABLESPACE TO u_sa_customers_data;
ALTER USER u_sa_stores_data QUOTA UNLIMITED ON ts_sa_stores_data_01;
GRANT UNLIMITED TABLESPACE TO u_sa_stores_data;
ALTER USER u_sa_employees_data QUOTA UNLIMITED ON ts_sa_employees_data_01;
GRANT UNLIMITED TABLESPACE TO u_sa_employees_data;
ALTER USER u_sa_pizzas_data QUOTA UNLIMITED ON ts_sa_pizzas_data_01;
GRANT UNLIMITED TABLESPACE TO u_sa_pizzas_data;
ALTER USER u_sa_promotions_data QUOTA UNLIMITED ON ts_sa_promotions_data_01;
GRANT UNLIMITED TABLESPACE TO u_sa_promotions_data;
ALTER USER u_sa_geo_locations_data QUOTA UNLIMITED ON ts_sa_geo_locations_data_01;
GRANT UNLIMITED TABLESPACE TO u_sa_geo_locations_data;
ALTER USER u_sa_sales_data QUOTA UNLIMITED ON ts_sa_sales_data_01;
GRANT UNLIMITED TABLESPACE TO u_sa_sales_data;
ALTER USER u_sa_dates_data QUOTA UNLIMITED ON ts_sa_dates_data_01;
GRANT UNLIMITED TABLESPACE TO u_sa_dates_data;
ALTER USER u_sa_payment_methods_data QUOTA UNLIMITED ON ts_sa_payment_methods_data_01;
GRANT UNLIMITED TABLESPACE TO u_sa_payment_methods_data;

--sa_dates

INSERT INTO u_sa_dates_data.sa_dates 
SELECT * FROM dim_date
WHERE dim_date.date_key < 20210101;

SELECT * FROM u_sa_dates_data.sa_dates ;

--sa_geo_locations



--sa_customers

INSERT INTO u_sa_customers_data.sa_customers(customer_id, first_name, last_name, gender, age, email, phone)
SELECT ROWNUM, 
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))),
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))),
        decode(round(dbms_random.value), 1, 'F', 'M'),
        round((DBMS_RANDOM.VALUE(1, 100)),0),
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))) || '@gmail.com',
        DBMS_RANDOM.STRING('L', 7)
  FROM DUAL
  CONNECT BY LEVEL <= 1000000;

SELECT * FROM u_sa_customers_data.sa_customers;

--sa_stores

INSERT INTO u_sa_stores_data.sa_stores(store_id, store_desc, email, phone, manager_id, manager_first_name, manager_last_name)
SELECT ROWNUM, 
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))),
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))) || '@gmail.com',
        DBMS_RANDOM.STRING('L', 7),
        ROWNUM,
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))),
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21)))
  FROM DUAL
  CONNECT BY LEVEL <= 100000;

SELECT * FROM u_sa_stores_data.sa_stores;

--sa_employees

INSERT INTO u_sa_employees_data.sa_employees(employee_id, first_name, last_name, gender, age, email, phone, hire_date, store_id, manager_id)
SELECT ROWNUM, 
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))),
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))),
        decode(round(dbms_random.value), 1, 'F', 'M'),
        round((DBMS_RANDOM.VALUE(18, 100)),0),
        DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21))) || '@gmail.com',
        DBMS_RANDOM.STRING('L', 7),
        TO_DATE(
              TRUNC(
                   DBMS_RANDOM.VALUE(TO_CHAR(DATE '2000-01-01','J')
                                    ,TO_CHAR(DATE '2021-01-01','J')
                                    )
                    ),'J'
               ),
        round((DBMS_RANDOM.VALUE(1, 100000)),0),
        0
  FROM DUAL
  CONNECT BY LEVEL <= 500000;

UPDATE u_sa_employees_data.sa_employees
    SET manager_id = store_id;

SELECT * FROM u_sa_employees_data.sa_employees;

--sa_pizzas

INSERT INTO u_sa_pizzas_data.sa_pizzas(pizza_id, category_id, category_desc, pizza_desc, pizza_weight, pizza_diameter, pizza_price)
SELECT ROWNUM, 
        round((DBMS_RANDOM.VALUE(1, 10)),0),
        'Category ',
        'Pizza ' || to_char(ROWNUM),
        round((DBMS_RANDOM.VALUE(300, 1500)),0),
        round((DBMS_RANDOM.VALUE(15, 50)),0),
        round((DBMS_RANDOM.VALUE(5, 50)),0)
  FROM DUAL
  CONNECT BY LEVEL <= 100000;

UPDATE u_sa_pizzas_data.sa_pizzas
SET category_desc = 'Category ' || category_id;

SELECT * FROM u_sa_pizzas_data.sa_pizzas;

--sa_promotions

INSERT INTO u_sa_promotions_data.sa_promotions(promotion_id, promotion_desc, promotion_percent, promotion_type_id, promotion_type_desc)
SELECT ROWNUM, 
        'Promotion ' || to_char(ROWNUM),
        round((DBMS_RANDOM.VALUE(1, 99)),0),
        round((DBMS_RANDOM.VALUE(1, 10)),0),
        'Promotion type '
  FROM DUAL
  CONNECT BY LEVEL <= 100000;

SELECT * FROM u_sa_promotions_data.sa_promotions;

--sa_payment_methods

INSERT INTO u_sa_payment_methods_data.sa_payment_methods(payment_method_id, payment_method_desc)
VALUES (1, 'Cash');
INSERT INTO u_sa_payment_methods_data.sa_payment_methods(payment_method_id, payment_method_desc)
VALUES (2, 'Checks');
INSERT INTO u_sa_payment_methods_data.sa_payment_methods(payment_method_id, payment_method_desc)
VALUES (3, 'Debit cards');
INSERT INTO u_sa_payment_methods_data.sa_payment_methods(payment_method_id, payment_method_desc)
VALUES (4, 'Credit cards');
INSERT INTO u_sa_payment_methods_data.sa_payment_methods(payment_method_id, payment_method_desc)
VALUES (5, 'Mobile payments');
INSERT INTO u_sa_payment_methods_data.sa_payment_methods(payment_method_id, payment_method_desc)
VALUES (6, 'Electronic bank transfers');

--sa_sales

INSERT INTO u_sa_sales_data.sa_sales(sales_id, employee_id, customer_id, store_id, geo_id, date_id, pizza_id, payment_method_id, promotion_id, sales_amount, sales_sum)
SELECT ROWNUM, 
        round((DBMS_RANDOM.VALUE(1, 500000)),0),
        round((DBMS_RANDOM.VALUE(1, 1000000)),0),
        round((DBMS_RANDOM.VALUE(1, 100000)),0),
        0,
        CAST(TO_CHAR(TO_DATE(
              TRUNC(
                   DBMS_RANDOM.VALUE(TO_CHAR(DATE '2016-05-07','J')
                                    ,TO_CHAR(DATE '2021-01-01','J')
                                    )
                    ),'J'
               ), 'YYYYMMDD') AS NUMBER),
        round((DBMS_RANDOM.VALUE(1, 100000)),0),
        round((DBMS_RANDOM.VALUE(1, 6)),0),
        round((DBMS_RANDOM.VALUE(1, 100000)),0),
        round((DBMS_RANDOM.VALUE(1, 1000000)),0),
        round((DBMS_RANDOM.VALUE(1, 100000000)),0)
  FROM DUAL
  CONNECT BY LEVEL <= 1000000;

SELECT * FROM u_sa_sales_data.sa_sales;