import 'package:flutter/material.dart';

class EmpMasterDataSource extends DataTableSource {
  final List<Employee> data = <Employee>[
    Employee("Emp-0001", "Linda", "Firtz", "01-01-2000"),
    Employee("Emp-0004", "Margret", "Ericssion", "01-01-2015"),
    Employee("Emp-0002", "Benjamin", "Ford", "01-01-2005"),
    Employee("Emp-0003", "Bill", "Gates", "01-01-2010"),
    Employee("Emp-0001", "Linda", "Firtz", "01-01-2000"),
    Employee("Emp-0004", "Margret", "Ericssion", "01-01-2015"),
    Employee("Emp-0002", "Benjamin", "Ford", "01-01-2005"),
    Employee("Emp-0003", "Bill", "Gates", "01-01-2010"),
    Employee("Emp-0001", "Linda", "Firtz", "01-01-2000"),
    Employee("Emp-0004", "Margret", "Ericssion", "01-01-2015"),
    Employee("Emp-0002", "Benjamin", "Ford", "01-01-2005"),
    Employee("Emp-0003", "Bill", "Gates", "01-01-2010"),
    Employee("Emp-0001", "Linda", "Firtz", "01-01-2000"),
    Employee("Emp-0004", "Margret", "Ericssion", "01-01-2015"),
    Employee("Emp-0002", "Benjamin", "Ford", "01-01-2005"),
    Employee("Emp-0003", "Bill", "Gates", "01-01-2010"),
    Employee("Emp-0001", "Linda", "Firtz", "01-01-2000"),
    Employee("Emp-0004", "Margret", "Ericssion", "01-01-2015"),
    Employee("Emp-0002", "Benjamin", "Ford", "01-01-2005"),
    Employee("Emp-0003", "Bill", "Gates", "01-01-2010"),
    Employee("Emp-0004", "Margret", "Ericssion", "01-01-2015"),
    Employee("Emp-0002", "Benjamin", "Ford", "01-01-2005"),
    Employee("Emp-0003", "Bill", "Gates", "01-01-2010"),
  ];

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    final Employee employee = data[index];
    return DataRow.byIndex(
      cells: <DataCell>[
        DataCell(Text('${employee.EmpNo}')),
        DataCell(Text('${employee.EmpFName}')),
        DataCell(Text('${employee.EmpLName}')),
        DataCell(Text('${employee.EmpJoinDate}')),
      ],
      index: index,
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class Employee {
  final String EmpNo;
  final String EmpFName;
  final String EmpLName;
  final String EmpJoinDate;

  Employee(this.EmpNo, this.EmpFName, this.EmpLName, this.EmpJoinDate);
}
