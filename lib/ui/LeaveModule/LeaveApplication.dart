import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/LeaveApplicationDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/LeaveApplicationRequest.dart';
import 'package:hrpayroll/request_model/LeaveApprovalRequest.dart';
import 'package:hrpayroll/response_model/LeaveApplicationResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class LeaveApplication extends StatefulWidget {
  @override
  _LeaveApplicationState createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication> {
  final List<String> leaveDuration = ["Half Day", "Full Day"];
  final List<String> statusList = [
    "Open",
    "Send For Approval",
    "Approved",
    "Rejected",
    "Cancelled"
  ];

  static List<String> empNo;
  static List<String> empName;
  static List<String> leaveCode;
  static List<String> leaveDescription;

  static var selectedEmp = "",
      selectedLeaveCode = "",
      selectedLeaveDuration = "",
      selectedStatus = "",
      cancellationConfirm = false;

  static TextEditingController empNameController = TextEditingController();
  static TextEditingController leaveDescripController = TextEditingController();
  static TextEditingController fromDateController = TextEditingController();
  static TextEditingController toDateController = TextEditingController();
  static TextEditingController totDaysController = TextEditingController();
  static TextEditingController leaveReasonController = TextEditingController();
  static TextEditingController contactDetailsController =
      TextEditingController();
  static TextEditingController workingDayController = TextEditingController();
  static TextEditingController apprDateTimeController = TextEditingController();
  static TextEditingController rejectionCommentController =
      TextEditingController();
  static TextEditingController applDateController = TextEditingController();
  static TextEditingController cancelCommentController =
      TextEditingController();

  Future<LeaveApplicationResponse> updateTableResponse;
  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();
  ApiInterface _apiInterface3 = ApiInterface();

  static List<LeaveApplicationModel> data = List();
  LeaveApplicationDataSource _leaveApplicationDataSource =
      LeaveApplicationDataSource(data);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  static bool textFieldEnableStatus = true;
  static bool editClicked = false;

  void getSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getStringList("empNo");
    empName = sharedPreferences.getStringList("empName");
    leaveCode = sharedPreferences.getStringList("leaveCode");
    leaveDescription = sharedPreferences.getStringList("leaveDescription");
  }

  @override
  void initState() {
    super.initState();
    LeaveApplicationRequest leaveApplicationRequest = LeaveApplicationRequest(
      action: 1,
    );
    setState(() {
      updateTableResponse =
          _apiInterface1.leaveApplicationResponseData(leaveApplicationRequest);
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
                      "Leave Application List",
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
                  AsyncSnapshot<LeaveApplicationResponse> snapshot) {
                if (snapshot.hasData) {
                  LeaveApplicationResponse _myResponseData = snapshot.data;
                  _leaveApplicationDataSource =
                      LeaveApplicationDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 &&
                            _myResponseData.data.length > 0)
                        ? _myResponseData.data.length
                        : _rowsPerPage,
                    onSelectAll: _leaveApplicationDataSource.selectAll,
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
                          "Leave Code",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Leave Description",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Leave Duration",
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
                          "Total Days",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Leave Reason",
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
                          "Sanctioned",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Leave Avbl Ccy",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Sanc Incharge",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Sanc Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Cancellation Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                    source: _leaveApplicationDataSource,
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
                        onSelectAll: _leaveApplicationDataSource.selectAll,
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
                              "Leave Code",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Leave Description",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Leave Duration",
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
                              "Total Days",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Leave Reason",
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
                              "Sanctioned",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Leave Avbl Ccy",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Sanc Incharge",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Sanc Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Cancellation Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        source: _leaveApplicationDataSource,
                      ),
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
              child: Text("New - Leave Application"),
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
                leaveReasonController.text.isEmpty ||
                contactDetailsController.text.isEmpty ||
                workingDayController.text.isEmpty) {
              Fluttertoast.showToast(
                msg: "One or more blank entries",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            } else {
              Navigator.pop(context);
              LeaveApplicationResponse leaveApplicationResponse =
                  await _apiInterface2
                      .leaveApplicationResponseData(LeaveApplicationRequest(
                action: 2,
                employeeNo: selectedEmp,
                employeeName: empNameController.text,
                leaveCode: selectedLeaveCode,
                leaveDescription: leaveDescripController.text,
                leaveDuration: leaveDuration.indexOf(selectedLeaveDuration),
                fromDate: fromDateController.text,
                toDate: toDateController.text,
                noDays: double.parse(totDaysController.text),
                reasonLeave: leaveReasonController.text,
                status: statusList.indexOf(selectedStatus),
                contactDetail: contactDetailsController.text,
                specifyWorkDay: workingDayController.text,
                cancelConfirm: cancellationConfirm,
                applicationDate: applDateController.text,
              ));

              if (leaveApplicationResponse.status) {
                LeaveApplicationRequest leaveApplicationRequest =
                    LeaveApplicationRequest(
                  action: 1,
                );
                setState(() {
                  updateTableResponse = _apiInterface1
                      .leaveApplicationResponseData(leaveApplicationRequest);
                });
              }

              Fluttertoast.showToast(
                msg: "${leaveApplicationResponse.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );

              /*var alert =
              AlertDialog(content: Text(leaveApplicationResponse.message));
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

    var documentNo =
        LeaveApplicationDataSource.selectedRowData.documentNo.toString();

    if (_leaveApplicationDataSource.rowSelect) {
      if (LeaveApplicationDataSource.selectedRowData.status == statusList[0] ||
          LeaveApplicationDataSource.selectedRowData.status == statusList[1]) {
        if (LeaveApplicationDataSource.selectedRowData.status ==
            statusList[1]) {
          textFieldEnableStatus = false;
          Fluttertoast.showToast(
            msg:
                "Document is ${LeaveApplicationDataSource.selectedRowData.status} status and cannot be edited",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
        }

        var alert = AlertDialog(
          titlePadding: EdgeInsets.all(2),
          title: Center(
            child: Text("Edit - Leave Application"),
          ),
          contentPadding: EdgeInsets.all(2),
          content: DialogContent(),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                if (fromDateController.text.isEmpty ||
                    toDateController.text.isEmpty ||
                    leaveReasonController.text.isEmpty ||
                    contactDetailsController.text.isEmpty ||
                    workingDayController.text.isEmpty) {
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
                      documentType: "1",
                      sequenceNo: "0",
                      senderId: selectedEmp,
                      status: "4",
                      fromDate: fromDateController.text,
                      cancellationComment: cancelCommentController.text,
                    ));

                    if (rejCanResponse.status) {
                      LeaveApplicationRequest leaveApplicationRequest =
                          LeaveApplicationRequest(
                        action: 1,
                      );
                      setState(() {
                        updateTableResponse =
                            _apiInterface1.leaveApplicationResponseData(
                                leaveApplicationRequest);
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
                    LeaveApplicationResponse leaveApplicationResponse =
                        await _apiInterface2.leaveApplicationResponseData(
                            LeaveApplicationRequest(
                      action: 3,
                      employeeNo: selectedEmp,
                      employeeName: empNameController.text,
                      leaveCode: selectedLeaveCode,
                      leaveDescription: leaveDescripController.text,
                      leaveDuration:
                          leaveDuration.indexOf(selectedLeaveDuration),
                      fromDate: fromDateController.text,
                      toDate: toDateController.text,
                      noDays: double.parse(totDaysController.text),
                      reasonLeave: leaveReasonController.text,
                      status: statusList.indexOf(selectedStatus),
                      contactDetail: contactDetailsController.text,
                      specifyWorkDay: workingDayController.text,
                      cancelConfirm: cancellationConfirm,
                      applicationDate: applDateController.text,
                      documentNo: documentNo,
                    ));

                    if (leaveApplicationResponse.status) {
                      LeaveApplicationRequest leaveApplicationRequest =
                          LeaveApplicationRequest(
                        action: 1,
                      );
                      setState(() {
                        updateTableResponse =
                            _apiInterface1.leaveApplicationResponseData(
                                leaveApplicationRequest);
                      });
                    }

                    Fluttertoast.showToast(
                      msg: "${leaveApplicationResponse.message}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );

                    /*var alert = AlertDialog(
                        content: Text(leaveApplicationResponse.message));
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
              "Document is ${LeaveApplicationDataSource.selectedRowData.status} status and cannot be edited"),
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
        LeaveApplicationDataSource.selectedRowData.selected = false;
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
    var documentNo =
        LeaveApplicationDataSource.selectedRowData.documentNo.toString();
    var employeeNo =
        LeaveApplicationDataSource.selectedRowData.employeeNo.toString();
    var fromDate =
        LeaveApplicationDataSource.selectedRowData.fromDate.toString();

    if (_leaveApplicationDataSource.rowSelect) {
      if (LeaveApplicationDataSource.selectedRowData.status == statusList[0] ||
          LeaveApplicationDataSource.selectedRowData.status == statusList[1]) {
        var alert = AlertDialog(
          content: Text("Are you sure you want to delete this entry!?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
                LeaveApplicationResponse leaveApplicationResponse =
                    await _apiInterface2
                        .leaveApplicationResponseData(LeaveApplicationRequest(
                  action: 4,
                  employeeNo: employeeNo,
                  leaveCode: documentNo,
                  fromDate: fromDate,
                ));

                if (leaveApplicationResponse.status) {
                  LeaveApplicationRequest leaveApplicationRequest =
                      LeaveApplicationRequest(
                    action: 1,
                  );
                  setState(() {
                    updateTableResponse = _apiInterface1
                        .leaveApplicationResponseData(leaveApplicationRequest);
                  });
                }

                Fluttertoast.showToast(
                  msg: "${leaveApplicationResponse.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
                /*var alert = AlertDialog(
                    content: Text(leaveApplicationResponse.message));
                showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  },
                );*/
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
              "Document is ${LeaveApplicationDataSource.selectedRowData.status} status and cannot be deleted"),
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
  _LeaveApplicationState _leaveApplicationState = _LeaveApplicationState();

  var formatter = new DateFormat('MM/dd/yyyy');

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  void selectStartDate() {
    DatePicker.showDatePicker(
      context,
      theme: DatePickerTheme(),
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime(2200),
      onConfirm: (date) {
        setState(() {
          fromDate = date;
          _LeaveApplicationState.fromDateController.text =
              formatter.format(fromDate);
          _LeaveApplicationState.totDaysController.text =
              (toDate.difference(fromDate).inDays + 1).toString();
        });
      },
    );
  }

  void selectEndDate() {
    DatePicker.showDatePicker(
      context,
      theme: DatePickerTheme(),
      showTitleActions: true,
      minTime: fromDate,
      maxTime: DateTime(2200),
      onConfirm: (date) {
        setState(() {
          toDate = date;
          _LeaveApplicationState.toDateController.text =
              formatter.format(toDate);
          _LeaveApplicationState.totDaysController.text =
              (toDate.difference(fromDate).inDays + 1).toString();
        });
      },
    );
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
        _LeaveApplicationState.fromDateController.text =
            formatter.format(fromDate);
        _LeaveApplicationState.totDaysController.text =
            (toDate.difference(fromDate).inDays + 1).toString();
      });
  }

  Future<Null> _selectToDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: toDate.difference(fromDate).inDays < 0 ? fromDate : toDate,
      firstDate: fromDate,
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        toDate = picked;
        _LeaveApplicationState.toDateController.text = formatter.format(toDate);
        _LeaveApplicationState.totDaysController.text =
            (toDate.difference(fromDate).inDays + 1).toString();
      });
  }

  DateTime specifyWorkDate = DateTime.now();

  Future<Null> _selectWorkDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: specifyWorkDate.difference(toDate).inDays < 0
          ? toDate
          : specifyWorkDate,
      firstDate: toDate,
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        specifyWorkDate = picked;
        _LeaveApplicationState.workingDayController.text =
            formatter.format(specifyWorkDate);
      });
  }

  DateTime applicationDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      _LeaveApplicationState.selectedEmp = _LeaveApplicationState.editClicked
          ? LeaveApplicationDataSource.selectedRowData.employeeNo
          : _LeaveApplicationState.empNo[0];
      _LeaveApplicationState.empNameController.text =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource.selectedRowData.employeeName
              : _LeaveApplicationState.empName[_LeaveApplicationState.empNo
                  .indexOf(_LeaveApplicationState.selectedEmp)];

      _LeaveApplicationState.selectedLeaveCode =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource.selectedRowData.leaveCode
              : _LeaveApplicationState.leaveCode[0];
      _LeaveApplicationState.leaveDescripController.text =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource.selectedRowData.leaveDescription
              : _LeaveApplicationState.leaveDescription[_LeaveApplicationState
                  .leaveCode
                  .indexOf(_LeaveApplicationState.selectedLeaveCode)];

      _LeaveApplicationState.selectedLeaveDuration =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource.selectedRowData.leaveDuration
              : _leaveApplicationState.leaveDuration[0];

      _LeaveApplicationState.fromDateController.text =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource.selectedRowData.fromDate
              : "";
      _LeaveApplicationState.toDateController.text =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource.selectedRowData.toDate
              : "";
      _LeaveApplicationState.totDaysController.text =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource.selectedRowData.noOfDays.toString()
              : "";
      _LeaveApplicationState.leaveReasonController.text =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource.selectedRowData.reasonForLeave
              : "";
      _LeaveApplicationState.contactDetailsController.text =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource
                  .selectedRowData.contactDetailsLeavePeriod
                  .toString()
              : "";
      _LeaveApplicationState.workingDayController.text =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource.selectedRowData.specifyWorkingDay
              : "";
      _LeaveApplicationState.apprDateTimeController.text =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource
                  .selectedRowData.sendForApprovalDateTime
              : "";

      _LeaveApplicationState.selectedStatus = _LeaveApplicationState.editClicked
          ? LeaveApplicationDataSource.selectedRowData.status
          : _leaveApplicationState.statusList[0];

      _LeaveApplicationState.cancellationConfirm = _LeaveApplicationState
              .editClicked
          ? (LeaveApplicationDataSource.selectedRowData.cancellationConfirmed ==
                  "1"
              ? true
              : false)
          : false;
      _LeaveApplicationState.applDateController.text =
          _LeaveApplicationState.editClicked
              ? LeaveApplicationDataSource.selectedRowData.applicationDate
              : formatter.format(applicationDate);

      if (_LeaveApplicationState.editClicked) {
        fromDate = DateFormat("yyyy-MM-dd")
            .parse(_LeaveApplicationState.fromDateController.text);
        toDate = DateFormat("yyyy-MM-dd")
            .parse(_LeaveApplicationState.toDateController.text);
      }
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
                        controller:
                            _LeaveApplicationState.cancelCommentController,
                        decoration: InputDecoration(
                            labelText: "Enter the cancellation comment"),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            if (_LeaveApplicationState
                                .cancelCommentController.text.isNotEmpty) {
                              Navigator.pop(context);
                              setState(() {
                                _LeaveApplicationState.selectedStatus =
                                    _leaveApplicationState.statusList[4];
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
                              _LeaveApplicationState.selectedStatus =
                                  _leaveApplicationState.statusList[1];
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
            visible: _LeaveApplicationState.editClicked,
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
                  value: _LeaveApplicationState.selectedEmp,
                  items: _LeaveApplicationState.empNo.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    debugPrint("Comment: " + newValue);
                    setState(() {
                      _LeaveApplicationState.selectedEmp = newValue;
                      _LeaveApplicationState.empNameController.text =
                          _LeaveApplicationState.empName[_LeaveApplicationState
                              .empNo
                              .indexOf(_LeaveApplicationState.selectedEmp)];
                    });
                  },
                ),
                ignoring: !_LeaveApplicationState.textFieldEnableStatus,
              )
            ],
          ),
          TextField(
            controller: _LeaveApplicationState.empNameController,
            decoration: InputDecoration(
              labelText: "Employee Name",
            ),
            enabled: false,
          ),
          Padding(padding: EdgeInsets.all(5)),
          Row(
            children: <Widget>[
              Text(
                "Leave Code : ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton(
                value: _LeaveApplicationState.selectedLeaveCode,
                items: _LeaveApplicationState.leaveCode.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  debugPrint("Comment: " + newValue);
                  setState(() {
                    _LeaveApplicationState.selectedLeaveCode = newValue;
                    _LeaveApplicationState.leaveDescripController.text =
                        _LeaveApplicationState.leaveDescription[
                            _LeaveApplicationState.leaveCode.indexOf(
                                _LeaveApplicationState.selectedLeaveCode)];
                  });
                },
              ),
            ],
          ),
          TextField(
            controller: _LeaveApplicationState.leaveDescripController,
            decoration: InputDecoration(
              labelText: "Leave Description",
            ),
            enabled: false,
          ),
          Padding(padding: EdgeInsets.all(5)),
          Row(
            children: <Widget>[
              Text(
                "Leave Duration : ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton(
                value: _LeaveApplicationState.selectedLeaveDuration,
                items: _leaveApplicationState.leaveDuration.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  debugPrint("Comment: " + newValue);
                  setState(() {
                    _LeaveApplicationState.selectedLeaveDuration = newValue;
                  });
                },
              ),
            ],
          ),
          TextField(
            controller: _LeaveApplicationState.fromDateController,
            decoration: InputDecoration(
              labelText: "From Date",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectFromDate(context);
            },
            enabled: _LeaveApplicationState.textFieldEnableStatus,
          ),
          TextField(
            controller: _LeaveApplicationState.toDateController,
            decoration: InputDecoration(
              labelText: "To Date",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectToDate(context);
            },
            enabled: _LeaveApplicationState.textFieldEnableStatus,
          ),
          TextField(
            controller: _LeaveApplicationState.totDaysController,
            decoration: InputDecoration(
              labelText: "Total Days",
            ),
            enabled: false,
          ),
          TextField(
            controller: _LeaveApplicationState.leaveReasonController,
            decoration: InputDecoration(
              labelText: "Reason for Leave",
            ),
            enabled: _LeaveApplicationState.textFieldEnableStatus,
          ),
          TextField(
            controller: _LeaveApplicationState.contactDetailsController,
            decoration: InputDecoration(
              labelText: "Contact Details",
            ),
            enabled: _LeaveApplicationState.textFieldEnableStatus,
          ),
          TextField(
            controller: _LeaveApplicationState.workingDayController,
            decoration: InputDecoration(
              labelText: "Specify Working Day",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectWorkDate(context);
            },
            enabled: _LeaveApplicationState.textFieldEnableStatus,
          ),
          TextField(
            controller: _LeaveApplicationState.apprDateTimeController,
            decoration: InputDecoration(
              labelText: "Send for Approval Date & Time",
            ),
            enabled: false,
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
                  value: _LeaveApplicationState.selectedStatus,
                  items: _leaveApplicationState.statusList.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _LeaveApplicationState.selectedStatus = newValue;
                    });
                  },
                ),
                ignoring: true,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Cancellation Confirmed",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IgnorePointer(
                child: Checkbox(
                  value: _LeaveApplicationState.cancellationConfirm,
                  onChanged: (bool value) {
                    setState(() {
                      _LeaveApplicationState.cancellationConfirm = value;
                    });
                  },
                ),
                ignoring: !_LeaveApplicationState.textFieldEnableStatus,
              )
            ],
          ),
          TextField(
            controller: _LeaveApplicationState.applDateController,
            decoration: InputDecoration(
              labelText: "Application Date",
            ),
            enabled: false,
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
