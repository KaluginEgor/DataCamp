CREATE TABLE members (
    firstname VARCHAR(25) NOT NULL,
    lastname VARCHAR(25) NOT NULL,
    username VARCHAR(16) NOT NULL,
    email VARCHAR(35),
    joined DATE NOT NULL
)PARTITION BY HASH (username)
    partitions 2
    store in (lab9, lab9_1);

ALTER TABLE members
     COALESCE PARTITION;

ALTER TABLE members
      ADD PARTITION p2 TABLESPACE lab9;

ALTER TABLE members
      move partition p2
        tablespace lab9_1;

alter table members
    Truncate PARTITION p2;