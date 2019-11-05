import 'package:flutter/material.dart';

import '../response_model/EmployeeMasterResponse.dart';

class EmployeeMasterDataSource extends DataTableSource {
  List<EmployeeMasterModel> data = new List();

  EmployeeMasterDataSource(this.data);

  int selectedCount = 0;
  var prevIndex = -1;

  bool rowSelect = false;
  EmployeeMasterModel selectedRowData = EmployeeMasterModel();

  void selectAll(bool checked) {
    for (EmployeeMasterModel empMasMod in data) empMasMod.selected = checked;
    selectedCount = checked ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    EmployeeMasterModel employeeMasterModel = data[index];

    return DataRow.byIndex(
      index: index,
      selected: employeeMasterModel.selected,
      onSelectChanged: (bool value) {
        if (employeeMasterModel.selected != value) {
          rowSelect = true;
          selectedRowData = data[index];

          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          employeeMasterModel.selected = value;
          if (prevIndex != -1) data[prevIndex].selected = false;
          notifyListeners();
          prevIndex = index;
        }
      },
      cells: <DataCell>[
        DataCell(Text(employeeMasterModel.no)),
        DataCell(Text(employeeMasterModel.firstName)),
        DataCell(Text(employeeMasterModel.lastName)),
        DataCell(Text(employeeMasterModel.gradePayCadre)),
        DataCell(Text(employeeMasterModel.employmentDate)),
        DataCell(Text(employeeMasterModel.sponser)),
        DataCell(Text(employeeMasterModel.employeeLocation)),
        DataCell(Checkbox(
            value: employeeMasterModel.postToGl == 1 ? true : false,
            onChanged: null)),
        DataCell(Checkbox(
            value: employeeMasterModel.entitleForDepedantFlight == 1
                ? true
                : false,
            onChanged: null)),
        DataCell(Checkbox(
            value: employeeMasterModel.entitleForDepedantIsurance == 1
                ? true
                : false,
            onChanged: null)),
        DataCell(Checkbox(
            value: employeeMasterModel.resigned == 1 ? true : false,
            onChanged: null)),
        DataCell(Checkbox(
            value: employeeMasterModel.termination == 1 ? true : false,
            onChanged: null)),
        DataCell(Text(employeeMasterModel.city)),
        DataCell(Text(employeeMasterModel.countryCode)),
        DataCell(Text(employeeMasterModel.designation)),
        DataCell(Text(employeeMasterModel.status.toString())),
        //status description needed
        DataCell(Text(employeeMasterModel.periodStartDate)),
        DataCell(Text(employeeMasterModel.periodEndDate)),
        DataCell(Text(employeeMasterModel.departmentCode)),
        DataCell(Text(employeeMasterModel.empPostingGroup)),
        DataCell(Text(employeeMasterModel.payrollBusPostingGroup)),
        DataCell(Checkbox(
            value: employeeMasterModel.probation == 1 ? true : false,
            onChanged: null)),
        DataCell(Text(employeeMasterModel.no)),
        DataCell(Text(employeeMasterModel.employeeLocation)),
        DataCell(Text(employeeMasterModel.jobTitle)),
        DataCell(Text(employeeMasterModel.operationType)),
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
