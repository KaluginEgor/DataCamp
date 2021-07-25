CREATE TABLE members (
    firstname VARCHAR(25) NOT NULL,
    lastname VARCHAR(25) NOT NULL,
    username VARCHAR(16) NOT NULL,
    email VARCHAR(35),
    joined DATE NOT NULL
)
PARTITION BY RANGE (joined) (
    PARTITION p0 VALUES LESS THAN (TO_DATE('01/01/1960','DD/MM/YYYY')),
    PARTITION p1 VALUES LESS THAN (TO_DATE('01/01/1970','DD/MM/YYYY'))
) tablespace lab9;

ALTER TABLE members
      ADD PARTITION p2 VALUES LESS THAN (TO_DATE('01/01/1980','DD/MM/YYYY'))
      TABLESPACE lab9;

ALTER TABLE members
      merge partitions p0, p1 into partition p3;

ALTER TABLE members
      move partition p3
        tablespace lab9 nologging compress;

ALTER TABLE members
      split partition p3
        at (to_date('01/01/1965', 'DD/MM/YYYY'))
            into(partition p0, partition p1);

ALTER TABLE members truncate partition p0;

ALTER TABLE members drop partition p0;