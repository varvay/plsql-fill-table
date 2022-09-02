# plsql-fill-table
PL/SQL script to fill table based on its column's data type

## Acceptable Data Types
Currently this PL/SQL script can only generate random value for column with data type of
1. `VARCHAR2`: random upper case alphanumeric will be generated with length of column's data length
2. `NUMBER`: random number will be generated with precision of column's data precision and scale of column's data scale
3. `DATE`: will be set to current timestamp
4. `TIMESTAMP`: will be set to current timestamp

## Mandatory Input!
These inputs are required to run the PL/SQL script
1. `totalData`: number of generated data with type of `NUMBER(38)` 
2. `tableOwner`: the owner of the table, be aware that it's **case-sensitive** with type of `VARCHAR2`
3. `tableName`: the name of the table with type of `VARCHAR2`

## P.S.
Feel free to share with me if you have better implementation :smile:
