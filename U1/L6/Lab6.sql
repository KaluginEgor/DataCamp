--task1
CREATE TABLESPACE ts_dw_data_01
DATAFILE '/oracle/u02/oradata/DMORCL21DB/ekalugin_db/db_qpt_dw_data_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_dw_idx_01
DATAFILE '/oracle/u02/oradata/DMORCL21DB/ekalugin_db/db_qpt_dw_idx_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_persons_data_01
DATAFILE '/oracle/u02/oradata/DMORCL21DB/ekalugin_db/db_qpt_person_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_persons_idx_01
DATAFILE '/oracle/u02/oradata/DMORCL21DB/ekalugin_db/db_qpt_person_idx_01.dat'
SIZE 50M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_references_data_01
DATAFILE '/oracle/u02/oradata/DMORCL21DB/ekalugin_db/db_qpt_references_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_references_ext_data_01
DATAFILE '/oracle/u02/oradata/DMORCL21DB/ekalugin_db/db_qpt_ext_references_data_01.dat'
SIZE 20M
 AUTOEXTEND ON
    NEXT 20M
    MAXSIZE 60M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_references_idx_01
DATAFILE '/oracle/u02/oradata/DMORCL21DB/ekalugin_db/db_qpt_references_idx_01.dat'
SIZE 50M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 
--==============================================================
-- User: u_dw_data
--==============================================================
CREATE USER u_dw_data
  IDENTIFIED BY %PWD%
    DEFAULT TABLESPACE ts_dw_data_01;

GRANT CONNECT,RESOURCE TO u_dw_data;

--==============================================================
-- User: u_dw_ext_references
--==============================================================
CREATE USER u_dw_ext_references
  IDENTIFIED BY %PWD%
    DEFAULT TABLESPACE ts_references_ext_data_01;

GRANT CONNECT,RESOURCE TO u_dw_ext_references;

--==============================================================
-- User: u_dw_persons
--==============================================================
CREATE USER u_dw_persons
  IDENTIFIED BY %PWD%
    DEFAULT TABLESPACE ts_persons_data_01;

GRANT CONNECT,RESOURCE TO u_dw_persons;

--==============================================================
-- User: u_dw_references
--==============================================================
CREATE USER u_dw_references
  IDENTIFIED BY %PWD%
    DEFAULT TABLESPACE ts_references_data_01;

GRANT CONNECT,RESOURCE, CREATE VIEW TO u_dw_references;

--==============================================================
-- User: u_dw_str_cls
--==============================================================
CREATE USER u_dw_str_cls
  IDENTIFIED BY %PWD%;

GRANT CONNECT,RESOURCE TO u_dw_str_cls;

--==============================================================
-- User: u_str_data
--==============================================================
CREATE USER u_str_data
  IDENTIFIED BY %PWD%;

GRANT CONNECT,RESOURCE TO u_str_data;

--==============================================================
-- User: u_dw_common                                            
--==============================================================
create user u_dw_common 
  identified by %PWD%;

grant CONNECT,CREATE PUBLIC SYNONYM,DROP PUBLIC SYNONYM,RESOURCE to u_dw_common;

CREATE OR REPLACE DIRECTORY ext_references
AS
  '/mnt/ext_references/';

GRANT READ ON DIRECTORY ext_references TO u_dw_ext_references;
GRANT WRITE ON DIRECTORY ext_references TO u_dw_ext_references;


GRANT UNLIMITED TABLESPACE TO u_dw_references;


alter table u_dw_references.lc_lng_scopes
   drop constraint FK_LOC2LNG_SCOPES;

alter table u_dw_references.lc_lng_types
   drop constraint FK_LOC2LNG_TYPES;

drop table u_dw_references.t_localizations cascade constraints;

