drop table T_DAYS cascade constraints;

/*==============================================================*/
/* Table: T_DAYS                                                */
/*==============================================================*/
create table T_DAYS (
   DAY_ID               NUMBER                not null,
   LAST_DAY_OF_WEEK_FL  NUMBER,
   LAST_DAY_OF_MONTH_FL NUMBER,
   LAST_DAY_OF_QTR_FL   NUMBER,
   LAST_DAY_OF_YR_FL    NUMBER,
   DAY_OF_WEEK_NAME     VARCHAR2(128),
   DAY_OF_WEEK_ABR      VARCHAR2(128),
   DAY_NUMBER_OF_WEEK   NUMBER,
   DAY_NUMBER_OF_MONTH  NUMBER,
   DAY_NUMBER_OF_QTR    NUMBER,
   DAY_NUMBER_OF_YR     NUMBER,
   constraint PK_T_DAYS primary key (DAY_ID)
);

drop table T_WEEKS cascade constraints;

/*==============================================================*/
/* Table: T_WEEKS                                               */
/*==============================================================*/
create table T_WEEKS (
   WEEK_ID              NUMBER                not null,
   WEEK_NUMBER_OF_MONTH NUMBER,
   WEEK_NUMBER_OF_QTR   NUMBER,
   WEEK_NUMBER_OF_YR    NUMBER,
   WEEK_BEGIN_DT        DATE,
   WEEK_END_DT          DATE,
   constraint PK_T_WEEKS primary key (WEEK_ID)
);


drop table T_MONTHS cascade constraints;

/*==============================================================*/
/* Table: T_MONTHS                                              */
/*==============================================================*/
create table T_MONTHS (
   MONTH_ID             NUMBER                not null,
   MONTH_NAME           VARCHAR2(128),
   MONTH_NAME_ABBR      VARCHAR2(128),
   MONTH_NUMBER_OF_YR   NUMBER,
   MONTH_BEGIN_DT       DATE,
   MONTH_END_DT         DATE,
   constraint PK_T_MONTHS primary key (MONTH_ID)
);

drop table T_QUARTERS cascade constraints;

/*==============================================================*/
/* Table: T_QUARTERS                                            */
/*==============================================================*/
create table T_QUARTERS (
   GUARTER_ID           NUMBER                not null,
   QTR_NUMBER_OF_YR     NUMBER,
   QTR_BEGIN_DT         DATE,
   QTR_END_DT           DATE,
   constraint PK_T_QUARTERS primary key (GUARTER_ID)
);

drop table T_YEARS cascade constraints;

/*==============================================================*/
/* Table: T_YEARS                                               */
/*==============================================================*/
create table T_YEARS (
   YEAR_ID              NUMBER                not null,
   YR_BEGIN_DT          DATE,
   YR_END_DT            DATE,
   constraint PK_T_YEARS primary key (YEAR_ID)
);

alter table T_DATE
   drop constraint FK_T_DATE_REFERENCE_T_DAYS;

alter table T_DATE
   drop constraint FK_T_DATE_REFERENCE_T_WEEKS;

alter table T_DATE
   drop constraint FK_T_DATE_REFERENCE_T_MONTHS;

alter table T_DATE
   drop constraint FK_T_DATE_REFERENCE_T_QUARTE;

alter table T_DATE
   drop constraint FK_T_DATE_REFERENCE_T_YEARS;

drop table T_DATE cascade constraints;

/*==============================================================*/
/* Table: T_DATE                                                */
/*==============================================================*/
create table T_DATE (
   DATE_ID              NUMBER                not null,
   DAY_ID               NUMBER,
   WEEK_ID              NUMBER,
   MONTH_ID             NUMBER,
   GUARTER_ID           NUMBER,
   YEAR_ID              NUMBER,
   DATE_FULL_NUMBER     VARCHAR2(128),
   DATE_FULL_STRING     VARCHAR2(128),
   DATE_WEEKDAY_FL      NUMBER,
   DATE_US_CIVIL_HOLIDAY_FL NUMBER,
   DATE_CREATE_DT       DATE,
   INSERT_DT            DATE,
   UPDATE_DT            DATE,
   constraint PK_T_DATE primary key (DATE_ID)
);

alter table T_DATE
   add constraint FK_T_DATE_REFERENCE_T_DAYS foreign key (DAY_ID)
      references T_DAYS (DAY_ID);

alter table T_DATE
   add constraint FK_T_DATE_REFERENCE_T_WEEKS foreign key (WEEK_ID)
      references T_WEEKS (WEEK_ID);

alter table T_DATE
   add constraint FK_T_DATE_REFERENCE_T_MONTHS foreign key (MONTH_ID)
      references T_MONTHS (MONTH_ID);

alter table T_DATE
   add constraint FK_T_DATE_REFERENCE_T_QUARTE foreign key (GUARTER_ID)
      references T_QUARTERS (GUARTER_ID);

alter table T_DATE
   add constraint FK_T_DATE_REFERENCE_T_YEARS foreign key (YEAR_ID)
      references T_YEARS (YEAR_ID);
