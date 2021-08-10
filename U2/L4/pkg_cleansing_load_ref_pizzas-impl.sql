CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_pizzas AS
   PROCEDURE load_pizzas 
   IS     
        BEGIN
            IF cur %ISOPEN THEN
            CLOSE cur ;
            END IF;
            OPEN cur;
            
            LOOP
            FETCH cur INTO pizza_id_tmp, category_id_tmp, category_desc_tmp, pizza_desc_tmp, pizza_weight_tmp, pizza_diameter_tmp, pizza_price_tmp;
            EXIT WHEN cur%NOTFOUND;
            
            SELECT COUNT(1) INTO flag FROM u_dw_data.DW_PIZZAS_SCD WHERE pizza_id = pizza_id_tmp;
            
            IF (flag=0) THEN
                INSERT INTO u_dw_data.DW_PIZZAS_SCD VALUES (pizza_id_tmp, pizza_id_tmp, pizza_desc_tmp, category_id_tmp, category_desc_tmp, pizza_weight_tmp, pizza_diameter_tmp, pizza_price_tmp
                            , (SELECT CURRENT_DATE FROM DUAL), NULL, 1,(SELECT CURRENT_DATE FROM DUAL));
            ELSE 
                select min(pizza_surr_id) into min_id  from u_dw_data.DW_PIZZAS_SCD;   
                
                UPDATE u_dw_data.DW_PIZZAS_SCD 
                SET   u_dw_data.DW_PIZZAS_SCD.pizza_surr_id = (min_id - 1)
                    , u_dw_data.DW_PIZZAS_SCD.valid_to = (SELECT CURRENT_DATE FROM DUAL)
                    , u_dw_data.DW_PIZZAS_SCD.is_active = 0
                WHERE u_dw_data.DW_PIZZAS_SCD.pizza_id = pizza_id_tmp;
                
                INSERT INTO u_dw_data.DW_PIZZAS_SCD VALUES (pizza_id_tmp, pizza_id_tmp, pizza_desc_tmp, category_id_tmp, category_desc_tmp, pizza_weight_tmp, pizza_diameter_tmp, pizza_price_tmp
                            , (SELECT CURRENT_DATE FROM DUAL), NULL, 1,(SELECT CURRENT_DATE FROM DUAL));
            END IF;
            END LOOP;
            COMMIT;	
            CLOSE cur;
        
      
        END load_pizzas;
END;
/