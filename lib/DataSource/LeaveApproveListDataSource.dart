import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/LeaveApproveListResponse.dart';
import 'package:intl/intl.dart';

class LeaveApproveListDataSource extends DataTableSource {
  List<LeaveApproveListModel> data = List();

  LeaveApproveListDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static LeaveApproveListModel selectedRowData = LeaveApproveListModel();

  var dateFormatter = new DateFormat('MM/dd/yyyy');

  void selectAll(bool checked) {
    for (LeaveApproveListModel leaveApprMod in data)
      leaveApprMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    LeaveApproveListModel leaveApproveListModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: leaveApproveListModel.selected,
      onSelectChanged: (bool value) {
        if (leaveApproveListModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          leaveApproveListModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(leaveApproveListModel.tableName)),
        DataCell(Text(leaveApproveListModel.documentCode)),
        DataCell(Text(leaveApproveListModel.senderId)),
        DataCell(Text(leaveApproveListModel.employeeApproverId)),
        DataCell(Text(leaveApproveListModel.approverId)),
        DataCell(Text(leaveApproveListModel.status)),
        DataCell(Text(dateFormatter.format(DateFormat("yyyy-MM-dd").parse(leaveApproveListModel.fromDate)))),
        DataCell(Text(dateFormatter.format(DateFormat("yyyy-MM-dd").parse(leaveApproveListModel.toDate)))),
        DataCell(Text(leaveApproveListModel.modifiedBy)),
        DataCell(Text(leaveApproveListModel.commentRejection)),
        DataCell(Text(leaveApproveListModel.commentCancellation)),
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
