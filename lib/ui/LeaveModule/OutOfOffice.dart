import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/OutOfOfficeDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/LeaveApprovalRequest.dart';
import 'package:hrpayroll/request_model/OutOfOfficeRequest.dart';
import 'package:hrpayroll/response_model/OutOfOFficeResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutOfOffice extends StatefulWidget {
  @override
  _OutOfOfficeState createState() => _OutOfOfficeState();
}

class _OutOfOfficeState extends State<OutOfOffice> {
  final List<String> statusList = [
    "Open",
    "Send For Approval",
    "Approved",
    "Rejected",
    "Cancelled"
  ];

  static List<String> empNo;
  static List<String> empName;
  static List<String> empDesignation;
  static List<String> empDepartment;

  static var selectedEmp = "", selectedStatus = "";

  static TextEditingController empNameController = TextEditingController();
  static TextEditingController designationController = TextEditingController();
  static TextEditingController departmentController = TextEditingController();
  static TextEditingController requestDateController = TextEditingController();
  static TextEditingController fromTimeController = TextEditingController();
  static TextEditingController toTimeController = TextEditingController();
  static TextEditingController leaveReasonController = TextEditingController();
  static TextEditingController cancelCommentController =
  TextEditingController();

  Future<OutOfOfficeResponse> updateTableResponse;
  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();
  ApiInterface _apiInterface3 = ApiInterface();

  static List<OutOfOfficeModel> data = List();
  OutOfOfficeDataSource _outOfOfficeDataSource = OutOfOfficeDataSource(data);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  static bool textFieldEnableStatus = true;

  static bool editClicked = false;

