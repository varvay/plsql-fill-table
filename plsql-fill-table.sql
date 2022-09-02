DECLARE
    TYPE all_tab_cols_type IS TABLE OF all_tab_cols%rowtype;
    all_tab_cols_table all_tab_cols_type;
    cols LONG;
    vals LONG;
    BEGIN
    SELECT * BULK COLLECT INTO all_tab_cols_table FROM all_tab_cols WHERE owner =: tableOwner AND LOWER(table_name) = :tableName ORDER BY column_name ASC;
    FOR t IN 1..:totalData LOOP
        cols := all_tab_cols_table(1).column_name;
        IF all_tab_cols_table(1).data_type = 'VARCHAR2' THEN
            vals := '''' || DBMS_RANDOM.STRING('X', all_tab_cols_table(1).data_length) || '''';
        ELSIF all_tab_cols_table(1).data_type LIKE 'TIMESTAMP%' OR all_tab_cols_table(1).data_type = 'DATE' THEN
            vals := 'LOCALTIMESTAMP';
        ELSIF all_tab_cols_table(1).data_type = 'NUMBER' THEN
            vals := ROUND(dbms_random.value(0, NVL(all_tab_cols_table(1).data_precision, 0)), NVL(all_tab_cols_table(1).data_scale, 0));
        END IF;
        FOR i IN 2..all_tab_cols_table.COUNT LOOP
            cols := cols || ', ' || all_tab_cols_table(i).column_name;
            IF all_tab_cols_table(i).data_type = 'VARCHAR2' THEN
                vals := vals || ', ' || '''' || DBMS_RANDOM.STRING('X', all_tab_cols_table(i).data_length) || '''';
            ELSIF all_tab_cols_table(i).data_type LIKE 'TIMESTAMP%' OR all_tab_cols_table(i).data_type = 'DATE' THEN
                vals := vals || ', ' || 'LOCALTIMESTAMP';
            ELSIF all_tab_cols_table(i).data_type = 'NUMBER' THEN
                vals := vals || ', ' || ROUND(dbms_random.value(0, NVL(all_tab_cols_table(i).data_precision, 0)), NVL(all_tab_cols_table(i).data_scale, 0));
            END IF;
        END LOOP;
        EXECUTE IMMEDIATE ('INSERT INTO ' || :tableName || ' (' || cols || ') VALUES (' || vals || ')');
    END LOOP;
END;