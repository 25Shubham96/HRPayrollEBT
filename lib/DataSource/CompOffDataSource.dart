import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/CompOffResponse.dart';

class CompOffDataSource extends DataTableSource {
  List<CompOffModel> data = List();

  CompOffDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static CompOffModel selectedRowData = CompOffModel();

  void selectAll(bool checked) {
    for (CompOffModel compOffMod in data) compOffMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    CompOffModel compOffModel = data[index];
    return DataRow.byIndex(
      index: index,
      selected: compOffModel.selected,
      onSelectChanged: (bool value) {
        if (compOffModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          compOffModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(compOffModel.entryNo.toString())),
        DataCell(Text(compOffModel.employeeNo)),
        DataCell(Text(compOffModel.employeeName)),
        DataCell(Text(compOffModel.designation)),
        DataCell(Text(compOffModel.department)),
        DataCell(Text(compOffModel.fromDate)),
        DataCell(Text(compOffModel.toDate)),
        DataCell(Text(compOffModel.noOfDays.toString())),
        DataCell(Text(compOffModel.taskToComplete)),
        DataCell(Text(compOffModel.reason)),
        DataCell(Text(compOffModel.status)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => selectedCount;
}