--==============================================================
-- Table: t_localizations                                       
--==============================================================
create table u_dw_references.t_localizations 
(
   localization_id      NUMBER(22,0)         not null,
   localization_code    VARCHAR2(5 CHAR)     not null,
   localization_desc    VARCHAR2(200 CHAR)   not null,
   localization_desc_ens VARCHAR2(200 CHAR)   not null,
   lng_id               NUMBER(22,0),
   contry_id            NUMBER(22,0),
   is_default           INTEGER,
   constraint PK_T_LOCALIZATIONS primary key (localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on column u_dw_references.t_localizations.localization_id is
'Identificator of Supported References Languages';

comment on column u_dw_references.t_localizations.localization_code is
'Code of Supported References Languages';

comment on column u_dw_references.t_localizations.localization_desc is
'Name of Supported References Languages';

comment on column u_dw_references.t_localizations.localization_desc_ens is
'Endonym Name of  Supported References Languages';

comment on column u_dw_references.t_localizations.lng_id is
'Disabled - FK for Language_Id - Post Mapped by Load PKG';

comment on column u_dw_references.t_localizations.contry_id is
'Disabled - FK for Country_Id - Post Mapped by Load PKG';

comment on column u_dw_references.t_localizations.is_default is
'Default Language for all Application and Members on DataBase';

alter table u_dw_references.t_localizations
   add constraint CHK_T_LOCALIZATIONS_IS_DEFAULT check (is_default is null or (is_default in (1,0)));


--Initial rows
INSERT INTO t_lng_scopes ( lng_scope_id
                         , lng_scope_code )
     VALUES ( 1
            , 'I' );

INSERT INTO t_lng_scopes ( lng_scope_id
                         , lng_scope_code )
     VALUES ( 2
            , 'M' );

INSERT INTO t_lng_scopes ( lng_scope_id
                         , lng_scope_code )
     VALUES ( 3
            , 'S' );

Commit;            


drop sequence u_dw_references.sq_lng_scopes_t_id;

create sequence u_dw_references.sq_lng_scopes_t_id
start with 4;

grant SELECT on u_dw_references.sq_lng_scopes_t_id to u_dw_ext_references;




alter table u_dw_references.lc_lng_scopes
   drop constraint FK_LOC2LNG_SCOPES;

alter table u_dw_references.lc_lng_types
   drop constraint FK_LOC2LNG_TYPES;

drop table u_dw_references.t_localizations cascade constraints;

--==============================================================
-- Table: t_localizations                                       
--==============================================================
create table u_dw_references.t_localizations 
(
   localization_id      NUMBER(22,0)         not null,
   localization_code    VARCHAR2(5 CHAR)     not null,
   localization_desc    VARCHAR2(200 CHAR)   not null,
   localization_desc_ens VARCHAR2(200 CHAR)   not null,
   lng_id               NUMBER(22,0),
   contry_id            NUMBER(22,0),
   is_default           INTEGER,
   constraint PK_T_LOCALIZATIONS primary key (localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on column u_dw_references.t_localizations.localization_id is
'Identificator of Supported References Languages';

comment on column u_dw_references.t_localizations.localization_code is
'Code of Supported References Languages';

comment on column u_dw_references.t_localizations.localization_desc is
'Name of Supported References Languages';

comment on column u_dw_references.t_localizations.localization_desc_ens is
'Endonym Name of  Supported References Languages';

comment on column u_dw_references.t_localizations.lng_id is
'Disabled - FK for Language_Id - Post Mapped by Load PKG';

comment on column u_dw_references.t_localizations.contry_id is
'Disabled - FK for Country_Id - Post Mapped by Load PKG';

comment on column u_dw_references.t_localizations.is_default is
'Default Language for all Application and Members on DataBase';

alter table u_dw_references.t_localizations
   add constraint CHK_T_LOCALIZATIONS_IS_DEFAULT check (is_default is null or (is_default in (1,0)));



--==============================================================
-- Initial Rows: t_localizations
--==============================================================
INSERT INTO t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( -1
            , 'n.a.'
            , 'Not Available'
            , 'Not Available'
            , NULL
            , NULL
            , NULL );

INSERT INTO t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( -2
            , 'n.d.'
            , 'Not Defined'
            , 'Not Defined'
            , NULL
            , NULL
            , NULL );

INSERT INTO t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( 1
            , 'en-US'
            , 'English'
            , 'English'
            , NULL
            , NULL
            , 1 );

INSERT INTO t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( 2
            , 'ru-RU'
            , 'Russian'
            , '�������'
            , NULL
            , NULL
            , NULL );

INSERT INTO t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( 3
            , 'be-BY'
            , 'Belarussian'
            , '��������i'
            , NULL
            , NULL
            , NULL );

COMMIT;


drop view w_localizations;

--==============================================================
-- View: w_localizations                                        
--==============================================================
create or replace view w_localizations as
SELECT localization_id
     , localization_code
     , localization_desc
     , localization_desc_ens
     , lng_id
     , contry_id
     , is_default
  FROM t_localizations;

comment on column w_localizations.localization_id is
'Identificator of Supported References Languages';

comment on column w_localizations.localization_code is
'Code of Supported References Languages';

comment on column w_localizations.localization_desc is
'Name of Supported References Languages';

comment on column w_localizations.localization_desc_ens is
'Endonym Name of  Supported References Languages';

comment on column w_localizations.lng_id is
'Disabled - FK for Language_Id - Post Mapped by Load PKG';

comment on column w_localizations.contry_id is
'Disabled - FK for Country_Id - Post Mapped by Load PKG';

comment on column w_localizations.is_default is
'Default Language for all Application and Members on DataBase';

grant SELECT on w_localizations to PUBLIC;



ALTER TABLE u_dw_references.lc_lng_scopes
   DROP CONSTRAINT fk_loc2lng_scopes;

ALTER TABLE u_dw_references.lc_lng_scopes
   DROP CONSTRAINT fk_t_lng_scopes2lc_lng_scopes;

DROP TABLE u_dw_references.lc_lng_scopes CASCADE CONSTRAINTS;

--==============================================================
-- Table: lc_lng_scopes
--==============================================================
CREATE TABLE u_dw_references.lc_lng_scopes
(
   lng_scope_id   NUMBER ( 22, 0 ) NOT NULL
 , lng_scope_code VARCHAR2 ( 1 CHAR ) NOT NULL
 , lng_scope_desc VARCHAR2 ( 200 CHAR ) NOT NULL
 , localization_id NUMBER ( 22, 0 ) NOT NULL
 , CONSTRAINT pk_lc_lng_scopes PRIMARY KEY
      ( lng_scope_id, localization_id )
      USING INDEX TABLESPACE ts_references_idx_01
)
TABLESPACE ts_references_data_01;

COMMENT ON COLUMN u_dw_references.lc_lng_scopes.lng_scope_id IS
'Identificator of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.lc_lng_scopes.lng_scope_code IS
'Code of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.lc_lng_scopes.lng_scope_desc IS
'Description of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.lc_lng_scopes.localization_id IS
'Identificator of Supported References Languages';

ALTER TABLE u_dw_references.lc_lng_scopes
   ADD CONSTRAINT fk_loc2lng_scopes FOREIGN KEY (localization_id)
      REFERENCES u_dw_references.t_localizations (localization_id)
      ON DELETE CASCADE;

ALTER TABLE u_dw_references.lc_lng_scopes
   ADD CONSTRAINT fk_t_lng_scopes2lc_lng_scopes FOREIGN KEY (lng_scope_id)
      REFERENCES u_dw_references.t_lng_scopes (lng_scope_id)
      ON DELETE CASCADE;



DROP VIEW u_dw_references.w_lng_scopes;

--==============================================================
-- View: w_lng_scopes
--==============================================================
CREATE OR REPLACE VIEW u_dw_references.w_lng_scopes
AS
   SELECT lng_scope_id
        , lng_scope_code
     FROM t_lng_scopes;

COMMENT ON COLUMN u_dw_references.w_lng_scopes.lng_scope_id IS
'Idemtificator of Language Scopes - ISO 639-3';

COMMENT ON COLUMN u_dw_references.w_lng_scopes.lng_scope_code IS
'Code of Languages Scopes - ISO 639-3';

GRANT DELETE,INSERT,UPDATE,SELECT ON u_dw_references.w_lng_scopes TO u_dw_ext_references;



drop view u_dw_references.vl_lng_scopes;

--==============================================================
-- View: vl_lng_scopes                                          
--==============================================================
create or replace view u_dw_references.vl_lng_scopes as
SELECT lng_scope_id
     , lng_scope_code
     , lng_scope_desc
     , localization_id
  FROM lc_lng_scopes;

comment on column u_dw_references.vl_lng_scopes.lng_scope_id is
'Idemtificator of Language Scopes - ISO 639-3';

comment on column u_dw_references.vl_lng_scopes.lng_scope_code is
'Code of Languages Scopes - ISO 639-3';

comment on column u_dw_references.vl_lng_scopes.lng_scope_desc is
'Description of Language Scopes - ISO 639-3';

comment on column u_dw_references.vl_lng_scopes.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_lng_scopes to u_dw_ext_references;



--alter table u_dw_references.lc_lng_types
--   drop constraint FK_T_LNG_TYPES2LC_LNG_TYPES;
--
--alter table u_dw_references.t_languages
--   drop constraint FK_T_LNG_TYPES2T_LANGUAGES;
--
--drop table u_dw_references.t_lng_types cascade constraints;

--==============================================================
-- Table: t_lng_types                                           
--==============================================================
create table u_dw_references.t_lng_types 
(
   lng_type_id          NUMBER(22,0)         not null,
   lng_type_code        VARCHAR2(30 CHAR)    not null,
   constraint PK_T_LNG_TYPES primary key (lng_type_id)
)
organization index tablespace TS_REFERENCES_DATA_01;

comment on column u_dw_references.t_lng_types.lng_type_id is
'Identificator of Language Types - ISO 639-3';

comment on column u_dw_references.t_lng_types.lng_type_code is
'Code of Language Types - ISO 639-3';

alter table u_dw_references.t_lng_types
   add constraint CHK_T_LNG_TYPES_LNG_TYPE_CODE check (lng_type_code = upper(lng_type_code));


--drop sequence u_dw_references.sq_lng_types_t_id;

create sequence u_dw_references.sq_lng_types_t_id;

grant SELECT on u_dw_references.sq_lng_types_t_id to u_dw_ext_references;



--alter table u_dw_references.lc_lng_types
--   drop constraint FK_LOC2LNG_TYPES;
--
--alter table u_dw_references.lc_lng_types
--   drop constraint FK_T_LNG_TYPES2LC_LNG_TYPES;

--drop table u_dw_references.lc_lng_types cascade constraints;

--==============================================================
-- Table: lc_lng_types                                          
--==============================================================
create table u_dw_references.lc_lng_types 
(
   lng_type_id          NUMBER(22,0)         not null,
   lng_type_code        VARCHAR2(30 CHAR)    not null,
   lng_type_desc        VARCHAR2(200 CHAR)   not null,
   localization_id      NUMBER(22,0)         not null,
   constraint PK_LC_LNG_TYPES primary key (lng_type_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on column u_dw_references.lc_lng_types.lng_type_id is
'Identificator of Language Types - ISO 639-3';

comment on column u_dw_references.lc_lng_types.lng_type_code is
'Code of Language Types - ISO 639-3';

comment on column u_dw_references.lc_lng_types.lng_type_desc is
'Description of Language Types - ISO 639-3';

comment on column u_dw_references.lc_lng_types.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_lng_types
   add constraint CHK_LC_LNG_TYPES_LNG_TYPE_CODE check (lng_type_code = upper(lng_type_code));

alter table u_dw_references.lc_lng_types
   add constraint FK_LOC2LNG_TYPES foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;

alter table u_dw_references.lc_lng_types
   add constraint FK_T_LNG_TYPES2LC_LNG_TYPES foreign key (lng_type_id)
      references u_dw_references.t_lng_types (lng_type_id)
      on delete cascade;



--DROP VIEW u_dw_references.w_lng_types;

--==============================================================
-- View: w_lng_types
--==============================================================
CREATE OR REPLACE VIEW u_dw_references.w_lng_types
AS
   SELECT t_lng_types.lng_type_id
        , t_lng_types.lng_type_code
     FROM t_lng_types;

COMMENT ON COLUMN u_dw_references.w_lng_types.lng_type_id IS
'Identificator of Language Types - ISO 639-3';

COMMENT ON COLUMN u_dw_references.w_lng_types.lng_type_code IS
'Code of Language Types - ISO 639-3';

GRANT DELETE,INSERT,UPDATE,SELECT ON u_dw_references.w_lng_types TO u_dw_ext_references;


--drop view u_dw_references.vl_lng_types;

--==============================================================
-- View: vl_lng_types                                           
--==============================================================
create or replace view u_dw_references.vl_lng_types as
SELECT lng_type_id
     , lng_type_code
     , lng_type_desc
     , localization_id
  FROM lc_lng_types;

comment on column u_dw_references.vl_lng_types.lng_type_id is
'Identificator of Language Types - ISO 639-3';

comment on column u_dw_references.vl_lng_types.lng_type_code is
'Code of Language Types - ISO 639-3';

comment on column u_dw_references.vl_lng_types.lng_type_desc is
'Description of Language Types - ISO 639-3';

comment on column u_dw_references.vl_lng_types.localization_id is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_lng_types to u_dw_ext_references;



ALTER TABLE u_dw_references.t_languages
   DROP CONSTRAINT fk_t_lng_scopes2t_languages;

ALTER TABLE u_dw_references.t_languages
   DROP CONSTRAINT fk_t_lng_types2t_languages;

ALTER TABLE u_dw_references.t_lng_links
   DROP CONSTRAINT fk_t_languages2t_lng_links_c;

ALTER TABLE u_dw_references.t_lng_links
   DROP CONSTRAINT fk_t_languages2t_lng_links_p;

DROP INDEX u_dw_references.idx_lng_3c_code;

DROP TABLE u_dw_references.t_languages CASCADE CONSTRAINTS;

--==============================================================
-- Table: t_languages
--==============================================================
CREATE TABLE u_dw_references.t_languages
(
   lng_id         NUMBER ( 22, 0 ) NOT NULL
 , lng_3c_code    VARCHAR2 ( 3 CHAR ) NOT NULL
 , lng_2b_code    VARCHAR2 ( 3 CHAR )
 , lng_2t_code    VARCHAR2 ( 3 CHAR )
 , lng_1c_code    VARCHAR2 ( 2 CHAR )
 , lng_scope_id   NUMBER ( 22, 0 ) NOT NULL
 , lng_type_id    NUMBER ( 22, 0 )
 , lng_desc       VARCHAR2 ( 200 CHAR ) NOT NULL
 , CONSTRAINT pk_t_languages PRIMARY KEY ( lng_id ) USING INDEX TABLESPACE ts_references_idx_01
)
TABLESPACE ts_references_data_01
PARTITION BY LIST (lng_scope_id)
   ( PARTITION p_individual
        VALUES (1)
        NOCOMPRESS
   , PARTITION p_macrolanguage
        VALUES (2)
        NOCOMPRESS
   , PARTITION p_special
        VALUES (3)
        NOCOMPRESS
   , PARTITION p_others
        VALUES (DEFAULT)
        NOCOMPRESS );

COMMENT ON TABLE u_dw_references.t_languages IS
'Using Standarts: ISO 639-3 
Codes for the representation of names of languages. ISO 639-3 attempts to provide as complete an enumeration of languages as possible, including living, extinct, ancient, and constructed languages, whether major or minor, written or unwritten.';

COMMENT ON COLUMN u_dw_references.t_languages.lng_id IS
'Identifier of the Language';

COMMENT ON COLUMN u_dw_references.t_languages.lng_3c_code IS
'ISO 639-3 identifier';

COMMENT ON COLUMN u_dw_references.t_languages.lng_2b_code IS
'ISO 639-2 identifier of the bibliographic applications';

COMMENT ON COLUMN u_dw_references.t_languages.lng_2t_code IS
'ISO 639-2 identifier of the terminology applications code ';

COMMENT ON COLUMN u_dw_references.t_languages.lng_1c_code IS
'ISO 639-1 identifier - common standart';

COMMENT ON COLUMN u_dw_references.t_languages.lng_scope_id IS
'Identifier of the language scope';

COMMENT ON COLUMN u_dw_references.t_languages.lng_desc IS
'Name of Language';

--==============================================================
-- Index: idx_lng_3c_code
--==============================================================
CREATE UNIQUE INDEX u_dw_references.idx_lng_3c_code
   ON u_dw_references.t_languages ( lng_3c_code ASC
                                  , lng_scope_id ASC )
   LOCAL
   TABLESPACE ts_references_idx_01;

ALTER TABLE u_dw_references.t_languages
   ADD CONSTRAINT fk_t_lng_scopes2t_languages FOREIGN KEY (lng_scope_id)
      REFERENCES u_dw_references.t_lng_scopes (lng_scope_id);

ALTER TABLE u_dw_references.t_languages
   ADD CONSTRAINT fk_t_lng_types2t_languages FOREIGN KEY (lng_type_id)
      REFERENCES u_dw_references.t_lng_types (lng_type_id);


--drop sequence u_dw_references.sq_languages_t_id;

create sequence u_dw_references.sq_languages_t_id;

grant SELECT on u_dw_references.sq_languages_t_id to u_dw_ext_references;


--drop view u_dw_references.w_languages;

--==============================================================
-- View: w_languages                                            
--==============================================================
create or replace view u_dw_references.w_languages as
SELECT lng_id
     , lng_3c_code
     , lng_2b_code
     , lng_2t_code
     , lng_1c_code
     , lng_scope_id
     , lng_type_id
     , lng_desc
  FROM t_languages;

comment on column u_dw_references.w_languages.lng_id is
'Identifier of the Language';

comment on column u_dw_references.w_languages.lng_3c_code is
'ISO 639-3 identifier';

comment on column u_dw_references.w_languages.lng_2b_code is
'ISO 639-2 identifier of the bibliographic applications';

comment on column u_dw_references.w_languages.lng_2t_code is
'ISO 639-2 identifier of the terminology applications code ';

comment on column u_dw_references.w_languages.lng_1c_code is
'ISO 639-1 identifier - common standart';

comment on column u_dw_references.w_languages.lng_scope_id is
'Idemtificator of Language Scopes - ISO 639-3';

comment on column u_dw_references.w_languages.lng_desc is
'Name of Language';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_languages to u_dw_ext_references;



alter table u_dw_references.t_lng_links
   drop constraint FK_T_LANGUAGES2T_LNG_LINKS_C;

alter table u_dw_references.t_lng_links
   drop constraint FK_T_LANGUAGES2T_LNG_LINKS_P;

drop table u_dw_references.t_lng_links cascade constraints;

--==============================================================
-- Table: t_lng_links                                           
--==============================================================
create table u_dw_references.t_lng_links 
(
   parent_lng_id        NUMBER(22,0)         not null,
   child_lng_id         NUMBER(22,0)         not null,
   link_type_id         NUMBER(3,0)          not null,
   constraint PK_T_LNG_LINKS primary key (parent_lng_id, child_lng_id, link_type_id)
         using index
       local
       tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01
 partition by list
 (link_type_id)
 (partition
         p_Macro2Individ
        values (1)
         nocompress);

comment on column u_dw_references.t_lng_links.parent_lng_id is
'Link: Paranet Object - Languages T_LANGUAGES';

comment on column u_dw_references.t_lng_links.child_lng_id is
'Link: Child Object - Languages T_LANGUAGES';

comment on column u_dw_references.t_lng_links.link_type_id is
'Link Type: 1 - Macrolanguages to Individual Languages';

alter table u_dw_references.t_lng_links
   add constraint FK_T_LANGUAGES2T_LNG_LINKS_C foreign key (child_lng_id)
      references u_dw_references.t_languages (lng_id);

alter table u_dw_references.t_lng_links
   add constraint FK_T_LANGUAGES2T_LNG_LINKS_P foreign key (parent_lng_id)
      references u_dw_references.t_languages (lng_id);



--drop view u_dw_references.w_lng_links;

--==============================================================
-- View: w_lng_links                                            
--==============================================================
create or replace view u_dw_references.w_lng_links as
select
   parent_lng_id,
   child_lng_id,
   link_type_id
from
   t_lng_links;

comment on column u_dw_references.w_lng_links.parent_lng_id is
'Link: Paranet Object - Languages T_LANGUAGES';

comment on column u_dw_references.w_lng_links.child_lng_id is
'Link: Child Object - Languages T_LANGUAGES';

comment on column u_dw_references.w_lng_links.link_type_id is
'Link Type: 1 - Macrolanguages to Individual Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_lng_links to u_dw_ext_references;




GRANT UNLIMITED TABLESPACE TO u_dw_common;

--DROP PACKAGE pkg_session_params;

CREATE OR REPLACE PACKAGE pkg_session_params
AS
   -- Retrieving Application User - Localization schemes
   --* @param     p_user_name     - Application User unique name
   --* @return                    - Id of Localization schemes
   FUNCTION get_user_localization_id ( p_user_name VARCHAR2 := SYS_CONTEXT ( 'USERENV' , 'SESSION_USER' ) )
      RETURN NUMBER;

   -- Setting Application User - Localization schemes
   --* @param     p_user_name     - Application User unique name
   --* @return                    - Id of Localization schemes
   PROCEDURE set_user_localization_id ( p_localization_id NUMBER
                                      , p_user_name     VARCHAR2 := SYS_CONTEXT ( 'USERENV'
                                                                                , 'SESSION_USER' ) );
END pkg_session_params;
/


CREATE OR REPLACE PACKAGE BODY pkg_session_params
AS
   --Paramters
   l_user_localization_id NUMBER DEFAULT -98;

   -- Retrieving Application User - Localization schemes
   --* @param     p_user_name     - Application User unique name
   --* @return                    - Id of Localization schemes
   FUNCTION get_user_localization_id ( p_user_name VARCHAR2 := SYS_CONTEXT ( 'USERENV' , 'SESSION_USER' ) )
      RETURN NUMBER
   IS
   BEGIN
      RETURN l_user_localization_id;
   EXCEPTION
      WHEN OTHERS THEN
         -- do you cleanup here
         RAISE;
   END get_user_localization_id;

   -- Setting Application User - Localization schemes
   --* @param     p_user_name     - Application User unique name
   --* @return                    - Id of Localization schemes
   PROCEDURE set_user_localization_id ( p_localization_id NUMBER
                                      , p_user_name     VARCHAR2 := SYS_CONTEXT ( 'USERENV'
                                                                                , 'SESSION_USER' ) )
   IS
   BEGIN
      IF p_localization_id IS NOT NULL THEN
         l_user_localization_id := p_localization_id;
      ELSE
         --Get Defualt localization
         SELECT lc.localization_id
           INTO l_user_localization_id
           FROM u_dw_references.w_localizations lc
          WHERE lc.is_default = 1;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         -- do you cleanup here
         RAISE;
   END set_user_localization_id;
BEGIN
   BEGIN
      --Get Defualt localization
      SELECT lc.localization_id
        INTO l_user_localization_id
        FROM u_dw_references.w_localizations lc
       WHERE lc.is_default = 1;
   EXCEPTION
      WHEN OTHERS THEN
         l_user_localization_id := -98;
   END;
END pkg_session_params;
/

create or replace public synonym pkg_session_params for U_DW_COMMON.PKG_SESSION_PARAMS;

grant execute on U_DW_COMMON.PKG_SESSION_PARAMS to PUBLIC;



drop view u_dw_references.cu_languages;

--==============================================================
-- View: cu_languages
--==============================================================
CREATE OR REPLACE VIEW u_dw_references.cu_languages
AS
   SELECT lng_id
        , lng_3c_code
        , lng_2b_code
        , lng_2t_code
        , lng_1c_code
        , lng_scope_id
        , lng_type_id
        , lng_desc
     FROM t_languages lng
    WHERE lng.lng_scope_id = 1 --Individuals
      AND lng.lng_type_id = 5 --Living
   WITH READ ONLY;

COMMENT ON COLUMN u_dw_references.cu_languages.lng_id IS
'Identifier of the Language';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_3c_code IS
'ISO 639-3 identifier';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_2b_code IS
'ISO 639-2 identifier of the bibliographic applications';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_2t_code IS
'ISO 639-2 identifier of the terminology applications code ';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_1c_code IS
'ISO 639-1 identifier - common standart';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_scope_id IS
'Identifier of the language scope';

COMMENT ON COLUMN u_dw_references.cu_languages.lng_desc IS
'Name of Language';

GRANT DELETE,INSERT,UPDATE,SELECT ON u_dw_references.cu_languages TO u_dw_ext_references;



--drop view u_dw_references.cu_lng_scopes;

--==============================================================
-- View: cu_lng_scopes                                          
--==============================================================
create or replace view u_dw_references.cu_lng_scopes as
SELECT src.lng_scope_id
     , src.lng_scope_code AS src_scope_code
     , NVL ( lc.lng_scope_code, '-' ) AS lng_scope_code
     , NVL ( lc.lng_scope_desc, 'Not Defined' ) AS lng_scope_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_lng_scopes src
     , lc_lng_scopes lc
 WHERE lc.lng_scope_id(+) = src.lng_scope_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_lng_scopes.lng_scope_id is
'Idemtificator of Language Scopes - ISO 639-3';

comment on column u_dw_references.cu_lng_scopes.src_scope_code is
'Code of Languages Scopes - ISO 639-3';



--drop view u_dw_references.cu_lng_types;

--==============================================================
-- View: cu_lng_types                                           
--==============================================================
create or replace view u_dw_references.cu_lng_types as
SELECT src.lng_type_id
     , src.lng_type_code AS src_type_code
     , NVL ( lc.lng_type_code, '-' ) AS lng_type_code
     , NVL ( lc.lng_type_desc, 'Not Defined' ) AS lng_type_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_lng_types src
     , lc_lng_types lc
 WHERE lc.lng_type_id(+) = src.lng_type_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_lng_types.lng_type_id is
'Identificator of Language Types - ISO 639-3';

comment on column u_dw_references.cu_lng_types.src_type_code is
'Code of Language Types - ISO 639-3';


GRANT UNLIMITED TABLESPACE TO u_dw_ext_references;



--drop table u_dw_ext_references.cls_languages_iso693 cascade constraints;

--==============================================================
-- Table: cls_languages_iso693                                  
--==============================================================
create table u_dw_ext_references.cls_languages_iso693 
(
   lng_3c_code           VARCHAR2( 3 CHAR ),
   lng_2b_code           VARCHAR2( 3 CHAR ),
   lng_2t_code           VARCHAR2( 3 CHAR ),
   lng_1c_code           VARCHAR2( 2 CHAR ),
   lng_scope             VARCHAR2( 2 CHAR ),
   lng_type              VARCHAR2( 1 CHAR ),
   lng_desc             VARCHAR2(200 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_languages_iso693 is
'Cleansing table for loading - Languages';

comment on column u_dw_ext_references.cls_languages_iso693.lng_3c_code is
'ISO 639-3 identifier';

comment on column u_dw_ext_references.cls_languages_iso693.lng_2b_code is
'ISO 639-2 identifier of the bibliographic applications';

comment on column u_dw_ext_references.cls_languages_iso693.lng_2t_code is
'ISO 639-2 identifier of the terminology applications code ';

comment on column u_dw_ext_references.cls_languages_iso693.lng_1c_code is
'ISO 639-1 identifier - common standart';

comment on column u_dw_ext_references.cls_languages_iso693.lng_scope is
'Identifier of the language scope';

comment on column u_dw_ext_references.cls_languages_iso693.lng_type is
'Identifier of the language type';

comment on column u_dw_ext_references.cls_languages_iso693.lng_desc is
'EdonymName of Language';



--drop table u_dw_ext_references.cls_lng_macro2ind_iso693 cascade constraints;

--==============================================================
-- Table: cls_lng_macro2ind_iso693                              
--==============================================================
create table u_dw_ext_references.cls_lng_macro2ind_iso693 
(
   macro_lng_code       VARCHAR2(3 CHAR),
   indiv_lng_code       VARCHAR2(3 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_lng_macro2ind_iso693 is
'Cleansing table for loading - Links from Macro Languages to Individual Languages';

comment on column u_dw_ext_references.cls_lng_macro2ind_iso693.macro_lng_code is
'LNG_ID: MacroLanguage - T_Languages';

comment on column u_dw_ext_references.cls_lng_macro2ind_iso693.indiv_lng_code is
'LNG_ID: Individual Language - T_Languages';

--drop table u_dw_ext_references.t_ext_languages_iso693 cascade constraints;

--==============================================================
-- Table: t_ext_languages_iso693
--==============================================================
CREATE TABLE u_dw_ext_references.t_ext_languages_iso693
(
   lng_3c_code    VARCHAR2 ( 3 CHAR )
 , lng_2b_code    VARCHAR2 ( 3 CHAR )
 , lng_2t_code    VARCHAR2 ( 3 CHAR )
 , lng_1c_code    VARCHAR2 ( 2 CHAR )
 , lng_scope      VARCHAR2 ( 2 CHAR )
 , lng_type       VARCHAR2 ( 1 CHAR )
 , lng_desc       VARCHAR2 ( 200 CHAR )
)
ORGANIZATION EXTERNAL
                      (
    TYPE oracle_loader
    DEFAULT DIRECTORY ext_references
    ACCESS PARAMETERS (RECORDS DELIMITED BY NEWLINE NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED BY ';' MISSING FIELD VALUES ARE NULL( lng_3c_code CHAR( 3 ) , lng_2b_code CHAR( 3 ) , lng_2t_code CHAR( 3 ) , lng_1c_code CHAR( 2 ) , lng_scope CHAR( 1 ) , lng_type CHAR( 1 ) , lng_desc CHAR( 150 ) ) )
    LOCATION ('iso-639-3.tab')
)
REJECT LIMIT UNLIMITED;


--drop table u_dw_ext_references.t_ext_lng_macro2ind_iso693 cascade constraints;

--==============================================================
-- Table: t_ext_lng_macro2ind_iso693                            
--==============================================================
create table u_dw_ext_references.t_ext_lng_macro2ind_iso693 
(
   MACRO_LNG_CODE       VARCHAR2(3 CHAR),
   INDIV_LNG_CODE       VARCHAR2(3 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (RECORDS DELIMITED BY 0x'0D0A' NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED BY ';' MISSING FIELD VALUES ARE NULL ( MACRO_LNG_CODE CHAR( 3 ) , INDIV_LNG_CODE CHAR( 3 ) ) )
    location ('iso-639-3-Macro.tab')
)
reject limit unlimited;



CREATE OR REPLACE PACKAGE pkg_load_ext_ref_languages
-- Package Reload Data From External Sources to DataBase
--
AS
   -- Extract Data from external source = External Table
   -- Load All Languages from ISO 693 - 3
   PROCEDURE load_cls_languages;

   -- Load All Languages Scopes from ISO 693 - 3
   PROCEDURE load_ref_lng_scopes;

   -- Load All Languages Types from ISO 693 - 3
   PROCEDURE load_ref_lng_types;

   -- Load All Languages from ISO 693 - 3
   PROCEDURE load_ref_lanuages;

   -- Load Macrolanguages Links to Indiviual Languages from ISO 693 - 3
   PROCEDURE load_cls_links_macro2indiv;
   
   -- Load References Macrolanguages Links to Indiviual from ISO 693 - 3
   PROCEDURE load_ref_lng_links_macro;
END;
/



CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_languages
-- Package Reload Data From External Sources to DataBase
--
AS
   -- Extract Data from external source = External Table
   -- Load All Languages from ISO 693 - 3
   PROCEDURE load_cls_languages
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_languages_iso693';

      --Extract data
      INSERT INTO cls_languages_iso693 ( lng_3c_code
                                       , lng_2b_code
                                       , lng_2t_code
                                       , lng_1c_code
                                       , lng_scope
                                       , lng_type
                                       , lng_desc )
         SELECT lng_3c_code
              , lng_2b_code
              , lng_2t_code
              , lng_1c_code
              , lng_scope
              , lng_type
              , lng_desc
           FROM t_ext_languages_iso693;

      --Commit Data
      COMMIT;
   END load_cls_languages;

   /*****/
   -- Load All Languages Scopes from ISO 693 - 3
   PROCEDURE load_ref_lng_scopes
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_lng_scopes lng
            WHERE lng.lng_scope_code NOT IN (     SELECT DISTINCT UPPER ( lng_scope ) FROM cls_languages_iso693);

      --Merge Source data
      MERGE INTO u_dw_references.w_lng_scopes lng
           USING (  SELECT DISTINCT UPPER ( lng_scope ) AS lng_scope
                      FROM cls_languages_iso693
                  ORDER BY lng_scope) cls
              ON ( lng.lng_scope_code = cls.lng_scope )
      WHEN NOT MATCHED THEN
         INSERT            ( lng_scope_id
                           , lng_scope_code )
             VALUES ( u_dw_references.sq_lng_scopes_t_id.NEXTVAL
                    , cls.lng_scope );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_lng_scopes lng
           USING (SELECT src.lng_scope_id
                       , src.lng_scope_code
                       , CASE
                            WHEN lng_scope_code = 'I' THEN 'Individual'
                            WHEN lng_scope_code = 'M' THEN 'Macrolanguage'
                            WHEN lng_scope_code = 'S' THEN 'Special'
                            ELSE 'Error: Not Defined'
                         END
                            AS lng_scope_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_lng_scopes src) cls
              ON ( lng.lng_scope_id = cls.lng_scope_id
              AND lng.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( lng_scope_id
                           , lng_scope_code
                           , lng_scope_desc
                           , localization_id )
             VALUES ( cls.lng_scope_id
                    , cls.lng_scope_code
                    , cls.lng_scope_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET lng.lng_scope_code = cls.lng_scope_code
                  , lng.lng_scope_desc = cls.lng_scope_desc;

      --Commit Resulst
      COMMIT;
   END load_ref_lng_scopes;

   /*****/
   -- Load All Languages types from ISO 693 - 3
   PROCEDURE load_ref_lng_types
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_lng_types lng
            WHERE lng.lng_type_code NOT IN (     SELECT DISTINCT UPPER ( lng_type ) FROM cls_languages_iso693);

      --Merge Source data
      MERGE INTO u_dw_references.w_lng_types lng
           USING (  SELECT DISTINCT UPPER ( lng_type ) AS lng_type
                      FROM cls_languages_iso693
                  ORDER BY lng_type) cls
              ON ( lng.lng_type_code = cls.lng_type )
      WHEN NOT MATCHED THEN
         INSERT            ( lng_type_id
                           , lng_type_code )
             VALUES ( u_dw_references.sq_lng_types_t_id.NEXTVAL
                    , cls.lng_type );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_lng_types lng
           USING (SELECT src.lng_type_id
                       , src.lng_type_code
                       , CASE
                            -- A(ncient), C(onstructed),
                            -- E(xtinct), H(istorical), L(iving), S(pecial)
                         WHEN lng_type_code = 'A' THEN 'Ancient'
                            WHEN lng_type_code = 'C' THEN 'Constructed'
                            WHEN lng_type_code = 'E' THEN 'Extinct'
                            WHEN lng_type_code = 'H' THEN 'Historical'
                            WHEN lng_type_code = 'L' THEN 'Living'
                            WHEN lng_type_code = 'S' THEN 'Special'
                            ELSE 'Error: Not Defined'
                         END
                            AS lng_type_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_lng_types src) cls
              ON ( lng.lng_type_id = cls.lng_type_id
              AND lng.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( lng_type_id
                           , lng_type_code
                           , lng_type_desc
                           , localization_id )
             VALUES ( cls.lng_type_id
                    , cls.lng_type_code
                    , cls.lng_type_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET lng.lng_type_code = cls.lng_type_code
                  , lng.lng_type_desc = cls.lng_type_desc;

      --Commit Resulst
      COMMIT;
   END load_ref_lng_types;

   /*****/
   -- Load All Languages from ISO 693 - 3
   PROCEDURE load_ref_lanuages
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_languages lng
            WHERE lng.lng_3c_code NOT IN (     SELECT DISTINCT lng_3c_code FROM cls_languages_iso693);

      --Merge New Values
      MERGE INTO u_dw_references.w_languages lng
           USING (SELECT cls.lng_3c_code
                       , cls.lng_2b_code
                       , cls.lng_2t_code
                       , cls.lng_1c_code
                       , NVL ( scp.lng_scope_id, -99 ) AS lng_scope_id
                       , NVL ( typ.lng_type_id, -99 ) AS lng_type_id
                       , cls.lng_desc
                    FROM cls_languages_iso693 cls
                       , u_dw_references.w_lng_scopes scp
                       , u_dw_references.w_lng_types typ
                   WHERE scp.lng_scope_code(+) = cls.lng_scope
                     AND typ.lng_type_code(+) = cls.lng_type) cls
              ON ( lng.lng_3c_code = cls.lng_3c_code )
      WHEN MATCHED THEN
         UPDATE SET lng.lng_2b_code = cls.lng_2b_code
                  , lng.lng_2t_code = cls.lng_2t_code
                  , lng.lng_1c_code = cls.lng_1c_code
                  , lng.lng_scope_id = cls.lng_scope_id
                  , lng.lng_type_id = cls.lng_type_id
                  , lng.lng_desc = cls.lng_desc
      WHEN NOT MATCHED THEN
         INSERT            ( lng_id
                           , lng_3c_code
                           , lng_2b_code
                           , lng_2t_code
                           , lng_1c_code
                           , lng_scope_id
                           , lng_type_id
                           , lng_desc )
             VALUES ( u_dw_references.sq_languages_t_id.NEXTVAL
                    , cls.lng_3c_code
                    , cls.lng_2b_code
                    , cls.lng_2t_code
                    , cls.lng_1c_code
                    , cls.lng_scope_id
                    , cls.lng_type_id
                    , cls.lng_desc );

      -- Commit Current Results
      COMMIT;
   END load_ref_lanuages;

   -- Load Macrolanguages Links to Indiviual Languages from ISO 693 - 3
   PROCEDURE load_cls_links_macro2indiv
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_LNG_MACRO2IND_ISO693';

      --Extract data
      INSERT INTO cls_lng_macro2ind_iso693 ( macro_lng_code
                                           , indiv_lng_code )
         SELECT macro_lng_code
              , indiv_lng_code
           FROM t_ext_lng_macro2ind_iso693;

      --Commit Data
      COMMIT;
   END load_cls_links_macro2indiv;

   -- Load References Macrolanguages Links to Indiviual from ISO 693 - 3
   PROCEDURE load_ref_lng_links_macro
   AS
   BEGIN
      DELETE FROM u_dw_references.w_lng_links lnk
            WHERE ( lnk.parent_lng_id, lnk.child_lng_id, lnk.link_type_id ) NOT IN
                     (SELECT NVL ( m_lng.lng_id, -99 ) AS m_lng_id
                           , NVL ( i_lng.lng_id, -99 ) AS i_lng_id
                           , 1 AS link_type_id
                        FROM cls_lng_macro2ind_iso693 cls
                           , u_dw_references.w_languages m_lng
                           , u_dw_references.w_languages i_lng
                       WHERE m_lng.lng_3c_code(+) = cls.macro_lng_code
                         AND m_lng.lng_scope_id(+) = 2
                         AND i_lng.lng_3c_code(+) = cls.indiv_lng_code
                         AND i_lng.lng_scope_id(+) = 1);

      MERGE INTO u_dw_references.w_lng_links lnk
           USING (SELECT NVL ( m_lng.lng_id, -99 ) AS m_lng_id
                       , NVL ( i_lng.lng_id, -99 ) AS i_lng_id
                       , 1 AS link_type_id
                    FROM cls_lng_macro2ind_iso693 cls
                       , u_dw_references.w_languages m_lng
                       , u_dw_references.w_languages i_lng
                   WHERE m_lng.lng_3c_code = cls.macro_lng_code
                     AND m_lng.lng_scope_id = 2
                     AND i_lng.lng_3c_code = cls.indiv_lng_code
                     AND i_lng.lng_scope_id = 1) src
              ON ( lnk.parent_lng_id = src.m_lng_id
              AND lnk.child_lng_id = src.i_lng_id
              AND lnk.link_type_id = 1 )
      WHEN NOT MATCHED THEN
         INSERT            ( lnk.parent_lng_id
                           , lnk.child_lng_id
                           , lnk.link_type_id )
             VALUES ( src.m_lng_id
                    , src.i_lng_id
                    , src.link_type_id );

      COMMIT;
   END;
END;
/



BEGIN
   pkg_load_ext_ref_languages.load_cls_languages;
   pkg_load_ext_ref_languages.load_ref_lng_scopes;
   pkg_load_ext_ref_languages.load_ref_lng_types;
   pkg_load_ext_ref_languages.load_ref_lanuages;   
END;


select * from u_dw_references.t_localizations;

select * from u_dw_references.cu_languages;

select * from u_dw_references.w_lng_links;

select * from u_dw_references.cu_lng_scopes;

select * from u_dw_references.cu_lng_types;



--task2


drop table u_dw_references.t_geo_types cascade constraints;

/*==============================================================*/
/* Table: t_geo_types                                         */
/*==============================================================*/
create table u_dw_references.t_geo_types 
(
   geo_type_id        NUMBER(22,0)         not null,
   geo_type_code      VARCHAR2(30 CHAR)    not null,
   geo_type_desc      VARCHAR2(200 CHAR)   not null,
   constraint PK_T_GEO_TYPES primary key (geo_type_id)
)
organization index
 tablespace TS_REFERENCES_DATA_01
    pctthreshold 10
 overflow tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.t_geo_types is
'Reference store all abstraction types of geograhy objects';

comment on column u_dw_references.t_geo_types.geo_type_id is
'ID of unique Type - abstraction code for Geo Objects ';

comment on column u_dw_references.t_geo_types.geo_type_code is
'Code of Geography Type Objects';

comment on column u_dw_references.t_geo_types.geo_type_desc is
'Description of Geography Type Objects (Not Localizable)';

alter table u_dw_references.t_geo_types
   add constraint CKC_GEO_TYPE_CODE_T_GEO_TY check (geo_type_code = upper(geo_type_code));



drop view u_dw_references.w_geo_types;

/*==============================================================*/
/* View: w_geo_types                                          */
/*==============================================================*/
create or replace view u_dw_references.w_geo_types as
SELECT geo_type_id
     , geo_type_code
     , geo_type_desc
  FROM t_geo_types;

 comment on table u_dw_references.w_geo_types is
'Work View: T_GEO_TYPES';

comment on column u_dw_references.w_geo_types.GEO_TYPE_ID is
'ID of unique Type - abstraction code for Geo Objects ';

comment on column u_dw_references.w_geo_types.GEO_TYPE_CODE is
'Code of Geography Type Objects';

comment on column u_dw_references.w_geo_types.GEO_TYPE_DESC is
'Description of Geography Type Objects (Not Localizable)';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_types to u_dw_ext_references;



alter table u_dw_references.t_geo_objects
   drop constraint FK_T_GEO_OB_FK_T_GEO__T_GEO_TY;

drop index u_dw_references.ui_geo_objects_codes;

drop table u_dw_references.t_geo_objects cascade constraints;

/*==============================================================*/
/* Table: t_geo_objects                                       */
/*==============================================================*/
create table u_dw_references.t_geo_objects 
(
   geo_id             NUMBER(22,0)         not null,
   geo_type_id        NUMBER(22,0)         not null,
   geo_code_id        NUMBER(22,0)         not null,
   constraint PK_T_GEO_OBJECTS primary key (geo_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.t_geo_objects is
'Abstarct Referense store all Geography objects';

comment on column u_dw_references.t_geo_objects.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.t_geo_objects.geo_type_id is
'Code of Geography Type Objects';

comment on column u_dw_references.t_geo_objects.geo_code_id is
'NK: Source ID from source systems';

/*==============================================================*/
/* Index: ui_geo_objects_codes                                */
/*==============================================================*/
create unique index u_dw_references.ui_geo_objects_codes on u_dw_references.t_geo_objects (
   geo_type_id ASC,
   geo_code_id ASC
)
tablespace TS_REFERENCES_IDX_01;

alter table u_dw_references.t_geo_objects
   add constraint FK_T_GEO_OB_FK_T_GEO__T_GEO_TY foreign key (geo_type_id)
      references u_dw_references.t_geo_types (geo_type_id);



drop view u_dw_references.w_geo_objects;

/*==============================================================*/
/* View: w_geo_objects                                        */
/*==============================================================*/
create or replace view u_dw_references.w_geo_objects as
SELECT geo_id
     , geo_type_id
     , geo_code_id
  FROM t_geo_objects;

 comment on table u_dw_references.w_geo_objects is
'Work View: T_GEO_TYPES';

comment on column u_dw_references.w_geo_objects.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_geo_objects.GEO_TYPE_ID is
'Code of Geography Type Objects';

comment on column u_dw_references.w_geo_objects.GEO_CODE_ID is
'NK: Source ID from source systems';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_objects to u_dw_ext_references;



alter table u_dw_references.t_geo_object_links
   drop constraint FK_T_GEO_OBJECTS2GEO_LINK_C;

alter table u_dw_references.t_geo_object_links
   drop constraint FK_T_GEO_OBJECTS2GEO_LINK_P;

drop table u_dw_references.t_geo_object_links cascade constraints;

/*==============================================================*/
/* Table: t_geo_object_links                                  */
/*==============================================================*/
create table u_dw_references.t_geo_object_links 
(
   parent_geo_id      NUMBER(22,0)         not null,
   child_geo_id       NUMBER(22,0)         not null,
   link_type_id       NUMBER(22,0)         not null,
   constraint PK_T_GEO_OBJECT_LINKS primary key (parent_geo_id, child_geo_id, link_type_id)
         using index
       local
       tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01
 partition by list
 (link_type_id)
    (
        partition
             p_geo_sys2continents
            values (1)
             nocompress,
        partition
             p_continent2regions
            values (2)
             nocompress,
        partition
             p_region2countries
            values (3)
             nocompress,
        partition
             p_grp_sys2groups
            values (4)
             nocompress,
        partition
             p_group2sub_groups
            values (5)
             nocompress,
        partition
             p_sub_groups2countries
            values (6)
             nocompress
    );

comment on table u_dw_references.t_geo_object_links is
'Reference store: All links between Geo Objects';

comment on column u_dw_references.t_geo_object_links.parent_geo_id is
'Parent objects of Geo_IDs';

comment on column u_dw_references.t_geo_object_links.child_geo_id is
'Child objects of Geo_IDs';

comment on column u_dw_references.t_geo_object_links.link_type_id is
'Type of Links, between Geo_IDs';

alter table u_dw_references.t_geo_object_links
   add constraint FK_T_GEO_OBJECTS2GEO_LINK_C foreign key (child_geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade;

alter table u_dw_references.t_geo_object_links
   add constraint FK_T_GEO_OBJECTS2GEO_LINK_P foreign key (parent_geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade;
      
      
drop view u_dw_references.w_geo_object_links;

/*==============================================================*/
/* View: w_geo_object_links                                   */
/*==============================================================*/
create or replace view u_dw_references.w_geo_object_links as
SELECT parent_geo_id
     , child_geo_id
     , link_type_id
  FROM t_geo_object_links;

 comment on table u_dw_references.w_geo_object_links is
'Work View: T_GEO_OBJECT_LINKS';

comment on column u_dw_references.w_geo_object_links.PARENT_GEO_ID is
'Parent objects of Geo_IDs';

comment on column u_dw_references.w_geo_object_links.CHILD_GEO_ID is
'Child objects of Geo_IDs';

comment on column u_dw_references.w_geo_object_links.LINK_TYPE_ID is
'Type of Links, between Geo_IDs';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_object_links to u_dw_ext_references;



drop sequence sq_geo_t_id;

create sequence sq_geo_t_id;

grant SELECT on sq_geo_t_id to u_dw_ext_references;


drop trigger u_dw_references.bi_t_cntr_group_systems
/

alter table u_dw_references.t_cntr_group_systems
   drop constraint FK_T_GEO_OBJECTS2CNTR_G_SYSTEM
/

drop table u_dw_references.t_cntr_group_systems cascade constraints
/

/*==============================================================*/
/* Table: t_cntr_group_systems                                */
/*==============================================================*/
create table u_dw_references.t_cntr_group_systems 
(
   geo_id             NUMBER(22,0)         not null,
   grp_system_id      NUMBER(22,0)         not null,
   constraint PK_T_CNTR_GROUP_SYSTEMS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_cntr_group_systems is
'Referense store:  Grouping Systems of Countries'
/

comment on column u_dw_references.t_cntr_group_systems.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications'
/

alter table u_dw_references.t_cntr_group_systems
   add constraint FK_T_GEO_OBJECTS2CNTR_G_SYSTEM foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_cntr_group_systems before insert
on u_dw_references.t_cntr_group_systems for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 50 --GROUPING SYSTEMS
               , :new.grp_system_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/



drop view u_dw_references.w_cntr_group_systems;

/*==============================================================*/
/* View: w_cntr_group_systems                                 */
/*==============================================================*/
create or replace view u_dw_references.w_cntr_group_systems as
SELECT geo_id
     , grp_system_id     
  FROM t_cntr_group_systems;

 comment on table u_dw_references.w_cntr_group_systems is
'Work View: T_GEO_TYPES';

comment on column u_dw_references.w_cntr_group_systems.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_cntr_group_systems.GRP_SYSTEM_ID is
'ID Code of Grouping System Specifications';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_cntr_group_systems to u_dw_ext_references;



alter table u_dw_references.lc_cntr_group_systems
   drop constraint FK_LC_CNTR_GROUP_SYSTEMS;

alter table u_dw_references.lc_cntr_group_systems
   drop constraint FK_LOC2CNTR_GROUP_SYSTEMS;

drop table u_dw_references.lc_cntr_group_systems cascade constraints;

/*==============================================================*/
/* Table: lc_cntr_group_systems                               */
/*==============================================================*/
create table u_dw_references.lc_cntr_group_systems 
(
   geo_id             NUMBER(22,0)         not null,
   grp_system_id      NUMBER(22,0)         not null,
   grp_system_code    VARCHAR2(30 CHAR),
   grp_system_desc    VARCHAR2(200 CHAR)   not null,
   localization_id    NUMBER(22,0)         not null,
   constraint PK_LC_CNTR_GROUP_SYSTEMS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_cntr_group_systems is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_cntr_group_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_cntr_group_systems.grp_system_id is
'ID Code of Grouping System Specifications';

comment on column u_dw_references.lc_cntr_group_systems.grp_system_code is
'Code of Grouping System Specifications';

comment on column u_dw_references.lc_cntr_group_systems.grp_system_desc is
'Description of Grouping System Specifications';

comment on column u_dw_references.lc_cntr_group_systems.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_cntr_group_systems
   add constraint CHK_LC_GRP_SYSTEMS_CODE check (grp_system_code is null or (grp_system_code = upper(grp_system_code)));

alter table u_dw_references.lc_cntr_group_systems
   add constraint FK_LC_CNTR_GROUP_SYSTEMS foreign key (geo_id)
      references u_dw_references.t_cntr_group_systems (geo_id)
      on delete cascade;

alter table u_dw_references.lc_cntr_group_systems
   add constraint FK_LOC2CNTR_GROUP_SYSTEMS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;


drop view u_dw_references.vl_cntr_group_systems;

/*==============================================================*/
/* View: vl_cntr_group_systems                                */
/*==============================================================*/
create or replace view u_dw_references.vl_cntr_group_systems as
SELECT geo_id
     , grp_system_id
     , grp_system_code
     , grp_system_desc
     , localization_id
  FROM lc_cntr_group_systems;

 comment on table u_dw_references.vl_cntr_group_systems is
'Localazible View: T_CNTR_GROUP_SYSTEMS';

comment on column u_dw_references.vl_cntr_group_systems.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_cntr_group_systems.GRP_SYSTEM_ID is
'ID Code of Grouping System Specifications';

comment on column u_dw_references.vl_cntr_group_systems.GRP_SYSTEM_CODE is
'Code of Grouping System Specifications';

comment on column u_dw_references.vl_cntr_group_systems.GRP_SYSTEM_DESC is
'Description of Grouping System Specifications';

comment on column u_dw_references.vl_cntr_group_systems.LOCALIZATION_ID is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_cntr_group_systems to u_dw_ext_references;




drop trigger u_dw_references.bi_t_cntr_groups
/

alter table u_dw_references.t_cntr_groups
   drop constraint FK_T_GEO_OBJECTS2CNTR_GROUPS
/

drop table u_dw_references.t_cntr_groups cascade constraints
/

/*==============================================================*/
/* Table: t_cntr_groups                                       */
/*==============================================================*/
create table u_dw_references.t_cntr_groups 
(
   geo_id             NUMBER(22,0)         not null,
   group_id           NUMBER(22,0)         not null,
   constraint PK_T_CNTR_GROUPS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_cntr_groups is
'Referense store: Grouping Countries - Groups'
/

comment on column u_dw_references.t_cntr_groups.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_cntr_groups.group_id is
'ID Code of Countries Groups'
/

alter table u_dw_references.t_cntr_groups
   add constraint FK_T_GEO_OBJECTS2CNTR_GROUPS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_cntr_groups before insert
on u_dw_references.t_cntr_groups for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 51 --Countries Groups
               , :new.group_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


drop view u_dw_references.w_cntr_groups;

/*==============================================================*/
/* View: w_cntr_groups                                        */
/*==============================================================*/
create or replace view u_dw_references.w_cntr_groups as
SELECT geo_id
     , group_id     
  FROM t_cntr_groups;

 comment on table u_dw_references.w_cntr_groups is
'Work View: T_CNTR_GROUPS';

comment on column u_dw_references.w_cntr_groups.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_cntr_groups.GROUP_ID is
'ID Code of Countries Groups';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_cntr_groups to u_dw_ext_references;



alter table u_dw_references.lc_cntr_groups
   drop constraint FK_LC_CNTR_GROUPS;

alter table u_dw_references.lc_cntr_groups
   drop constraint FK_LOC2CNTR_GROUPS;

drop table u_dw_references.lc_cntr_groups cascade constraints;

/*==============================================================*/
/* Table: lc_cntr_groups                                      */
/*==============================================================*/
create table u_dw_references.lc_cntr_groups 
(
   geo_id             NUMBER(22,0)         not null,
   group_id           NUMBER(22,0)         not null,
   group_code         VARCHAR2(30 CHAR),
   group_desc         VARCHAR2(200 CHAR)   not null,
   localization_id    NUMBER(22,0)         not null,
   constraint PK_LC_CNTR_GROUPS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_cntr_groups is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_cntr_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_cntr_groups.group_id is
'ID Code of Countries Groups';

comment on column u_dw_references.lc_cntr_groups.group_code is
'Code of Countries Groups';

comment on column u_dw_references.lc_cntr_groups.group_desc is
'Description of Countries Groups';

comment on column u_dw_references.lc_cntr_groups.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_cntr_groups
   add constraint CHK_LC_CNTR_GROUPS_CODE check (group_code is null or (group_code = upper(group_code)));

alter table u_dw_references.lc_cntr_groups
   add constraint FK_LC_CNTR_GROUPS foreign key (geo_id)
      references u_dw_references.t_cntr_groups (geo_id)
      on delete cascade;

alter table u_dw_references.lc_cntr_groups
   add constraint FK_LOC2CNTR_GROUPS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;




drop view u_dw_references.vl_cntr_groups;

/*==============================================================*/
/* View: vl_cntr_groups                                       */
/*==============================================================*/
create or replace view u_dw_references.vl_cntr_groups as
SELECT geo_id
     , GROUP_ID
     , group_code
     , group_desc
     , localization_id
  FROM lc_cntr_groups;

 comment on table u_dw_references.vl_cntr_groups is
'Localazible View: T_CNTR_GROUPS';

comment on column u_dw_references.vl_cntr_groups.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_cntr_groups.GROUP_ID is
'ID Code of Countries Groups';

comment on column u_dw_references.vl_cntr_groups.GROUP_CODE is
'Code of Countries Groups';

comment on column u_dw_references.vl_cntr_groups.GROUP_DESC is
'Description of Countries Groups';

comment on column u_dw_references.vl_cntr_groups.LOCALIZATION_ID is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_cntr_groups to u_dw_ext_references;



drop trigger u_dw_references.bi_t_cntr_sub_groups
/

alter table u_dw_references.t_cntr_sub_groups
   drop constraint FK_T_GEO_OBJECTS2CNTR_S_GROUPS
/

drop table u_dw_references.t_cntr_sub_groups cascade constraints
/

/*==============================================================*/
/* Table: t_cntr_sub_groups                                   */
/*==============================================================*/
create table u_dw_references.t_cntr_sub_groups 
(
   geo_id             NUMBER(22,0)         not null,
   sub_group_id       NUMBER(22,0)         not null,
   constraint PK_T_CNTR_SUB_GROUPS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_cntr_sub_groups is
'Referense store: Grouping Countries - Sub Groups'
/

comment on column u_dw_references.t_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups'
/

alter table u_dw_references.t_cntr_sub_groups
   add constraint FK_T_GEO_OBJECTS2CNTR_S_GROUPS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_cntr_sub_groups before insert
on u_dw_references.t_cntr_sub_groups for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 52 --Countries Sub Groups
               , :new.sub_group_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


drop view u_dw_references.w_cntr_sub_groups;

/*==============================================================*/
/* View: w_cntr_sub_groups                                    */
/*==============================================================*/
create or replace view u_dw_references.w_cntr_sub_groups as
SELECT geo_id
     , sub_group_id     
  FROM t_cntr_sub_groups;

 comment on table u_dw_references.w_cntr_sub_groups is
'Work View: T_CNTR_SUB_GROUPS';

comment on column u_dw_references.w_cntr_sub_groups.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_cntr_sub_groups.SUB_GROUP_ID is
'ID Code of Countries Sub Groups';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_cntr_sub_groups to u_dw_ext_references;



alter table u_dw_references.lc_cntr_sub_groups
   drop constraint FK_LC_CNTR_SUB_GROUPS;

alter table u_dw_references.lc_cntr_sub_groups
   drop constraint FK_LOC2CNTR_SUB_GROUPS;

drop table u_dw_references.lc_cntr_sub_groups cascade constraints;

/*==============================================================*/
/* Table: lc_cntr_sub_groups                                  */
/*==============================================================*/
create table u_dw_references.lc_cntr_sub_groups 
(
   geo_id             NUMBER(22,0)         not null,
   sub_group_id       NUMBER(22,0)         not null,
   sub_group_code     VARCHAR2(30 CHAR),
   sub_group_desc     VARCHAR2(200 CHAR)   not null,
   localization_id    NUMBER(22,0)         not null,
   constraint PK_LC_CNTR_SUB_GROUPS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_cntr_sub_groups is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_cntr_sub_groups.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_cntr_sub_groups.sub_group_id is
'ID Code of Countries Sub Groups';

comment on column u_dw_references.lc_cntr_sub_groups.sub_group_code is
'Code of Countries Sub Groups';

comment on column u_dw_references.lc_cntr_sub_groups.sub_group_desc is
'Description of Countries Sub Groups';

comment on column u_dw_references.lc_cntr_sub_groups.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_cntr_sub_groups
   add constraint CHK_LC_CNTR_SUB_GROUPS_CODE check (sub_group_code is null or (sub_group_code = upper(sub_group_code)));

alter table u_dw_references.lc_cntr_sub_groups
   add constraint FK_LC_CNTR_SUB_GROUPS foreign key (geo_id)
      references u_dw_references.t_cntr_sub_groups (geo_id)
      on delete cascade;

alter table u_dw_references.lc_cntr_sub_groups
   add constraint FK_LOC2CNTR_SUB_GROUPS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;


drop view u_dw_references.vl_cntr_sub_groups;

/*==============================================================*/
/* View: vl_cntr_sub_groups                                   */
/*==============================================================*/
create or replace view u_dw_references.vl_cntr_sub_groups as
SELECT geo_id
     , sub_group_id
     , sub_group_code
     , sub_group_desc
     , localization_id
  FROM lc_cntr_sub_groups;

 comment on table u_dw_references.vl_cntr_sub_groups is
'Localazible View: T_CNTR_GROUPS';

comment on column u_dw_references.vl_cntr_sub_groups.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_cntr_sub_groups.SUB_GROUP_ID is
'ID Code of Countries Sub Groups';

comment on column u_dw_references.vl_cntr_sub_groups.SUB_GROUP_CODE is
'Code of Countries Sub Groups';

comment on column u_dw_references.vl_cntr_sub_groups.SUB_GROUP_DESC is
'Description of Countries Sub Groups';

comment on column u_dw_references.vl_cntr_sub_groups.LOCALIZATION_ID is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_cntr_sub_groups to u_dw_ext_references;



drop view u_dw_references.cu_cntr_group_systems;

/*==============================================================*/
/* View: cu_cntr_group_systems                                */
/*==============================================================*/
create or replace view u_dw_references.cu_cntr_group_systems as
SELECT src.geo_id
     , src.grp_system_id AS grp_system_id
     , NVL ( lc.grp_system_code, '-' ) AS grp_system_code
     , NVL ( lc.grp_system_desc, 'Not Defined' ) AS grp_system_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_cntr_group_systems src
     , lc_cntr_group_systems lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_cntr_group_systems.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_cntr_group_systems.GRP_SYSTEM_ID is
'ID Code of Grouping System Specifications';


drop view u_dw_references.cu_cntr_groups;

/*==============================================================*/
/* View: cu_cntr_groups                                       */
/*==============================================================*/
create or replace view u_dw_references.cu_cntr_groups as
SELECT src.geo_id
     , src.group_id AS group_id
     , NVL ( lc.group_code, '-' ) AS group_code
     , NVL ( lc.group_desc, 'Not Defined' ) AS group_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_cntr_groups src
     , lc_cntr_groups lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_cntr_groups.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_cntr_groups.GROUP_ID is
'ID Code of Countries Groups';


drop view u_dw_references.cu_cntr_sub_groups;

/*==============================================================*/
/* View: cu_cntr_sub_groups                                   */
/*==============================================================*/
create or replace view u_dw_references.cu_cntr_sub_groups as
SELECT src.geo_id
     , src.sub_group_id AS sub_group_id
     , NVL ( lc.sub_group_code, '-' ) AS sub_group_code
     , NVL ( lc.sub_group_desc, 'Not Defined' ) AS sub_group_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_cntr_sub_groups src
     , lc_cntr_sub_groups lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_cntr_sub_groups.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_cntr_sub_groups.SUB_GROUP_ID is
'ID Code of Countries Sub Groups';




drop trigger u_dw_references.bi_t_geo_system
/

alter table u_dw_references.t_geo_systems
   drop constraint FK_T_GEO_SY_FK_T_GEO__T_GEO_OB
/

drop table u_dw_references.t_geo_systems cascade constraints
/

/*==============================================================*/
/* Table: t_geo_systems                                       */
/*==============================================================*/
create table u_dw_references.t_geo_systems 
(
   geo_id             NUMBER(22,0)         not null,
   geo_system_id      NUMBER(22,0)         not null,
   constraint PK_T_GEO_SYSTEMS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_geo_systems is
'Referense store:  Geographical Systems of Specifications'
/

comment on column u_dw_references.t_geo_systems.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_geo_systems.geo_system_id is
'ID Code of Geography System Specifications'
/

alter table u_dw_references.t_geo_systems
   add constraint FK_T_GEO_SY_FK_T_GEO__T_GEO_OB foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_geo_system before insert
on u_dw_references.t_geo_systems for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 2 --SYSTEMS
               , :new.geo_system_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/



drop view u_dw_references.w_geo_systems;

/*==============================================================*/
/* View: w_geo_systems                                        */
/*==============================================================*/
create or replace view u_dw_references.w_geo_systems as
SELECT geo_id
     , geo_system_id
  FROM t_geo_systems;

 comment on table u_dw_references.w_geo_systems is
'Work View: T_GEO_SYSTEMS';

comment on column u_dw_references.w_geo_systems.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_geo_systems.GEO_SYSTEM_ID is
'ID Code of Geography System Specifications';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_systems to u_dw_ext_references;



alter table u_dw_references.lc_geo_systems
   drop constraint FK_LC_GEO_SYSTEMS;

alter table u_dw_references.lc_geo_systems
   drop constraint FK_LOC2GEO_SYSTEMS;

drop table u_dw_references.lc_geo_systems cascade constraints;

/*==============================================================*/
/* Table: lc_geo_systems                                      */
/*==============================================================*/
create table u_dw_references.lc_geo_systems 
(
   geo_id             NUMBER(22,0)         not null,
   geo_system_id      NUMBER(22,0)         not null,
   geo_system_code    VARCHAR2(30 CHAR),
   geo_system_desc    VARCHAR2(200 CHAR)   not null,
   localization_id    NUMBER(22,0)         not null,
   constraint PK_LC_GEO_SYSTEMS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_geo_systems is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_geo_systems.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_geo_systems.geo_system_id is
'ID Code of Geography System Specifications';

comment on column u_dw_references.lc_geo_systems.geo_system_code is
'Code of Geography System Specifications';

comment on column u_dw_references.lc_geo_systems.geo_system_desc is
'Description of Geography System Specifications';

comment on column u_dw_references.lc_geo_systems.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_geo_systems
   add constraint CHK_LC_GEO_SYSTEMS_CODE check (geo_system_code is null or (geo_system_code = upper(geo_system_code)));

alter table u_dw_references.lc_geo_systems
   add constraint FK_LC_GEO_SYSTEMS foreign key (geo_id)
      references u_dw_references.t_geo_systems (geo_id)
      on delete cascade;

alter table u_dw_references.lc_geo_systems
   add constraint FK_LOC2GEO_SYSTEMS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;



drop view u_dw_references.vl_geo_systems;

/*==============================================================*/
/* View: vl_geo_systems                                       */
/*==============================================================*/
create or replace view u_dw_references.vl_geo_systems as
SELECT geo_id
     , geo_system_id
     , geo_system_code
     , geo_system_desc
     , localization_id
  FROM lc_geo_systems;

 comment on table u_dw_references.vl_geo_systems is
'Localazible View: T_GEO_SYSTEMS';

comment on column u_dw_references.vl_geo_systems.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_geo_systems.GEO_SYSTEM_ID is
'ID Code of Geography System Specifications';

comment on column u_dw_references.vl_geo_systems.GEO_SYSTEM_CODE is
'Code of Geography System Specifications';

comment on column u_dw_references.vl_geo_systems.GEO_SYSTEM_DESC is
'Description of Geography System Specifications';

comment on column u_dw_references.vl_geo_systems.LOCALIZATION_ID is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_geo_systems to u_dw_ext_references;



drop view u_dw_references.cu_geo_systems;

/*==============================================================*/
/* View: cu_geo_systems                                       */
/*==============================================================*/
create or replace view u_dw_references.cu_geo_systems as
SELECT src.geo_id
     , src.geo_system_id AS geo_system_id
     , NVL ( lc.geo_system_code, '-' ) AS geo_system_code
     , NVL ( lc.geo_system_desc, 'Not Defined' ) AS geo_system_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_geo_systems src
     , lc_geo_systems lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_geo_systems.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_geo_systems.GEO_SYSTEM_ID is
'ID Code of Geography System Specifications';



drop trigger u_dw_references.bi_t_geo_parts
/

alter table u_dw_references.t_geo_parts
   drop constraint FK_T_GEO_OBJECTS2PARTS
/

drop table u_dw_references.t_geo_parts cascade constraints
/

/*==============================================================*/
/* Table: t_geo_parts                                         */
/*==============================================================*/
create table u_dw_references.t_geo_parts 
(
   geo_id             NUMBER(22,0)         not null,
   part_id            NUMBER(22,0)         not null,
   constraint PK_T_GEO_PARTS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_geo_parts is
'Referense store: Geographical Parts of Worlds'
/

comment on column u_dw_references.t_geo_parts.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_geo_parts.part_id is
'ID Code of Geographical Part of World'
/

alter table u_dw_references.t_geo_parts
   add constraint FK_T_GEO_OBJECTS2PARTS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_geo_parts before insert
on u_dw_references.t_geo_parts for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 10 --Part of World
               , :new.part_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/



drop view u_dw_references.w_geo_parts;

/*==============================================================*/
/* View: w_geo_parts                                          */
/*==============================================================*/
create or replace view u_dw_references.w_geo_parts as
select
   geo_id,
   part_id
from
   t_geo_parts;

 comment on table u_dw_references.w_geo_parts is
'Work View: T_GEO_PARTS';

comment on column u_dw_references.w_geo_parts.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_geo_parts.PART_ID is
'ID Code of Geographical Part of World';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_parts to u_dw_ext_references;



alter table u_dw_references.lc_geo_parts
   drop constraint FK_LC_CONTINENTS;

alter table u_dw_references.lc_geo_parts
   drop constraint FK_LOC2CONTINENTS;

drop table u_dw_references.lc_geo_parts cascade constraints;

/*==============================================================*/
/* Table: lc_geo_parts                                        */
/*==============================================================*/
create table u_dw_references.lc_geo_parts 
(
   geo_id             NUMBER(22,0)         not null,
   part_id            NUMBER(22,0)         not null,
   part_code          VARCHAR2(30 CHAR),
   part_desc          VARCHAR2(200 CHAR)   not null,
   localization_id    NUMBER(22,0)         not null,
   constraint PK_LC_GEO_PARTS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_geo_parts is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_geo_parts.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_geo_parts.part_id is
'ID Code of Part of World';

comment on column u_dw_references.lc_geo_parts.part_code is
'Code of Part of World';

comment on column u_dw_references.lc_geo_parts.part_desc is
'Description of Part of World';

comment on column u_dw_references.lc_geo_parts.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_geo_parts
   add constraint CHK_LC_CONTINENTS_CODE check (part_code is null or (part_code = upper(part_code)));

alter table u_dw_references.lc_geo_parts
   add constraint FK_LC_CONTINENTS foreign key (geo_id)
      references u_dw_references.t_geo_parts (geo_id)
      on delete cascade;

alter table u_dw_references.lc_geo_parts
   add constraint FK_LOC2CONTINENTS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;


drop view u_dw_references.vl_geo_parts;

/*==============================================================*/
/* View: vl_geo_parts                                         */
/*==============================================================*/
create or replace view u_dw_references.vl_geo_parts as
select
   geo_id,
   part_id,
   part_code,
   part_desc,
   localization_id
from
   lc_geo_parts;

 comment on table u_dw_references.vl_geo_parts is
'Localazible View: T_CONTINENTS';

comment on column u_dw_references.vl_geo_parts.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_geo_parts.PART_ID is
'ID Code of Part of World';

comment on column u_dw_references.vl_geo_parts.PART_CODE is
'Code of Part of World';

comment on column u_dw_references.vl_geo_parts.PART_DESC is
'Description of Part of World';

comment on column u_dw_references.vl_geo_parts.LOCALIZATION_ID is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_geo_parts to u_dw_ext_references;



drop view u_dw_references.cu_geo_parts;

/*==============================================================*/
/* View: cu_geo_parts                                         */
/*==============================================================*/
create or replace view u_dw_references.cu_geo_parts as
select
   src.geo_id,
   src.part_id as part_id,
   NVL( lc.part_code, '-' ) as part_code,
   NVL( lc.part_desc, 'Not Defined' ) as part_desc,
   NVL( lc.localization_id, -99 ) as localization_id
from
   w_geo_parts src,
   lc_geo_parts lc
where
   lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id

with read only;

comment on column u_dw_references.cu_geo_parts.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_geo_parts.PART_ID is
'ID Code of Geographical Part of World';



drop trigger u_dw_references.bi_t_regions
/

alter table u_dw_references.t_geo_regions
   drop constraint FK_T_GEO_OBJECTS2GEO_REGIONS
/

drop table u_dw_references.t_geo_regions cascade constraints
/

/*==============================================================*/
/* Table: t_geo_regions                                       */
/*==============================================================*/
create table u_dw_references.t_geo_regions 
(
   geo_id             NUMBER(22,0)         not null,
   region_id          NUMBER(22,0)         not null,
   constraint PK_T_GEO_REGIONS primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_geo_regions is
'Referense store: Geographical Continents - Regions'
/

comment on column u_dw_references.t_geo_regions.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_geo_regions.region_id is
'ID Code of Geographical Continent - Regions'
/

alter table u_dw_references.t_geo_regions
   add constraint FK_T_GEO_OBJECTS2GEO_REGIONS foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_regions before insert
on u_dw_references.t_geo_regions for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 11 --Regions
               , :new.region_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/



drop view u_dw_references.w_geo_regions;

/*==============================================================*/
/* View: w_geo_regions                                        */
/*==============================================================*/
create or replace view u_dw_references.w_geo_regions as
select
   geo_id,
   region_id
from
   t_geo_regions;

 comment on table u_dw_references.w_geo_regions is
'Work View: T_CONTINENTS';

comment on column u_dw_references.w_geo_regions.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_geo_regions.REGION_ID is
'ID Code of Geographical Continent - Regions';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_geo_regions to u_dw_ext_references;


alter table u_dw_references.lc_geo_regions
   drop constraint FK_LC_GEO_REGIONS;

alter table u_dw_references.lc_geo_regions
   drop constraint FK_LOC2LC_GEO_REGIONS;

drop table u_dw_references.lc_geo_regions cascade constraints;

/*==============================================================*/
/* Table: lc_geo_regions                                      */
/*==============================================================*/
create table u_dw_references.lc_geo_regions 
(
   geo_id             NUMBER(22,0)         not null,
   region_id          NUMBER(22,0)         not null,
   region_code        VARCHAR2(30 CHAR),
   region_desc        VARCHAR2(200 CHAR)   not null,
   localization_id    NUMBER(22,0)         not null,
   constraint PK_LC_GEO_REGIONS primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_geo_regions is
'Localization table: T_GEO_SYSTEMS';

comment on column u_dw_references.lc_geo_regions.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_geo_regions.region_id is
'ID Code of Geographical Continent - Regions';

comment on column u_dw_references.lc_geo_regions.region_code is
'Code of Continent Regions';

comment on column u_dw_references.lc_geo_regions.region_desc is
'Description of Continent Regions';

comment on column u_dw_references.lc_geo_regions.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_geo_regions
   add constraint CHK_LC_GEO_REGIONS_CODE check (region_code is null or (region_code = upper(region_code)));

alter table u_dw_references.lc_geo_regions
   add constraint FK_LC_GEO_REGIONS foreign key (geo_id)
      references u_dw_references.t_geo_regions (geo_id)
      on delete cascade;

alter table u_dw_references.lc_geo_regions
   add constraint FK_LOC2LC_GEO_REGIONS foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;



drop view u_dw_references.vl_geo_regions;

/*==============================================================*/
/* View: vl_geo_regions                                       */
/*==============================================================*/
create or replace view u_dw_references.vl_geo_regions as
SELECT geo_id
     , region_id
     , region_code
     , region_desc
     , localization_id
  FROM lc_geo_regions;

 comment on table u_dw_references.vl_geo_regions is
'Localazible View: T_CONTINENTS';

comment on column u_dw_references.vl_geo_regions.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_geo_regions.REGION_ID is
'ID Code of Geographical Continent - Regions';

comment on column u_dw_references.vl_geo_regions.REGION_CODE is
'Code of Continent Regions';

comment on column u_dw_references.vl_geo_regions.REGION_DESC is
'Description of Continent Regions';

comment on column u_dw_references.vl_geo_regions.LOCALIZATION_ID is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_geo_regions to u_dw_ext_references;



drop view u_dw_references.cu_geo_regions;

/*==============================================================*/
/* View: cu_geo_regions                                       */
/*==============================================================*/
create or replace view u_dw_references.cu_geo_regions as
SELECT src.geo_id
     , src.region_id AS region_id
     , NVL ( lc.region_code, '-' ) AS region_code
     , NVL ( lc.region_desc, 'Not Defined' ) AS region_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_geo_regions src
     , lc_geo_regions lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_geo_regions.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_geo_regions.REGION_ID is
'ID Code of Geographical Continent - Regions';


drop trigger u_dw_references.bi_t_countries
/

alter table u_dw_references.t_countries
   drop constraint FK_T_GEO_OBJECTS2COUNTRIES
/

drop table u_dw_references.t_countries cascade constraints
/

/*==============================================================*/
/* Table: t_countries                                         */
/*==============================================================*/
create table u_dw_references.t_countries 
(
   geo_id             NUMBER(22,0)         not null,
   country_id         NUMBER(22,0)         not null,
   constraint PK_T_COUNTRIES primary key (geo_id)
)
organization index tablespace TS_REFERENCES_DATA_01
/

comment on table u_dw_references.t_countries is
'Referense store: Geographical Countries'
/

comment on column u_dw_references.t_countries.geo_id is
'Unique ID for All Geography objects'
/

comment on column u_dw_references.t_countries.country_id is
'ID Code of Country'
/

alter table u_dw_references.t_countries
   add constraint FK_T_GEO_OBJECTS2COUNTRIES foreign key (geo_id)
      references u_dw_references.t_geo_objects (geo_id)
      on delete cascade
      deferrable
/


create trigger u_dw_references.bi_t_countries before insert
on u_dw_references.t_countries for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    lc_geo_id      NUMBER := 0;
BEGIN
   IF :new.geo_id IS NOT NULL THEN
      raise_application_error ( -20000
                              , 'Geo_id have to be ''NULL''. New Values will be generated by triger.' );
   END IF;

   INSERT INTO w_geo_objects ( geo_id
                             , geo_type_id
                             , geo_code_id )
        VALUES ( sq_geo_t_id.NEXTVAL
               , 12 --Country
               , :new.country_id )
     RETURNING geo_id
          INTO :new.geo_id;
--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/



drop view u_dw_references.w_countries;

/*==============================================================*/
/* View: w_countries                                          */
/*==============================================================*/
create or replace view u_dw_references.w_countries as
select
   geo_id,
   country_id
from
   t_countries;

 comment on table u_dw_references.w_countries is
'Work View: T_COUNTRIES';

comment on column u_dw_references.w_countries.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.w_countries.COUNTRY_ID is
'ID Code of Country';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_countries to u_dw_ext_references;


alter table u_dw_references.lc_countries
   drop constraint FK_LC_COUNTRIES;

alter table u_dw_references.lc_countries
   drop constraint FK_LOC2COUNTRIES;

drop table u_dw_references.lc_countries cascade constraints;

/*==============================================================*/
/* Table: lc_countries                                        */
/*==============================================================*/
create table u_dw_references.lc_countries 
(
   geo_id             NUMBER(22,0)         not null,
   country_id         NUMBER(22,0)         not null,
   country_code_a2    VARCHAR2(30 CHAR),
   country_code_a3    VARCHAR2(30 CHAR),
   country_desc       VARCHAR2(200 CHAR)   not null,
   localization_id    NUMBER(22,0)         not null,
   constraint PK_LC_COUNTRIES primary key (geo_id, localization_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.lc_countries is
'Localization table: T_COUNTRIES';

comment on column u_dw_references.lc_countries.geo_id is
'Unique ID for All Geography objects';

comment on column u_dw_references.lc_countries.country_id is
'ID Code of Country';

comment on column u_dw_references.lc_countries.country_code_a2 is
'Code of Countries - ALPHA 2';

comment on column u_dw_references.lc_countries.country_code_a3 is
'Code of Countries - ALPHA 3';

comment on column u_dw_references.lc_countries.country_desc is
'Description of Countries';

comment on column u_dw_references.lc_countries.localization_id is
'Identificator of Supported References Languages';

alter table u_dw_references.lc_countries
   add constraint CHK_LC_COUNTRIES_CODE_A2 check (country_code_a2 is null or (country_code_a2 = upper(country_code_a2)));

alter table u_dw_references.lc_countries
   add constraint CHK_LC_COUNTRIES_CODE_A3 check (country_code_a3 is null or (country_code_a3 = upper(country_code_a3)));

alter table u_dw_references.lc_countries
   add constraint FK_LC_COUNTRIES foreign key (geo_id)
      references u_dw_references.t_countries (geo_id)
      on delete cascade;

alter table u_dw_references.lc_countries
   add constraint FK_LOC2COUNTRIES foreign key (localization_id)
      references u_dw_references.t_localizations (localization_id)
      on delete cascade;


drop view u_dw_references.vl_countries;

/*==============================================================*/
/* View: vl_countries                                         */
/*==============================================================*/
create or replace view u_dw_references.vl_countries as
SELECT geo_id
     , country_id
     , country_code_a2
     , country_code_a3
     , country_desc
     , localization_id
  FROM lc_countries;

 comment on table u_dw_references.vl_countries is
'Localazible View: T_CONTINENTS';

comment on column u_dw_references.vl_countries.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.vl_countries.COUNTRY_ID is
'ID Code of Country';

comment on column u_dw_references.vl_countries.COUNTRY_CODE_A2 is
'Code of Countries - ALPHA 2';

comment on column u_dw_references.vl_countries.COUNTRY_CODE_A3 is
'Code of Countries - ALPHA 3';

comment on column u_dw_references.vl_countries.COUNTRY_DESC is
'Description of Countries';

comment on column u_dw_references.vl_countries.LOCALIZATION_ID is
'Identificator of Supported References Languages';

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.vl_countries to u_dw_ext_references;


drop view u_dw_references.cu_countries;

/*==============================================================*/
/* View: cu_countries                                         */
/*==============================================================*/
create or replace view u_dw_references.cu_countries as
SELECT src.geo_id
     , src.country_id AS country_id
     , NVL ( lc.country_code_a2, '-' ) AS country_code_a2
     , NVL ( lc.country_code_a3, '-' ) AS country_code_a3
     , NVL ( lc.country_desc, 'Not Defined' ) AS region_desc
     , NVL ( lc.localization_id, -99 ) AS localization_id
  FROM w_countries src
     , lc_countries lc
 WHERE lc.geo_id(+) = src.geo_id
   AND lc.localization_id(+) = pkg_session_params.get_user_localization_id
with read only;

comment on column u_dw_references.cu_countries.GEO_ID is
'Unique ID for All Geography objects';

comment on column u_dw_references.cu_countries.COUNTRY_ID is
'ID Code of Country';


drop sequence u_dw_references.sq_languages_t_id;

create sequence u_dw_references.sq_languages_t_id;

grant SELECT on u_dw_references.sq_languages_t_id to u_dw_ext_references;


drop sequence u_dw_references.sq_lng_scopes_t_id;

create sequence u_dw_references.sq_lng_scopes_t_id
start with 4;

grant SELECT on u_dw_references.sq_lng_scopes_t_id to u_dw_ext_references;


drop sequence u_dw_references.sq_lng_types_t_id;

create sequence u_dw_references.sq_lng_types_t_id;

grant SELECT on u_dw_references.sq_lng_types_t_id to u_dw_ext_references;



--drop table u_dw_ext_references.t_ext_cntr_grouping_iso3166 cascade constraints;

--==============================================================
-- Table: t_ext_cntr_grouping_iso3166                           
--==============================================================
create table u_dw_ext_references.t_ext_cntr_grouping_iso3166 
(
   child_code           NUMBER(10,0),
   parent_code          NUMBER(10,0),
   group_desc           VARCHAR2(200 CHAR),
   group_level          VARCHAR2(200 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL ( child_code integer external (4), parent_code integer external, group_desc char(200), group_level char(200) ) )
    location ('iso_3166_groups_un.tab')
)
reject limit unlimited;

--comment on table u_dw_ext_references.t_ext_cntr_grouping_iso3166 is
--'External table for loading - Geography stucture of WORLD';



drop table u_dw_ext_references.t_ext_cntr2grouping_iso3166 cascade constraints;

--==============================================================
-- Table: t_ext_cntr2grouping_iso3166                           
--==============================================================
create table u_dw_ext_references.t_ext_cntr2grouping_iso3166 
(
   country_id           NUMBER(10,0),
   country_desc          VARCHAR2(200 CHAR),
   group_code           NUMBER(10,0),
   group_desc           VARCHAR2(200 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL ( country_id integer external (4), country_desc char(200), group_code integer external, group_desc char(200) ) )
    location ('iso_3166_groups_un_contries.tab')
)
reject limit unlimited;

--comment on table u_dw_ext_references.t_ext_cntr2grouping_iso3166 is
--'External table for loading - Countries';



drop table u_dw_ext_references.cls_cntr_grouping_iso3166 cascade constraints;

/*==============================================================*/
/* Table: cls_cntr_grouping_iso3166                           */
/*==============================================================*/
create table u_dw_ext_references.cls_cntr_grouping_iso3166 
(
   child_code         NUMBER(10,0),
   parent_code        NUMBER(10,0),
   group_desc         VARCHAR2(200 CHAR),
   group_level        VARCHAR2(200 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_cntr_grouping_iso3166 is
'Cleansing table for loading - Structure of GeoLocation world Dividing (USA standart)';

comment on column u_dw_ext_references.cls_cntr_grouping_iso3166.child_code is
'Code of Group Element';

comment on column u_dw_ext_references.cls_cntr_grouping_iso3166.parent_code is
'Parent Code of Group Element';

comment on column u_dw_ext_references.cls_cntr_grouping_iso3166.group_desc is
'Description of GroupElement';

comment on column u_dw_ext_references.cls_cntr_grouping_iso3166.group_level is
'Level grouping Code of Group Element';



drop table u_dw_ext_references.cls_cntr2grouping_iso3166 cascade constraints;

/*==============================================================*/
/* Table: cls_cntr2grouping_iso3166                           */
/*==============================================================*/
create table u_dw_ext_references.cls_cntr2grouping_iso3166 
(
   country_id         NUMBER(10,0),
   country_desc        VARCHAR2(200 CHAR),
   group_code         NUMBER(10,0),
   group_desc         VARCHAR2(200 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_cntr2grouping_iso3166 is
'Cleansing table for loading - Links Countries to GeoLocation Sructure world Dividing  (USA standart)';

comment on column u_dw_ext_references.cls_cntr2grouping_iso3166.country_id is
'ISO - Country ID';

comment on column u_dw_ext_references.cls_cntr2grouping_iso3166.country_desc is
'ISO - Country Desc';

comment on column u_dw_ext_references.cls_cntr2grouping_iso3166.group_code is
'Code of Group Element';

comment on column u_dw_ext_references.cls_cntr2grouping_iso3166.group_desc is
'Description of Group Element';


drop table u_dw_ext_references.t_ext_geo_structure_iso3166 cascade constraints;

/*==============================================================*/
/* Table: t_ext_geo_structure_iso3166                         */
/*==============================================================*/
create table u_dw_ext_references.t_ext_geo_structure_iso3166 
(
   child_code         NUMBER(10,0),
   parent_code        NUMBER(10,0),
   structure_desc     VARCHAR2(200 CHAR),
   structure_level    VARCHAR2(200 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (child_code integer external (4), parent_code integer external, structure_desc char(200), structure_level char(200) ) )
    location ('iso_3166_geo_un.tab')
)
reject limit unlimited;



drop table u_dw_ext_references.t_ext_cntr2structure_iso3166 cascade constraints;

/*==============================================================*/
/* Table: t_ext_cntr2structure_iso3166                        */
/*==============================================================*/
create table u_dw_ext_references.t_ext_cntr2structure_iso3166 
(
   country_id         NUMBER(10,0),
   country_desc        VARCHAR2(200 CHAR),
   structure_code     NUMBER(10,0),
   structure_desc     VARCHAR2(200 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL ( country_id integer external (4), country_desc char(200), structure_code integer external, structure_desc char(200) ) )
    location ('iso_3166_geo_un_contries.tab')
)
reject limit unlimited;


drop table u_dw_ext_references.cls_geo_structure_iso3166 cascade constraints;

/*==============================================================*/
/* Table: cls_geo_structure_iso3166                           */
/*==============================================================*/
create table u_dw_ext_references.cls_geo_structure_iso3166 
(
   child_code         NUMBER(10,0),
   parent_code        NUMBER(10,0),
   structure_desc     VARCHAR2(200 CHAR),
   structure_level    VARCHAR2(200 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_geo_structure_iso3166 is
'Cleansing table for loading - Structure of GeoLocation world Dividing (USA standart)';

comment on column u_dw_ext_references.cls_geo_structure_iso3166.child_code is
'Code of Structure Element';

comment on column u_dw_ext_references.cls_geo_structure_iso3166.parent_code is
'Parent Code of Structure Element';

comment on column u_dw_ext_references.cls_geo_structure_iso3166.structure_desc is
'Description of Structure Element';

comment on column u_dw_ext_references.cls_geo_structure_iso3166.structure_level is
'Level grouping Code of Structure Element';



drop table u_dw_ext_references.cls_cntr2structure_iso3166 cascade constraints;

/*==============================================================*/
/* Table: cls_cntr2structure_iso3166                          */
/*==============================================================*/
create table u_dw_ext_references.cls_cntr2structure_iso3166 
(
   country_id         NUMBER(10,0),
   country_desc        VARCHAR2(200 CHAR),
   structure_code     NUMBER(10,0),
   structure_desc     VARCHAR2(200 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_cntr2structure_iso3166 is
'Cleansing table for loading - Links Countries to GeoLocation Sructure world Dividing  (USA standart)';

comment on column u_dw_ext_references.cls_cntr2structure_iso3166.country_id is
'ISO - Country ID';

comment on column u_dw_ext_references.cls_cntr2structure_iso3166.country_desc is
'ISO - Country Desc';

comment on column u_dw_ext_references.cls_cntr2structure_iso3166.structure_code is
'Code of Structure Element';

comment on column u_dw_ext_references.cls_cntr2structure_iso3166.structure_desc is
'Description of Structure Element';



drop table u_dw_ext_references.t_ext_geo_countries_iso3166 cascade constraints;

/*==============================================================*/
/* Table: t_ext_geo_countries_iso3166                         */
/*==============================================================*/
create table u_dw_ext_references.t_ext_geo_countries_iso3166 
(
   country_id         NUMBER(10,0),
   country_desc        VARCHAR2(200 CHAR),
   country_code       VARCHAR2(30 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (country_id integer external (4), country_desc char(200), country_code char(3) ) )
    location ('iso_3166.tab')
)
reject limit unlimited;


drop table u_dw_ext_references.t_ext_geo_countries2_iso3166 cascade constraints;

/*==============================================================*/
/* Table: t_ext_geo_countries2_iso3166                        */
/*==============================================================*/
create table u_dw_ext_references.t_ext_geo_countries2_iso3166 
(
   country_desc       VARCHAR2(200 CHAR),
   country_code       VARCHAR2(30 CHAR)
)
organization external (
    type oracle_loader
    default directory ext_references
    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (country_desc char(200), country_code char(3) ) )
    location ('iso_3166_2.tab')
)
reject limit unlimited;



drop table u_dw_ext_references.cls_geo_countries_iso3166 cascade constraints;

/*==============================================================*/
/* Table: cls_geo_countries_iso3166                           */
/*==============================================================*/
create table u_dw_ext_references.cls_geo_countries_iso3166 
(
   country_id         NUMBER(10,0),
   country_desc       VARCHAR2(200 CHAR),
   country_code       VARCHAR2(30 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_geo_countries_iso3166 is
'Cleansing table for loading - Countries';

comment on column u_dw_ext_references.cls_geo_countries_iso3166.country_id is
'ISO - Country ID';

comment on column u_dw_ext_references.cls_geo_countries_iso3166.country_desc is
'ISO - Country Name';

comment on column u_dw_ext_references.cls_geo_countries_iso3166.country_code is
'ISO - Alpha Name 3';

alter table u_dw_ext_references.cls_geo_countries_iso3166
   add constraint CHK_CLS_GEO_COUNTRY_CODE check (country_code is null or (country_code = upper(country_code)));



drop table u_dw_ext_references.cls_geo_countries2_iso3166 cascade constraints;

/*==============================================================*/
/* Table: cls_geo_countries2_iso3166                          */
/*==============================================================*/
create table u_dw_ext_references.cls_geo_countries2_iso3166 
(
   country_desc       VARCHAR2(200 CHAR),
   country_code       VARCHAR2(30 CHAR)
)
tablespace TS_REFERENCES_EXT_DATA_01;

comment on table u_dw_ext_references.cls_geo_countries2_iso3166 is
'Cleansing table for loading - Countries';

comment on column u_dw_ext_references.cls_geo_countries2_iso3166.country_desc is
'ISO - Country Name';

comment on column u_dw_ext_references.cls_geo_countries2_iso3166.country_code is
'ISO - Alpha Name 3';

alter table u_dw_ext_references.cls_geo_countries2_iso3166
   add constraint CHK_CLS_GEO_COUNTRY2_CODE check (country_code is null or (country_code = upper(country_code)));

SELECT DName
       FROM SCOTT.dept dept
      WHERE deptno NOT IN
            ( SELECT /*+ NL_AJ */ deptno FROM scott.emp );

insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (2,2,2);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (10,10,10);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (11,11,11);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (12,12,12);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (50,50,50);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (51,51,51);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (52,52,52);



CREATE OR REPLACE PACKAGE pkg_load_ext_ref_geography
-- Package Reload Data From External Sources to DataBase - Geography objects
--
AS  
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha3;
   
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 2
   PROCEDURE load_cls_languages_alpha2;
      
   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_ref_geo_countries;
   
   -- Extract Data from external source = External Table
   -- Load All Geography objects from ISO 3166
   PROCEDURE load_cls_geo_structure;
      
   -- Extract Data from external source = External Table
   -- Load All Geography objects from ISO 3166
   PROCEDURE load_cls_geo_structure2cntr;
   
   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_systems;
   
   -- Load Geography Continents from ISO 3166 to References
   PROCEDURE load_ref_geo_parts;
   
   -- Load Geography Regions from ISO 3166 to References
   PROCEDURE load_ref_geo_regions;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups from ISO 3166
   PROCEDURE load_cls_countries_grouping;

     -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups Links to Countries from ISO 3166
   PROCEDURE load_cls_countries2groups;
   
    -- Load Countries Grouping System from ISO 3166 to References
   PROCEDURE load_ref_cntr_group_systems;
   
    -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_groups;
   
    -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_sub_groups;
   
    -- Load Countries links to Geography from ISO 3166 to References
   PROCEDURE load_lnk_geo_structure;
   
   -- Load Countries links to Geography Regions from ISO 3166 to References
   PROCEDURE load_lnk_geo_countries;
   
   -- Load Countries links to Grouping Systems from ISO 3166 to References
   PROCEDURE load_lnk_cntr_grouping;
   
   -- Load Countries links to Groups from ISO 3166 to References
   PROCEDURE load_lnk_cntr2groups;
   
END pkg_load_ext_ref_geography;
/



CREATE OR REPLACE PACKAGE BODY pkg_load_ext_ref_geography
AS
   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha3
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_COUNTRIES_ISO3166';

      --Extract data
      INSERT INTO cls_geo_countries_iso3166 ( country_id
                                            , country_desc
                                            , country_code )
         SELECT country_id
              , country_desc
              , country_code
           FROM t_ext_geo_countries_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_languages_alpha3;

   -- Extract Data from external source = External Table
   -- Load All Countries from ISO 3166 Alpha 3
   PROCEDURE load_cls_languages_alpha2
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_COUNTRIES2_ISO3166';

      --Extract data
      INSERT INTO cls_geo_countries2_iso3166 ( country_desc
                                             , country_code )
         SELECT country_desc
              , country_code
           FROM t_ext_geo_countries2_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_languages_alpha2;

   -- Load All Countries from ISO 3166 to References
   PROCEDURE load_ref_geo_countries
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_countries trg
            WHERE trg.country_id NOT IN (     SELECT DISTINCT country_id FROM cls_geo_countries_iso3166);

      --Merge Source data
      MERGE INTO u_dw_references.w_countries trg
           USING (  SELECT DISTINCT country_id
                      FROM cls_geo_countries_iso3166
                  ORDER BY country_id) cls
              ON ( trg.country_id = cls.country_id )
      WHEN NOT MATCHED THEN
         INSERT            ( country_id )
             VALUES ( cls.country_id );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_countries trg
           USING (  SELECT MAX ( geo_id ) AS geo_id
                         , MAX ( country_id ) AS country_id
                         , country_desc
                         , MAX ( country_code_alpha3 ) AS country_code_alpha3
                         , MAX ( country_code_alpha2 ) AS country_code_alpha2
                         , 1 AS localization_id
                      FROM (SELECT trg.geo_id
                                 , trg.country_id
                                 , trg.country_desc
                                 , trg.country_code_alpha3
                                 , lkp.country_code_alpha2
                                 , trg.look_country_desc AS target_desc
                                 , lkp.look_country_desc AS lookup_desc
                              FROM (SELECT trg.geo_id
                                         , trg.country_id
                                         , src.country_desc
                                         , UPPER ( src.country_desc ) || '%' look_country_desc
                                         , src.country_code AS country_code_alpha3
                                      FROM u_dw_references.w_countries trg
                                         , cls_geo_countries_iso3166 src
                                     WHERE src.country_id(+) = trg.country_id) trg
                                 , (SELECT NULL AS geo_id
                                         , NULL AS country_id
                                         , NULL AS country_desc
                                         , src2.country_desc AS look_country_desc
                                         , NULL AS country_code_alpha3
                                         , src2.country_code AS country_code_alpha2
                                      FROM cls_geo_countries2_iso3166 src2) lkp
                             WHERE lkp.look_country_desc(+) LIKE trg.look_country_desc
                            UNION ALL
                            SELECT trg.geo_id
                                 , trg.country_id
                                 , trg.country_desc
                                 , trg.country_code_alpha3
                                 , lkp.country_code_alpha2
                                 , trg.look_country_desc AS target_desc
                                 , lkp.look_country_desc AS lookup_desc
                              FROM (SELECT trg.geo_id
                                         , trg.country_id
                                         , src.country_desc
                                         , UPPER ( src.country_desc ) look_country_desc
                                         , src.country_code AS country_code_alpha3
                                      FROM u_dw_references.w_countries trg
                                         , cls_geo_countries_iso3166 src
                                     WHERE src.country_id(+) = trg.country_id) trg
                                 , (SELECT NULL AS geo_id
                                         , NULL AS country_id
                                         , NULL AS country_desc
                                         , SUBSTR ( src2.country_desc
                                                  , 1
                                                  , DECODE ( INSTR ( src2.country_desc
                                                                   , ',' )
                                                           , 0, 201
                                                           , INSTR ( src2.country_desc
                                                                   , ',' ) )
                                                    - 1 )
                                           || '%'
                                              AS look_country_desc
                                         , NULL AS country_code_alpha3
                                         , src2.country_code AS country_code_alpha2
                                      FROM cls_geo_countries2_iso3166 src2) lkp
                             WHERE trg.look_country_desc(+) LIKE lkp.look_country_desc)
                     WHERE country_id IS NOT NULL
                  GROUP BY country_desc
                  ORDER BY country_id) cls
              ON ( trg.country_id = cls.country_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , country_id
                           , country_code_a2
                           , country_code_a3
                           , country_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.country_id
                    , cls.country_code_alpha2
                    , cls.country_code_alpha3
                    , cls.country_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.country_desc = cls.country_desc
                  , trg.country_code_a2 = cls.country_code_alpha2
                  , trg.country_code_a3 = cls.country_code_alpha3;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_countries;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Structures from ISO 3166
   PROCEDURE load_cls_geo_structure
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_GEO_STRUCTURE_ISO3166';

      --Extract data
      INSERT INTO cls_geo_structure_iso3166 ( child_code
                                            , parent_code
                                            , structure_desc
                                            , structure_level )
         SELECT child_code
              , parent_code
              , structure_desc
              , structure_level
           FROM t_ext_geo_structure_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_geo_structure;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Contries from ISO 3166
   PROCEDURE load_cls_geo_structure2cntr
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_CNTR2STRUCTURE_ISO3166';

      --Extract data
      INSERT INTO cls_cntr2structure_iso3166 ( country_id
                                             , country_desc
                                             , structure_code
                                             , structure_desc )
         SELECT country_id
              , country_desc
              , structure_code
              , structure_desc
           FROM t_ext_cntr2structure_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_geo_structure2cntr;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_systems
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_geo_systems trg
            WHERE trg.geo_system_id NOT IN (SELECT DISTINCT child_code
                                              FROM cls_geo_structure_iso3166
                                             WHERE UPPER ( structure_level ) = 'WORLD');

      --Merge Source data
      MERGE INTO u_dw_references.w_geo_systems trg
           USING (SELECT DISTINCT child_code
                    FROM cls_geo_structure_iso3166
                   WHERE UPPER ( structure_level ) = 'WORLD') cls
              ON ( trg.geo_system_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_system_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_geo_systems trg
           USING (SELECT geo_id
                       , geo_system_id
                       , CASE WHEN ( geo_system_id = 1 ) THEN 'WORLD' ELSE NULL END geo_system_code
                       , CASE WHEN ( geo_system_id = 1 ) THEN 'The UN World structure' ELSE NULL END geo_system_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_geo_systems src
                       , cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.geo_system_id) cls
              ON ( trg.geo_system_id = cls.geo_system_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , geo_system_id
                           , geo_system_code
                           , geo_system_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.geo_system_id
                    , cls.geo_system_code
                    , cls.geo_system_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.geo_system_desc = cls.geo_system_desc
                  , trg.geo_system_code = cls.geo_system_code;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_systems;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_parts
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_geo_parts trg
            WHERE trg.part_id NOT IN (SELECT DISTINCT child_code
                                        FROM cls_geo_structure_iso3166
                                       WHERE UPPER ( structure_level ) = 'CONTINENTS');

      --Merge Source data
      MERGE INTO u_dw_references.w_geo_parts trg
           USING (SELECT DISTINCT child_code
                    FROM cls_geo_structure_iso3166
                   WHERE UPPER ( structure_level ) = 'CONTINENTS') cls
              ON ( trg.part_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( part_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_geo_parts trg
           USING (SELECT geo_id
                       , src.part_id
                       , NULL part_code
                       , structure_desc AS part_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_geo_parts src
                       , cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.part_id
                     AND UPPER ( cls.structure_level ) = 'CONTINENTS') cls
              ON ( trg.part_id = cls.part_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , part_id
                           , part_code
                           , part_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.part_id
                    , cls.part_code
                    , cls.part_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.part_desc = cls.part_desc
                  , trg.part_code = cls.part_code;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_parts;

   -- Load Geography System from ISO 3166 to References
   PROCEDURE load_ref_geo_regions
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_geo_regions trg
            WHERE trg.region_id NOT IN (SELECT DISTINCT child_code
                                          FROM cls_geo_structure_iso3166
                                         WHERE UPPER ( structure_level ) = 'REGIONS');

      --Merge Source data
      MERGE INTO u_dw_references.w_geo_regions trg
           USING (SELECT DISTINCT child_code
                    FROM cls_geo_structure_iso3166
                   WHERE UPPER ( structure_level ) = 'REGIONS') cls
              ON ( trg.region_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( region_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_geo_regions trg
           USING (SELECT geo_id
                       , src.region_id
                       , NULL region_code
                       , structure_desc AS region_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_geo_regions src
                       , cls_geo_structure_iso3166 cls
                   WHERE cls.child_code(+) = src.region_id
                     AND UPPER ( cls.structure_level ) = 'REGIONS') cls
              ON ( trg.region_id = cls.region_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , region_id
                           , region_code
                           , region_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.region_id
                    , cls.region_code
                    , cls.region_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.region_desc = cls.region_desc
                  , trg.region_code = cls.region_code;

      --Commit Resulst
      COMMIT;
   END load_ref_geo_regions;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups from ISO 3166
   PROCEDURE load_cls_countries_grouping
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CLS_CNTR_GROUPING_ISO3166';

      --Extract data
      INSERT INTO cls_cntr_grouping_iso3166 ( child_code
                                            , parent_code
                                            , group_desc
                                            , group_level )
         SELECT child_code
              , parent_code
              , group_desc
              , group_level
           FROM t_ext_cntr_grouping_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_countries_grouping;

   -- Extract Data from external source = External Table
   -- Load All Geography objects - Groups Links to Countries from ISO 3166
   PROCEDURE load_cls_countries2groups
   AS
   BEGIN
      --truncate cleansing tables
      EXECUTE IMMEDIATE 'TRUNCATE TABLE cls_cntr2grouping_iso3166';

      --Extract data
      INSERT INTO cls_cntr2grouping_iso3166 ( country_id
                                            , country_desc
                                            , group_code
                                            , group_desc )
         SELECT country_id
              , country_desc
              , group_code
              , group_desc
           FROM t_ext_cntr2grouping_iso3166;

      --Commit Data
      COMMIT;
   END load_cls_countries2groups;

   -- Load Countries Grouping System from ISO 3166 to References
   PROCEDURE load_ref_cntr_group_systems
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_cntr_group_systems trg
            WHERE trg.grp_system_id NOT IN (SELECT DISTINCT child_code
                                              FROM cls_cntr_grouping_iso3166
                                             WHERE UPPER ( group_level ) = 'ALL');

      --Merge Source data
      MERGE INTO u_dw_references.w_cntr_group_systems trg
           USING (SELECT DISTINCT child_code
                    FROM cls_cntr_grouping_iso3166
                   WHERE UPPER ( group_level ) = 'ALL') cls
              ON ( trg.grp_system_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( grp_system_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_cntr_group_systems trg
           USING (SELECT geo_id
                       , grp_system_id
                       , CASE WHEN ( grp_system_id = 1 ) THEN 'MAIN' ELSE NULL END grp_system_code
                       , cls.group_desc grp_system_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_cntr_group_systems src
                       , cls_cntr_grouping_iso3166 cls
                   WHERE cls.child_code(+) = src.grp_system_id) cls
              ON ( trg.grp_system_id = cls.grp_system_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , grp_system_id
                           , grp_system_code
                           , grp_system_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.grp_system_id
                    , cls.grp_system_code
                    , cls.grp_system_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.grp_system_desc = cls.grp_system_desc
                  , trg.grp_system_code = cls.grp_system_code;

      --Commit Resulst
      COMMIT;
   END load_ref_cntr_group_systems;

   -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_groups
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_cntr_groups trg
            WHERE trg.GROUP_ID NOT IN (SELECT DISTINCT child_code
                                         FROM cls_cntr_grouping_iso3166
                                        WHERE UPPER ( group_level ) = 'GROUPS');

      --Merge Source data
      MERGE INTO u_dw_references.w_cntr_groups trg
           USING (SELECT DISTINCT child_code
                    FROM cls_cntr_grouping_iso3166
                   WHERE UPPER ( group_level ) = 'GROUPS') cls
              ON ( trg.GROUP_ID = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( GROUP_ID )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_cntr_groups trg
           USING (SELECT geo_id
                       , src.GROUP_ID
                       , NULL group_code
                       , group_desc AS group_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_cntr_groups src
                       , cls_cntr_grouping_iso3166 cls
                   WHERE cls.child_code(+) = src.GROUP_ID
                     AND UPPER ( group_level ) = 'GROUPS') cls
              ON ( trg.GROUP_ID = cls.GROUP_ID
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , GROUP_ID
                           , group_code
                           , group_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.GROUP_ID
                    , cls.group_code
                    , cls.group_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.group_desc = cls.group_desc
                  , trg.group_code = cls.group_code;

      --Commit Resulst
      COMMIT;
   END load_ref_cntr_groups;

   -- Load Countries Groups from ISO 3166 to References
   PROCEDURE load_ref_cntr_sub_groups
   AS
   BEGIN
      --Delete old values
      DELETE FROM u_dw_references.w_cntr_sub_groups trg
            WHERE trg.sub_group_id NOT IN (SELECT DISTINCT child_code
                                             FROM cls_cntr_grouping_iso3166
                                            WHERE UPPER ( group_level ) = 'GROUP ITEMS');

      --Merge Source data
      MERGE INTO u_dw_references.w_cntr_sub_groups trg
           USING (SELECT DISTINCT child_code
                    FROM cls_cntr_grouping_iso3166
                   WHERE UPPER ( group_level ) = 'GROUP ITEMS') cls
              ON ( trg.sub_group_id = cls.child_code )
      WHEN NOT MATCHED THEN
         INSERT            ( sub_group_id )
             VALUES ( cls.child_code );

      --Merge Source Localizable Data
      MERGE INTO u_dw_references.vl_cntr_sub_groups trg
           USING (SELECT geo_id
                       , src.sub_group_id
                       , NULL sub_group_code
                       , group_desc AS sub_group_desc
                       , 1 AS localization_id
                    FROM u_dw_references.w_cntr_sub_groups src
                       , cls_cntr_grouping_iso3166 cls
                   WHERE cls.child_code(+) = src.sub_group_id
                     AND UPPER ( group_level ) = 'GROUP ITEMS') cls
              ON ( trg.sub_group_id = cls.sub_group_id
              AND trg.localization_id = cls.localization_id )
      WHEN NOT MATCHED THEN
         INSERT            ( geo_id
                           , sub_group_id
                           , sub_group_code
                           , sub_group_desc
                           , localization_id )
             VALUES ( cls.geo_id
                    , cls.sub_group_id
                    , cls.sub_group_code
                    , cls.sub_group_desc
                    , cls.localization_id )
      WHEN MATCHED THEN
         UPDATE SET trg.sub_group_desc = cls.sub_group_desc
                  , trg.sub_group_code = cls.sub_group_code;

      --Commit Resulst
      COMMIT;
   END load_ref_cntr_sub_groups;

   -- Load Countries links to Geography from ISO 3166 to References
   PROCEDURE load_lnk_geo_structure
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_references.w_geo_object_links trg
           USING (SELECT p_obj.geo_id parent_geo_id
                       , c_obj.geo_id child_geo_id
                       , CASE
                            WHEN p_obj.geo_type_id = 2
                             AND c_obj.geo_type_id = 10 THEN
                               1
                            WHEN p_obj.geo_type_id = 10
                             AND c_obj.geo_type_id = 11 THEN
                               2
                            ELSE
                               NULL
                         END
                            AS link_type_id
                    FROM (SELECT child_code
                               , parent_code
                               , structure_desc
                               , CASE
                                    WHEN UPPER ( structure_level ) = 'WORLD' THEN 2
                                    WHEN UPPER ( structure_level ) = 'CONTINENTS' THEN 10
                                    WHEN UPPER ( structure_level ) = 'REGIONS' THEN 11
                                    ELSE NULL
                                 END
                                    AS type_id
                            FROM cls_geo_structure_iso3166) cls
                       , u_dw_references.w_geo_objects p_obj
                       , u_dw_references.w_geo_objects c_obj
                   WHERE cls.parent_code IS NOT NULL
                     AND p_obj.geo_code_id = cls.parent_code
                     AND p_obj.geo_type_id < cls.type_id
                     AND c_obj.geo_code_id = cls.child_code
                     AND c_obj.geo_type_id = cls.type_id) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_geo_structure;

   -- Load Countries links to Geography Regions from ISO 3166 to References
   PROCEDURE load_lnk_geo_countries
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_references.w_geo_object_links trg
           USING (SELECT reg.geo_id AS parent_geo_id
                       , cntr.geo_id AS child_geo_id
                       , cls.country_desc
                       , cls.structure_desc
                       , 3 AS link_type_id
                    FROM cls_cntr2structure_iso3166 cls
                       , u_dw_references.w_countries cntr
                       , u_dw_references.w_geo_regions reg
                   WHERE cls.country_id = cntr.country_id
                     AND cls.structure_code = reg.region_id) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_geo_countries;

   -- Load Countries links to Grouping Systems from ISO 3166 to References
   PROCEDURE load_lnk_cntr_grouping
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_references.w_geo_object_links trg
           USING (SELECT p_obj.geo_id parent_geo_id
                       , c_obj.geo_id child_geo_id
                       , CASE
                            WHEN p_obj.geo_type_id = 50
                             AND c_obj.geo_type_id = 51 THEN
                               4
                            WHEN p_obj.geo_type_id = 51
                             AND c_obj.geo_type_id = 52 THEN
                               5
                            ELSE
                               NULL
                         END
                            AS link_type_id
                    FROM (SELECT child_code
                               , parent_code
                               , group_desc
                               , CASE
                                    WHEN UPPER ( group_level ) = 'ALL' THEN 50
                                    WHEN UPPER ( group_level ) = 'GROUPS' THEN 51
                                    WHEN UPPER ( group_level ) = 'GROUP ITEMS' THEN 52
                                    ELSE NULL
                                 END
                                    AS type_id
                            FROM cls_cntr_grouping_iso3166) cls
                       , u_dw_references.w_geo_objects p_obj
                       , u_dw_references.w_geo_objects c_obj
                   WHERE cls.parent_code IS NOT NULL
                     AND p_obj.geo_code_id = cls.parent_code
                     AND p_obj.geo_type_id < cls.type_id
                     AND p_obj.geo_type_id > 49 --constant deviding by type
                     AND c_obj.geo_code_id = cls.child_code
                     AND c_obj.geo_type_id = cls.type_id) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_cntr_grouping;

   -- Load Countries links to Groups from ISO 3166 to References
   PROCEDURE load_lnk_cntr2groups
   AS
   BEGIN
      --Merge Source data
      MERGE INTO u_dw_references.w_geo_object_links trg
           USING (SELECT spb.geo_id AS parent_geo_id
                       , cntr.geo_id AS child_geo_id
                       , 6 AS link_type_id
                       , cls.country_desc
                    FROM cls_cntr2grouping_iso3166 cls
                       , u_dw_references.w_cntr_sub_groups spb
                       , u_dw_references.w_countries cntr
                   WHERE cntr.country_id = cls.country_id
                     AND spb.sub_group_id = cls.group_code) cls
              ON ( trg.parent_geo_id = cls.parent_geo_id
              AND trg.child_geo_id = cls.child_geo_id
              AND trg.link_type_id = cls.link_type_id )
      WHEN NOT MATCHED THEN
         INSERT            ( parent_geo_id
                           , child_geo_id
                           , link_type_id )
             VALUES ( cls.parent_geo_id
                    , cls.child_geo_id
                    , cls.link_type_id );

      --Commit Resulst
      COMMIT;
   END load_lnk_cntr2groups;
END pkg_load_ext_ref_geography;
/


BEGIN
   --Transport Countries
   pkg_load_ext_ref_geography.load_cls_languages_alpha3;
   pkg_load_ext_ref_geography.load_cls_languages_alpha2;
   pkg_load_ext_ref_geography.load_ref_geo_countries;
   --Cleansing
   pkg_load_ext_ref_geography.load_cls_geo_structure;
   pkg_load_ext_ref_geography.load_cls_geo_structure2cntr;
   pkg_load_ext_ref_geography.load_cls_countries_grouping;
   pkg_load_ext_ref_geography.load_cls_countries2groups;
   --Transport References
   pkg_load_ext_ref_geography.load_ref_geo_systems;
   pkg_load_ext_ref_geography.load_ref_geo_parts;
   pkg_load_ext_ref_geography.load_ref_geo_regions;
   pkg_load_ext_ref_geography.load_ref_cntr_group_systems;
   pkg_load_ext_ref_geography.load_ref_cntr_groups;
   pkg_load_ext_ref_geography.load_ref_cntr_sub_groups;   
   --Transport Links
   pkg_load_ext_ref_geography.load_lnk_geo_structure;
   pkg_load_ext_ref_geography.load_lnk_geo_countries;
   pkg_load_ext_ref_geography.load_lnk_cntr_grouping;
   pkg_load_ext_ref_geography.load_lnk_cntr2groups;
END;

SELECT Table_NAME, OWNER
FROM SYS.ALL_TABLES
WHERE OWNER IN ('U_DW_COMMON', 'U_DW_REFERENCES', 'U_DW_EXT_REFERENCES')
UNION
SELECT VIEW_NAME, OWNER
FROM SYS.ALL_VIEWS
WHERE OWNER IN ('U_DW_COMMON', 'U_DW_REFERENCES', 'U_DW_EXT_REFERENCES');



SELECT * FROM t_countries;
SELECT * FROM t_geo_types;
SELECT * FROM t_geo_systems;
SELECT * FROM t_geo_regions;
SELECT * FROM t_geo_objects;
SELECT * FROM t_geo_parts;