INSERT INTO u_sa_geo_locations_data.sa_geo_locations
SELECT * FROM u_sb_mbackup.sb_mbackup;

UPDATE u_sa_sales_data.sa_sales 
SET geo_id = round((DBMS_RANDOM.VALUE(206, 446)),0);

UPDATE u_sa_customers_data.sa_customers 
SET COUNTRY_GEO_ID = round((DBMS_RANDOM.VALUE(206, 446)),0);

UPDATE u_sa_customers_data.sa_customers 
SET GEO_COUNTRY_DESC = 
    (SELECT GEO_COUNTRY_DESC 
    FROM u_sa_geo_locations_data.sa_geo_locations 
    WHERE u_sa_geo_locations_data.sa_geo_locations.COUNTRY_GEO_ID = u_sa_customers_data.sa_customers.COUNTRY_GEO_ID);