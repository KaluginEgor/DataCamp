drop table u_dw_data.DW_CUSTOMERS cascade constraints;

/*==============================================================*/
/* Table: DW_CUSTOMERS                                         */
/*==============================================================*/
create table u_dw_data.DW_CUSTOMERS (
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
   MANAGER_ID           NUMBER                not null,
   PHONE                VARCHAR2(128)         not null,
   ADRESS               VARCHAR2(128)         not null,
   CITY                 VARCHAR2(128)         not null,
   COUNTRY              VARCHAR2(128)         not null,
   REGION               VARCHAR2(128)         not null,
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
   EMAIL                VARCHAR2(128)         not null,
   PHONE                VARCHAR2(128)         not null,
   CAFE_ID              NUMBER                not null,
   HIRE_DATE            DATE                  not null,
   FIRE_DATE            DATE                  not null,
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
   PIZZA_ID             NUMBER                not null,
   PIZZA_DESC           VARCHAR2(128)         not null,
   PIZZA_WEIGHT         NUMBER                not null,
   PIZZA_DIAMETER       NUMBER                not null,
   PIZZA_PRICE          NUMBER                not null,
   VALID_FROM           DATE                  not null,
   VALID_TO             CHAR(10)              not null,
   IS_ACTIVE            CHAR(10)              not null,
   CATEGORY_ID          NUMBER                not null,
   CATEGORY_DESC        VARCHAR2(128)         not null,
   INSERT_DT            DATE                  not null,
   constraint PK_DW_PIZZAS_SCD primary key (PIZZA_ID)
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
   LEFT_UNIT_AMOUNT     NUMBER                not null,
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
   BANK_ID              NUMBER                not null,
   BANK_DESC            VARCHAR2(128)         not null,
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
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_GEO_LOCATIONS primary key (GEO_ID)
)
tablespace ts_dw_data_01;

drop table u_dw_data.DW_DATES cascade constraints;

/*==============================================================*/
/* Table: DW_DATES                                             */
/*==============================================================*/
create table u_dw_data.DW_DATES (
   DATE_ID              NUMBER                not null,
   DATE_FULL_NUMBER     VARCHAR2(128)         not null,
   DATE_FULL_STRING     VARCHAR2(128)         not null,
   DATE_WEEKDAY_FL      NUMBER                not null,
   DATE_US_CIVIL_HOLIDAY_FL NUMBER                not null,
   DATE_LAST_DAY_OF_WEEK_FL NUMBER                not null,
   DATE_LAST_DAY_OF_MONTH_FL NUMBER                not null,
   DATE_LAST_DAY_OF_QTR_FL NUMBER                not null,
   DATE_LAST_DAY_OF_YR_FL NUMBER                not null,
   DATE_DAY_OF_WEEK_NAME VARCHAR2(128)         not null,
   DATE_DAY_OF_WEEK_ABR VARCHAR2(128)         not null,
   DATE_MONTH_NAME      VARCHAR2(128)         not null,
   DATE_MONTH_NAME_ABBR VARCHAR2(128)         not null,
   DATE_DAY_NUMBER_OF_WEEK NUMBER                not null,
   DATE_DAY_NUMBER_OF_MONTH NUMBER                not null,
   DATE_DAY_NUMBER_OF_QTR NUMBER                not null,
   DATE_DAY_NUMBER_OF_YR NUMBER                not null,
   DATE_WEEK_NUMBER_OF_MONTH NUMBER                not null,
   DATE_WEEK_NUMBER_OF_QTR NUMBER                not null,
   DATE_WEEK_NUMBER_OF_YR NUMBER                not null,
   DATE_MONTH_NUMBER_OF_YR NUMBER                not null,
   DATE_QTR_NUMBER_OF_YR NUMBER                not null,
   DATE_YEAR_NUMBER     NUMBER                not null,
   DATE_WEEK_BEGIN_DT   DATE                  not null,
   DATE_WEEK_END_DT     DATE                  not null,
   DATE_MONTH_BEGIN_DT  DATE                  not null,
   DATE_MONTH_END_DT    DATE                  not null,
   DATE_QTR_BEGIN_DT    DATE                  not null,
   DATE_QTR_END_DT      DATE                  not null,
   DATE_YR_BEGIN_DT     DATE                  not null,
   DATE_YR_END_DT       DATE                  not null,
   DATE_CREATE_DT       DATE                  not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_DATES primary key (DATE_ID)
)
tablespace ts_dw_data_01;

drop table u_dw_data.DW_GEN_PERIOD cascade constraints;

/*==============================================================*/
/* Table: DW_GEN_PERIOD                                        */
/*==============================================================*/
create table u_dw_data.DW_GEN_PERIOD (
   SALES_CAT_ID         NUMBER                not null,
   SALES_CAT_DESC       VARCHAR2(128)         not null,
   START_AMOUNT         NUMBER                not null,
   END_AMOUNT           NUMBER                not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_GEN_PERIOD primary key (SALES_CAT_ID)
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
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DW_SALES primary key (SALES_ID)
)
tablespace ts_dw_data_01;

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_CUST foreign key (CUSTOMER_ID)
      references u_dw_data.DW_CUSTOMERS (CUSTOMER_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_PIZZ foreign key (PRODUCT_ID)
      references u_dw_data.DW_PIZZAS_SCD (PIZZA_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_EMPL foreign key (EMPLOYEE_ID)
      references u_dw_data.DW_EMPLOYEES (EMPLOYEE_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_DATE foreign key (DATE_ID)
      references u_dw_data.DW_DATES (DATE_ID);

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
      references u_dw_data.DW_GEO_LOCATIONS (GEO_ID);

alter table u_dw_data.DW_SALES
   add constraint FK_DW_SALE_REFERENCE_DW_GEN_ foreign key (SALES_CAT_ID)
      references u_dw_data.DW_GEN_PERIOD (SALES_CAT_ID);
