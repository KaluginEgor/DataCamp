CREATE OR REPLACE PACKAGE u_dw_cl.pkg_cleansing_load_ref_stores
AS
    CURSOR store IS SELECT * FROM u_sa_stores_data.sa_stores where store_id not in (SELECT store_id FROM u_dw_data.DW_STORES);
    CURSOR store_updt IS SELECT * FROM u_sa_stores_data.sa_stores where store_id in (SELECT store_id FROM u_dw_data.DW_STORES);
    id_tmp NUMBER;
    desc_tmp VARCHAR2(128);
    email_tmp VARCHAR2(128);
    phone_tmp VARCHAR2(128);
    mngr_id_tmp NUMBER;
    mngr_first_tmp VARCHAR2(128);
    mngr_last_tmp VARCHAR2(128);
    PROCEDURE load_stores;
END;
/