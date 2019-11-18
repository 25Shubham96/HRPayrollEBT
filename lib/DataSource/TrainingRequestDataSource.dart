import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/TrainingReqResponse.dart';

class TrainingRequestDataSource extends DataTableSource {
  List<TrainingRequestModel> data = List();

  TrainingRequestDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static TrainingRequestModel selectedRowData = TrainingRequestModel();

  void selectAll(bool checked) {
    for (TrainingRequestModel trainingReqMod in data)
      trainingReqMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    TrainingRequestModel trainingRequestModel = data[index];
    return DataRow.byIndex(
      index: index,
      selected: trainingRequestModel.selected,
      onSelectChanged: (bool value) {
        if (trainingRequestModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          trainingRequestModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(trainingRequestModel.requestNo)),
        DataCell(Text(trainingRequestModel.requestedBy)),
        DataCell(Text(trainingRequestModel.contactNo)),
        DataCell(Text(trainingRequestModel.requestType)),
        DataCell(Text(trainingRequestModel.trainingCourseTitle)),
        DataCell(Text(trainingRequestModel.comments)),
        DataCell(Text(trainingRequestModel.contactName)),
        DataCell(Text(trainingRequestModel.trainingCourse)),
        DataCell(Text(trainingRequestModel.status)),
        DataCell(Text(trainingRequestModel.department)),
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
