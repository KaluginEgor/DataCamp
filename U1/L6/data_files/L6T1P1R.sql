
alter table u_dw_references.lc_lng_scopes
   drop constraint FK_LOC2LNG_SCOPES;

alter table u_dw_references.lc_lng_types
   drop constraint FK_LOC2LNG_TYPES;

drop table u_dw_references.t_lng_scopes cascade constraints;

/*==============================================================*/
/* Table: "t_lng_scopes"                                        */
/*==============================================================*/
create table u_dw_references.t_lng_scopes (
   lng_scope_id       NUMBER(22,0)          not null,
   lng_scope_code     VARCHAR2(1 CHAR)      not null,
   constraint PK_T_LNG_SCOPES primary key (lng_scope_id)
)
   organization index tablespace TS_REFERENCES_DATA_01;

comment on table u_dw_references.t_lng_scopes is
'Store Possible Variats of Macrolanguages
I(ndividual), M(acrolanguage), S(pecial)';

comment on column u_dw_references.t_lng_scopes.lng_scope_id is
'Idemtificator of Language Scopes - ISO 639-3';

comment on column u_dw_references.t_lng_scopes.lng_scope_code is
'Code of Languages Scopes - ISO 639-3';


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
            , 'Русский'
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
            , 'Беларускi'
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



drop view u_dw_references.cu_lng_scopes;

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



drop view u_dw_references.cu_lng_types;

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