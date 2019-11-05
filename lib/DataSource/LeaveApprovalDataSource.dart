import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/LeaveApprovalResponse.dart';

class LeaveApprovalDataSource extends DataTableSource {
  List<LeaveApprovalModel> data = new List();

  LeaveApprovalDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static LeaveApprovalModel selectedRowData = LeaveApprovalModel();

  void selectAll(bool checked) {
    for (LeaveApprovalModel leaveApprMod in data)
      leaveApprMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    LeaveApprovalModel leaveApprovalModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: leaveApprovalModel.selected,
      onSelectChanged: (bool value) {
        if (leaveApprovalModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          leaveApprovalModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(leaveApprovalModel.documentNo.toString())),
        DataCell(Text(leaveApprovalModel.entryNo.toString())),
        DataCell(Text(leaveApprovalModel.tableName)),
        DataCell(Text(leaveApprovalModel.documentType)),
        DataCell(Text(leaveApprovalModel.documentCode)),
        DataCell(Text(leaveApprovalModel.sequenceNo.toString())),
        DataCell(Text(leaveApprovalModel.senderId)),
        DataCell(Text(leaveApprovalModel.employeeApproverId)),
        DataCell(Text(leaveApprovalModel.approverId)),
        DataCell(Text(leaveApprovalModel.status)),
        DataCell(Text(leaveApprovalModel.fromDate)),
        DataCell(Text(leaveApprovalModel.toDate)),
        DataCell(Text(leaveApprovalModel.modifiedBy)),
        DataCell(Text(leaveApprovalModel.commentRejection)),
        DataCell(Text(leaveApprovalModel.commentCancellation)),
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
