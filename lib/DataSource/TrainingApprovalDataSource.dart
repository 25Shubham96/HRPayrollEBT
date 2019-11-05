import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/TrainingApprovalResponse.dart';

class TrainingApprovalDataSource extends DataTableSource {
  List<TrainingApprovalModel> data = new List();

  TrainingApprovalDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static TrainingApprovalModel selectedRowData = TrainingApprovalModel();

  void selectAll(bool checked) {
    for (TrainingApprovalModel trainApprMod in data)
      trainApprMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    TrainingApprovalModel trainingApprovalModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: trainingApprovalModel.selected,
      onSelectChanged: (bool value) {
        if (trainingApprovalModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          trainingApprovalModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(trainingApprovalModel.entryNo.toString())),
        DataCell(Text(trainingApprovalModel.tableName)),
        DataCell(Text(trainingApprovalModel.documentType)),
        DataCell(Text(trainingApprovalModel.requestCode)),
        DataCell(Text(trainingApprovalModel.sequenceNo.toString())),
        DataCell(Text(trainingApprovalModel.senderId)),
        DataCell(Text(trainingApprovalModel.employeeApproverId)),
        DataCell(Text(trainingApprovalModel.approverId)),
        DataCell(Text(trainingApprovalModel.status)),
        DataCell(Text(trainingApprovalModel.modifiedBy)),
        DataCell(Text(trainingApprovalModel.commentRejection)),
        DataCell(Text(trainingApprovalModel.commentCancellation)),
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
