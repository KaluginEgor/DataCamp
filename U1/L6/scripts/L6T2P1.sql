
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



insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (2,2,2);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (10,10,10);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (11,11,11);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (12,12,12);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (50,50,50);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (51,51,51);
insert into t_geo_types (geo_type_id, geo_type_code, geo_type_desc) values (52,52,52);