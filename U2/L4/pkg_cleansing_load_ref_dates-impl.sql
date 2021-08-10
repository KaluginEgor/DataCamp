CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_dates AS
   PROCEDURE load_dates 
   IS  
    BEGIN
                OPEN cur;
                
                FETCH cur BULK COLLECT INTO key_arr, full_number_arr, full_string_arr,
                weekday_fl_arr, us_civil_holiday_fl_arr, last_day_of_week_fl_arr,
                 last_day_of_month_fl_arr, last_day_of_qtr_fl_arr, last_day_of_yr_fl_arr,
                 day_of_week_name_arr, day_of_week_abbr_arr, month_name_arr,
                 month_name_abbr_arr, day_number_of_week_arr, day_number_of_month_arr,
                 day_number_of_qtr_arr, day_number_of_yr_arr, week_number_of_month_arr,
                 week_number_of_qtr_arr,week_number_of_yr_arr, month_number_of_year_arr,
                 qtr_number_of_year_arr, year_number_arr, week_begin_dt_arr, week_end_dt_arr,
                 month_begin_dt_arr, month_end_dt_arr, qtr_begin_dt_arr, qrt_end_dt_arr,
                 yr_begin_dt_arr, yr_end_dt_arr;
                
                FORALL i in key_arr.FIRST .. key_arr.LAST
                INSERT INTO u_dw_data.DW_DATES VALUES(key_arr(i), full_number_arr(i), full_string_arr(i),
                weekday_fl_arr(i), us_civil_holiday_fl_arr(i), last_day_of_week_fl_arr(i),
                 last_day_of_month_fl_arr(i), last_day_of_qtr_fl_arr(i), last_day_of_yr_fl_arr(i),
                 day_of_week_name_arr(i), day_of_week_abbr_arr(i), month_name_arr(i),
                 month_name_abbr_arr(i), day_number_of_week_arr(i), day_number_of_month_arr(i),
                 day_number_of_qtr_arr(i), day_number_of_yr_arr(i), week_number_of_month_arr(i),
                 week_number_of_qtr_arr(i), week_number_of_yr_arr(i), month_number_of_year_arr(i),
                 qtr_number_of_year_arr(i), year_number_arr(i), week_begin_dt_arr(i), week_end_dt_arr(i),
                 month_begin_dt_arr(i), month_end_dt_arr(i), qtr_begin_dt_arr(i), qrt_end_dt_arr(i),
                 yr_begin_dt_arr(i), yr_end_dt_arr(i), (SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL));
                
                CLOSE CUR; 
                
    END load_dates;
END;
/