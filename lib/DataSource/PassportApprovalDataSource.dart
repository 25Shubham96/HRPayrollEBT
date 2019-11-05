import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/PassportApprovalResponse.dart';

class PassportApprovalDataSource extends DataTableSource {
  List<PassportApprovalModel> data = new List();

  PassportApprovalDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static PassportApprovalModel selectedRowData = PassportApprovalModel();

  List<String> Status = [
    "Created",
    "Pending For Approval",
    "Approved",
    "Rejected",
    "Closed"
  ];

  void selectAll(bool checked) {
    for (PassportApprovalModel passApprMod in data)
      passApprMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    PassportApprovalModel passportApprovalModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: passportApprovalModel.selected,
      onSelectChanged: (bool value) {
        if (passportApprovalModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          passportApprovalModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(passportApprovalModel.entryNo.toString())),
        DataCell(Text(passportApprovalModel.tableName)),
        DataCell(Text(passportApprovalModel.documentType)),
        DataCell(Text(passportApprovalModel.transactionId)),
        DataCell(Text(passportApprovalModel.sequenceNo.toString())),
        DataCell(Text(passportApprovalModel.senderId)),
        DataCell(Text(passportApprovalModel.employeeApproverId)),
        DataCell(Text(passportApprovalModel.approverId)),
        DataCell(Text(Status[passportApprovalModel.status])),
        DataCell(Text(passportApprovalModel.modifiedBy)),
        DataCell(Text(passportApprovalModel.commentRejection)),
        DataCell(Text(passportApprovalModel.commentCancellation)),
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
