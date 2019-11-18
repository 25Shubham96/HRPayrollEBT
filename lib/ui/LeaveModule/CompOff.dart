import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/CompOffDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/CompOffRequest.dart';
import 'package:hrpayroll/request_model/LeaveApprovalRequest.dart';
import 'package:hrpayroll/response_model/CompOffResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompOff extends StatefulWidget {
  @override
  _CompOffState createState() => _CompOffState();
}

class _CompOffState extends State<CompOff> {
  Future<CompOffResponse> updateTableResponse;
  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();
  ApiInterface _apiInterface3 = ApiInterface();

  static List<CompOffModel> data = List();
  CompOffDataSource _compOffDataSource = CompOffDataSource(data);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  final List<String> statusList = [
    "Open",
    "Send For Approval",
    "Approved",
    "Rejected",
    "Cancelled"
  ];
  static List<String> empNoList;
  static List<String> empNameList;
  static List<String> designationList;
  static List<String> departmentList;

  static TextEditingController empNameController = TextEditingController();
  static TextEditingController designationController = TextEditingController();
  static TextEditingController departmentController = TextEditingController();
  static TextEditingController fromDateController = TextEditingController();
  static TextEditingController toDateController = TextEditingController();
  static TextEditingController totDaysController = TextEditingController();
  static TextEditingController taskToCompleteController =
      TextEditingController();
  static TextEditingController leaveReasonController = TextEditingController();
  static TextEditingController cancelCommentController =
      TextEditingController();

  static var selectedEmp = "", selectedStatus = "";

  static bool textFieldEnableStatus = true;
  static bool editClicked = false;

