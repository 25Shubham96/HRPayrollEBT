import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/LeaveApplicationResponse.dart';
import 'package:intl/intl.dart';

class LeaveApplicationDataSource extends DataTableSource {
  List<LeaveApplicationModel> data = new List();

  LeaveApplicationDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static LeaveApplicationModel selectedRowData = LeaveApplicationModel();

  var formatter = new DateFormat('MM/dd/yyyy');

  void selectAll(bool checked) {
    for (LeaveApplicationModel leaveApplMod in data)
      leaveApplMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    LeaveApplicationModel leaveApplicationModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: leaveApplicationModel.selected,
      onSelectChanged: (bool value) {
        if (leaveApplicationModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          leaveApplicationModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(leaveApplicationModel.documentNo.toString())),
        DataCell(Text(leaveApplicationModel.employeeNo)),
        DataCell(Text(leaveApplicationModel.employeeName)),
        DataCell(Text(leaveApplicationModel.leaveCode)),
        DataCell(Text(leaveApplicationModel.leaveDescription)),
        DataCell(Text(leaveApplicationModel.leaveDuration)),
        DataCell(Text(formatter.format(DateFormat("yyyy-MM-dd").parse(leaveApplicationModel.fromDate)))),
        DataCell(Text(formatter.format(DateFormat("yyyy-MM-dd").parse(leaveApplicationModel.toDate)))),
        DataCell(Text(leaveApplicationModel.noOfDays.toString())),
        DataCell(Text(leaveApplicationModel.reasonForLeave)),
        DataCell(Text(leaveApplicationModel.status)),
        DataCell(Checkbox(
            value: leaveApplicationModel.sanctioned == 1 ? true : false,
            onChanged: null)),
        DataCell(Text(leaveApplicationModel.leavesAvailCurrMonth.toString())),
        DataCell(Text(leaveApplicationModel.sanctioningIncharge)),
        DataCell(Text(formatter.format(DateFormat("yyyy-MM-dd").parse(leaveApplicationModel.dateOfSanction)))),
        DataCell(Text(leaveApplicationModel.dateOfCancellation == "" ? "" : formatter.format(DateFormat("yyyy-MM-dd").parse(leaveApplicationModel.dateOfCancellation)))),
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
