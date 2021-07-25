CREATE TABLE members (
    firstname VARCHAR(25) NOT NULL,
    lastname VARCHAR(25) NOT NULL,
    username VARCHAR(16) NOT NULL,
    email VARCHAR(35),
    joined DATE NOT NULL
)
PARTITION BY RANGE (joined) 
INTERVAL(NUMTOYMINTERVAL(1, 'Month'))
(
    PARTITION p1 VALUES LESS THAN (TO_DATE('01/01/1961','DD/MM/YYYY')),
    PARTITION p2 VALUES LESS THAN (TO_DATE('01/01/1962','DD/MM/YYYY')),
    PARTITION p3 VALUES LESS THAN (TO_DATE('01/01/1963','DD/MM/YYYY')),
    PARTITION p4 VALUES LESS THAN (TO_DATE('01/01/1964','DD/MM/YYYY'))
) tablespace lab9;

ALTER TABLE members
      merge partitions p1, p2 into partition p5;

ALTER TABLE members
      move partition p3
        tablespace lab9 nologging compress;

ALTER TABLE members
      split partition p5
        at (to_date('01/01/1961', 'DD/MM/YYYY'))
            into(partition p1, partition p2);

ALTER TABLE members truncate partition p1;

ALTER TABLE members drop partition p1;