  void getSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNoList = sharedPreferences.getStringList("empNo");
    empNameList = sharedPreferences.getStringList("empName");
    designationList = sharedPreferences.getStringList("empDesignation");
    departmentList = sharedPreferences.getStringList("empDepartment");
  }

  @override
  void initState() {
    super.initState();
    CompOffRequest compOffRequest = CompOffRequest(action: 1);

    setState(() {
      updateTableResponse = _apiInterface1.compOffResponseData(compOffRequest);
    });

    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              margin: new EdgeInsets.all(5),
              child: new Column(
                children: <Widget>[
                  new Center(
                    child: new Text(
                      "Compensatory Off List",
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
                              onNewPress(context);
                            },
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                new Text(
                                  "New",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            color: Colors.red,
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.only(left: 10)),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              onEditPress(context);
                            },
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                new Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            color: Colors.red,
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.only(left: 10)),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              onRemovePress(context);
                            },
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                new Text(
                                  "Remove",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: updateTableResponse,
              builder: (BuildContext context,
                  AsyncSnapshot<CompOffResponse> snapshot) {
                if (snapshot.hasData) {
                  CompOffResponse _myResponseData = snapshot.data;
                  _compOffDataSource = CompOffDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 &&
                            _myResponseData.data.length > 0)
                        ? _myResponseData.data.length
                        : _rowsPerPage,
                    onSelectAll: _compOffDataSource.selectAll,
                    header: Text(""),
                    columns: [
                      DataColumn(
                        label: new Text(
                          "Document No",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Employee No",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Employee Name",
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
                          "Department",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "From Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "To Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "No of Days",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Task to Complete",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Reason",
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
                    ],
                    source: _compOffDataSource,
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
                        header: Text(""),
                        columns: [
                          DataColumn(
                            label: new Text(
                              "Document No",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Employee No",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Employee Name",
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
                              "Department",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "From Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "To Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "No of Days",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Task to Complete",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Reason",
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
                        ],
                        source: _compOffDataSource,
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

  void onNewPress(BuildContext context) {
    setState(() {
      textFieldEnableStatus = true;
    });
    var alert = AlertDialog(
      titlePadding: EdgeInsets.all(2),
      title: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Text("New - Compensatory Off"),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(2),
      content: DialogContent(),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            if (fromDateController.text.isEmpty ||
                toDateController.text.isEmpty ||
                taskToCompleteController.text.isEmpty ||
                leaveReasonController.text.isEmpty) {
              Fluttertoast.showToast(
                msg: "One or more blank entries",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            } else {
              Navigator.pop(context);
              CompOffResponse compOffResponse =
                  await _apiInterface2.compOffResponseData(CompOffRequest(
                action: 2,
                employeeNo: selectedEmp,
                employeeName: empNameController.text,
                designation: designationController.text,
                department: departmentController.text,
                fromDate: fromDateController.text,
                toDate: toDateController.text,
                noOfDays: int.parse(totDaysController.text),
                taskToComplete: taskToCompleteController.text,
                reason: leaveReasonController.text,
                status: statusList.indexOf(selectedStatus),
              ));

              if (compOffResponse.status) {
                CompOffRequest compOffRequest = CompOffRequest(action: 1);

                setState(() {
                  updateTableResponse =
                      _apiInterface1.compOffResponseData(compOffRequest);
                });
              }

              Fluttertoast.showToast(
                msg: "${compOffResponse.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );

              /*var alert = AlertDialog(content: Text(compOffResponse.message));
              showDialog(
                context: context,
                builder: (context) {
                  return alert;
                },
              );*/
            }
          },
          child: Text("Submit"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void onEditPress(BuildContext context) {
    editClicked = true;
    var entryNo = CompOffDataSource.selectedRowData.entryNo.toString();

    if (_compOffDataSource.rowSelect) {
      if (CompOffDataSource.selectedRowData.status == statusList[0] ||
          CompOffDataSource.selectedRowData.status == statusList[1]) {
        if (CompOffDataSource.selectedRowData.status == statusList[1]) {
          textFieldEnableStatus = false;
          Fluttertoast.showToast(
            msg:
                "Document is ${CompOffDataSource.selectedRowData.status} status and cannot be edited",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
        }

        var alert = AlertDialog(
          titlePadding: EdgeInsets.all(2),
          title: Center(
            child: Text("Edit - Compensatory Off"),
          ),
          contentPadding: EdgeInsets.all(2),
          content: DialogContent(),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                if (fromDateController.text.isEmpty ||
                    toDateController.text.isEmpty ||
                    taskToCompleteController.text.isEmpty ||
                    leaveReasonController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "One or more blank entries",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                  );
                } else {
                  Navigator.pop(context);
                  setState(() {
                    editClicked = false;
                  });
                  if (selectedStatus == statusList[4]) {
                    RejCanPostResponse rejCanResponse = await _apiInterface3
                        .leaveRejCanResponseData(LeaveApprovalRequest(
                      action: "7",
                      documentType: "2",
                      sequenceNo: "0",
                      senderId: selectedEmp,
                      status: "4",
                      fromDate: fromDateController.text,
                      cancellationComment: cancelCommentController.text,
                    ));

                    if (rejCanResponse.status) {
                      CompOffRequest compOffRequest = CompOffRequest(action: 1);

                      setState(() {
                        updateTableResponse =
                            _apiInterface1.compOffResponseData(compOffRequest);
                      });
                    }

                    Fluttertoast.showToast(
                      msg: "${rejCanResponse.message}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                    /*var alert =
                    AlertDialog(content: Text(rejCanResponse.message));
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );*/
                  } else {
                    CompOffResponse compOffResponse =
                        await _apiInterface2.compOffResponseData(CompOffRequest(
                      action: 3,
                      entryNo: entryNo,
                      employeeNo: selectedEmp,
                      employeeName: empNameController.text,
                      designation: designationController.text,
                      department: departmentController.text,
                      fromDate: fromDateController.text,
                      toDate: toDateController.text,
                      noOfDays: int.parse(totDaysController.text),
                      taskToComplete: taskToCompleteController.text,
                      reason: leaveReasonController.text,
                      status: statusList.indexOf(selectedStatus),
                    ));

                    if (compOffResponse.status) {
                      CompOffRequest compOffRequest = CompOffRequest(action: 1);

                      setState(() {
                        updateTableResponse =
                            _apiInterface1.compOffResponseData(compOffRequest);
                      });
                    }

                    Fluttertoast.showToast(
                      msg: "${compOffResponse.message}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                    /*var alert =
                    AlertDialog(content: Text(compOffResponse.message));
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );*/
                  }
                }
              },
              child: Text("Update"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  editClicked = false;
                });
              },
              child: Text("Cancel"),
            ),
          ],
        );
        showDialog(
            context: context,
            builder: (context) {
              return alert;
            });
      } else {
        setState(() {
          editClicked = false;
        });
        var alert = AlertDialog(
          content: Text(
              "Document is ${CompOffDataSource.selectedRowData.status} status and cannot be edited"),
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
      setState(() {
        CompOffDataSource.selectedRowData.selected = false;
      });
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
  }

  void onRemovePress(BuildContext context) {
    var entryNo = CompOffDataSource.selectedRowData.entryNo.toString();
    if (_compOffDataSource.rowSelect) {
      if (CompOffDataSource.selectedRowData.status == statusList[0] ||
          CompOffDataSource.selectedRowData.status == statusList[1]) {
        var alert = AlertDialog(
          content: Text("Are you sure you want to delete this entry!?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
                CompOffResponse compOffResponse =
                    await _apiInterface2.compOffResponseData(CompOffRequest(
                  action: 4,
                  entryNo: entryNo,
                  noOfDays: 0,
                ));

                if (compOffResponse.status) {
                  CompOffRequest compOffRequest = CompOffRequest(action: 1);

                  setState(() {
                    updateTableResponse =
                        _apiInterface1.compOffResponseData(compOffRequest);
                  });
                }

                var alert = AlertDialog(
                  content: Text(compOffResponse.message),
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
              },
              child: Text("Yes"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (context) {
            return alert;
          },
        );
      } else {
        var alert = AlertDialog(
          content: Text(
              "Document is ${CompOffDataSource.selectedRowData.status} status and cannot be deleted"),
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
  }
}

class DialogContent extends StatefulWidget {
  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  _CompOffState _compOffState = _CompOffState();

  var formatter = new DateFormat('MM/dd/yyyy');

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().subtract(Duration(days: 1));

  @override
  void initState() {
    super.initState();
    setState(() {
      _CompOffState.selectedEmp = _CompOffState.editClicked
          ? CompOffDataSource.selectedRowData.employeeNo
          : _CompOffState.empNoList[0];
      _CompOffState.empNameController.text = _CompOffState.editClicked
          ? CompOffDataSource.selectedRowData.employeeName
          : _CompOffState.empNameList[
              _CompOffState.empNoList.indexOf(_CompOffState.selectedEmp)];
      _CompOffState.designationController.text = _CompOffState.editClicked
          ? CompOffDataSource.selectedRowData.designation
          : _CompOffState.designationList[
              _CompOffState.empNoList.indexOf(_CompOffState.selectedEmp)];
      _CompOffState.departmentController.text = _CompOffState.editClicked
          ? CompOffDataSource.selectedRowData.department
          : _CompOffState.departmentList[
              _CompOffState.empNoList.indexOf(_CompOffState.selectedEmp)];

      _CompOffState.selectedStatus = _CompOffState.editClicked
          ? CompOffDataSource.selectedRowData.status
          : _compOffState.statusList[0];

      _CompOffState.fromDateController.text = _CompOffState.editClicked
          ? CompOffDataSource.selectedRowData.fromDate
          : "";
      _CompOffState.toDateController.text = _CompOffState.editClicked
          ? CompOffDataSource.selectedRowData.toDate
          : "";
      _CompOffState.totDaysController.text = _CompOffState.editClicked
          ? CompOffDataSource.selectedRowData.noOfDays.toString()
          : "";
      _CompOffState.taskToCompleteController.text = _CompOffState.editClicked
          ? CompOffDataSource.selectedRowData.taskToComplete
          : "";
      _CompOffState.leaveReasonController.text = _CompOffState.editClicked
          ? CompOffDataSource.selectedRowData.reason
          : "";
      if(_CompOffState.editClicked) {
        fromDate = DateFormat("yyyy-MM-dd").parse(
                _CompOffState.fromDateController.text);
        toDate = DateFormat("yyyy-MM-dd").parse(
                _CompOffState.toDateController.text);
      }
    });
  }

  Future<Null> _selectFromDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: fromDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        fromDate = picked;
        _CompOffState.fromDateController.text = formatter.format(fromDate);
        _CompOffState.totDaysController.text =
                (toDate.difference(fromDate).inDays + 1).toString();
      });
  }

  Future<Null> _selectToDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: toDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        toDate = picked;
        _CompOffState.toDateController.text = formatter.format(toDate);
        _CompOffState.totDaysController.text =
                (toDate.difference(fromDate).inDays + 1).toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Visibility(
            child: Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    var alert = AlertDialog(
                      contentPadding: EdgeInsets.all(2),
                      content: TextField(
                        controller: _CompOffState.cancelCommentController,
                        decoration: InputDecoration(
                            labelText: "enter the cancellation comment"),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            if (_CompOffState
                                .cancelCommentController.text.isNotEmpty) {
                              Navigator.pop(context);
                              setState(() {
                                _CompOffState.selectedStatus =
                                    _compOffState.statusList[4];
                              });
                            } else {
                              Fluttertoast.showToast(
                                msg: "Cancellation comment is compulsory",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                              );
                            }
                          },
                          child: Text("done"),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("cancel"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.cancel),
                      Text("Cancel Request")
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 5)),
                FlatButton(
                  onPressed: () {
                    var alert = AlertDialog(
                      content:
                          Text("Are you sure you want to send for approval ?"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              _CompOffState.selectedStatus =
                                  _compOffState.statusList[1];
                            });
                          },
                          child: Text("Yes"),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No"),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.send),
                      Text("Send for Approval")
                    ],
                  ),
                ),
              ],
            ),
            visible: _CompOffState.editClicked,
          ),
          Row(
            children: <Widget>[
              Text(
                "Employee No. : ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IgnorePointer(
                child: DropdownButton(
                  value: _CompOffState.selectedEmp,
                  items: _CompOffState.empNoList.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    debugPrint("Comment: " + newValue);
                    setState(() {
                      _CompOffState.selectedEmp = newValue;
                      _CompOffState.empNameController.text =
                          _CompOffState.empNameList[_CompOffState.empNoList
                              .indexOf(_CompOffState.selectedEmp)];
                      _CompOffState.designationController.text =
                          _CompOffState.designationList[_CompOffState.empNoList
                              .indexOf(_CompOffState.selectedEmp)];
                      _CompOffState.departmentController.text =
                          _CompOffState.departmentList[_CompOffState.empNoList
                              .indexOf(_CompOffState.selectedEmp)];
                    });
                  },
                ),
                ignoring: !_CompOffState.textFieldEnableStatus,
              )
            ],
          ),
          TextField(
            controller: _CompOffState.empNameController,
            decoration: InputDecoration(
              labelText: "Employee Name",
            ),
            enabled: false,
          ),
          TextField(
            controller: _CompOffState.designationController,
            decoration: InputDecoration(
              labelText: "Designation",
            ),
            enabled: false,
          ),
          TextField(
            controller: _CompOffState.departmentController,
            decoration: InputDecoration(
              labelText: "Department",
            ),
            enabled: false,
          ),
          TextField(
            controller: _CompOffState.fromDateController,
            decoration: InputDecoration(
              labelText: "From Date",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectFromDate(context);
            },
            enabled: _CompOffState.textFieldEnableStatus,
          ),
          TextField(
            controller: _CompOffState.toDateController,
            decoration: InputDecoration(
              labelText: "To Date",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectToDate(context);
            },
            enabled: _CompOffState.textFieldEnableStatus,
          ),
          TextField(
            controller: _CompOffState.totDaysController,
            decoration: InputDecoration(
              labelText: "No of Days",
            ),
            enabled: false,
          ),
          TextField(
            controller: _CompOffState.taskToCompleteController,
            decoration: InputDecoration(
              labelText: "Task to Complete",
            ),
            enabled: _CompOffState.textFieldEnableStatus,
          ),
          TextField(
            controller: _CompOffState.leaveReasonController,
            decoration: InputDecoration(
              labelText: "Reason",
            ),
            enabled: _CompOffState.textFieldEnableStatus,
          ),
          Padding(padding: EdgeInsets.all(5)),
          Row(
            children: <Widget>[
              Text(
                "Status : ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IgnorePointer(
                child: DropdownButton(
                  value: _CompOffState.selectedStatus,
                  items: _compOffState.statusList.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _CompOffState.selectedStatus = newValue;
                    });
                  },
                ),
                ignoring: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class NoKeyboardEditableTextFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;

  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
