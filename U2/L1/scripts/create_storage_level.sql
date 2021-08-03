drop table u_sa_customers_data.sa_customers cascade constraints;

/*==============================================================*/
/* Table: sa_customers                                         */
/*==============================================================*/
create table u_sa_customers_data.sa_customers (
   CUSTOMER_ID          NUMBER                not null,
   FIRST_NAME           VARCHAR2(128)         not null,
   LAST_NAME            VARCHAR2(128)         not null,
   GENDER               VARCHAR2(10)          not null,
   AGE                  NUMBER                not null,
   EMAIL                VARCHAR2(128)         not null,
   PHONE                VARCHAR2(128)         not null,
   constraint PK_SA_CUSTOMERS primary key (CUSTOMER_ID)
)
tablespace ts_sa_customers_data_01;



drop table u_sa_stores_data.sa_stores cascade constraints;

/*==============================================================*/
/* Table: sa_stores                                          */
/*==============================================================*/
create table u_sa_stores_data.sa_stores (
   STORE_ID             NUMBER                not null,
   STORE_DESC           VARCHAR2(128)         not null,
   EMAIL                VARCHAR2(128)         not null,
   PHONE                VARCHAR2(128)         not null,
   MANAGER_ID           NUMBER                not null,
   MANAGER_FIRST_NAME   VARCHAR2(128)         not null,
   MANAGER_LAST_NAME    VARCHAR2(128)         not null,
   constraint PK_SA_STORES primary key (STORE_ID)
)
tablespace ts_sa_stores_data_01;


drop table u_sa_employees_data.sa_employees cascade constraints;

/*==============================================================*/
/* Table: sa_employees                                         */
/*==============================================================*/
create table u_sa_employees_data.sa_employees (
   EMPLOYEE_ID          NUMBER                not null,
   FIRST_NAME           VARCHAR2(128)         not null,
   LAST_NAME            VARCHAR2(128)         not null,
   GENDER               VARCHAR2(10)          not null,
   AGE                  NUMBER                not null,
   EMAIL                VARCHAR2(128)         not null,
   PHONE                VARCHAR2(128)         not null,
   STORE_ID             NUMBER                not null,
   HIRE_DATE            DATE                  not null,
   MANAGER_ID           NUMBER                not null,
   constraint PK_SA_EMPLOYEES primary key (EMPLOYEE_ID)
)
tablespace ts_sa_employees_data_01;

drop table u_sa_pizzas_data.sa_pizzas cascade constraints;

/*==============================================================*/
/* Table: sa_pizzas                                        */
/*==============================================================*/
create table u_sa_pizzas_data.sa_pizzas (
   PIZZA_ID             NUMBER                not null,
   CATEGORY_ID          NUMBER                not null,
   CATEGORY_DESC        VARCHAR2(128)         not null,
   PIZZA_DESC           VARCHAR2(128)         not null,
   PIZZA_WEIGHT         NUMBER                not null,
   PIZZA_DIAMETER       NUMBER                not null,
   PIZZA_PRICE          NUMBER                not null,
   constraint PK_SA_PIZZAS_SCD primary key (PIZZA_ID)
)
tablespace ts_sa_pizzas_data_01;


drop table u_sa_promotions_data.sa_promotions cascade constraints;

/*==============================================================*/
/* Table: sa_promotions                                        */
/*==============================================================*/
create table u_sa_promotions_data.sa_promotions (
   PROMOTION_ID         NUMBER                not null,
   PROMOTION_DESC       VARCHAR2(128)         not null,
   PROMOTION_PERCENT    NUMBER                not null,
   PROMOTION_TYPE_ID    NUMBER                not null,
   PROMOTION_TYPE_DESC  VARCHAR2(128)         not null,
   constraint PK_SA_PROMOTIONS primary key (PROMOTION_ID)
)
tablespace ts_sa_promotions_data_01;


drop table u_sa_geo_locations_data.sa_geo_locations cascade constraints;

