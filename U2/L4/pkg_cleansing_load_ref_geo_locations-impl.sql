CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_geo_locations AS
   PROCEDURE load_geo_locations
   AS  
    BEGIN
        DECLARE
        TYPE type_cur IS REF CURSOR;
        cur type_cur;
        BEGIN
        OPEN cur FOR SELECT * FROM u_sa_geo_locations_data.sa_geo_locations;
                
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
                
        CLOSE cur; 
        END;         
    END load_geo_locations;
END;
/