CREATE TABLE accounts
( id             NUMBER
, account_number NUMBER
, customer_id    NUMBER
, branch_id      NUMBER
, region         VARCHAR(2)
, status         VARCHAR2(1)
)
PARTITION BY LIST (region)
( PARTITION p_northwest VALUES ('OR', 'WA')
, PARTITION p_southwest VALUES ('AZ', 'UT', 'NM')
, PARTITION p_northeast VALUES ('NY', 'VM', 'NJ')
, PARTITION p_southeast VALUES ('FL', 'GA')
, PARTITION p_northcentral VALUES ('SD', 'WI')
, PARTITION p_southcentral VALUES ('OK', 'TX')
);

alter table accounts 
    add partition p_south values ('SO','TH') nologging;

alter table accounts
    merge partitions p_northwest, p_southwest
    into PARTITION p_west;

alter table accounts
    move partition p_west tablespace lab9;

alter table accounts
    split PARTITION p_northeast VALUES ('NY', 'VM')
    into 
    ( PARTITION p_northeast_1,
        partition p_northeast_2);

alter table accounts truncate partition p_west;