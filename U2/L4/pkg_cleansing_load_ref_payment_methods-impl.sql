CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_payment_methods

AS
   PROCEDURE load_payment_methods
   AS
   BEGIN
       IF methods %ISOPEN THEN
        CLOSE methods ;
        END IF;
        OPEN methods;
        
        LOOP
        FETCH methods INTO id_tmp,desc_tmp;
        EXIT WHEN methods%NOTFOUND;
        INSERT INTO u_dw_data.DW_PAYMENT_METHODS VALUES (id_tmp, desc_tmp
                        , (SELECT CURRENT_DATE FROM DUAL)
                        , (SELECT CURRENT_DATE FROM DUAL));
        END LOOP;
        CLOSE methods;
        COMMIT;	
        
        IF methods_updt %ISOPEN THEN
        CLOSE methods_updt;
        END IF;
        OPEN methods_updt;
        
        LOOP
        FETCH methods_updt INTO id_tmp, desc_tmp;
        EXIT WHEN methods_updt%NOTFOUND;
        UPDATE u_dw_data.DW_PAYMENT_METHODS SET payment_method_desc=desc_tmp 
                                    , update_dt=(SELECT CURRENT_DATE FROM DUAL)
        WHERE payment_method_id=id_tmp;
        END LOOP;
        CLOSE methods_updt;
        COMMIT;	
   END load_payment_methods;
END;
/