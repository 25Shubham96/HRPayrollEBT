import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/PassportRetentionResponse.dart';

class PassportRetentionDataSource extends DataTableSource {

  List<PassportRetentionModel> data = List();

  PassportRetentionDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static PassportRetentionModel selectedRowData = PassportRetentionModel();

  void selectAll(bool checked) {
    for (PassportRetentionModel passRetenMod in data)
      passRetenMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    PassportRetentionModel passportRetentionModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: passportRetentionModel.selected,
      onSelectChanged: (bool value) {
        if (passportRetentionModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          passportRetentionModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell> [
        DataCell(Text(passportRetentionModel.dateOfReceipt)),
        DataCell(Text(passportRetentionModel.transactionId)),
        DataCell(Text(passportRetentionModel.requestType)),
        DataCell(Text(passportRetentionModel.employeeId)),
        DataCell(Text(passportRetentionModel.employeeName)),
        DataCell(Text(passportRetentionModel.passportNo)),
        DataCell(Text(passportRetentionModel.status)),
        DataCell(Text(passportRetentionModel.receivingEmployeeId)),
        DataCell(Text(passportRetentionModel.receivingEmployeeName)),
        DataCell(Text(passportRetentionModel.column1)),
        DataCell(Text(passportRetentionModel.commentRemarks)),
        DataCell(Text(passportRetentionModel.transactionType)),
        DataCell(Text(passportRetentionModel.userId)),
        DataCell(Text(passportRetentionModel.expectedReceiptDate)),
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