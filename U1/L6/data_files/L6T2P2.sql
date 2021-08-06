--task2

drop table u_dw_ext_references.t_ext_cntr_grouping_iso3166 cascade constraints;

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
--organization external (
--    type oracle_loader
--    default directory ext_references
--    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL ( child_code integer external (4), parent_code integer external, group_desc char(200), group_level char(200) ) )
--    location ('iso_3166_groups_un.tab')
--)
--reject limit unlimited;

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
--organization external (
--    type oracle_loader
--    default directory ext_references
--    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL ( country_id integer external (4), country_desc char(200), group_code integer external, group_desc char(200) ) )
--    location ('iso_3166_groups_un_contries.tab')
--)
--reject limit unlimited;

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
--organization external (
--    type oracle_loader
--    default directory ext_references
--    access parameters (records delimited by 0x'0D' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (child_code integer external (4), parent_code integer external, structure_desc char(200), structure_level char(200) ) )
--    location ('iso_3166_geo_un.tab')
--)
--reject limit unlimited;



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
--organization external (
--    type oracle_loader
--    default directory ext_references
--    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL ( country_id integer external (4), country_desc char(200), structure_code integer external, structure_desc char(200) ) )
--    location ('iso_3166_geo_un_contries.tab')
--)
--reject limit unlimited;


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
--organization external (
--    type oracle_loader
--    default directory ext_references
--    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (country_id integer external (4), country_desc char(200), country_code char(3) ) )
--    location ('iso_3166.tab')
--)
--reject limit unlimited;


drop table u_dw_ext_references.t_ext_geo_countries2_iso3166 cascade constraints;

/*==============================================================*/
/* Table: t_ext_geo_countries2_iso3166                        */
/*==============================================================*/
create table u_dw_ext_references.t_ext_geo_countries2_iso3166 
(
   country_desc       VARCHAR2(200 CHAR),
   country_code       VARCHAR2(30 CHAR)
)
--organization external (
--    type oracle_loader
--    default directory ext_references
--    access parameters (records delimited by 0x'0D0A' nobadfile nodiscardfile nologfile fields terminated by ';' missing field values are NULL (country_desc char(200), country_code char(3) ) )
--    location ('iso_3166_2.tab')
--)
--reject limit unlimited;



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