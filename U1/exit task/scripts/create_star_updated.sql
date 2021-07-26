drop table u_sa_dim_customers.DIM_CUSTOMERS cascade constraints;

/*==============================================================*/
/* Table: DIM_CUSTOMERS                                         */
/*==============================================================*/
create table u_sa_dim_customers.DIM_CUSTOMERS (
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
   constraint PK_DIM_CUSTOMERS primary key (CUSTOMER_ID)
)
tablespace ts_sa_dim_customers_01;



drop table u_sa_dim_stores.DIM_STORES cascade constraints;

/*==============================================================*/
/* Table: DIM_STORES                                            */
/*==============================================================*/
create table u_sa_dim_stores.DIM_STORES (
   STORE_ID             NUMBER                not null,
   MANAGER_ID           NUMBER                not null,
   PHONE                VARCHAR2(128)         not null,
   ADRESS               VARCHAR2(128)         not null,
   CITY                 VARCHAR2(128)         not null,
   COUNTRY              VARCHAR2(128)         not null,
   REGION               VARCHAR2(128)         not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DIM_STORES primary key (STORE_ID)
)
tablespace ts_sa_dim_stores_01;


drop table u_sa_dim_employees.DIM_EMPLOYEES cascade constraints;

/*==============================================================*/
/* Table: DIM_EMPLOYEES                                         */
/*==============================================================*/
create table u_sa_dim_employees.DIM_EMPLOYEES (
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
   constraint PK_DIM_EMPLOYEES primary key (EMPLOYEE_ID)
)
tablespace ts_sa_dim_employees_01;

drop table u_sa_dim_pizzas_scd.DIM_PIZZAS_SCD cascade constraints;

/*==============================================================*/
/* Table: DIM_PIZZAS_SCD                                        */
/*==============================================================*/
create table u_sa_dim_pizzas_scd.DIM_PIZZAS_SCD (
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
   constraint PK_DIM_PIZZAS_SCD primary key (PIZZA_ID)
)
tablespace ts_sa_dim_pizzas_scd_01;

drop table u_sa_dim_promotions.DIM_PROMOTIONS cascade constraints;

/*==============================================================*/
/* Table: DIM_PROMOTIONS                                        */
/*==============================================================*/
create table u_sa_dim_promotions.DIM_PROMOTIONS (
   PROMOTION_ID         NUMBER                not null,
   PROMOTION_DESC       VARCHAR2(128)         not null,
   PROMOTION_PERCENT    NUMBER                not null,
   PROMOTION_TYPE_ID    NUMBER                not null,
   PROMOTION_TYPE_DESC  VARCHAR2(128)         not null,
   LEFT_UNIT_AMOUNT     NUMBER                not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DIM_PROMOTIONS primary key (PROMOTION_ID)
)
tablespace ts_sa_dim_promotions_01;


drop table u_sa_dim_payment_methods.DIM_PAYMENT_METHODS cascade constraints;

/*==============================================================*/
/* Table: DIM_PAYMENT_METHODS                                   */
/*==============================================================*/
create table u_sa_dim_payment_methods.DIM_PAYMENT_METHODS (
   PAYMENT_METHOD_ID    NUMBER                not null,
   PAYMENT_METHOD_DESC  VARCHAR2(128)         not null,
   BANK_ID              NUMBER                not null,
   BANK_DESC            VARCHAR2(128)         not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DIM_PAYMENT_METHODS primary key (PAYMENT_METHOD_ID)
)
tablespace ts_sa_dim_payment_methods_01;

drop table u_sa_dim_geo_locations.DIM_GEO_LOCATIONS cascade constraints;

/*==============================================================*/
/* Table: DIM_GEO_LOCATIONS                                     */
/*==============================================================*/
create table u_sa_dim_geo_locations.DIM_GEO_LOCATIONS (
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
   constraint PK_DIM_GEO_LOCATIONS primary key (GEO_ID)
)
tablespace ts_sa_dim_geo_locations_01;

drop table u_sa_dim_dates.DIM_DATES cascade constraints;

/*==============================================================*/
/* Table: DIM_DATES                                             */
/*==============================================================*/
create table u_sa_dim_dates.DIM_DATES (
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
   constraint PK_DIM_DATES primary key (DATE_ID)
)
tablespace ts_sa_dim_dates_01;

drop table u_sa_dim_gen_period.DIM_GEN_PERIOD cascade constraints;

/*==============================================================*/
/* Table: DIM_GEN_PERIOD                                        */
/*==============================================================*/
create table u_sa_dim_gen_period.DIM_GEN_PERIOD (
   SALES_CAT_ID         NUMBER                not null,
   SALES_CAT_DESC       VARCHAR2(128)         not null,
   START_AMOUNT         NUMBER                not null,
   END_AMOUNT           NUMBER                not null,
   INSERT_DT            DATE                  not null,
   UPDATE_DT            DATE                  not null,
   constraint PK_DIM_GEN_PERIOD primary key (SALES_CAT_ID)
)
tablespace ts_sa_dim_gen_period_01;


alter table u_sa_fct_sales.FCT_SALES
   drop constraint FK_FCT_SALE_REFERENCE_DIM_CUST;

