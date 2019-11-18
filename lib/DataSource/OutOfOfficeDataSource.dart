import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/OutOfOFficeResponse.dart';
import 'package:intl/intl.dart';

class OutOfOfficeDataSource extends DataTableSource {
  List<OutOfOfficeModel> data = List();

  OutOfOfficeDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static OutOfOfficeModel selectedRowData = OutOfOfficeModel();

  var dateFormatter = new DateFormat('MM/dd/yyyy');

  void selectAll(bool checked) {
    for (OutOfOfficeModel outOfOfficeMod in data)
      outOfOfficeMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    OutOfOfficeModel outOfOfficeModel = data[index];
    return DataRow.byIndex(
      index: index,
      selected: outOfOfficeModel.selected,
      onSelectChanged: (bool value) {
        if (outOfOfficeModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          outOfOfficeModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(outOfOfficeModel.entryNo.toString())),
        DataCell(Text(outOfOfficeModel.employeeNo)),
        DataCell(Text(outOfOfficeModel.employeeName)),
        DataCell(Text(outOfOfficeModel.designation)),
        DataCell(Text(outOfOfficeModel.department)),
        DataCell(Text(dateFormatter.format(DateFormat("yyyy-MM-dd").parse(outOfOfficeModel.requestDate)))),
        DataCell(Text(outOfOfficeModel.fromTime)),
        DataCell(Text(outOfOfficeModel.toTime)),
        DataCell(Text(outOfOfficeModel.reason)),
        DataCell(Text(outOfOfficeModel.status)),
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
