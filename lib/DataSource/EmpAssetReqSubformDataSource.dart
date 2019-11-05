import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/AssetReqSubformResponse.dart';

class EmpAssetReqSubformDataSource extends DataTableSource {

  List<AssetReqSubformModel> data = List();

  EmpAssetReqSubformDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  int selectedRow = -1;

  bool rowSelect = false;
  static AssetReqSubformModel selectedRowData = AssetReqSubformModel();

  void selectAll(bool checked) {
    for (AssetReqSubformModel assetReqSubformMod in data)
      assetReqSubformMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    AssetReqSubformModel assetReqSubformModel = data[index];
    return DataRow.byIndex(
      index: index,
      selected: assetReqSubformModel.selected,
      onSelectChanged: (bool value) {
        if (assetReqSubformModel.selected != value) {
          selectedRow = index;
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          assetReqSubformModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(assetReqSubformModel.assetType)),
        DataCell(Text(assetReqSubformModel.quantity.toString())),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => selectedCount;

}