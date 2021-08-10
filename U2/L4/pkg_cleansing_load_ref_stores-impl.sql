CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_stores AS
   PROCEDURE load_stores 
   IS     
        BEGIN
                MERGE INTO u_dw_data.DW_STORES target
                USING (SELECT * FROM u_sa_stores_data.sa_stores) source
                ON (target.store_id = source.store_id)
                WHEN NOT MATCHED THEN
                 INSERT (store_id, store_desc, email, phone, manager_id, manager_first_name, manager_last_name, insert_dt, update_dt)
                     VALUES (source.store_id, source.store_desc, source.email, source.phone, source.manager_id
                     , source.manager_first_name, source.manager_last_name
                     , (select CURRENT_DATE from DUAL)
                     , (select CURRENT_DATE from DUAL))
                WHEN MATCHED THEN
                     UPDATE SET target.store_desc=source.store_desc, target.email=source.email
                     , target.phone=source.phone, target.manager_id=source.manager_id
                     , target.manager_first_name=source.manager_first_name, target.manager_last_name=source.manager_last_name
                     , target.update_dt= (select CURRENT_DATE from dual);

      --Commit Results
      COMMIT;
   END load_stores;
END;
/