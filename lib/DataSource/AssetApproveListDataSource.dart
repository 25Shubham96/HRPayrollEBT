import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/AssetApproveListResponse.dart';

class AssetApproveListDataSource extends DataTableSource {
  List<AssetApproveListModel> data = List();

  AssetApproveListDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static AssetApproveListModel selectedRowData = AssetApproveListModel();

  void selectAll(bool checked) {
    for (AssetApproveListModel assetApprMod in data)
      assetApprMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    AssetApproveListModel assetApproveListModel = data[index];
    return DataRow.byIndex(
      index: index,
      selected: assetApproveListModel.selected,
      onSelectChanged: (bool value) {
        if (assetApproveListModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          assetApproveListModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(assetApproveListModel.tableName)),
        DataCell(Text(assetApproveListModel.documentType)),
        DataCell(Text(assetApproveListModel.requisitionNo)),
        DataCell(Text(assetApproveListModel.senderId)),
        DataCell(Text(assetApproveListModel.employeeApproverId)),
        DataCell(Text(assetApproveListModel.approverId)),
        DataCell(Text(assetApproveListModel.status)),
        DataCell(Text(assetApproveListModel.modifiedBy)),
        DataCell(Text(assetApproveListModel.commentRejection)),
        DataCell(Text(assetApproveListModel.commentCancellation)),
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