/*==============================================================*/
/* Table: sa_geo_locations                                     */
/*==============================================================*/
create table u_sa_geo_locations_data.sa_geo_locations (
   COUNTRY_GEO_ID      NUMBER                not null,
   GEO_COUNTRY_ID       NUMBER                not null,
   GEO_COUNTRY_CODE_A2  VARCHAR2(128)         not null,
   GEO_COUNTRY_CODE_A3  VARCHAR2(128)         not null,
   GEO_COUNTRY_DESC     VARCHAR2(128)         not null,
   REGION_GEO_ID        NUMBER                not null,
   GEO_REGION_ID        NUMBER                not null,
   GEO_REGION_CODE      VARCHAR2(128)         not null,
   GEO_REGION_DESC      VARCHAR2(128)         not null,
   CONTENET_GEO_ID      NUMBER                not null,
   GEO_PART_ID          NUMBER                not null,
   GEO_PART_CODE        VARCHAR2(128)         not null,
   GEO_PART_DESC        VARCHAR2(128)         not null,
   SYSTEM_GEO_ID        NUMBER                not null,
   GEO_SYSTEM_ID        NUMBER                not null,
   GEO_SYSTEM_CODE      VARCHAR2(128)         not null,
   GEO_SYSTEM_DESC      VARCHAR2(128)         not null,
   constraint PK_SA_GEO_LOCATIONS primary key (COUNTRY_GEO_ID)
)
tablespace ts_sa_geo_locations_data_01;

drop table u_sa_dates_data.sa_dates cascade constraints;

/*==============================================================*/
/* Table: sa_dates                                             */
/*==============================================================*/
create table u_sa_dates_data.sa_dates (
   DATE_KEY NUMBER
,DATE_FULL_NUMBER VARCHAR2(20)
,DATE_FULL_STRING VARCHAR2(50)
,DATE_WEEKDAY_FL NUMBER
,DATE_US_CIVIL_HOLIDAY_FL NUMBER
,DATE_LAST_DAY_OF_WEEK_FL NUMBER
,DATE_LAST_DAY_OF_MONTH_FL NUMBER
,DATE_LAST_DAY_OF_QTR_FL NUMBER
,DATE_LAST_DAY_OF_YR_FL NUMBER
,DATE_DAY_OF_WEEK_NAME VARCHAR2(20)
,DATE_DAY_OF_WEEK_ABBR VARCHAR2(20)
,DATE_MONTH_NAME VARCHAR2(20)
,DATE_MONTH_NAME_ABBR VARCHAR2(20)
,DATE_DAY_NUMBER_OF_WEEK NUMBER
,DATE_DAY_NUMBER_OF_MONTH NUMBER
,DATE_DAY_NUMBER_OF_QTR NUMBER
,DATE_DAY_NUMBER_OF_YR NUMBER
,DATE_WEEK_NUMBER_OF_MONTH NUMBER
,DATE_WEEK_NUMBER_OF_QTR NUMBER
,DATE_WEEK_NUMBER_OF_YR NUMBER
,DATE_MONTH_NUMBER_OF_YR NUMBER
,DATE_QTR_NUMBER_OF_YR NUMBER
,DATE_YEAR_NUMBER NUMBER
,DATE_WEEK_BEGIN_DT DATE
,DATE_WEEK_END_DT DATE
,DATE_MONTH_BEGIN_DT DATE
,DATE_MONTH_END_DT DATE
,DATE_QTR_BEGIN_DT DATE
,DATE_QTR_END_DT DATE
,DATE_YR_BEGIN_DT DATE
,DATE_YR_END_DT DATE
,CONSTRAINT PK_SA_DATES PRIMARY KEY (DATE_KEY)
)
tablespace ts_sa_dates_data_01;


drop table u_sa_payment_methods_data.sa_payment_methods cascade constraints;

/*==============================================================*/
/* Table: SA_PAYMENT_METHODS                                    */
/*==============================================================*/
create table u_sa_payment_methods_data.sa_payment_methods (
   PAYMENT_METHOD_ID    NUMBER                not null,
   PAYMENT_METHOD_DESC  VARCHAR2(128)         not null,
   constraint PK_SA_PAYMENT_METHODS primary key (PAYMENT_METHOD_ID)
)
tablespace ts_sa_payment_methods_data_01;


drop table u_sa_sales_data.sa_sales cascade constraints;

/*==============================================================*/
/* Table: sa_sales                                             */
/*==============================================================*/
create table u_sa_sales_data.sa_sales (
   SALES_ID             NUMBER                not null,
   EMPLOYEE_ID          NUMBER                not null,
   CUSTOMER_ID          NUMBER                not null,
   STORE_ID             NUMBER                not null,
   GEO_ID               NUMBER                not null,
   DATE_ID              NUMBER                not null,
   PIZZA_ID             NUMBER,
   PAYMENT_METHOD_ID    NUMBER                not null,
   PROMOTION_ID         NUMBER                not null,
   SALES_AMOUNT         NUMBER                not null,
   SALES_SUM            NUMBER                not null,
   constraint PK_SA_SALES primary key (SALES_ID)
)
tablespace ts_sa_sales_data_01;
