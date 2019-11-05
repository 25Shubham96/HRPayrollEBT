import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/ClosedTrainingListResponse.dart';

class ClosedTrainingListDataSource extends DataTableSource {

  List<ClosedTrainingListModel> data = new List();

  ClosedTrainingListDataSource(this.data);

  int selectedCount = 0;

  @override
  DataRow getRow(int index) {
    ClosedTrainingListModel closedTrainingListModel = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(closedTrainingListModel.activityNo)),
        DataCell(Text(closedTrainingListModel.trainingLocation)),
        DataCell(Text(closedTrainingListModel.status)),
        DataCell(Text(closedTrainingListModel.trainingProvider)),
        DataCell(Text(closedTrainingListModel.courseId)),
        DataCell(Text(closedTrainingListModel.courseStartDate)),
        DataCell(Text(closedTrainingListModel.courseEndDate)),
        DataCell(Text(closedTrainingListModel.trainingProviderName)),
        DataCell(Text(closedTrainingListModel.courseDescription)),
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