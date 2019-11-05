import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/NavigateResponseCarryFwdInfo.dart';

class CarryFwdInfoDataSource extends DataTableSource {
  List<CarryFwdInfoModel> data = new List();

  CarryFwdInfoDataSource(this.data);

  var prevIndex = -1;

  @override
  DataRow getRow(int index) {
    CarryFwdInfoModel carryFwdInfoModel = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(carryFwdInfoModel.employeeNo)),
        DataCell(Text(carryFwdInfoModel.carryForwardToYear.toString())),
        DataCell(Text(carryFwdInfoModel.startDate)),
        DataCell(Text(carryFwdInfoModel.carryForwardLeave.toString())),
        DataCell(Text(carryFwdInfoModel.remarks)),
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
