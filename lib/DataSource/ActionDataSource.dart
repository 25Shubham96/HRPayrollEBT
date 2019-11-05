import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/ActionResponse.dart';

class ActionDataSource extends DataTableSource {
  List<ActionResponseModel> data = new List();

  ActionDataSource(this.data);

  var prevIndex = -1;

  @override
  DataRow getRow(int index) {
    ActionResponseModel actionResponseModel = data[index];
    return DataRow.byIndex(
      index: index,
      /*selected: actionResponseModel.selected,
      onSelectChanged: (bool value) {
        actionResponseModel.selected = value;
        if(prevIndex != -1)
          data[prevIndex].selected = false;
        notifyListeners();
        prevIndex = index;
      },*/
      cells: <DataCell>[
        DataCell(Text(actionResponseModel.employeeId)),
        DataCell(Text(actionResponseModel.sanctioningIncharge)),
        DataCell(Text(actionResponseModel.hierarchy.toString())),
        DataCell(Text(actionResponseModel.inchargeName)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
