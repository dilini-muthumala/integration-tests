package resources.services;

import resources.connectorInit as conn;
import ballerina.lang.errors;
import ballerina.data.sql;

sql:ClientConnector connectorInstance = conn:init();

function insertPerRecordToDB (json dataset) (string[], int, errors:Error){

    sql:Parameter[] parameters = [];
    datatable df;
    int i = 0;
    string[] keyColumns = [];
    int insertedRowCount;
    int insertTotalRowCount;
    string[] generatedIDs;
    string[] keys = [];
    int length = lengthof dataset.persons;
    errors:Error err;

    try {
        while (i < length) {
            var lastname, _ = (string)dataset.persons[i].lastname;
            sql:Parameter paraLName = {sqlType:"varchar", value:lastname, direction:0};
            var firstname, _ = (string)dataset.persons[i].firstname;
            sql:Parameter paraFName = {sqlType:"varchar", value:firstname, direction:0};
            var age, _ = (int)dataset.persons[i].age;
            sql:Parameter paraAge = {sqlType:"varchar", value:age, direction:0};
            parameters = [paraLName, paraFName, paraAge];
            insertedRowCount, generatedIDs = connectorInstance.updateWithGeneratedKeys ("insert into Persons (Lastname, Firstname, Age) values (?, ?, ?)", parameters, keyColumns);
            insertTotalRowCount = insertTotalRowCount + insertedRowCount;
            keys[i] = generatedIDs[0];
            i = i + 1;
        }

    } catch (errors:Error e) {
        string msg = "Error in database insertion. Please retry";
        e = {msg:msg};
        err = e;
    }
    return keys, insertTotalRowCount, err;
}

function insertAutoGeneratedKeysNonKeyCol (json dataset)(string[], int, errors:Error){

    sql:Parameter[] parameters = [];
    datatable df;
    int i = 0;
    string[] keyColumns = [];
    int insertedRowCount;
    int insertTotalRowCount;
    string[] generatedIDs;
    string[] keys = [];
    int length = lengthof dataset.employees;
    errors:Error err;

    try {
        while (i < length) {
            var nic, _ = (int)dataset.employees[i].nic;
            sql:Parameter paraNic = {sqlType:"varchar", value:nic, direction:0};
            var lastname, _ = (string)dataset.employees[i].lastname;
            sql:Parameter paraLName = {sqlType:"varchar", value:lastname, direction:0};
            var firstname, _ = (string)dataset.employees[i].firstname;
            sql:Parameter paraFName = {sqlType:"varchar", value:firstname , direction:0};
            var age, _ = (int)dataset.employees[i].age;
            sql:Parameter paraAge = {sqlType:"varchar", value:age, direction:0};
            parameters = [paraNic, paraLName, paraFName, paraAge];
            insertedRowCount, generatedIDs = connectorInstance.updateWithGeneratedKeys ("insert into employees (nic ,lastname, firstname, age) values (?, ?, ?, ?)", parameters, keyColumns);
            insertTotalRowCount = insertTotalRowCount + insertedRowCount;
            keys[i] = generatedIDs[0];
            i = i + 1;
        }

    } catch (errors:Error e) {
        string msg = "Error in database insertion. Please retry";
        e = {msg:msg};
        err = e;
    }
    return keys, insertTotalRowCount, err;
}

function insertWithMissingCol (json dataset)(string[], int, errors:Error){

    sql:Parameter[] parameters = [];
    datatable df;
    int i = 0;
    string[] keyColumns = [];
    int insertedRowCount;
    int insertTotalRowCount;
    string[] generatedIDs;
    string[] keys = [];
    int length = lengthof dataset.employees;
    errors:Error err;

    try {
        while (i < length) {
            var nic, _ = (int)dataset.employees[i].nic;
            sql:Parameter paraNic = {sqlType:"varchar", value:nic, direction:0};
            var lastname, _ = (string)dataset.employees[i].lastname;
            sql:Parameter paraLName = {sqlType:"varchar", value:lastname, direction:0};
            var firstname, _ = (string)dataset.employees[i].firstname;
            sql:Parameter paraFName = {sqlType:"varchar", value:firstname, direction:0};
            var age, _ = (int)dataset.employees[i].age;
            sql:Parameter paraAge = {sqlType:"varchar", value:age, direction:0};
            parameters = [paraLName, paraFName, paraAge];
            insertedRowCount, generatedIDs = connectorInstance.updateWithGeneratedKeys ("insert into employees (lastname, firstname, age) values (?, ?, ?)", parameters, keyColumns);
            insertTotalRowCount = insertTotalRowCount + insertedRowCount;
            keys[i] = generatedIDs[0];
            i = i + 1;
        }

    } catch (errors:Error e) {
        string msg = "Error in database insertion. Please retry";
        e = {msg:msg};
        err = e;
    }
    return keys, insertTotalRowCount, err;
}