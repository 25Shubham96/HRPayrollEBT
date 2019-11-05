import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/NavigateResponseDesigLocHistory.dart';

class DesigLocDataSource extends DataTableSource {
  List<DesigLocModel> data = new List();

  DesigLocDataSource(this.data);

  var prevIndex = -1;

  @override
  DataRow getRow(int index) {
    DesigLocModel desigLocModel = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(desigLocModel.employeeId)),
        DataCell(Text(desigLocModel.fromDate)),
        DataCell(Text(desigLocModel.toDate)),
        DataCell(Text(desigLocModel.value)),
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