alter table u_sa_fct_sales.FCT_SALES
   drop constraint FK_FCT_SALE_REFERENCE_DIM_PIZZ;

alter table u_sa_fct_sales.FCT_SALES
   drop constraint FK_FCT_SALE_REFERENCE_DIM_EMPL;

alter table u_sa_fct_sales.FCT_SALES
   drop constraint FK_FCT_SALE_REFERENCE_DIM_DATE;

alter table u_sa_fct_sales.FCT_SALES
   drop constraint FK_FCT_SALE_REFERENCE_DIM_STOR;

alter table u_sa_fct_sales.FCT_SALES
   drop constraint FK_FCT_SALE_REFERENCE_DIM_PAYM;

alter table u_sa_fct_sales.FCT_SALES
   drop constraint FK_FCT_SALE_REFERENCE_DIM_PROM;

alter table u_sa_fct_sales.FCT_SALES
   drop constraint FK_FCT_SALE_REFERENCE_DIM_GEO_;

alter table u_sa_fct_sales.FCT_SALES
   drop constraint FK_FCT_SALE_REFERENCE_DIM_GEN_;

drop table u_sa_fct_sales.FCT_SALES cascade constraints;

/*==============================================================*/
/* Table: FCT_SALES                                             */
/*==============================================================*/
create table u_sa_fct_sales.FCT_SALES (
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
   constraint PK_FCT_SALES primary key (SALES_ID)
) PARTITION BY RANGE (EVENT_DT)
    subpartition by hash(SALES_CAT_ID) subpartitions 4
(
    PARTITION QUARTER_1 VALUES LESS THAN(TO_DATE('01-apr-2020','dd-mon-yyyy'))
    (
      subpartition Q_1_1,
      subpartition Q_1_2,
      subpartition Q_1_3,
      subpartition Q_1_4
    ),
    PARTITION QUARTER_2 VALUES LESS THAN(TO_DATE('01-jul-2020','dd-mon-yyyy'))
    (
      subpartition Q_2_1,
      subpartition Q_2_2,
      subpartition Q_2_3,
      subpartition Q_2_4
     ),
     PARTITION QUARTER_3 VALUES LESS THAN(TO_DATE('01-oct-2020','dd-mon-yyyy'))
    (
      subpartition Q_3_1,
      subpartition Q_3_2,
      subpartition Q_3_3,
      subpartition Q_3_4
    ),
     PARTITION QUARTER_4 VALUES LESS THAN(TO_DATE('01-jan-2021','dd-mon-yyyy'))
    (
      subpartition Q_4_1,
      subpartition Q_4_2,
      subpartition Q_4_3,
      subpartition Q_4_4
    )
) tablespace ts_sa_fct_sales_01;

alter table u_sa_fct_sales.FCT_SALES
   add constraint FK_FCT_SALE_REFERENCE_DIM_CUST foreign key (CUSTOMER_ID)
      references u_sa_dim_customers.DIM_CUSTOMERS (CUSTOMER_ID);

alter table u_sa_fct_sales.FCT_SALES
   add constraint FK_FCT_SALE_REFERENCE_DIM_PIZZ foreign key (PRODUCT_ID)
      references u_sa_dim_pizzas_scd.DIM_PIZZAS_SCD (PIZZA_ID);

alter table u_sa_fct_sales.FCT_SALES
   add constraint FK_FCT_SALE_REFERENCE_DIM_EMPL foreign key (EMPLOYEE_ID)
      references u_sa_dim_employees.DIM_EMPLOYEES (EMPLOYEE_ID);

alter table u_sa_fct_sales.FCT_SALES
   add constraint FK_FCT_SALE_REFERENCE_DIM_DATE foreign key (DATE_ID)
      references u_sa_dim_dates.DIM_DATES (DATE_ID);

alter table u_sa_fct_sales.FCT_SALES
   add constraint FK_FCT_SALE_REFERENCE_DIM_STOR foreign key (STORE_ID)
      references u_sa_dim_stores.DIM_STORES (STORE_ID);

alter table u_sa_fct_sales.FCT_SALES
   add constraint FK_FCT_SALE_REFERENCE_DIM_PAYM foreign key (PAYMENT_METHOD_ID)
      references u_sa_dim_payment_methods.DIM_PAYMENT_METHODS (PAYMENT_METHOD_ID);

alter table u_sa_fct_sales.FCT_SALES
   add constraint FK_FCT_SALE_REFERENCE_DIM_PROM foreign key (PROMOTION_ID)
      references u_sa_dim_promotions.DIM_PROMOTIONS (PROMOTION_ID);

alter table u_sa_fct_sales.FCT_SALES
   add constraint FK_FCT_SALE_REFERENCE_DIM_GEO_ foreign key (GEO_ID)
      references u_sa_dim_geo_locations.DIM_GEO_LOCATIONS (GEO_ID);

alter table u_sa_fct_sales.FCT_SALES
   add constraint FK_FCT_SALE_REFERENCE_DIM_GEN_ foreign key (SALES_CAT_ID)
      references u_sa_dim_gen_period.DIM_GEN_PERIOD (SALES_CAT_ID);
