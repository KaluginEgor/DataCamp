CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_employees

AS
   PROCEDURE load_employees
   AS
   BEGIN
      MERGE INTO u_dw_data.DW_EMPLOYEES target
           USING (SELECT * FROM u_sa_employees_data.sa_employees) source
              ON ( target.employee_id = source.employee_id)
      WHEN NOT MATCHED THEN
         INSERT (employee_id, first_name, last_name, gender, age, email, phone, store_id, hire_date, manager_id, manager_first_name, manager_last_name, insert_dt, update_dt)
             VALUES (source.employee_id, source.first_name, source.last_name, source.gender, source.age, source.email, source.phone, source.store_id, source.hire_date, source.manager_id, source.manager_first_name, source.manager_last_name
             , (select CURRENT_DATE from DUAL)
             , (select CURRENT_DATE from DUAL))
      WHEN MATCHED THEN
         UPDATE SET target.first_name=source.first_name, target.last_name=source.last_name 
         , target.gender=source.gender, target.age=source.age, target.email=source.email 
         , target.phone=source.phone, target.store_id=source.store_id, target.hire_date=source.hire_date
         , target.manager_id=source.manager_id, target.manager_first_name=source.manager_first_name, target.manager_last_name=source.manager_last_name
         , target.update_dt= (select CURRENT_DATE from dual);

      --Commit Resulst
      COMMIT;
   END load_employees;
END;
/