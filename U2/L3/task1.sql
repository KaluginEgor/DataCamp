CREATE TABLESPACE SB_MBackUp
DATAFILE '/oracle/u02/oradata/DMORCL21DB/ekalugin_db/SB_MBackUp.dat'
    SIZE 100M
AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE USER U_SB_MBackUp
IDENTIFIED BY "%PWD%"
DEFAULT TABLESPACE SB_MBackUp;

GRANT CONNECT,RESOURCE TO U_SB_MBackUp;

DROP TABLE u_sb_mbackup.sb_mbackup;
CREATE TABLE u_sb_mbackup.sb_mbackup
(
   COUNTRY_GEO_ID      NUMBER                not null,
   GEO_COUNTRY_ID       NUMBER                not null,
   GEO_COUNTRY_CODE_A2  VARCHAR2(128)         not null,
   GEO_COUNTRY_CODE_A3  VARCHAR2(128)         not null,
   GEO_COUNTRY_DESC     VARCHAR2(128)         not null,
   REGION_GEO_ID        NUMBER                not null,
   GEO_REGION_ID        NUMBER                not null,
   GEO_REGION_CODE      VARCHAR2(128)         not null,
   GEO_REGION_DESC      VARCHAR2(128)         not null,
   CONTENET_GEO_ID      NUMBER                not null,
   GEO_PART_ID          NUMBER                not null,
   GEO_PART_CODE        VARCHAR2(128)         not null,
   GEO_PART_DESC        VARCHAR2(128)         not null,
   SYSTEM_GEO_ID        NUMBER                not null,
   GEO_SYSTEM_ID        NUMBER                not null,
   GEO_SYSTEM_CODE      VARCHAR2(128)         not null,
   GEO_SYSTEM_DESC      VARCHAR2(128)         not null
)
TABLESPACE sb_mbackup;

GRANT UNLIMITED TABLESPACE TO u_sb_mbackup;

INSERT INTO u_sb_mbackup.sb_mbackup(country_geo_id, geo_country_id, geo_country_code_a2, geo_country_code_a3, geo_country_desc, 
                                    region_geo_id, geo_region_id, geo_region_code, geo_region_desc, contenet_geo_id, geo_part_id,
                                    geo_part_code, geo_part_desc, system_geo_id, geo_system_id, geo_system_code, geo_system_desc)
SELECT geo.country_geo_id
     , cnt.country_id
     , cnt.country_code_a2
     , cnt.country_code_a3
     , cnt.region_desc AS country_desc
     , geo.region_geo_id
     , reg.region_id
     , reg.region_code
     , reg.region_desc
     , geo.contenet_geo_id
     , prt.part_id
     , prt.part_code
     , prt.part_desc
     , geo.system_geo_id
     , gs.geo_system_id
     , gs.geo_system_code
     , gs.geo_system_desc
  FROM (  SELECT country_geo_id
               , SUM ( geo_system ) AS system_geo_id
               , SUM ( contenet ) AS contenet_geo_id
               , SUM ( region ) AS region_geo_id
               , SUM ( group_system ) AS group_system_geo_id
               , SUM ( country_group ) AS country_group_geo_id
               , SUM ( country_sub_group ) AS country_sub_group_geo_id
            FROM (    SELECT CONNECT_BY_ROOT ( child_geo_id ) AS country_geo_id
                           , parent_geo_id
                           , link_type_id
                           , DECODE ( link_type_id, 1, parent_geo_id ) AS geo_system
                           , DECODE ( link_type_id, 2, parent_geo_id ) AS contenet
                           , DECODE ( link_type_id, 3, parent_geo_id ) AS region
                           , DECODE ( link_type_id, 4, parent_geo_id ) AS group_system
                           , DECODE ( link_type_id, 5, parent_geo_id ) AS country_group
                           , DECODE ( link_type_id, 6, parent_geo_id ) AS country_sub_group
                        FROM u_dw_references.w_geo_object_links
                  CONNECT BY PRIOR parent_geo_id = child_geo_id
                  START WITH child_geo_id IN (SELECT DISTINCT geo_id
                                                FROM u_dw_references.cu_countries))
        GROUP BY country_geo_id) geo
       LEFT JOIN u_dw_references.cu_countries cnt
          ON ( geo.country_geo_id = cnt.geo_id )
       LEFT JOIN u_dw_references.cu_geo_regions reg
          ON ( geo.region_geo_id = reg.geo_id )
       LEFT JOIN u_dw_references.cu_geo_parts prt
          ON ( geo.contenet_geo_id = prt.geo_id )
       LEFT JOIN u_dw_references.cu_geo_systems gs
          ON ( geo.system_geo_id = gs.geo_id );

SELECT * FROM u_sb_mbackup.sb_mbackup;

DROP TABLE u_sb_mbackup.sb_mbackup_hierarchy;
CREATE TABLE u_sb_mbackup.sb_mbackup_hierarchy 
AS SELECT 
            lpad(' ', level * 2 - 1, ' ') || child_geo_id AS child_id
                   , parent_geo_id AS parent_id
                   , link_type_id
                   , DECODE ( LEVEL,  1, 'ROOT',  2, 'BRANCH',  'LEAF' ) AS geo_id_type
                   , DECODE ( ( SELECT COUNT ( * )
                               FROM u_dw_references.t_geo_object_links a
                                    WHERE a.parent_geo_id = b.child_geo_id )
                            , 0, NULL
                            , ( SELECT COUNT ( * )
                                    FROM u_dw_references.t_geo_object_links a
                                    WHERE a.parent_geo_id = b.child_geo_id ) )
                     AS child_count
                    , sys_connect_by_path(parent_geo_id, ':') path
             FROM u_dw_references.t_geo_object_links b
       CONNECT BY PRIOR child_geo_id = parent_geo_id
ORDER SIBLINGS BY child_geo_id;

SELECT * FROM u_sb_mbackup.sb_mbackup_hierarchy;