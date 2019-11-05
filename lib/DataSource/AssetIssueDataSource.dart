import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/AssetIssueResponse.dart';

class AssetIssueDataSource extends DataTableSource {

  List<AssetIssueModel> data = List();

  AssetIssueDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static AssetIssueModel selectedRowData = AssetIssueModel();

  void selectAll(bool checked) {
    for (AssetIssueModel assetIssueMod in data)
      assetIssueMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    AssetIssueModel assetIssueModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: assetIssueModel.selected,
      onSelectChanged: (bool value) {
        if (assetIssueModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          assetIssueModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(assetIssueModel.issueNo)),
        DataCell(Text(assetIssueModel.issueDate)),
        DataCell(Text(assetIssueModel.employeeNo)),
        DataCell(Text(assetIssueModel.employeeName)),
        DataCell(Text(assetIssueModel.issuedBy)),
        DataCell(Text(assetIssueModel.issuedByName)),
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