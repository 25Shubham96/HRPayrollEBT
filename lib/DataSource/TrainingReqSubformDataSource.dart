import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/TrainingReqSubformResponse.dart';

class TrainingReqSubformDataSource extends DataTableSource {

  List<TrainingReqSubformModel> data = List();

  TrainingReqSubformDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  int selectedRow = -1;

  bool rowSelect = false;
  static TrainingReqSubformModel selectedRowData = TrainingReqSubformModel();

  void selectAll(bool checked) {
    for (TrainingReqSubformModel trainingReqSubformMod in data)
      trainingReqSubformMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    TrainingReqSubformModel trainingReqSubformModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: trainingReqSubformModel.selected,
      onSelectChanged: (bool value) {
        if (trainingReqSubformModel.selected != value) {
          selectedRow = index;
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          trainingReqSubformModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell> [
        DataCell(Text(trainingReqSubformModel.employeeNo)),
        DataCell(Text(trainingReqSubformModel.employeeName)),
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