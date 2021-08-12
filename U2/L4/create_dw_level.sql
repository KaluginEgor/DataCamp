drop table u_dw_data.DW_CUSTOMERS cascade constraints;

/*==============================================================*/
/* Table: DW_CUSTOMERS                                         */
/*==============================================================*/
create table u_dw_data.DW_CUSTOMERS (
   CUSTOMER_ID          NUMBER                not null,
   FIRST_NAME           VARCHAR2(128)         not null,
   LAST_NAME            VARCHAR2(128)         not null,
   GENDER               VARCHAR2(10)          not null,
   AGE                  NUMBER                not null,
   EMAIL                VARCHAR2(128)         not null,
   PHONE                VARCHAR2(128)         not null,
   COUNTRY_GEO_ID       NUMBER                not null,
   GEO_COUNTRY_DESC     VARCHAR2(128)         not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_CUSTOMERS primary key (CUSTOMER_ID)
)
tablespace ts_dw_data_01;



drop table u_dw_data.DW_STORES cascade constraints;

/*==============================================================*/
/* Table: DW_STORES                                            */
/*==============================================================*/
create table u_dw_data.DW_STORES (
   STORE_ID             NUMBER                not null,
   STORE_DESC           VARCHAR2(128)         not null,
   EMAIL                VARCHAR2(128)         not null,
   PHONE                VARCHAR2(128)         not null,
   MANAGER_ID           NUMBER                not null,
   MANAGER_FIRST_NAME   VARCHAR2(128)         not null,
   MANAGER_LAST_NAME    VARCHAR2(128)         not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_STORES primary key (STORE_ID)
)
tablespace ts_dw_data_01;


drop table u_dw_data.DW_EMPLOYEES cascade constraints;

/*==============================================================*/
/* Table: DW_EMPLOYEES                                         */
/*==============================================================*/
create table u_dw_data.DW_EMPLOYEES (
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
   MANAGER_FIRST_NAME   VARCHAR2(128)         not null,
   MANAGER_LAST_NAME    VARCHAR2(128)         not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_EMPLOYEES primary key (EMPLOYEE_ID)
)
tablespace ts_dw_data_01;

drop table u_dw_data.DW_PIZZAS_SCD cascade constraints;

/*==============================================================*/
/* Table: DW_PIZZAS_SCD                                        */
/*==============================================================*/
create table u_dw_data.DW_PIZZAS_SCD (
   PIZZA_SURR_ID        NUMBER                not null,
   PIZZA_ID             NUMBER                not null,
   PIZZA_DESC           VARCHAR2(128)         not null,
   CATEGORY_ID          NUMBER                not null,
   CATEGORY_DESC        VARCHAR2(128)         not null,
   PIZZA_WEIGHT         NUMBER                not null,
   PIZZA_DIAMETER       NUMBER                not null,
   PIZZA_PRICE          NUMBER                not null,
   VALID_FROM           DATE                  not null,
   VALID_TO             DATE                          ,
   IS_ACTIVE            NUMBER                not null,
   INSERT_DT            DATE                  not null,
   constraint PK_DW_PIZZAS_SCD primary key (PIZZA_SURR_ID)
)
tablespace ts_dw_data_01;

drop table u_dw_data.DW_PROMOTIONS cascade constraints;

/*==============================================================*/
/* Table: DW_PROMOTIONS                                        */
/*==============================================================*/
create table u_dw_data.DW_PROMOTIONS (
   PROMOTION_ID         NUMBER                not null,
   PROMOTION_DESC       VARCHAR2(128)         not null,
   PROMOTION_PERCENT    NUMBER                not null,
   PROMOTION_TYPE_ID    NUMBER                not null,
   PROMOTION_TYPE_DESC  VARCHAR2(128)         not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_PROMOTIONS primary key (PROMOTION_ID)
)
tablespace ts_dw_data_01;


drop table u_dw_data.DW_PAYMENT_METHODS cascade constraints;

/*==============================================================*/
/* Table: DW_PAYMENT_METHODS                                   */
/*==============================================================*/
create table u_dw_data.DW_PAYMENT_METHODS (
   PAYMENT_METHOD_ID    NUMBER                not null,
   PAYMENT_METHOD_DESC  VARCHAR2(128)         not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_PAYMENT_METHODS primary key (PAYMENT_METHOD_ID)
)
tablespace ts_dw_data_01;

