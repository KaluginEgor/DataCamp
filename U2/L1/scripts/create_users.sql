--Storage level

--==============================================================
-- User: u_sa_sales_data
--==============================================================
CREATE USER u_sa_sales_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_sales_data_01;

grant CONNECT,RESOURCE to u_sa_sales_data;
--==============================================================
-- User: u_sa_customers_data
--==============================================================
CREATE USER u_sa_customers_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_customers_data_01;

grant CONNECT,RESOURCE to u_sa_customers_data;
--==============================================================
-- User: u_sa_stores_data
--==============================================================
CREATE USER u_sa_stores_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_stores_data_01;

grant CONNECT,RESOURCE to u_sa_stores_data;
--==============================================================
-- User: u_sa_employees_data
--==============================================================
CREATE USER u_sa_employees_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_employees_data_01;

grant CONNECT,RESOURCE to u_sa_employees_data;
--==============================================================
-- User: u_sa_pizzas_data
--==============================================================
CREATE USER u_sa_pizzas_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_pizzas_data_01;

grant CONNECT,RESOURCE to u_sa_pizzas_data;
--==============================================================
-- User: u_sa_promotions_data
--==============================================================
CREATE USER u_sa_promotions_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_promotions_data_01;

grant CONNECT,RESOURCE to u_sa_promotions_data;
--==============================================================
-- User: u_sa_payment_methods_data
--==============================================================
CREATE USER u_sa_payment_methods_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_payment_methods_data_01;

grant CONNECT,RESOURCE to u_sa_payment_methods_data;
--==============================================================
-- User: u_sa_geo_locations_data
--==============================================================
CREATE USER u_sa_geo_locations_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_geo_locations_data_01;

grant CONNECT,RESOURCE to u_sa_geo_locations_data;
--==============================================================
-- User: u_sa_dates_data
--==============================================================
CREATE USER u_sa_dates_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dates_data_01;

grant CONNECT,RESOURCE to u_sa_dates_data;
--==============================================================
-- User: u_sa_gen_periods_data
--==============================================================
CREATE USER u_sa_gen_periods_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_gen_periods_data_01;

grant CONNECT,RESOURCE to u_sa_gen_periods_data;

--DW - Cleansing Level

--==============================================================
-- User: u_dw_cl
--==============================================================
CREATE USER u_dw_cl
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_cl_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_dw_cl;

--DW – Level
 
--==============================================================
-- User: u_dw_data
--==============================================================
CREATE USER u_dw_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_data_01;
    
grant CONNECT,RESOURCE to u_dw_data;
    
--DW– Prepare Star Cleansing Level

--==============================================================
-- User: u_sal_dw_cl
--==============================================================
CREATE USER u_sal_dw_cl
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sal_dw_cl_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sal_dw_cl;

--STAR - Cleansing

--==============================================================
-- User: u_sal_cl
--==============================================================
CREATE USER u_sal_cl
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sal_cl_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sal_cl;

--STAR – Level

--==============================================================
-- User: u_sa_fct_sales
--==============================================================
CREATE USER u_sa_fct_sales
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_fct_sales_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sa_fct_sales;

--==============================================================
-- User: u_sa_dim_customers
--==============================================================
CREATE USER u_sa_dim_customers
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_customers_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sa_dim_customers;

--==============================================================
-- User: u_sa_dim_stores
--==============================================================
CREATE USER u_sa_dim_stores
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_stores_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sa_dim_stores;

--==============================================================
-- User: u_sa_dim_employees
--==============================================================
CREATE USER u_sa_dim_employees
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_employees_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sa_dim_employees;
    
--==============================================================
-- User: u_sa_dim_pizzas_scd
--==============================================================
CREATE USER u_sa_dim_pizzas_scd
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_pizzas_scd_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sa_dim_pizzas_scd;
    
--==============================================================
-- User: u_sa_dim_promotions
--==============================================================
CREATE USER u_sa_dim_promotions
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_promotions_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sa_dim_promotions;
    
--==============================================================
-- User: u_sa_dim_payment_methods
--==============================================================
CREATE USER u_sa_dim_payment_methods
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_payment_methods_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sa_dim_payment_methods;
    
--==============================================================
-- User: u_sa_dim_geo_locations
--==============================================================
CREATE USER u_sa_dim_geo_locations
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_geo_locations_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sa_dim_geo_locations;
    
--==============================================================
-- User: u_sa_dim_dates
--==============================================================
CREATE USER u_sa_dim_dates
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_dates_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sa_dim_dates;
    
--==============================================================
-- User: u_sa_dim_gen_period
--==============================================================
CREATE USER u_sa_dim_gen_period
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_dim_gen_period_01;
    
grant CONNECT,CREATE VIEW,RESOURCE to u_sa_dim_gen_period;