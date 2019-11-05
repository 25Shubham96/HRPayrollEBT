import 'package:flutter/material.dart';
import 'package:hrpayroll/DataSource/KRADataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/NavigateRequest.dart';
import 'package:hrpayroll/response_model/NavigateResponseKRA.dart';

import '../../MyAppBar.dart';

class KRA extends StatelessWidget {
  String EmpNo;

  KRA(this.EmpNo);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ApiInterface _apiInterface = ApiInterface();

  static List<KRAModel> newdata = new List();
  KRADataSource _kraDataSource = KRADataSource(newdata);

  @override
  Widget build(BuildContext context) {
    NavigateRequest navigateRequest = NavigateRequest(
      action: 1,
      employeeId: EmpNo,
    );

    return Scaffold(
      appBar: MyAppBar.getAppBar("KRA List (${EmpNo})"),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: _apiInterface.kraResponseData(navigateRequest),
              builder: (BuildContext context,
                  AsyncSnapshot<NavigateResponseKRA> snapshot) {
                debugPrint(snapshot.hasData.toString());
                if (snapshot.hasData) {
                  NavigateResponseKRA _kraResponseData = snapshot.data;
                  _kraDataSource = KRADataSource(_kraResponseData.data);
                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: _kraResponseData.data.length + 1,
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
                          "KRA Code",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "KRA Description",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Weightage",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Target Units",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Target",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Target Type",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                    source: _kraDataSource,
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
                              "KRA Code",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "KRA Description",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Weightage",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Target Units",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Target",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Target Type",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        source: _kraDataSource,
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
