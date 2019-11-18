import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/BusinessTripResponse.dart';
import 'package:intl/intl.dart';

class BusinessTripDataSource extends DataTableSource {
  List<BusinessTripModel> data = List();

  BusinessTripDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  static BusinessTripModel selectedRowData = BusinessTripModel();

  var dateFormatter = new DateFormat('MM/dd/yyyy');

  void selectAll(bool checked) {
    for (BusinessTripModel businessTripMod in data)
      businessTripMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    BusinessTripModel businessTripModel = data[index];
    return DataRow.byIndex(
      index: index,
      selected: businessTripModel.selected,
      onSelectChanged: (bool value) {
        if (businessTripModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          businessTripModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(businessTripModel.entryNo.toString())),
        DataCell(Text(businessTripModel.employeeNo)),
        DataCell(Text(businessTripModel.employeeName)),
        DataCell(Text(dateFormatter.format(DateFormat("yyyy-MM-dd").parse(businessTripModel.fromDate)))),
        DataCell(Text(dateFormatter.format(DateFormat("yyyy-MM-dd").parse(businessTripModel.toDate)))),
        DataCell(Text(businessTripModel.reasonForTrip)),
        DataCell(Text(businessTripModel.department)),
        DataCell(Text(businessTripModel.status)),
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
