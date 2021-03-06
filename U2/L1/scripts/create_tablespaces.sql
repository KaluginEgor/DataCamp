--Storage level
CREATE TABLESPACE ts_sa_sales_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sa_sales_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;


CREATE TABLESPACE ts_sa_customers_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sa_customers_data_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;
 

CREATE TABLESPACE ts_sa_stores_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sa_stores_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 
CREATE TABLESPACE ts_sa_employees_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sa_employees_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 

CREATE TABLESPACE ts_sa_pizzas_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sa_pizzas_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 

CREATE TABLESPACE ts_sa_promotions_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sa_promotions_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;


CREATE TABLESPACE ts_sa_payment_methods_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sa_payment_methods_data_01.dat'
SIZE 50M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;


CREATE TABLESPACE ts_sa_geo_locations_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sa_geo_locations_data_01.dat'
SIZE 50M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_sa_dates_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sa_dates_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE ts_sa_gen_periods_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sa_gen_periods_data_01.dat'
SIZE 50M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;


--DW - Cleansing Level
CREATE TABLESPACE ts_dw_cl_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_dw_cl_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;


--DW ? Level
CREATE TABLESPACE ts_dw_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_dw_data_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;

 

--DW? Prepare Star Cleansing Level
CREATE TABLESPACE ts_sal_dw_cl_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sal_dw_cl_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;


--STAR - Cleansing
CREATE TABLESPACE ts_sal_cl_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sal_cl_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;


--STAR ? Level
CREATE TABLESPACE ts_sal_data_01
DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/ts_sal_data_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;
 
