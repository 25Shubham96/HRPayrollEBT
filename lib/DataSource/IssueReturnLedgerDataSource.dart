import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/IssueReturnLedgerResponse.dart';
import 'package:intl/intl.dart';

class IssueReturnLedgerDataSource extends DataTableSource {
  List<IssueReturnLedgerModel> data = new List();

  IssueReturnLedgerDataSource(this.data);

  int selectedCount = 0;

  var dateFormatter = new DateFormat('MM/dd/yyyy');

  @override
  DataRow getRow(int index) {
    IssueReturnLedgerModel issueReturnLedgerModel = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(issueReturnLedgerModel.issueNo.toString())),
        DataCell(Text(issueReturnLedgerModel.employeeNo)),
        DataCell(Text(issueReturnLedgerModel.issuedBy)),
        DataCell(Checkbox(
            value: issueReturnLedgerModel.issued == 1 ? true : false,
            onChanged: null)),
        DataCell(Text(dateFormatter.format(DateFormat("yyyy-MM-dd").parse(issueReturnLedgerModel.issueDate)))),
        DataCell(Checkbox(
            value: issueReturnLedgerModel.returned == 1 ? true : false,
            onChanged: null)),
        DataCell(Text(dateFormatter.format(DateFormat("yyyy-MM-dd").parse(issueReturnLedgerModel.returnDate)))),
        DataCell(Text(issueReturnLedgerModel.assetType)),
        DataCell(Text(issueReturnLedgerModel.assetNo)),
        DataCell(Text(issueReturnLedgerModel.assetName)),
        DataCell(Text(issueReturnLedgerModel.owner.toString())),
        DataCell(Text(issueReturnLedgerModel.value.toString())),
        DataCell(Text(issueReturnLedgerModel.manufacturar)),
        DataCell(Text(issueReturnLedgerModel.model)),
        DataCell(Text(issueReturnLedgerModel.ownerName)),
        DataCell(Text(issueReturnLedgerModel.currentAssetLocation)),
        DataCell(Text(issueReturnLedgerModel.postedPurchaseOrderNo)),
        DataCell(Checkbox(
            value: issueReturnLedgerModel.issuedReturned == 1 ? true : false,
            onChanged: null)),
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