drop table u_dw_data.DW_GEO_LOCATIONS cascade constraints;

/*==============================================================*/
/* Table: DW_GEO_LOCATIONS                                     */
/*==============================================================*/
create table u_dw_data.DW_GEO_LOCATIONS (
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
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_GEO_LOCATIONS primary key (COUNTRY_GEO_ID)
)
tablespace ts_dw_data_01;

drop table u_dw_data.DW_DATES cascade constraints;

/*==============================================================*/
/* Table: DW_DATES                                             */
/*==============================================================*/
create table u_dw_data.DW_DATES (
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
,INSERT_DT DATE
,UPDATE_DT DATE
,constraint PK_DW_DATES primary key (DATE_KEY)
)
tablespace ts_dw_data_01;

drop table u_dw_data.DW_GEN_PERIODS cascade constraints;

/*==============================================================*/
/* Table: DW_GEN_PERIOD                                        */
/*==============================================================*/
create table u_dw_data.DW_GEN_PERIODS (
   SALES_CAT_ID         NUMBER                not null,
   SALES_CAT_DESC       VARCHAR2(128)         not null,
   START_AMOUNT         NUMBER                not null,
   END_AMOUNT           NUMBER                not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_GEN_PERIODS primary key (SALES_CAT_ID)
)
tablespace ts_dw_data_01;


alter table u_dw_data.DW_SALES
   drop constraint FK_DW_SALE_REFERENCE_DW_CUST;

alter table u_dw_data.DW_SALES
   drop constraint FK_DW_SALE_REFERENCE_DW_PIZZ;

alter table u_dw_data.DW_SALES
   drop constraint FK_DW_SALE_REFERENCE_DW_EMPL;

alter table u_dw_data.DW_SALES
   drop constraint FK_DW_SALE_REFERENCE_DW_DATE;

alter table u_dw_data.DW_SALES
   drop constraint FK_DW_SALE_REFERENCE_DW_STOR;

alter table u_dw_data.DW_SALES
   drop constraint FK_DW_SALE_REFERENCE_DW_PAYM;

alter table u_dw_data.DW_SALES
   drop constraint FK_DW_SALE_REFERENCE_DW_PROM;

alter table u_dw_data.DW_SALES
   drop constraint FK_DW_SALE_REFERENCE_DW_GEO_;

alter table u_dw_data.DW_SALES
   drop constraint FK_DW_SALE_REFERENCE_DW_GEN_;

drop table u_dw_data.DW_SALES cascade constraints;

/*==============================================================*/
/* Table: DW_SALES                                             */
/*==============================================================*/
create table u_dw_data.DW_SALES (
   EVENT_DT             DATE                  not null,
   SALES_ID             NUMBER                not null,
   PIZZA_SURR_ID        NUMBER                not null,
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
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_SALES primary key (SALES_ID)
)
tablespace ts_dw_data_01;

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_CUST foreign key (CUSTOMER_ID)
      references u_dw_data.DW_CUSTOMERS (CUSTOMER_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_PIZZ foreign key (PIZZA_SURR_ID)
      references u_dw_data.DW_PIZZAS_SCD (PIZZA_SURR_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_EMPL foreign key (EMPLOYEE_ID)
      references u_dw_data.DW_EMPLOYEES (EMPLOYEE_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_DATE foreign key (DATE_ID)
      references u_dw_data.DW_DATES (DATE_KEY);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_STOR foreign key (STORE_ID)
      references u_dw_data.DW_STORES (STORE_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_PAYM foreign key (PAYMENT_METHOD_ID)
      references u_dw_data.DW_PAYMENT_METHODS (PAYMENT_METHOD_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_PROM foreign key (PROMOTION_ID)
      references u_dw_data.DW_PROMOTIONS (PROMOTION_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_GEO_ foreign key (GEO_ID)
      references u_dw_data.DW_GEO_LOCATIONS (COUNTRY_GEO_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_GEN_ foreign key (SALES_CAT_ID)
      references u_dw_data.DW_GEN_PERIODS (SALES_CAT_ID);
