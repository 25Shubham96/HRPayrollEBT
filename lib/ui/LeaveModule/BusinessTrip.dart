import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/BusinessTripDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/BusinessTripRequest.dart';
import 'package:hrpayroll/request_model/LeaveApprovalRequest.dart';
import 'package:hrpayroll/response_model/BusinessTripResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessTrip extends StatefulWidget {
  @override
  _BusinessTripState createState() => _BusinessTripState();
}

class _BusinessTripState extends State<BusinessTrip> {
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
  static TextEditingController departmentController = TextEditingController();
  static TextEditingController fromDateController = TextEditingController();
  static TextEditingController toDateController = TextEditingController();
  static TextEditingController leaveReasonController = TextEditingController();
  static TextEditingController cancelCommentController =
  TextEditingController();

  Future<BusinessTripResponse> updateTableResponse;
  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();
  ApiInterface _apiInterface3 = ApiInterface();

  static List<BusinessTripModel> data = List();
  BusinessTripDataSource _businessTripDataSource = BusinessTripDataSource(data);

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
    BusinessTripRequest businessTripRequest = BusinessTripRequest(
      action: 1,
    );
    setState(() {
      updateTableResponse =
              _apiInterface1.businessTripResponseData(businessTripRequest);
    });

    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: new EdgeInsets.all(5),
              child: new Column(
                children: <Widget>[
                  new Center(
                    child: new Text(
                      "Business Trip List",
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
                      AsyncSnapshot<BusinessTripResponse> snapshot) {
                if (snapshot.hasData) {
                  BusinessTripResponse _myResponseData = snapshot.data;
                  _businessTripDataSource =
                          BusinessTripDataSource(_myResponseData.data);
                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 && _myResponseData.data.length > 0) ? _myResponseData.data.length : _rowsPerPage,
                    onSelectAll: _businessTripDataSource.selectAll,
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
                          "Reason",
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
                          "Status",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                    ],
                    source: _businessTripDataSource,
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
                        onSelectAll: _businessTripDataSource.selectAll,
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
                              "Reason",
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
                              "Status",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                        ],
                        source: _businessTripDataSource,
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
              child: Text("New - Business Trip"),
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
                    leaveReasonController.text.isEmpty) {
              Fluttertoast.showToast(
                msg: "One or more blank entries",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            } else {
              Navigator.pop(context);
              BusinessTripResponse businessTripResponse =
              await _apiInterface2.businessTripResponseData(
                      BusinessTripRequest(
                        action: 2,
                        employeeNo: selectedEmp,
                        employeeName: empNameController.text,
                        department: departmentController.text,
                        fromDate: fromDateController.text,
                        toDate: toDateController.text,
                        reason: leaveReasonController.text,
                        status: statusList.indexOf(selectedStatus),
                      ));

              if (businessTripResponse.status) {
                BusinessTripRequest businessTripRequest = BusinessTripRequest(
                  action: 1,
                );
                setState(() {
                  updateTableResponse = _apiInterface1.businessTripResponseData(
                          businessTripRequest);
                });
              }

              Fluttertoast.showToast(
                msg: "${businessTripResponse.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
              /*var alert =
              AlertDialog(content: Text(businessTripResponse.message));
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

    var entryNo = BusinessTripDataSource.selectedRowData.entryNo.toString();

    if (_businessTripDataSource.rowSelect) {
      if (BusinessTripDataSource.selectedRowData.status == statusList[0] ||
              BusinessTripDataSource.selectedRowData.status == statusList[1]) {
        if (BusinessTripDataSource.selectedRowData.status == statusList[1]) {
          textFieldEnableStatus = false;
          Fluttertoast.showToast(
            msg:
            "Document is ${BusinessTripDataSource.selectedRowData.status} status and cannot be edited",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
        }

        var alert = AlertDialog(
          titlePadding: EdgeInsets.all(2),
          title: Center(
            child: Text("Edit - Business Trip"),
          ),
          contentPadding: EdgeInsets.all(2),
          content: DialogContent(),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                if (fromDateController.text.isEmpty ||
                        toDateController.text.isEmpty ||
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
                              documentType: "4",
                              sequenceNo: "0",
                              senderId: selectedEmp,
                              status: "4",
                              fromDate: fromDateController.text,
                              cancellationComment: cancelCommentController.text,
                            ));

                    if (rejCanResponse.status) {
                      BusinessTripRequest businessTripRequest =
                      BusinessTripRequest(
                        action: 1,
                      );
                      setState(() {
                        updateTableResponse =
                                _apiInterface1.businessTripResponseData(
                                        businessTripRequest);
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
                    BusinessTripResponse businessTripResponse =
                    await _apiInterface2.businessTripResponseData(
                            BusinessTripRequest(
                              action: 3,
                              employeeNo: selectedEmp,
                              employeeName: empNameController.text,
                              department: departmentController.text,
                              fromDate: fromDateController.text,
                              toDate: toDateController.text,
                              reason: leaveReasonController.text,
                              status: statusList.indexOf(selectedStatus),
                              entryNo: entryNo,
                            ));

                    if (businessTripResponse.status) {
                      BusinessTripRequest businessTripRequest =
                      BusinessTripRequest(
                        action: 1,
                      );
                      setState(() {
                        updateTableResponse =
                                _apiInterface1.businessTripResponseData(
                                        businessTripRequest);
                      });
                    }
                    Fluttertoast.showToast(
                      msg: "${businessTripResponse.message}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                    /*var alert = AlertDialog(
                        content: Text(businessTripResponse.message));
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
                  "Document is ${BusinessTripDataSource.selectedRowData.status} status and cannot be edited"),
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
        BusinessTripDataSource.selectedRowData.selected = false;
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
    var entryNo = BusinessTripDataSource.selectedRowData.entryNo.toString();
    if (_businessTripDataSource.rowSelect) {
      if (BusinessTripDataSource.selectedRowData.status == statusList[0] ||
              BusinessTripDataSource.selectedRowData.status == statusList[1]) {
        var alert = AlertDialog(
          content: Text("Are you sure you want to delete this entry!?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
                BusinessTripResponse businessTripResponse =
                await _apiInterface2.businessTripResponseData(
                        BusinessTripRequest(
                          action: 4,
                          entryNo: entryNo,
                        ));

                if (businessTripResponse.status) {
                  BusinessTripRequest businessTripRequest = BusinessTripRequest(
                    action: 1,
                  );
                  setState(() {
                    updateTableResponse =
                            _apiInterface1.businessTripResponseData(
                                    businessTripRequest);
                  });
                }

                var alert =
                AlertDialog(
                  content: Text(businessTripResponse.message),
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
                  "Document is ${BusinessTripDataSource.selectedRowData.status} status and cannot be deleted"),
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
  _BusinessTripState _businessTripState = _BusinessTripState();

  @override
  void initState() {
    super.initState();
    setState(() {
      _BusinessTripState.selectedEmp = _BusinessTripState.editClicked
              ? BusinessTripDataSource.selectedRowData.employeeNo
              : _BusinessTripState.empNo[0];
      _BusinessTripState.empNameController.text = _BusinessTripState.editClicked
              ? BusinessTripDataSource.selectedRowData.employeeName
              : _BusinessTripState.empName[
      _BusinessTripState.empNo.indexOf(_BusinessTripState.selectedEmp)];
      _BusinessTripState.departmentController.text = _BusinessTripState
              .editClicked
              ? BusinessTripDataSource.selectedRowData.department
              : _BusinessTripState.empDepartment[
      _BusinessTripState.empNo.indexOf(_BusinessTripState.selectedEmp)];

      _BusinessTripState.selectedStatus = _BusinessTripState.editClicked
              ? BusinessTripDataSource.selectedRowData.status
              : _businessTripState.statusList[0];

      _BusinessTripState.fromDateController.text =
      _BusinessTripState.editClicked
              ? BusinessTripDataSource.selectedRowData.fromDate
              : "";
      _BusinessTripState.toDateController.text = _BusinessTripState.editClicked
              ? BusinessTripDataSource.selectedRowData.toDate
              : "";
      _BusinessTripState.leaveReasonController.text =
      _BusinessTripState.editClicked
              ? BusinessTripDataSource.selectedRowData.reasonForTrip
              : "";
    });
  }

  var formatter = new DateFormat('MM/dd/yyyy');

  DateTime fromDate = DateTime.now();

  Future<Null> _selectFromTime(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: fromDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        fromDate = picked;
        _BusinessTripState.fromDateController.text = formatter.format(fromDate);
      });
  }

  DateTime toDate = DateTime.now();

  Future<Null> _selectToTime(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: toDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        toDate = picked;
        _BusinessTripState.toDateController.text = formatter.format(toDate);
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
                        controller: _BusinessTripState.cancelCommentController,
                        decoration: InputDecoration(
                                labelText: "Enter the cancellation comment"),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            if (_BusinessTripState
                                    .cancelCommentController.text.isNotEmpty) {
                              Navigator.pop(context);
                              setState(() {
                                _BusinessTripState.selectedStatus =
                                _businessTripState.statusList[4];
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
                              _BusinessTripState.selectedStatus =
                              _businessTripState.statusList[1];
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
            visible: _BusinessTripState.editClicked,
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
                  value: _BusinessTripState.selectedEmp,
                  items: _BusinessTripState.empNo.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    debugPrint("Comment: " + newValue);
                    setState(() {
                      _BusinessTripState.selectedEmp = newValue;
                      _BusinessTripState.empNameController.text =
                      _BusinessTripState.empName[_BusinessTripState.empNo
                              .indexOf(_BusinessTripState.selectedEmp)];
                      _BusinessTripState.departmentController.text =
                      _BusinessTripState.empDepartment[_BusinessTripState
                              .empNo
                              .indexOf(_BusinessTripState.selectedEmp)];
                    });
                  },
                ),
                ignoring: !_BusinessTripState.textFieldEnableStatus,
              )
            ],
          ),
          TextField(
            controller: _BusinessTripState.empNameController,
            decoration: InputDecoration(
              labelText: "Employee Name",
            ),
            enabled: false,
          ),
          TextField(
            controller: _BusinessTripState.departmentController,
            decoration: InputDecoration(
              labelText: "Department",
            ),
            enabled: false,
          ),
          TextField(
            controller: _BusinessTripState.fromDateController,
            decoration: InputDecoration(
              labelText: "From Date",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectFromTime(context);
            },
            enabled: _BusinessTripState.textFieldEnableStatus,
          ),
          TextField(
            controller: _BusinessTripState.toDateController,
            decoration: InputDecoration(
              labelText: "To Date",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectToTime(context);
            },
            enabled: _BusinessTripState.textFieldEnableStatus,
          ),
          TextField(
            controller: _BusinessTripState.leaveReasonController,
            decoration: InputDecoration(
              labelText: "Reason for Trip",
            ),
            enabled: _BusinessTripState.textFieldEnableStatus,
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
                  value: _BusinessTripState.selectedStatus,
                  items: _businessTripState.statusList.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _BusinessTripState.selectedStatus = newValue;
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
