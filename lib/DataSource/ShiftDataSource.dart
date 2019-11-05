import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/NavigateResponseShift.dart';

class ShiftDataSource extends DataTableSource {
  List<ShiftModel> data = new List();

  ShiftDataSource(this.data);

  var prevIndex = -1;

  @override
  DataRow getRow(int index) {
    ShiftModel shiftModel = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(shiftModel.employeeCode)),
        DataCell(Text(shiftModel.startDate)),
        DataCell(Text(shiftModel.shiftCode)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
