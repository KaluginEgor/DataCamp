CREATE OR REPLACE PACKAGE u_dw_cl.pkg_cleansing_load_ref_geo_locations
AS  
    TYPE type1 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.COUNTRY_GEO_ID%TYPE;
    country_geo_id_arr type1;
    TYPE type2 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_COUNTRY_ID%TYPE;
    geo_country_id_arr type2;
    TYPE type3 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_COUNTRY_CODE_A2%TYPE;
    geo_country_code_a2_arr type3;
    TYPE type4 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_COUNTRY_CODE_A3%TYPE;
    geo_country_code_a3_arr type4;
    TYPE type5 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_COUNTRY_DESC%TYPE;
    geo_country_desc_arr type5;
    TYPE type6 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.REGION_GEO_ID%TYPE;
    region_geo_id_arr type6;
    TYPE type7 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_REGION_ID%TYPE;
    geo_region_id_arr type7;
    TYPE type8 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_REGION_CODE%TYPE;
    geo_region_code_arr type8;
    TYPE type9 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_REGION_DESC%TYPE;
    geo_region_desc_arr type9;
    TYPE type10 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.CONTENET_GEO_ID%TYPE;
    contenet_geo_id_arr type10;
    TYPE type11 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_PART_ID%TYPE;
    geo_part_id_arr type11;
    TYPE type12 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_PART_CODE%TYPE;
    geo_part_code_arr type12;
    TYPE type13 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_PART_DESC%TYPE;
    geo_part_desc_arr type13;
    TYPE type14 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.SYSTEM_GEO_ID%TYPE;
    system_geo_id_arr type14;
    TYPE type15 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_SYSTEM_ID%TYPE;
    geo_system_id_arr type15;
    TYPE type16 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_SYSTEM_CODE%TYPE;
    geo_system_code_arr type16;
    TYPE type17 IS TABLE OF u_sa_geo_locations_data.sa_geo_locations.GEO_SYSTEM_DESC%TYPE;
    geo_system_desc_arr type17;
    
    PROCEDURE load_geo_locations;
END;