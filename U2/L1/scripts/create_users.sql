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
-- User: u_sal_data
--==============================================================
CREATE USER u_sal_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sal_data_01;

grant CONNECT,CREATE VIEW,RESOURCE to u_sal_data;