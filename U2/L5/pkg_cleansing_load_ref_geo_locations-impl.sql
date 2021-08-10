CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_geo_locations AS
   PROCEDURE load_geo_locations
   AS  
    BEGIN
        DECLARE
        type rc is ref cursor;
        cur rc;
        statement1 VARCHAR2(2000) := 'SELECT MIN(COUNTRY_GEO_ID) FROM u_sa_geo_locations_data.sa_geo_locations';
        statement2 VARCHAR2(2000) := 'SELECT MAX(COUNTRY_GEO_ID) FROM u_sa_geo_locations_data.sa_geo_locations';
        statement3 VARCHAR2(2000) := 'SELECT * FROM u_sa_geo_locations_data.sa_geo_locations WHERE COUNTRY_GEO_ID BETWEEN :b1 AND :b2';
        rows_processed INTEGER;
        curid NUMBER;
        min_id NUMBER;
        max_id NUMBER;
        BEGIN
        
                EXECUTE IMMEDIATE statement1 INTO min_id;
                EXECUTE IMMEDIATE statement2 INTO max_id;
                
                curid := DBMS_SQL.OPEN_CURSOR;
                DBMS_SQL.PARSE(curid, statement3, DBMS_SQL.NATIVE);
                DBMS_SQL.BIND_VARIABLE(curid, 'b1', min_id);
                DBMS_SQL.BIND_VARIABLE(curid, 'b2', max_id);
                rows_processed := DBMS_SQL.EXECUTE(curid);
                cur := DBMS_SQL.TO_REFCURSOR(curid);
                
                FETCH cur BULK COLLECT INTO country_geo_id_arr,  geo_country_id_arr, geo_country_code_a2_arr,
                geo_country_code_a3_arr, geo_country_desc_arr, 
                region_geo_id_arr, geo_region_id_arr, geo_region_code_arr,
                geo_region_desc_arr, contenet_geo_id_arr, geo_part_id_arr,
                geo_part_code_arr, geo_part_desc_arr, system_geo_id_arr, geo_system_id_arr, 
                geo_system_code_arr, geo_system_desc_arr;
                
                FORALL i IN country_geo_id_arr.FIRST .. country_geo_id_arr.LAST 
                insert into u_dw_data.DW_GEO_LOCATIONS VALUES (country_geo_id_arr(i),  geo_country_id_arr(i), geo_country_code_a2_arr(i),
                geo_country_code_a3_arr(i), geo_country_desc_arr(i), 
                region_geo_id_arr(i), geo_region_id_arr(i), geo_region_code_arr(i),
                geo_region_desc_arr(i), contenet_geo_id_arr(i), geo_part_id_arr(i),
                geo_part_code_arr(i), geo_part_desc_arr(i), system_geo_id_arr(i), geo_system_id_arr(i), 
                geo_system_code_arr(i), geo_system_desc_arr(i), (SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL));
                
                close cur;
                commit;
        END;         
    END load_geo_locations;
END;
/