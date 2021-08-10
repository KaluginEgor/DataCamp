CREATE OR REPLACE PACKAGE u_dw_cl.pkg_cleansing_load_ref_payment_methods
AS
    CURSOR methods IS SELECT * FROM u_sa_payment_methods_data.sa_payment_methods where payment_method_id not in (SELECT payment_method_id FROM u_dw_data.DW_PAYMENT_METHODS);
    CURSOR methods_updt IS SELECT * FROM u_sa_payment_methods_data.sa_payment_methods where payment_method_id in (SELECT payment_method_id FROM u_dw_data.DW_PAYMENT_METHODS);
    id_tmp NUMBER;
    desc_tmp VARCHAR2(128);
    PROCEDURE load_payment_methods;
END;
/