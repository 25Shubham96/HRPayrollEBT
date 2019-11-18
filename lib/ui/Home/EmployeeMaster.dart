import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrpayroll/DataSource/EmployeeMasterDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/response_model/EmployeeMasterResponse.dart';
import 'package:hrpayroll/ui/Home/Action/BusinessTripSanction.dart';
import 'package:hrpayroll/ui/Home/Action/CompOffSanction.dart';
import 'package:hrpayroll/ui/Home/Action/EmployeeAssetSanction.dart';
import 'package:hrpayroll/ui/Home/Action/LeaveSanction.dart';
import 'package:hrpayroll/ui/Home/Action/OutOfOfficeSanction.dart';
import 'package:hrpayroll/ui/Home/Action/PassportSanction.dart';
import 'package:hrpayroll/ui/Home/Action/TrainingSanction.dart';
import 'package:hrpayroll/ui/Home/Navigate/DesignationHistory.dart';
import 'package:hrpayroll/ui/Home/Navigate/Kins.dart';
import 'package:hrpayroll/ui/Home/Navigate/LocationHistory.dart';
import 'package:hrpayroll/ui/Home/Navigate/PayElements.dart';
import 'package:http/http.dart' as http;

import './EmpMasterDataSource.dart';
import 'Action/AssesmentSanction.dart';
import 'Navigate/CarryFwdInfo.dart';
import 'Navigate/KRA.dart';
import 'Navigate/Shift.dart';

class EmployeeMaster extends StatefulWidget {
  @override
  _EmployeeMasterState createState() => _EmployeeMasterState();
}

class _EmployeeMasterState extends State<EmployeeMaster> {
  EmpMasterDataSource empMasterDataSource = EmpMasterDataSource();

  static List<EmployeeMasterModel> newdata = new List();

  EmployeeMasterDataSource _employeeMasterDataSource =
      EmployeeMasterDataSource(newdata);

  EmployeeMasterResponse _myResponseData;

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ApiInterface _apiInterface = ApiInterface();

  void getEmployeeMasterResponse() async {
    _myResponseData = await getEmpData();
    setState(() {
      _employeeMasterDataSource =
          EmployeeMasterDataSource(_myResponseData.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              margin: new EdgeInsets.all(5),
              child: new Column(
                children: <Widget>[
                  new Center(
                    child: new Text(
                      "Employee Master View",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              showAction(context);
                            },
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  "Action",
                                  style: TextStyle(color: Colors.white),
                                ),
                                new Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            color: Colors.redAccent.shade200,
                          ),
                        ),
//                        new FlatButton(
//                          onPressed: () {
//                            showAction(context);
//                          },
//                          child: new Row(
//                            children: <Widget>[
//                              new Text("Action"),
//                              new Icon(Icons.arrow_drop_down),
//                            ],
//                          ),
//                          color: Colors.grey.shade300,
//                        ),
                        new Padding(padding: new EdgeInsets.only(left: 10)),
                        Expanded(
                            child: FlatButton(
                          onPressed: () {
                            showNavigation(context);
                          },
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                "Navigate",
                                style: TextStyle(color: Colors.white),
                              ),
                              new Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          color: Colors.redAccent.shade200,
                        )),
//                        new FlatButton(
//                          onPressed: () {
//                            showNavigation(context);
//                          },
//                          child: new Row(
//                            children: <Widget>[
//                              new Text("Navigate"),
//                              new Icon(Icons.arrow_drop_down),
//                            ],
//                          ),
//                          color: Colors.grey.shade300,
//                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _apiInterface.getEmpData(),
              builder: (BuildContext context,
                  AsyncSnapshot<EmployeeMasterResponse> snapshot) {
                if (snapshot.hasData) {
                  EmployeeMasterResponse _myResponseData = snapshot.data;
                  _employeeMasterDataSource =
                      EmployeeMasterDataSource(_myResponseData.data);
                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 &&
                            _myResponseData.data.length > 0)
                        ? _myResponseData.data.length
                        : _rowsPerPage,
                    onRowsPerPageChanged: (int value) {
                      setState(() {
                        _rowsPerPage = value;
                      });
                    },
                    onSelectAll: _employeeMasterDataSource.selectAll,
                    header: new Text(""),
                    columns: [
                      DataColumn(
                        label: new Text(
                          "Emp No",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "First Name",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Last Name",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Grade/Pay Cadre",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Employment Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Sponser",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Location",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Post to GL",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Entitled for Dependent Flight",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Entitled for Dependent Insuarence",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Resigned",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Termination",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "City",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Country Code",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Designation",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Status",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Period Start Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Period End Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Department Code",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Emp Posting Group",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Bus Posting Group",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Probation",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Employee Code",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Location Code",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Job Title",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Operation Type",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                    source: _employeeMasterDataSource,
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
                        ),
                      ),
                      PaginatedDataTable(
                        columnSpacing: 15,
                        horizontalMargin: 15,
                        headingRowHeight: 35,
                        dataRowHeight: 30,
                        rowsPerPage: _rowsPerPage,
                        onRowsPerPageChanged: (int value) {
                          setState(() {
                            _rowsPerPage = value;
                          });
                        },
                        header: new Text(""),
                        columns: [
                          DataColumn(
                            label: new Text(
                              "Emp No",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "First Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Last Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Grade/Pay Cadre",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Employment Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Sponser",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Location",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Post to GL",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Entitled for Dependent Flight",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Entitled for Dependent Insuarence",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Resigned",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Termination",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "City",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Country Code",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Designation",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Status",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Period Start Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Period End Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Department Code",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Emp Posting Group",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Bus Posting Group",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Probation",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Employee Code",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Location Code",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Job Title",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Operation Type",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        source: _employeeMasterDataSource,
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<EmployeeMasterResponse> getEmpData() async {
    String apiURL = "http://103.1.92.74:8098/api/employeesapi/getemployees";

    var response = await http.get(
      apiURL,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'Basic A78F4134A3A841F0954EA29D5C8DBDB3'
      },
    );

    return employeeMasterFromJson(response.body);
  }

  void showAction(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Action"),
      content: new Container(
        height: 448,
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.assessment),
                title: new Text("Assesment Sanc Incharge"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return AssessmentSanction(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.adjust),
                title: new Text("Comp Off Sanc Incharge"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return CompOffSanction(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: new Text("Business Trip Sanc Incharge"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return BusinessTripSanction(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: new Text("Out of Office Sanc Incharge"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return OutOfOfficeSanction(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.transfer_within_a_station),
                title: new Text("Leave Sanc Incharge"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return LeaveSanction(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: new Text("Training Sanc Incharge"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return TrainingSanction(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: new Text("Emp Asset Sanc Incharge"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return EmployeeAssetSanction(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.airplanemode_active),
                title: new Text("Passport Sanc Incharge"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return PassportSanction(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void showNavigation(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Navigate"),
      content: new Container(
        height: 392,
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.group),
                title: new Text("Kins"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return Kins(_employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.compare_arrows),
                title: new Text("Shifts"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return Shift(_employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: new Text("Designation"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return DesignationHistory(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: new Text("Location History"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return LocationHistory(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.fast_forward),
                title: new Text("Carry Forward Info"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return CarryFwdInfo(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.vpn_key),
                title: new Text("KRA"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return KRA(_employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: new Text("Pay Elements"),
                onTap: () {
                  if (_employeeMasterDataSource.rowSelect) {
                    Navigator.pop(context);

                    Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                      return PayElements(
                              _employeeMasterDataSource.selectedRowData.no);
                    }));
                  } else {
                    var alert = AlertDialog(
                      content: Text("Please select a row first!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
