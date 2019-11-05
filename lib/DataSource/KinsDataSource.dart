import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/NavigateResponseKins.dart';

class KinsDataSource extends DataTableSource {
  List<KinsModel> data = new List();

  KinsDataSource(this.data);

  var prevIndex = -1;

  @override
  DataRow getRow(int index) {
    KinsModel kinsModel = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(kinsModel.name)),
        DataCell(Text(kinsModel.relation)),
        DataCell(Checkbox(
            value: kinsModel.emergencyContact == 1 ? true : false,
            onChanged: null)),
        DataCell(Text(kinsModel.address1)),
        DataCell(Text(kinsModel.address2)),
        DataCell(Text(kinsModel.address3)),
        DataCell(Text(kinsModel.address4)),
        DataCell(Text(kinsModel.address5)),
        DataCell(Text(kinsModel.postCode)),
        DataCell(Text(kinsModel.homePhoneNo)),
        DataCell(Text(kinsModel.workPhoneNo)),
        DataCell(Text(kinsModel.eMai)),
        DataCell(Text(kinsModel.mobileNumber)),
        DataCell(Checkbox(
            value: kinsModel.beneficiary == 1 ? true : false, onChanged: null)),
        DataCell(Text(kinsModel.notes)),
        DataCell(Text(kinsModel.firstName)),
        DataCell(Text(kinsModel.lastName)),
        DataCell(Text(kinsModel.knownAs)),
        DataCell(Checkbox(
            value: kinsModel.nominee == 1 ? true : false, onChanged: null)),
        DataCell(Text(kinsModel.dateOfBirth)),
        DataCell(Text(kinsModel.sex)),
        DataCell(Text(kinsModel.sponsoredBy)),
        DataCell(Text(kinsModel.educationStatus)),
        DataCell(Text(kinsModel.placeOfBirth)),
        DataCell(Text(kinsModel.relationCode)),
        DataCell(Text(kinsModel.age.toString())),
        DataCell(Checkbox(
            value: kinsModel.benefitStatus == 1 ? true : false,
            onChanged: null)),
        DataCell(Text(kinsModel.relationshipType)),
        DataCell(Text(kinsModel.religion)),
        DataCell(Text(kinsModel.countryCode))
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
