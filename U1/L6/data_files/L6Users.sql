 
--==============================================================
-- User: u_dw_data
--==============================================================
CREATE USER u_dw_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_data_01;

GRANT CONNECT,RESOURCE TO u_dw_data;

--==============================================================
-- User: u_dw_ext_references
--==============================================================
CREATE USER u_dw_ext_references
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_references_ext_data_01;

GRANT CONNECT,RESOURCE TO u_dw_ext_references;

--==============================================================
-- User: u_dw_persons
--==============================================================
CREATE USER u_dw_persons
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_persons_data_01;

GRANT CONNECT,RESOURCE TO u_dw_persons;

--==============================================================
-- User: u_dw_references
--==============================================================
CREATE USER u_dw_references
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_references_data_01;

GRANT CONNECT,RESOURCE, CREATE VIEW TO u_dw_references;

--==============================================================
-- User: u_dw_str_cls
--==============================================================
CREATE USER u_dw_str_cls
  IDENTIFIED BY "%PWD%";

GRANT CONNECT,RESOURCE TO u_dw_str_cls;

--==============================================================
-- User: u_str_data
--==============================================================
CREATE USER u_str_data
  IDENTIFIED BY "%PWD%";

GRANT CONNECT,RESOURCE TO u_str_data;

--==============================================================
-- User: u_dw_common                                            
--==============================================================
create user u_dw_common 
  identified by "%PWD%";

grant CONNECT,CREATE PUBLIC SYNONYM,DROP PUBLIC SYNONYM,RESOURCE to u_dw_common;



GRANT UNLIMITED TABLESPACE TO u_dw_ext_references;

GRANT UNLIMITED TABLESPACE TO u_dw_references;

GRANT UNLIMITED TABLESPACE TO u_dw_common;