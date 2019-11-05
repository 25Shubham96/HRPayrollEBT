import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/TrainingActivitySubformResponse.dart';

class TrainingActivitySubformDataSource extends DataTableSource {

  List<TrainingActivitySubformModel> data = List();

  TrainingActivitySubformDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  int selectedRow = -1;

  bool rowSelect = false;
  static TrainingActivitySubformModel selectedRowData = TrainingActivitySubformModel();

  void selectAll(bool checked) {
    for (TrainingActivitySubformModel trainingActSubformMod in data)
      trainingActSubformMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    TrainingActivitySubformModel trainingActivitySubformModel = data[index];
    return DataRow.byIndex(
      index: index,
      selected: trainingActivitySubformModel.selected,
      onSelectChanged: (bool value) {
        if (trainingActivitySubformModel.selected != value) {
          selectedRow = index;
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          trainingActivitySubformModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(trainingActivitySubformModel.employeeNo)),
        DataCell(Text(trainingActivitySubformModel.employeeName)),
        DataCell(Checkbox(
            value: trainingActivitySubformModel.planned == 1 ? true : false,
            onChanged: null)),
        DataCell(Checkbox(
            value: trainingActivitySubformModel.attended == 1 ? true : false,
            onChanged: null)),
        DataCell(Checkbox(
            value: trainingActivitySubformModel.certificateIssued == 1 ? true : false,
            onChanged: null)),
        DataCell(Text(trainingActivitySubformModel.departmentCode)),
        DataCell(Checkbox(
            value: trainingActivitySubformModel.confirmationAssessmentFilled == 1 ? true : false,
            onChanged: null)),
        DataCell(Text(trainingActivitySubformModel.comments)),
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