  void getSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getStringList("empNo");
    empName = sharedPreferences.getStringList("empName");
    empDesignation = sharedPreferences.getStringList("empDesignation");
    empDepartment = sharedPreferences.getStringList("empDepartment");
  }

  @override
  void initState() {
    super.initState();
    OutOfOfficeRequest outOfOfficeRequest = OutOfOfficeRequest(
      action: 1,
    );
    setState(() {
      updateTableResponse =
              _apiInterface1.outOfOfficeResponseData(outOfOfficeRequest);
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
                      "Out of Office List",
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
                      AsyncSnapshot<OutOfOfficeResponse> snapshot) {
                if (snapshot.hasData) {
                  OutOfOfficeResponse _myResponseData = snapshot.data;
                  _outOfOfficeDataSource =
                          OutOfOfficeDataSource(_myResponseData.data);
                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 && _myResponseData.data.length > 0) ? _myResponseData.data.length : _rowsPerPage,
                    onSelectAll: _outOfOfficeDataSource.selectAll,
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
                          "Request Date",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "From Time",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "To Time",
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
                    source: _outOfOfficeDataSource,
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
                        onSelectAll: _outOfOfficeDataSource.selectAll,
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
                              "Request Date",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "From Time",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "To Time",
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
                        source: _outOfOfficeDataSource,
                      ),
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
              child: Text("New - Out of Office"),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(2),
      content: DialogContent(),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            if (requestDateController.text.isEmpty ||
                    fromTimeController.text.isEmpty ||
                    toTimeController.text.isEmpty ||
                    leaveReasonController.text.isEmpty) {
              Fluttertoast.showToast(
                msg: "One or more blank entries",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            } else {
              Navigator.pop(context);
              OutOfOfficeResponse outOfOfficeResponse =
              await _apiInterface2.outOfOfficeResponseData(
                      OutOfOfficeRequest(
                        action: 2,
                        employeeNo: selectedEmp,
                        employeeName: empNameController.text,
                        designation: designationController.text,
                        department: departmentController.text,
                        requestDate: requestDateController.text,
                        fromTime: fromTimeController.text,
                        toTime: toTimeController.text,
                        reason: leaveReasonController.text,
                        status: statusList.indexOf(selectedStatus),
                      ));

              if (outOfOfficeResponse.status) {
                OutOfOfficeRequest outOfOfficeRequest = OutOfOfficeRequest(
                  action: 1,
                );
                setState(() {
                  updateTableResponse = _apiInterface1.outOfOfficeResponseData(
                          outOfOfficeRequest);
                });
              }

              Fluttertoast.showToast(
                msg: "${outOfOfficeResponse.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
              /*var alert =
              AlertDialog(content: Text(outOfOfficeResponse.message));
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
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onEditPress(BuildContext context) {
    editClicked = true;

    var entryNo = OutOfOfficeDataSource.selectedRowData.entryNo.toString();

    if (_outOfOfficeDataSource.rowSelect) {
      if (OutOfOfficeDataSource.selectedRowData.status == statusList[0] ||
              OutOfOfficeDataSource.selectedRowData.status == statusList[1]) {
        if (OutOfOfficeDataSource.selectedRowData.status == statusList[1]) {
          textFieldEnableStatus = false;
          Fluttertoast.showToast(
            msg:
            "Document is ${OutOfOfficeDataSource.selectedRowData.status} status and cannot be edited",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
        }

        var alert = AlertDialog(
          titlePadding: EdgeInsets.all(2),
          title: Center(
            child: Text("Edit - Out of Office"),
          ),
          contentPadding: EdgeInsets.all(2),
          content: DialogContent(),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                if (requestDateController.text.isEmpty ||
                        fromTimeController.text.isEmpty ||
                        toTimeController.text.isEmpty ||
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
                    RejCanPostResponse rejCanResponse =
                    await _apiInterface3.leaveRejCanResponseData(
                            LeaveApprovalRequest(
                              action: "7",
                              documentType: "3",
                              sequenceNo: "0",
                              senderId: selectedEmp,
                              status: "4",
                              fromDate: fromTimeController.text,
                              cancellationComment: cancelCommentController.text,
                            ));

                    if (rejCanResponse.status) {
                      OutOfOfficeRequest outOfOfficeRequest =
                      OutOfOfficeRequest(
                        action: 1,
                      );
                      setState(() {
                        updateTableResponse =
                                _apiInterface1.outOfOfficeResponseData(
                                        outOfOfficeRequest);
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
                    OutOfOfficeResponse outOfOfficeResponse =
                    await _apiInterface2.outOfOfficeResponseData(
                            OutOfOfficeRequest(
                              action: 3,
                              employeeNo: selectedEmp,
                              employeeName: empNameController.text,
                              designation: designationController.text,
                              department: departmentController.text,
                              requestDate: requestDateController.text,
                              fromTime: fromTimeController.text,
                              toTime: toTimeController.text,
                              reason: leaveReasonController.text,
                              status: statusList.indexOf(selectedStatus),
                              entryNo: entryNo,
                            ));

                    if (outOfOfficeResponse.status) {
                      OutOfOfficeRequest outOfOfficeRequest =
                      OutOfOfficeRequest(
                        action: 1,
                      );
                      setState(() {
                        updateTableResponse =
                                _apiInterface1.outOfOfficeResponseData(
                                        outOfOfficeRequest);
                      });
                    }
                    Fluttertoast.showToast(
                      msg: "${outOfOfficeResponse.message}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                    /*var alert =
                    AlertDialog(content: Text(outOfOfficeResponse.message));
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
                  "Document is ${OutOfOfficeDataSource.selectedRowData.status} status and cannot be edited"),
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
        OutOfOfficeDataSource.selectedRowData.selected = false;
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
    var entryNo = OutOfOfficeDataSource.selectedRowData.entryNo.toString();
    if (_outOfOfficeDataSource.rowSelect) {
      if (OutOfOfficeDataSource.selectedRowData.status == statusList[0] ||
              OutOfOfficeDataSource.selectedRowData.status == statusList[1]) {
        var alert = AlertDialog(
          content: Text("Are you sure you want to delete this entry!?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
                OutOfOfficeResponse outOfOfficeResponse =
                await _apiInterface2.outOfOfficeResponseData(
                        OutOfOfficeRequest(
                          action: 4,
                          entryNo: entryNo,
                        ));

                if (outOfOfficeResponse.status) {
                  OutOfOfficeRequest outOfOfficeRequest = OutOfOfficeRequest(
                    action: 1,
                  );
                  setState(() {
                    updateTableResponse =
                            _apiInterface1.outOfOfficeResponseData(
                                    outOfOfficeRequest);
                  });
                }

                var alert =
                AlertDialog(
                  content: Text(outOfOfficeResponse.message),
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
                  "Document is ${OutOfOfficeDataSource.selectedRowData.status} status and cannot be deleted"),
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
  _OutOfOfficeState _outOfOfficeState = _OutOfOfficeState();

  @override
  void initState() {
    super.initState();
    setState(() {
      _OutOfOfficeState.selectedEmp = _OutOfOfficeState.editClicked
              ? OutOfOfficeDataSource.selectedRowData.employeeNo
              : _OutOfOfficeState.empNo[0];
      _OutOfOfficeState.empNameController.text = _OutOfOfficeState.editClicked
              ? OutOfOfficeDataSource.selectedRowData.employeeName
              : _OutOfOfficeState.empName[
      _OutOfOfficeState.empNo.indexOf(_OutOfOfficeState.selectedEmp)];
      _OutOfOfficeState.designationController.text = _OutOfOfficeState
              .editClicked
              ? OutOfOfficeDataSource.selectedRowData.designation
              : _OutOfOfficeState.empDesignation[
      _OutOfOfficeState.empNo.indexOf(_OutOfOfficeState.selectedEmp)];
      _OutOfOfficeState.departmentController.text = _OutOfOfficeState
              .editClicked
              ? OutOfOfficeDataSource.selectedRowData.department
              : _OutOfOfficeState.empDepartment[
      _OutOfOfficeState.empNo.indexOf(_OutOfOfficeState.selectedEmp)];

      _OutOfOfficeState.selectedStatus = _OutOfOfficeState.editClicked
              ? OutOfOfficeDataSource.selectedRowData.status
              : _outOfOfficeState.statusList[0];

      _OutOfOfficeState.requestDateController.text =
      _OutOfOfficeState.editClicked
              ? OutOfOfficeDataSource.selectedRowData.requestDate
              : "";
      _OutOfOfficeState.fromTimeController.text = _OutOfOfficeState.editClicked
              ? OutOfOfficeDataSource.selectedRowData.fromTime
              : "";
      _OutOfOfficeState.toTimeController.text = _OutOfOfficeState.editClicked
              ? OutOfOfficeDataSource.selectedRowData.toTime
              : "";
      _OutOfOfficeState.leaveReasonController.text =
      _OutOfOfficeState.editClicked
              ? OutOfOfficeDataSource.selectedRowData.reason
              : "";
    });
  }

  var formatter = new DateFormat('MM/dd/yyyy');

  DateTime selectedRequestDate = DateTime.now();

  Future<Null> _selectRequestDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedRequestDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        selectedRequestDate = picked;
        _OutOfOfficeState.requestDateController.text =
                formatter.format(selectedRequestDate);
      });
  }

  TimeOfDay fromTime = TimeOfDay.now();

  Future<Null> _selectFromTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: fromTime,
    );
    if (picked != null)
      setState(() {
        fromTime = picked;
        _OutOfOfficeState.fromTimeController.text =
                fromTime.hour.toString() + ":" + fromTime.minute.toString() + ":00";
      });
  }

  TimeOfDay toTime = TimeOfDay.now();

  Future<Null> _selectToTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: toTime,
    );
    if (picked != null)
      setState(() {
        toTime = picked;
        _OutOfOfficeState.toTimeController.text =
                toTime.hour.toString() + ":" + toTime.minute.toString() + ":00";
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
                        controller: _OutOfOfficeState.cancelCommentController,
                        decoration: InputDecoration(
                                labelText: "Enter the cancellation comment"),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            if (_OutOfOfficeState
                                    .cancelCommentController.text.isNotEmpty) {
                              Navigator.pop(context);
                              setState(() {
                                _OutOfOfficeState.selectedStatus =
                                _outOfOfficeState.statusList[4];
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
                              _OutOfOfficeState.selectedStatus =
                              _outOfOfficeState.statusList[1];
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
            visible: _OutOfOfficeState.editClicked,
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
                  value: _OutOfOfficeState.selectedEmp,
                  items: _OutOfOfficeState.empNo.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _OutOfOfficeState.selectedEmp = newValue;
                      _OutOfOfficeState.empNameController.text =
                      _OutOfOfficeState.empName[_OutOfOfficeState.empNo
                              .indexOf(_OutOfOfficeState.selectedEmp)];
                      _OutOfOfficeState.designationController.text =
                      _OutOfOfficeState.empDesignation[_OutOfOfficeState
                              .empNo
                              .indexOf(_OutOfOfficeState.selectedEmp)];
                      _OutOfOfficeState.departmentController.text =
                      _OutOfOfficeState.empDepartment[_OutOfOfficeState
                              .empNo
                              .indexOf(_OutOfOfficeState.selectedEmp)];
                    });
                  },
                ),
                ignoring: !_OutOfOfficeState.textFieldEnableStatus,
              )
            ],
          ),
          TextField(
            controller: _OutOfOfficeState.empNameController,
            decoration: InputDecoration(
              labelText: "Employee Name",
            ),
            enabled: false,
          ),
          TextField(
            controller: _OutOfOfficeState.designationController,
            decoration: InputDecoration(
              labelText: "Designation",
            ),
            enabled: false,
          ),
          TextField(
            controller: _OutOfOfficeState.departmentController,
            decoration: InputDecoration(
              labelText: "Department",
            ),
            enabled: false,
          ),
          TextField(
            controller: _OutOfOfficeState.requestDateController,
            decoration: InputDecoration(
              labelText: "Request Date",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectRequestDate(context);
            },
            enabled: _OutOfOfficeState.textFieldEnableStatus,
          ),
          TextField(
            controller: _OutOfOfficeState.fromTimeController,
            decoration: InputDecoration(
              labelText: "From Time",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectFromTime(context);
            },
            enabled: _OutOfOfficeState.textFieldEnableStatus,
          ),
          TextField(
            controller: _OutOfOfficeState.toTimeController,
            decoration: InputDecoration(
              labelText: "To Time",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectToTime(context);
            },
            enabled: _OutOfOfficeState.textFieldEnableStatus,
          ),
          TextField(
            controller: _OutOfOfficeState.leaveReasonController,
            decoration: InputDecoration(
              labelText: "Reason",
            ),
            enabled: _OutOfOfficeState.textFieldEnableStatus,
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
                  value: _OutOfOfficeState.selectedStatus,
                  items: _outOfOfficeState.statusList.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _OutOfOfficeState.selectedStatus = newValue;
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
