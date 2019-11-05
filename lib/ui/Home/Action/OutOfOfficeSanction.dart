import 'package:flutter/material.dart';
import 'package:hrpayroll/DataSource/ActionDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/ActionRequest.dart';
import 'package:hrpayroll/response_model/ActionResponse.dart';

import '../../MyAppBar.dart';

class OutOfOfficeSanction extends StatelessWidget {
  String EmpNo;

  OutOfOfficeSanction(this.EmpNo);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ApiInterface _apiInterface = ApiInterface();

  static List<ActionResponseModel> newdata = new List();
  ActionDataSource _actionDataSource = ActionDataSource(newdata);

  @override
  Widget build(BuildContext context) {
    ActionRequest actionRequest = ActionRequest(
      action: 1,
      employeeId: EmpNo,
    );

    return Scaffold(
      appBar: MyAppBar.getAppBar("Out of Office Sanction (${EmpNo})"),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future:
                  _apiInterface.outofOfficeSanctionResponseData(actionRequest),
              builder: (BuildContext context,
                  AsyncSnapshot<ActionResponse> snapshot) {
                debugPrint(snapshot.hasData.toString());
                if (snapshot.hasData) {
                  ActionResponse _actionResponseData = snapshot.data;
                  _actionDataSource =
                      ActionDataSource(_actionResponseData.data);
                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: _actionResponseData.data.length + 1,
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
                          "Sanction Incharge",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Hierarchy",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Incharge Name",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                    source: _actionDataSource,
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
                              "Sanction Incharge",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Hierarchy",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Incharge Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        source: _actionDataSource,
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
