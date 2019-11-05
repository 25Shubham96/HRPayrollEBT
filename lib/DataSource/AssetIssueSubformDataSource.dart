import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/AssetIssueSubformResponse.dart';

class AssetIssueSubformDataSource extends DataTableSource {

  List<AssetIssueSubformModel> data = List();

  AssetIssueSubformDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  int selectedRow = -1;

  bool rowSelect = false;
  static AssetIssueSubformModel selectedRowData = AssetIssueSubformModel();

  void selectAll(bool checked) {
    for (AssetIssueSubformModel assetIssueSubMod in data)
      assetIssueSubMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    AssetIssueSubformModel assetIssueSubformModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: assetIssueSubformModel.selected,
      onSelectChanged: (bool value) {
        if (assetIssueSubformModel.selected != value) {
          selectedRow = index;
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          assetIssueSubformModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(assetIssueSubformModel.assetType)),
        DataCell(Text(assetIssueSubformModel.assetNo)),
        DataCell(Text(assetIssueSubformModel.assetName)),
        DataCell(Text(assetIssueSubformModel.owner)),
        DataCell(Text(assetIssueSubformModel.value.toString())),
        DataCell(Text(assetIssueSubformModel.manufacturar)),
        DataCell(Text(assetIssueSubformModel.model)),
        DataCell(Text(assetIssueSubformModel.ownerName)),
        DataCell(Text(assetIssueSubformModel.currentAssetLocation)),
        DataCell(Text(assetIssueSubformModel.postedPurchaseOrderNo)),
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