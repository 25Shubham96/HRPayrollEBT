import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/AssetReqResponse.dart';
import 'package:intl/intl.dart';

class EmpAssetReqDataSource extends DataTableSource {
  List<AssetReqModel> data = List();

  EmpAssetReqDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static AssetReqModel selectedRowData = AssetReqModel();

  var dateFormatter = new DateFormat('MM/dd/yyyy');

  void selectAll(bool checked) {
    for (AssetReqModel assetReqMod in data) assetReqMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    AssetReqModel assetReqModel = data[index];
    return DataRow.byIndex(
      index: index,
      selected: assetReqModel.selected,
      onSelectChanged: (bool value) {
        if (assetReqModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          assetReqModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(assetReqModel.requisitionNo)),
        DataCell(Text(assetReqModel.employeeNo)),
        DataCell(Text(assetReqModel.employeeName)),
        DataCell(Text(dateFormatter.format(DateFormat("yyyy-MM-dd").parse(assetReqModel.requisionDate)))),
        DataCell(Text(assetReqModel.requestedBy)),
        DataCell(Text(assetReqModel.requestedByName)),
        DataCell(Text(assetReqModel.status)),
        DataCell(Text(assetReqModel.department)),
        DataCell(Text(assetReqModel.userId)),
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
