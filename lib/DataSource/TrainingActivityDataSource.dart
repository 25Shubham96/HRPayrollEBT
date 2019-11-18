import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/TrainingActivityResponse.dart';
import 'package:intl/intl.dart';

class TrainingActivityDataSource extends DataTableSource {
  List<TrainingActivityModel> data = List();

  TrainingActivityDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static TrainingActivityModel selectedRowData = TrainingActivityModel();

  var dateFormatter = new DateFormat('MM/dd/yyyy');

  void selectAll(bool checked) {
    for (TrainingActivityModel trainingActMod in data)
      trainingActMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    TrainingActivityModel trainingActivityModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: trainingActivityModel.selected,
      onSelectChanged: (bool value) {
        if (trainingActivityModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          trainingActivityModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(trainingActivityModel.activityNo)),
        DataCell(Text(trainingActivityModel.trainingLocation)),
        DataCell(Text(trainingActivityModel.status)),
        DataCell(Text(trainingActivityModel.trainingProvider)),
        DataCell(Text(trainingActivityModel.courseId)),
        DataCell(Text(dateFormatter.format(DateFormat("yyyy-MM-dd").parse(trainingActivityModel.courseStartDate)))),
        DataCell(Text(trainingActivityModel.courseStartTime)),
        DataCell(Text(dateFormatter.format(DateFormat("yyyy-MM-dd").parse(trainingActivityModel.courseEndDate)))),
        DataCell(Text(trainingActivityModel.courseEndTime)),
        DataCell(Text(trainingActivityModel.joiningInstructionDocument)),
        DataCell(Text(trainingActivityModel.trainingProviderName)),
        DataCell(Text(trainingActivityModel.courseDescription)),
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
