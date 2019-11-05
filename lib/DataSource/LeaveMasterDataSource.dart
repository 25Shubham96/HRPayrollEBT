import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/LeaveMasterResponse.dart';

class LeaveMasterDataSource extends DataTableSource {
  List<LeaveMasterModel> data = new List();

  LeaveMasterDataSource(this.data);

  int selectedCount = 0;

  @override
  DataRow getRow(int index) {
    LeaveMasterModel leaveMasterModel = data[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(leaveMasterModel.leaveCode)),
        DataCell(Text(leaveMasterModel.description)),
        DataCell(Text(leaveMasterModel.noOfLeavesInYear.toString())),
        DataCell(Text(leaveMasterModel.creditingInterval)),
        DataCell(Text(leaveMasterModel.creditingType)),
        DataCell(Text(leaveMasterModel.minimumAllowed.toString())),
        DataCell(Text(leaveMasterModel.maximumAllowed.toString())),
          DataCell(Checkbox(
              value: leaveMasterModel.carryForward == 1 ? true : false,
              onChanged: null)),
        DataCell(Text(leaveMasterModel.applicableDate)),
        DataCell(Text(leaveMasterModel.applicableForGrade)),
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
