import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/PassportApproveListResponse.dart';

class PassportApproveListDataSource extends DataTableSource {
  List<PassportApproveListModel> data = List();

  PassportApproveListDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static PassportApproveListModel selectedRowData = PassportApproveListModel();

  void selectAll(bool checked) {
    for (PassportApproveListModel passportApprMod in data)
      passportApprMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    PassportApproveListModel passportApproveListModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: passportApproveListModel.selected,
      onSelectChanged: (bool value) {
        if (passportApproveListModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          passportApproveListModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(passportApproveListModel.tableName)),
        DataCell(Text(passportApproveListModel.documentType)),
        DataCell(Text(passportApproveListModel.transactionId)),
        DataCell(Text(passportApproveListModel.senderId)),
        DataCell(Text(passportApproveListModel.employeeApproverId)),
        DataCell(Text(passportApproveListModel.approverId)),
        DataCell(Text(passportApproveListModel.status)),
        DataCell(Text(passportApproveListModel.modifiedBy)),
        DataCell(Text(passportApproveListModel.commentRejection)),
        DataCell(Text(passportApproveListModel.commentCancellation)),
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
