drop table u_sa_customers_data.sa_customers cascade constraints;

/*==============================================================*/
/* Table: sa_customers                                         */
/*==============================================================*/
create table u_sa_customers_data.sa_customers (
   CUSTOMER_ID          NUMBER                not null,
   FIRST_NAME           VARCHAR2(128)         not null,
   LAST_NAME            VARCHAR2(128)         not null,
   AGE                  NUMBER                not null,
   EMAIL                VARCHAR2(128)         not null,
   PHONE                VARCHAR2(128)         not null,
   ADRESS               VARCHAR2(128)         not null,
   CITY                 VARCHAR2(128)         not null,
   COUNTRY              VARCHAR2(128)         not null,
   REGION               VARCHAR2(128)         not null,
   constraint PK_SA_CUSTOMERS primary key (CUSTOMER_ID)
)
tablespace ts_sa_customers_data_01;



drop table u_sa_stores_data.sa_stores cascade constraints;

/*==============================================================*/
/* Table: sa_stores                                          */
/*==============================================================*/
create table u_sa_stores_data.sa_stores (
   STORE_ID             NUMBER                not null,
   MANAGER_ID           NUMBER                not null,
   PHONE                VARCHAR2(128)         not null,
   ADRESS               VARCHAR2(128)         not null,
   CITY                 VARCHAR2(128)         not null,
   COUNTRY              VARCHAR2(128)         not null,
   REGION               VARCHAR2(128)         not null,
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
   EMAIL                VARCHAR2(128)         not null,
   PHONE                VARCHAR2(128)         not null,
   CAFE_ID              NUMBER                not null,
   HIRE_DATE            DATE                  not null,
   FIRE_DATE            DATE                  not null,
   MANAGER_ID           NUMBER                not null,
   MANAGER_FIRST_NAME   VARCHAR2(128)         not null,
   MANAGER_LAST_NAME    VARCHAR2(128)         not null,
   constraint PK_SA_EMPLOYEES primary key (EMPLOYEE_ID)
)
tablespace ts_sa_employees_data_01;

drop table u_sa_pizzas_data.sa_pizzas cascade constraints;

/*==============================================================*/
/* Table: sa_pizzas                                        */
/*==============================================================*/
create table u_sa_pizzas_data.sa_pizzas (
   PIZZA_ID             NUMBER                not null,
   PIZZA_DESC           VARCHAR2(128)         not null,
   PIZZA_WEIGHT         NUMBER                not null,
   PIZZA_DIAMETER       NUMBER                not null,
   PIZZA_PRICE          NUMBER                not null,
   CATEGORY_ID          NUMBER                not null,
   CATEGORY_DESC        VARCHAR2(128)         not null,
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
   LEFT_UNIT_AMOUNT     NUMBER                not null,
   constraint PK_SA_PROMOTIONS primary key (PROMOTION_ID)
)
tablespace ts_sa_promotions_data_01;


drop table u_sa_payment_methods_data.sa_payment_methods cascade constraints;

/*==============================================================*/
/* Table: sa_payment_methods                                   */
/*==============================================================*/
create table u_sa_payment_methods_data.sa_payment_methods (
   PAYMENT_METHOD_ID    NUMBER                not null,
   PAYMENT_METHOD_DESC  VARCHAR2(128)         not null,
   BANK_ID              NUMBER                not null,
   BANK_DESC            VARCHAR2(128)         not null,
   constraint PK_SA_PAYMENT_METHODS primary key (PAYMENT_METHOD_ID)
)
tablespace ts_sa_payment_methods_data_01;

drop table u_sa_geo_locations_data.sa_geo_locations cascade constraints;

/*==============================================================*/
/* Table: sa_geo_locations                                     */
/*==============================================================*/
create table u_sa_geo_locations_data.sa_geo_locations (
   GEO_ID               NUMBER                not null,
   GEO_COUNTRY_ID       NUMBER                not null,
   GEO_COUNTRY_CODE_A2  VARCHAR2(128)         not null,
   GEO_COUNTRY_CODE_A3  VARCHAR2(128)         not null,
   GEO_COUNTRY_DESC     VARCHAR2(128)         not null,
   GEO_REGION_ID        NUMBER                not null,
   GEO_REGION_DESC      VARCHAR2(128)         not null,
   GEO_REGION_CODE      NUMBER                not null,
   GEO_PART_ID          NUMBER                not null,
   GEO_PART_CODE        NUMBER                not null,
   GEO_PART_DESC        VARCHAR2(128)         not null,
   GEO_SYSTEM_ID        NUMBER                not null,
   GEO_SYSTEM_CODE      NUMBER                not null,
   GEO_SYSTEM_DESC      VARCHAR2(128)         not null,
   constraint PK_SA_GEO_LOCATIONS primary key (GEO_ID)
)
tablespace ts_sa_geo_locations_data_01;


drop table u_sa_sales_data.sa_sales cascade constraints;

/*==============================================================*/
/* Table: sa_sales                                             */
/*==============================================================*/
create table u_sa_sales_data.sa_sales (
   EVENT_DT             DATE                  not null,
   SALES_ID             NUMBER                not null,
   PRODUCT_ID           NUMBER                not null,
   EMPLOYEE_ID          NUMBER                not null,
   CUSTOMER_ID          NUMBER                not null,
   STORE_ID             NUMBER                not null,
   GEO_ID               NUMBER                not null,
   DATE_ID              NUMBER                not null,
   PAYMENT_METHOD_ID    NUMBER                not null,
   PROMOTION_ID         NUMBER                not null,
   SALES_CAT_ID         NUMBER                not null,
   SALES_AMOUNT         NUMBER                not null,
   SALES_SUM            NUMBER                not null,
   constraint PK_FCT_SALES primary key (SALES_ID)
)
tablespace ts_sa_sales_data_01;