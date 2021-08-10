CREATE OR REPLACE PACKAGE u_dw_cl.pkg_cleansing_load_ref_pizzas
AS
    CURSOR cur IS SELECT * FROM u_sa_pizzas_data.sa_pizzas;
    pizza_id_tmp NUMBER;
    category_id_tmp NUMBER;
    category_desc_tmp VARCHAR2(128);
    pizza_desc_tmp VARCHAR2(128);
    pizza_weight_tmp NUMBER;
    pizza_diameter_tmp NUMBER;
    pizza_price_tmp NUMBER;
    min_id NUMBER;
    flag NUMBER;
    PROCEDURE load_pizzas;
END;
/