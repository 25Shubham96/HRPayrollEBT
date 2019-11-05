import 'package:flutter/material.dart';
import 'package:hrpayroll/DataSource/DesigLocDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/NavigateRequest.dart';
import 'package:hrpayroll/response_model/NavigateResponseDesigLocHistory.dart';

import '../../MyAppBar.dart';

class LocationHistory extends StatelessWidget {
  String EmpNo;

  LocationHistory(this.EmpNo);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ApiInterface _apiInterface = ApiInterface();

  static List<DesigLocModel> newdata = new List();
  DesigLocDataSource _desigLocDataSource = DesigLocDataSource(newdata);

  @override
  Widget build(BuildContext context) {
    NavigateRequest navigateRequest = NavigateRequest(
      action: 1,
      employeeId: EmpNo,
    );

    return Scaffold(
      appBar: MyAppBar.getAppBar("Location List (${EmpNo})"),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: _apiInterface.locationResponseData(navigateRequest),
              builder: (BuildContext context,
                  AsyncSnapshot<NavigateResponseDesigLocHistory> snapshot) {
                debugPrint(snapshot.hasData.toString());
                if (snapshot.hasData) {
                  NavigateResponseDesigLocHistory _desigLocResponseData =
                      snapshot.data;
                  _desigLocDataSource =
                      DesigLocDataSource(_desigLocResponseData.data);
                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: _desigLocResponseData.data.length + 1,
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
                          "From Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "To Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Value",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                    source: _desigLocDataSource,
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
                              "From Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "To Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Value",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        source: _desigLocDataSource,
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
