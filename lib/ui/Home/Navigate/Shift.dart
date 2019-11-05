import 'package:flutter/material.dart';
import 'package:hrpayroll/DataSource/ShiftDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/NavigateRequest.dart';
import 'package:hrpayroll/response_model/NavigateResponseShift.dart';

import '../../MyAppBar.dart';

class Shift extends StatelessWidget {
  String EmpNo;

  Shift(this.EmpNo);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ApiInterface _apiInterface = ApiInterface();

  static List<ShiftModel> newdata = new List();
  ShiftDataSource _shiftDataSource = ShiftDataSource(newdata);

  @override
  Widget build(BuildContext context) {
    NavigateRequest navigateRequest = NavigateRequest(
      action: 1,
      employeeId: EmpNo,
    );

    return Scaffold(
      appBar: MyAppBar.getAppBar("Shift List (${EmpNo})"),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: _apiInterface.shiftResponseData(navigateRequest),
              builder: (BuildContext context,
                  AsyncSnapshot<NavigateResponseShift> snapshot) {
                debugPrint(snapshot.hasData.toString());
                if (snapshot.hasData) {
                  NavigateResponseShift _shiftResponseData = snapshot.data;
                  _shiftDataSource = ShiftDataSource(_shiftResponseData.data);
                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: _shiftResponseData.data.length + 1,
                    header: Text(""),
                    columns: [
                      DataColumn(
                        label: Text(
                          "Employee Id",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Start Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Shift Code",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                    source: _shiftDataSource,
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      Center(
                          child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                          ),
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          Text("Loading please wait...")
                        ],
                      )),
                      PaginatedDataTable(
                        columnSpacing: 15,
                        horizontalMargin: 15,
                        headingRowHeight: 35,
                        dataRowHeight: 30,
                        rowsPerPage: _rowsPerPage,
                        header: Text(""),
                        columns: [
                          DataColumn(
                            label: Text(
                              "Employee Id",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Start Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Shift Code",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        source: _shiftDataSource,
                      )
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
