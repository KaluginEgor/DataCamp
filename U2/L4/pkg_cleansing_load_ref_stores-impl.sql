CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_stores AS
   PROCEDURE load_stores 
   IS     
        BEGIN
        IF store %ISOPEN THEN
        CLOSE store ;
        END IF;
        OPEN store;
        
        LOOP
        FETCH store INTO id_tmp,desc_tmp, email_tmp, phone_tmp, mngr_id_tmp, mngr_first_tmp, mngr_last_tmp;
        EXIT WHEN store%NOTFOUND;
        INSERT INTO u_dw_data.DW_STORES VALUES (id_tmp, desc_tmp, email_tmp, phone_tmp, mngr_id_tmp, mngr_first_tmp, mngr_last_tmp
                        , (SELECT CURRENT_DATE FROM DUAL)
                        , (SELECT CURRENT_DATE FROM DUAL));
        END LOOP;
        COMMIT;	
        CLOSE store;
        
        IF store_updt %ISOPEN THEN
        CLOSE store_updt;
        END IF;
        OPEN store_updt;
        
        LOOP
        FETCH store_updt INTO id_tmp,desc_tmp, email_tmp, phone_tmp, mngr_id_tmp, mngr_first_tmp, mngr_last_tmp;
        EXIT WHEN store_updt%NOTFOUND;
        UPDATE u_dw_data.DW_STORES SET store_desc=desc_tmp, email=email_tmp
                                    , phone=phone_tmp, manager_id=mngr_id_tmp
                                    , manager_first_name=mngr_first_tmp
                                    , manager_last_name=mngr_last_tmp
                                    , update_dt=(SELECT CURRENT_DATE FROM DUAL);
        END LOOP;
        COMMIT;	
        CLOSE store_updt;
   END load_stores;
END;
/