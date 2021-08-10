CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_customers

AS
   PROCEDURE load_customers
   AS
   BEGIN
      MERGE INTO u_dw_data.DW_CUSTOMERS target
           USING (SELECT * FROM u_sa_customers_data.sa_customers) source
              ON ( target.customer_id = source.customer_id)
      WHEN NOT MATCHED THEN
         INSERT (customer_id, first_name, last_name, gender, age, email, phone, country_geo_id, geo_country_desc, insert_dt, update_dt)
             VALUES (source.customer_id, source.first_name, source.last_name, source.gender, source.age, source.email, source.phone, source.country_geo_id, source.geo_country_desc
             , (select CURRENT_DATE from DUAL)
             , (select CURRENT_DATE from DUAL))
      WHEN MATCHED THEN
         UPDATE SET target.first_name=source.first_name, target.last_name=source.last_name 
         , target.gender=source.gender, target.age=source.age, target.email=source.email 
         , target.phone=source.phone, target.country_geo_id=source.country_geo_id, target.geo_country_desc=source.geo_country_desc
         , target.update_dt= (select CURRENT_DATE from dual);

      --Commit Resulst
      COMMIT;
   END load_customers;
END;
/