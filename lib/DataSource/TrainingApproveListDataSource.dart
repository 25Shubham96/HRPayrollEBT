import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/TrainingApproveListResponse.dart';

class TrainingApproveListDataSource extends DataTableSource {
  List<TrainingApproveListModel> data = List();

  TrainingApproveListDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static TrainingApproveListModel selectedRowData = TrainingApproveListModel();

  void selectAll(bool checked) {
    for (TrainingApproveListModel trainingApprMod in data)
      trainingApprMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    TrainingApproveListModel trainingApproveListModel = data[index];
    return DataRow.byIndex(
      index: index,
      selected: trainingApproveListModel.selected,
      onSelectChanged: (bool value) {
        if (trainingApproveListModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          trainingApproveListModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(trainingApproveListModel.tableName)),
        DataCell(Text(trainingApproveListModel.documentType)),
        DataCell(Text(trainingApproveListModel.requestCode)),
        DataCell(Text(trainingApproveListModel.senderId)),
        DataCell(Text(trainingApproveListModel.employeeApproverId)),
        DataCell(Text(trainingApproveListModel.approverId)),
        DataCell(Text(trainingApproveListModel.status.toString())),
        DataCell(Text(trainingApproveListModel.modifiedBy)),
        DataCell(Text(trainingApproveListModel.commentRejection)),
        DataCell(Text(trainingApproveListModel.commentCancellation)),
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
