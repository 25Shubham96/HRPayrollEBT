import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/AssessmentApprovalResponse.dart';

class AssessmentApprovalDataSource extends DataTableSource {
  List<AssessmentApprovalModel> data = new List();

  AssessmentApprovalDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static AssessmentApprovalModel selectedRowData = AssessmentApprovalModel();

  void selectAll(bool checked) {
    for (AssessmentApprovalModel assessApprMod in data)
      assessApprMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    AssessmentApprovalModel assessmentApprovalModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: assessmentApprovalModel.selected,
      onSelectChanged: (bool value) {
        if (assessmentApprovalModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          assessmentApprovalModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(assessmentApprovalModel.entryNo.toString())),
        DataCell(Text(assessmentApprovalModel.documentType)),
        DataCell(Text(assessmentApprovalModel.requisitionNo)),
        DataCell(Text(assessmentApprovalModel.requisitionDate)),
        DataCell(Text(assessmentApprovalModel.sequenceNo.toString())),
        DataCell(Text(assessmentApprovalModel.senderId)),
        DataCell(Text(assessmentApprovalModel.employeeApproverId)),
        DataCell(Text(assessmentApprovalModel.approverId)),
        DataCell(Text(assessmentApprovalModel.status)),
        DataCell(Text(assessmentApprovalModel.modifiedBy)),
        DataCell(Text(assessmentApprovalModel.commentRejection)),
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
