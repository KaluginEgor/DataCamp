CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_dates AS
   PROCEDURE load_dates 
   IS  
    BEGIN
        DECLARE
            TYPE curtype IS REF CURSOR;
            sql_stmt   CLOB;
            src_cur    curtype;
            curid      NUMBER;
            
            BEGIN
                sql_stmt := 'SELECT * FROM u_sa_dates_data.sa_dates';
                OPEN src_cur FOR sql_stmt;
                curid := DBMS_SQL.to_cursor_number(src_cur);
    
                DBMS_SQL.DEFINE_COLUMN(curid, 1, DATE_KEY);
                DBMS_SQL.DEFINE_COLUMN(curid, 2, DATE_FULL_NUMBER, 20);
                DBMS_SQL.DEFINE_COLUMN(curid, 3, DATE_FULL_STRING, 50);
                DBMS_SQL.DEFINE_COLUMN(curid, 4, DATE_WEEKDAY_FL);
                DBMS_SQL.DEFINE_COLUMN(curid, 5, DATE_US_CIVIL_HOLIDAY_FL);
                DBMS_SQL.DEFINE_COLUMN(curid, 6, DATE_LAST_DAY_OF_WEEK_FL);
                DBMS_SQL.DEFINE_COLUMN(curid, 7, DATE_LAST_DAY_OF_MONTH_FL);
                DBMS_SQL.DEFINE_COLUMN(curid, 8, DATE_LAST_DAY_OF_QTR_FL);
                DBMS_SQL.DEFINE_COLUMN(curid, 9, DATE_LAST_DAY_OF_YR_FL);
                DBMS_SQL.DEFINE_COLUMN(curid, 10, DATE_DAY_OF_WEEK_NAME, 20);
                DBMS_SQL.DEFINE_COLUMN(curid, 11, DATE_DAY_OF_WEEK_ABBR, 20);
                DBMS_SQL.DEFINE_COLUMN(curid, 12, DATE_MONTH_NAME, 20);
                DBMS_SQL.DEFINE_COLUMN(curid, 13, DATE_MONTH_NAME_ABBR, 20);
                DBMS_SQL.DEFINE_COLUMN(curid, 14, DATE_DAY_NUMBER_OF_WEEK);
                DBMS_SQL.DEFINE_COLUMN(curid, 15, DATE_DAY_NUMBER_OF_MONTH);
                DBMS_SQL.DEFINE_COLUMN(curid, 16, DATE_DAY_NUMBER_OF_QTR);
                DBMS_SQL.DEFINE_COLUMN(curid, 17, DATE_DAY_NUMBER_OF_YR);
                DBMS_SQL.DEFINE_COLUMN(curid, 18, DATE_WEEK_NUMBER_OF_MONTH);
                DBMS_SQL.DEFINE_COLUMN(curid, 19, DATE_WEEK_NUMBER_OF_QTR);
                DBMS_SQL.DEFINE_COLUMN(curid, 20, DATE_WEEK_NUMBER_OF_YR);
                DBMS_SQL.DEFINE_COLUMN(curid, 21, DATE_MONTH_NUMBER_OF_YR);
                DBMS_SQL.DEFINE_COLUMN(curid, 22, DATE_QTR_NUMBER_OF_YR);
                DBMS_SQL.DEFINE_COLUMN(curid, 23, DATE_YEAR_NUMBER);
                DBMS_SQL.DEFINE_COLUMN(curid, 24, DATE_WEEK_BEGIN_DT);
                DBMS_SQL.DEFINE_COLUMN(curid, 25, DATE_WEEK_END_DT);
                DBMS_SQL.DEFINE_COLUMN(curid, 26, DATE_MONTH_BEGIN_DT);
                DBMS_SQL.DEFINE_COLUMN(curid, 27, DATE_MONTH_END_DT);
                DBMS_SQL.DEFINE_COLUMN(curid, 28, DATE_QTR_BEGIN_DT);
                DBMS_SQL.DEFINE_COLUMN(curid, 29, DATE_QTR_END_DT);
                DBMS_SQL.DEFINE_COLUMN(curid, 30, DATE_YR_BEGIN_DT);
                DBMS_SQL.DEFINE_COLUMN(curid, 31, DATE_YR_END_DT);
    
    
                WHILE DBMS_SQL.fetch_rows(curid) > 0
                    LOOP
                        DBMS_SQL.COLUMN_VALUE(curid, 1, DATE_KEY);
                        DBMS_SQL.COLUMN_VALUE(curid, 2, DATE_FULL_NUMBER);
                        DBMS_SQL.COLUMN_VALUE(curid, 3, DATE_FULL_STRING);
                        DBMS_SQL.COLUMN_VALUE(curid, 4, DATE_WEEKDAY_FL);
                        DBMS_SQL.COLUMN_VALUE(curid, 5, DATE_US_CIVIL_HOLIDAY_FL);
                        DBMS_SQL.COLUMN_VALUE(curid, 6, DATE_LAST_DAY_OF_WEEK_FL);
                        DBMS_SQL.COLUMN_VALUE(curid, 7, DATE_LAST_DAY_OF_MONTH_FL);
                        DBMS_SQL.COLUMN_VALUE(curid, 8, DATE_LAST_DAY_OF_QTR_FL);
                        DBMS_SQL.COLUMN_VALUE(curid, 9, DATE_LAST_DAY_OF_YR_FL);
                        DBMS_SQL.COLUMN_VALUE(curid, 10, DATE_DAY_OF_WEEK_NAME);
                        DBMS_SQL.COLUMN_VALUE(curid, 11, DATE_DAY_OF_WEEK_ABBR);
                        DBMS_SQL.COLUMN_VALUE(curid, 12, DATE_MONTH_NAME);
                        DBMS_SQL.COLUMN_VALUE(curid, 13, DATE_MONTH_NAME_ABBR);
                        DBMS_SQL.COLUMN_VALUE(curid, 14, DATE_DAY_NUMBER_OF_WEEK);
                        DBMS_SQL.COLUMN_VALUE(curid, 15, DATE_DAY_NUMBER_OF_MONTH);
                        DBMS_SQL.COLUMN_VALUE(curid, 16, DATE_DAY_NUMBER_OF_QTR);
                        DBMS_SQL.COLUMN_VALUE(curid, 17, DATE_DAY_NUMBER_OF_YR);
                        DBMS_SQL.COLUMN_VALUE(curid, 18, DATE_WEEK_NUMBER_OF_MONTH);
                        DBMS_SQL.COLUMN_VALUE(curid, 19, DATE_WEEK_NUMBER_OF_QTR);
                        DBMS_SQL.COLUMN_VALUE(curid, 20, DATE_WEEK_NUMBER_OF_YR);
                        DBMS_SQL.COLUMN_VALUE(curid, 21, DATE_MONTH_NUMBER_OF_YR);
                        DBMS_SQL.COLUMN_VALUE(curid, 22, DATE_QTR_NUMBER_OF_YR);
                        DBMS_SQL.COLUMN_VALUE(curid, 23, DATE_YEAR_NUMBER);
                        DBMS_SQL.COLUMN_VALUE(curid, 24, DATE_WEEK_BEGIN_DT);
                        DBMS_SQL.COLUMN_VALUE(curid, 25, DATE_WEEK_END_DT);
                        DBMS_SQL.COLUMN_VALUE(curid, 26, DATE_MONTH_BEGIN_DT);
                        DBMS_SQL.COLUMN_VALUE(curid, 27, DATE_MONTH_END_DT);
                        DBMS_SQL.COLUMN_VALUE(curid, 28, DATE_QTR_BEGIN_DT);
                        DBMS_SQL.COLUMN_VALUE(curid, 29, DATE_QTR_END_DT);
                        DBMS_SQL.COLUMN_VALUE(curid, 30, DATE_YR_BEGIN_DT);
                        DBMS_SQL.COLUMN_VALUE(curid, 31, DATE_YR_END_DT);
                        INSERT INTO u_dw_data.DW_DATES
                        VALUES (DATE_KEY, DATE_FULL_NUMBER, DATE_FULL_STRING, DATE_WEEKDAY_FL, DATE_US_CIVIL_HOLIDAY_FL
                                , DATE_LAST_DAY_OF_WEEK_FL, DATE_LAST_DAY_OF_MONTH_FL, DATE_LAST_DAY_OF_QTR_FL
                                , DATE_LAST_DAY_OF_YR_FL, DATE_DAY_OF_WEEK_NAME, DATE_DAY_OF_WEEK_ABBR, DATE_MONTH_NAME
                                , DATE_MONTH_NAME_ABBR, DATE_DAY_NUMBER_OF_WEEK, DATE_DAY_NUMBER_OF_MONTH, DATE_DAY_NUMBER_OF_QTR
                                , DATE_DAY_NUMBER_OF_YR, DATE_WEEK_NUMBER_OF_MONTH, DATE_WEEK_NUMBER_OF_QTR, DATE_WEEK_NUMBER_OF_YR
                                , DATE_MONTH_NUMBER_OF_YR, DATE_QTR_NUMBER_OF_YR, DATE_YEAR_NUMBER, DATE_WEEK_BEGIN_DT, DATE_WEEK_END_DT
                                , DATE_MONTH_BEGIN_DT, DATE_MONTH_END_DT, DATE_QTR_BEGIN_DT, DATE_QTR_END_DT, DATE_YR_BEGIN_DT, DATE_YR_END_DT
                                , (SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL));
                    END LOOP;
    
                DBMS_SQL.close_cursor(curid);
    
                commit;
            END;
        END load_dates;
    END;
/