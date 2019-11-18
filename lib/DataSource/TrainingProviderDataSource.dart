import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/TrainingProviderResponse.dart';

class TrainingProviderDataSource extends DataTableSource {
  List<TrainingProviderModel> data = new List();

  TrainingProviderDataSource(this.data);

  int selectedCount = 0;

  @override
  DataRow getRow(int index) {
    TrainingProviderModel trainingProviderModel = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(trainingProviderModel.providerNo)),
        DataCell(Text(trainingProviderModel.providerName)),
        DataCell(Text(trainingProviderModel.address1)),
        DataCell(Text(trainingProviderModel.address2)),
        DataCell(Text(trainingProviderModel.postCode)),
        DataCell(Text(trainingProviderModel.city)),
        DataCell(Text(trainingProviderModel.country)),
        DataCell(Text(trainingProviderModel.phoneNo)),
        DataCell(Text(trainingProviderModel.providerType)),
        DataCell(Text(trainingProviderModel.employeeNo)),
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
