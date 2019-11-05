import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/NavigateResponsePayElements.dart';

class PayElementsDataSource extends DataTableSource {
  List<PayElementsModel> data = new List();

  PayElementsDataSource(this.data);

  var prevIndex = -1;

  @override
  DataRow getRow(int index) {
    PayElementsModel payElementsModel = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(payElementsModel.employeeCode)),
        DataCell(Text(payElementsModel.effectiveStartDate)),
        DataCell(Text(payElementsModel.payElementCode)),
        DataCell(Text(payElementsModel.fixedPercent)),
        DataCell(Text(payElementsModel.addDeduct)),
        DataCell(Text(payElementsModel.amountPercent.toString())),
        DataCell(Text(payElementsModel.computationType)),
        DataCell(Text(payElementsModel.payCadre)),
        DataCell(Checkbox(
            value: payElementsModel.applicableForOt == 1 ? true : false,
            onChanged: null)),
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
