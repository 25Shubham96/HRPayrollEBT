import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/NavigateResponseKRA.dart';

class KRADataSource extends DataTableSource {
  List<KRAModel> data = new List();

  KRADataSource(this.data);

  var prevIndex = -1;

  @override
  DataRow getRow(int index) {
    KRAModel kraModel = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(kraModel.employeeCode)),
        DataCell(Text(kraModel.applicablePeriodFromDate)),
        DataCell(Text(kraModel.applicablePeriodToDate)),
        DataCell(Text(kraModel.kraCode.toString())),
        DataCell(Text(kraModel.kraDescription)),
        DataCell(Text(kraModel.weightage.toString())),
        DataCell(Text(kraModel.targetUnits)),
        DataCell(Text(kraModel.target.toString())),
        DataCell(Text(kraModel.targerType)),
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
