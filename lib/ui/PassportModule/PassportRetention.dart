import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/PassportRetentionDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/Network/Utils.dart';
import 'package:hrpayroll/request_model/PassportApprovalRequest.dart';
import 'package:hrpayroll/request_model/PassportRetentionRequest.dart';
import 'package:hrpayroll/request_model/PostRetentionRequest.dart';
import 'package:hrpayroll/request_model/UpdateObtainReleaseRequest.dart';
import 'package:hrpayroll/response_model/PassportRetentionResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:hrpayroll/response_model/RequisitionNoResponse.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassportRetention extends StatefulWidget {
  @override
  _PassportRetentionState createState() => _PassportRetentionState();
}

class _PassportRetentionState extends State<PassportRetention> {
  final List<String> statusList = [
    "Created",
    "Send For Approval",
    "Approved",
    "Rejected",
    "Cancelled"
  ];

  final List<String> requestType = ["Obtaining", "Releasing"];

  static List<String> transactionType;
  static List<String> empNo;
  static List<String> empName;
  static List<String> passportRetentionReq;
  static List<String> passportObtained;
  static List<String> passportReleased;

  static String transactionId;
  static String userId;

  static var selectedEmp = "",
      selectedRequestType = "",
      selectedTransactionType = "",
      selectedStatus = "",
      selectedReceEmpId = "";

  static TextEditingController transactionIdController =
      TextEditingController();
  static TextEditingController empNameController = TextEditingController();
  static TextEditingController passportNoController = TextEditingController();
  static TextEditingController receEmpNameController = TextEditingController();
  static TextEditingController expCollectionDateController =
      TextEditingController();
  static TextEditingController receivingTimeController =
      TextEditingController();
  static TextEditingController receTimeController = TextEditingController();
  static TextEditingController commentRemarkController =
      TextEditingController();
  static TextEditingController userIdController = TextEditingController();
  static TextEditingController expReturnDateController =
      TextEditingController();
  static TextEditingController cancelCommentController =
      TextEditingController();

  Future<PassportRetentionResponse> updateTableResponse;
  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();
  ApiInterface _apiInterface3 = ApiInterface();

  static List<PassportRetentionModel> data = List();
  PassportRetentionDataSource _passportRetentionDataSource =
      PassportRetentionDataSource(data);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  static bool textFieldEnableStatus = true;
  static bool editClicked = false;

  void getSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getStringList("empNo");
    empName = sharedPreferences.getStringList("empName");
    passportRetentionReq =
        sharedPreferences.getStringList("passportRetentionReq");
    passportObtained = sharedPreferences.getStringList("passportObtained");
    passportReleased = sharedPreferences.getStringList("passportReleased");
    transactionType = sharedPreferences.getStringList("transactionType");
    userId = sharedPreferences.getString(Util.userName);
  }

  static bool postReq = false;

  static String obtainedStatus = "",
      releasedStatus = "",
      requestTypeStatus = "";

  static String obtainedTxt = "", releasedTxt = "", empNoTxtPassObtRel = "";

  static bool wrongEmpCheck;

  static int postCheck = 0;

  @override
  void initState() {
    super.initState();
    PassportRetentionRequest passportRetentionRequest =
        PassportRetentionRequest(
      action: 1,
    );
    setState(() {
      updateTableResponse = _apiInterface1
          .passportRetentionResponseData(passportRetentionRequest);
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
                      "Passport Retention",
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
                  AsyncSnapshot<PassportRetentionResponse> snapshot) {
                if (snapshot.hasData) {
                  PassportRetentionResponse _myResponseData = snapshot.data;
                  _passportRetentionDataSource =
                      PassportRetentionDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 &&
                            _myResponseData.data.length > 0)
                        ? _myResponseData.data.length
                        : _rowsPerPage,
                    onSelectAll: _passportRetentionDataSource.selectAll,
                    header: Text(""),
                    columns: [
                      DataColumn(
                        label: new Text(
                          "Receipt Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Transaction ID",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Request Type",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Employee ID",
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
                          "Passport No",
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
                          "Receiving Emp ID",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Receiving Emp Name",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Receiving Time",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Comment/Remark",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Transaction Type",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "User ID",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Exp. Receipt Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                    source: _passportRetentionDataSource,
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
                        onSelectAll: _passportRetentionDataSource.selectAll,
                        header: Text(""),
                        columns: [
                          DataColumn(
                            label: new Text(
                              "Receipt Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Transaction ID",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Request Type",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Employee ID",
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
                              "Passport No",
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
                              "Receiving Emp ID",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Receiving Emp Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Receiving Time",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Comment/Remark",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Transaction Type",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "User ID",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Exp. Receipt Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        source: _passportRetentionDataSource,
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
              child: Text("New - Passport Retention"),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(2),
      content: DialogContent(),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            if (expCollectionDateController.text.isEmpty ||
                expReturnDateController.text.isEmpty ||
                receivingTimeController.text.isEmpty ||
                passportNoController.text.isEmpty ||
                commentRemarkController.text.isEmpty ||
                wrongEmpCheck ||
                (requestTypeStatus == "0" && obtainedStatus == "1") ||
                (requestTypeStatus == "1" && obtainedStatus == "0")) {
              if (wrongEmpCheck) {
                Fluttertoast.showToast(
                  msg:
                      "Employee is not selected for Passport Retention in Employee Master",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
              } else if ((requestTypeStatus == "0" && obtainedStatus == "1")) {
                Fluttertoast.showToast(
                  msg: "Passport is already obtained for the employee",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
              } else if ((requestTypeStatus == "1" && obtainedStatus == "0")) {
                Fluttertoast.showToast(
                  msg:
                      "Passport cannot be released, first you have to obtain the passport for the employee",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
              } else {
                Fluttertoast.showToast(
                  msg: "One or more blank entries",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
              }
            } else {
              Navigator.pop(context);
              PassportRetentionResponse passportRetentionResponse =
                  await _apiInterface2
                      .passportRetentionResponseData(PassportRetentionRequest(
                action: 2,
                transactionId: transactionIdController.text,
                requestType: requestType.indexOf(selectedRequestType),
                transactionType: selectedTransactionType,
                employeeId: selectedEmp,
                employeeName: empNameController.text,
                passportNo: passportNoController.text,
                receivingEmployeeNo: selectedReceEmpId,
                receivingEmployeeName: receEmpNameController.text,
                expectedColDate: expCollectionDateController.text,
                receivingTime: receivingTimeController.text,
                comment: commentRemarkController.text,
                status: statusList.indexOf(selectedStatus),
                userId: userIdController.text,
                returnDate: expReturnDateController.text,
              ));

              if (passportRetentionResponse.status) {
                PassportRetentionRequest passportRetentionRequest =
                    PassportRetentionRequest(
                  action: 1,
                );
                setState(() {
                  updateTableResponse = _apiInterface1
                      .passportRetentionResponseData(passportRetentionRequest);
                });
              }
              Fluttertoast.showToast(
                msg: "${passportRetentionResponse.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
              /*var alert =
              AlertDialog(content: Text(passportRetentionResponse.message));
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
    postCheck = 0;
    editClicked = true;

    if (_passportRetentionDataSource.rowSelect) {
      if (PassportRetentionDataSource.selectedRowData.status == statusList[0] ||
          PassportRetentionDataSource.selectedRowData.status == statusList[1] ||
          PassportRetentionDataSource.selectedRowData.status == statusList[2]) {
        if (PassportRetentionDataSource.selectedRowData.status ==
            statusList[1]) {
          textFieldEnableStatus = false;
          Fluttertoast.showToast(
            msg:
                "Document is ${PassportRetentionDataSource.selectedRowData.status} status and cannot be edited",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
        }

        var alert = AlertDialog(
          titlePadding: EdgeInsets.all(2),
          title: Center(
            child: Text("Edit - Passport Retention"),
          ),
          contentPadding: EdgeInsets.all(2),
          content: DialogContent(),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                if (expCollectionDateController.text.isEmpty ||
                    expReturnDateController.text.isEmpty ||
                    receivingTimeController.text.isEmpty ||
                    passportNoController.text.isEmpty ||
                    commentRemarkController.text.isEmpty ||
                    wrongEmpCheck ||
                    (requestTypeStatus == "0" && obtainedStatus == "1") ||
                    (requestTypeStatus == "1" && obtainedStatus == "0")) {
                  if (wrongEmpCheck) {
                    Fluttertoast.showToast(
                      msg:
                          "Employee is not selected for Passport Retention in Employee Master",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                  } else if ((requestTypeStatus == "0" &&
                      obtainedStatus == "1")) {
                    Fluttertoast.showToast(
                      msg: "Passport is already obtained for the employee",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                  } else if ((requestTypeStatus == "1" &&
                      obtainedStatus == "0")) {
                    Fluttertoast.showToast(
                      msg:
                          "Passport cannot be released, first you have to obtain the passport for the employee",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "One or more blank entries",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                  }
                } else {
                  if (requestTypeStatus == "0") {
                    obtainedTxt = "1";
                    releasedTxt = "0";
                    empNoTxtPassObtRel = _PassportRetentionState.selectedEmp;
                  }

                  if (requestTypeStatus == "1") {
                    obtainedTxt = "0";
                    releasedTxt = "1";
                    empNoTxtPassObtRel = _PassportRetentionState.selectedEmp;
                  }

                  Navigator.pop(context);
                  setState(() {
                    editClicked = false;
                  });

                  if (_PassportRetentionState.postCheck == 1) {
                    RejCanPostResponse rejCanResponse = await _apiInterface3
                        .postRetentionResponseData(PostRetentionRequest(
                      action: 2,
                      receiptDate: _PassportRetentionState
                          .expCollectionDateController.text,
                      transactionId:
                          _PassportRetentionState.transactionIdController.text,
                    ));

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

                    RejCanPostResponse rejCanResponse2 =
                        await _apiInterface1.updateObtainReleaseResponseData(
                            UpdateObtainReleaseRequest(
                      passportObtained: obtainedTxt,
                      passportReleased: releasedTxt,
                      employeeId: empNoTxtPassObtRel,
                    ));

                    PassportRetentionResponse passportRetentionResponse =
                        await _apiInterface2.passportRetentionResponseData(
                            PassportRetentionRequest(
                      action: 4,
                      transactionId: transactionId,
                    ));
                  } else {
                    if (selectedStatus == statusList[4]) {
                      RejCanPostResponse rejCanResponse = await _apiInterface3
                          .passportRejCanResponseData(PassportApprovalRequest(
                        action: "5",
                        sequenceNo: "0",
                        senderId: selectedEmp,
                        status: "4",
                        cancellationComment: cancelCommentController.text,
                        transactionId: transactionIdController.text,
                      ));

                      if (rejCanResponse.status) {
                        PassportRetentionRequest passportRetentionRequest =
                            PassportRetentionRequest(
                          action: 1,
                        );
                        setState(() {
                          updateTableResponse =
                              _apiInterface1.passportRetentionResponseData(
                                  passportRetentionRequest);
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
                      PassportRetentionResponse passportRetentionResponse =
                          await _apiInterface2.passportRetentionResponseData(
                              PassportRetentionRequest(
                        action: 3,
                        transactionId: transactionIdController.text,
                        requestType: requestType.indexOf(selectedRequestType),
                        transactionType: selectedTransactionType,
                        employeeId: selectedEmp,
                        employeeName: empNameController.text,
                        passportNo: passportNoController.text,
                        receivingEmployeeNo: selectedReceEmpId,
                        receivingEmployeeName: receivingTimeController.text,
                        expectedColDate: expCollectionDateController.text,
                        receivingTime: receivingTimeController.text,
                        comment: commentRemarkController.text,
                        status: statusList.indexOf(selectedStatus),
                        userId: userIdController.text,
                        returnDate: expReturnDateController.text,
                      ));

                      if (passportRetentionResponse.status) {
                        PassportRetentionRequest passportRetentionRequest =
                            PassportRetentionRequest(
                          action: 1,
                        );
                        setState(() {
                          updateTableResponse =
                              _apiInterface1.passportRetentionResponseData(
                                  passportRetentionRequest);
                        });
                      }
                      Fluttertoast.showToast(
                        msg: "${passportRetentionResponse.message}",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                      );
                      /*var alert = AlertDialog(
                          content: Text(passportRetentionResponse.message));
                      showDialog(
                        context: context,
                        builder: (context) {
                          return alert;
                        },
                      );*/
                    }
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
              "Document is ${PassportRetentionDataSource.selectedRowData.status} status and cannot be edited"),
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
        PassportRetentionDataSource.selectedRowData.selected = false;
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
    var transactionId =
        PassportRetentionDataSource.selectedRowData.transactionId.toString();
    if (_passportRetentionDataSource.rowSelect) {
      if (PassportRetentionDataSource.selectedRowData.status == statusList[0] ||
          PassportRetentionDataSource.selectedRowData.status == statusList[1]) {
        var alert = AlertDialog(
          content: Text("Are you sure you want to delete this entry!?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
                PassportRetentionResponse passportRetentionResponse =
                    await _apiInterface2
                        .passportRetentionResponseData(PassportRetentionRequest(
                  action: 4,
                  transactionId: transactionId,
                ));

                if (passportRetentionResponse.status) {
                  PassportRetentionRequest passportRetentionRequest =
                      PassportRetentionRequest(
                    action: 1,
                  );
                  setState(() {
                    updateTableResponse =
                        _apiInterface1.passportRetentionResponseData(
                            passportRetentionRequest);
                  });
                }
                Fluttertoast.showToast(
                  msg: "${passportRetentionResponse.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
                /*var alert =
                AlertDialog(content: Text(passportRetentionResponse.message));
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
              "Document is ${PassportRetentionDataSource.selectedRowData.status} status and cannot be deleted"),
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
  _PassportRetentionState _passportRetentionState = _PassportRetentionState();

  ApiInterface _apiInterface4 = ApiInterface();

  var formatter = new DateFormat('MM/dd/yyyy');
  DateTime expCollectionDate = DateTime.now();
  DateTime expReturnDate = DateTime.now();

  void getRequisitionNo() async {
    NoSeriesResponse seriesNoResponse =
        await _apiInterface4.transactionIdReasponseData();

    _PassportRetentionState.transactionIdController.text =
        seriesNoResponse.message;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (_PassportRetentionState.editClicked)
        _PassportRetentionState.transactionIdController.text =
            PassportRetentionDataSource.selectedRowData.transactionId;
      else
        getRequisitionNo();

      _PassportRetentionState.selectedRequestType =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.requestType
              : _passportRetentionState.requestType[0];
      _PassportRetentionState.selectedTransactionType =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.transactionType
              : _PassportRetentionState.transactionType[0];
      _PassportRetentionState.selectedEmp = _PassportRetentionState.editClicked
          ? PassportRetentionDataSource.selectedRowData.employeeId
          : _PassportRetentionState.empNo[0];
      _PassportRetentionState.empNameController.text =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.employeeName
              : _PassportRetentionState.empName[_PassportRetentionState.empNo
                  .indexOf(_PassportRetentionState.selectedEmp)];
      _PassportRetentionState.passportNoController.text =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.passportNo
              : "";
      _PassportRetentionState.selectedReceEmpId =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.receivingEmployeeId
              : _PassportRetentionState.empNo[0];
      _PassportRetentionState.receEmpNameController.text =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource
                  .selectedRowData.receivingEmployeeName
              : _PassportRetentionState.empName[_PassportRetentionState.empNo
                  .indexOf(_PassportRetentionState.selectedReceEmpId)];
      _PassportRetentionState.expCollectionDateController.text =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.dateOfReceipt
              : "";
      _PassportRetentionState.receTimeController.text =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.column1
              : "";
      _PassportRetentionState.commentRemarkController.text =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.commentRemarks
              : "";
      _PassportRetentionState.selectedStatus =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.status
              : _passportRetentionState.statusList[0];
      _PassportRetentionState.userIdController.text =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.userId
              : _PassportRetentionState.userId;
      _PassportRetentionState.expReturnDateController.text =
          _PassportRetentionState.editClicked
              ? PassportRetentionDataSource.selectedRowData.expectedReceiptDate
              : "";

      _PassportRetentionState.postReq =
          _PassportRetentionState.selectedStatus ==
                  _passportRetentionState.statusList[2]
              ? true
              : false;

      _PassportRetentionState.wrongEmpCheck = true;

      if(_PassportRetentionState.editClicked) {
        expCollectionDate = DateFormat("yyyy-MM-dd").parse(_PassportRetentionState.expCollectionDateController.text);
        expReturnDate = DateFormat("yyyy-MM-dd").parse(_PassportRetentionState.expReturnDateController.text);
      }
    });
  }

  Future<Null> _selectExpCollectionDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: expCollectionDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        expCollectionDate = picked;
        _PassportRetentionState.expCollectionDateController.text =
            formatter.format(expCollectionDate);
      });
  }

  Future<Null> _selectExpReturnDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: expReturnDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        expReturnDate = picked;
        _PassportRetentionState.expReturnDateController.text =
            formatter.format(expReturnDate);
      });
  }

  TimeOfDay receivingTime = TimeOfDay.now();

  Future<Null> _selectReceivingTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: receivingTime,
    );
    if (picked != null)
      setState(() {
        receivingTime = picked;
        _PassportRetentionState.receivingTimeController.text =
            receivingTime.hour.toString() +
                ":" +
                receivingTime.minute.toString() +
                ":00";
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
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      var alert = AlertDialog(
                        contentPadding: EdgeInsets.all(2),
                        content: TextField(
                          controller:
                              _PassportRetentionState.cancelCommentController,
                          decoration: InputDecoration(
                              labelText: "Enter the cancellation comment"),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              if (_PassportRetentionState
                                  .cancelCommentController.text.isNotEmpty) {
                                Navigator.pop(context);
                                setState(() {
                                  _PassportRetentionState.selectedStatus =
                                      _passportRetentionState.statusList[4];
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
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.cancel),
                        Text("Cancel Req")
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      var alert = AlertDialog(
                        content: Text(
                            "Are you sure you want to send for approval ?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                _PassportRetentionState.selectedStatus =
                                    _passportRetentionState.statusList[1];
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
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.send),
                        Text("Send for Appr")
                      ],
                    ),
                  ),
                ),
                IgnorePointer(
                  child: FlatButton(
                    onPressed: () {
                      var alert = AlertDialog(
                        content: Text(
                            "Are you sure you want to POST the document ?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                _PassportRetentionState.postCheck = 1;
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
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.lightGreen,
                        ),
                        Text("Post"),
                      ],
                    ),
                  ),
                  ignoring: !_PassportRetentionState.postReq,
                )
              ],
            ),
            visible: _PassportRetentionState.editClicked,
          ),
          TextField(
            controller: _PassportRetentionState.transactionIdController,
            decoration: InputDecoration(
              labelText: "Transaction ID",
            ),
            enabled: false,
          ),
          Padding(padding: EdgeInsets.all(5)),
          Row(
            children: <Widget>[
              Text(
                "Request Type : ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IgnorePointer(
                child: DropdownButton(
                  value: _PassportRetentionState.selectedRequestType,
                  items:
                      _passportRetentionState.requestType.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _PassportRetentionState.selectedRequestType = newValue;
                      _PassportRetentionState.requestTypeStatus =
                          _passportRetentionState.requestType
                              .indexOf(newValue)
                              .toString();
                    });
                  },
                ),
                ignoring: !_PassportRetentionState.textFieldEnableStatus,
              )
            ],
          ),
          Padding(padding: EdgeInsets.all(5)),
          Row(
            children: <Widget>[
              Text(
                "Transaction Type : ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IgnorePointer(
                child: DropdownButton(
                  value: _PassportRetentionState.selectedTransactionType,
                  items: _PassportRetentionState.transactionType
                      .map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _PassportRetentionState.selectedTransactionType =
                          newValue;
                    });
                  },
                ),
                ignoring: !_PassportRetentionState.textFieldEnableStatus,
              )
            ],
          ),
          Padding(padding: EdgeInsets.all(5)),
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
                  value: _PassportRetentionState.selectedEmp,
                  items: _PassportRetentionState.empNo.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    debugPrint("Comment: " + newValue);
                    setState(() {
                      _PassportRetentionState.selectedEmp = newValue;
                      _PassportRetentionState.empNameController.text =
                          _PassportRetentionState.empName[
                              _PassportRetentionState.empNo.indexOf(
                                  _PassportRetentionState.selectedEmp)];

                      if (identical(
                          _PassportRetentionState.passportRetentionReq[
                                  _PassportRetentionState.empNo
                                      .indexOf(newValue)]
                              .toString(),
                          "0"))
                        _PassportRetentionState.wrongEmpCheck = true;
                      else
                        _PassportRetentionState.wrongEmpCheck = false;

                      _PassportRetentionState.obtainedStatus =
                          _PassportRetentionState.passportObtained[
                              _PassportRetentionState.empNo.indexOf(newValue)];
                      _PassportRetentionState.releasedStatus =
                          _PassportRetentionState.passportReleased[
                              _PassportRetentionState.empNo.indexOf(newValue)];
                    });
                  },
                ),
                ignoring: !_PassportRetentionState.textFieldEnableStatus,
              )
            ],
          ),
          Visibility(
            child: MyBlinkingText(),
            visible: _PassportRetentionState.wrongEmpCheck,
          ),
          TextField(
            controller: _PassportRetentionState.empNameController,
            decoration: InputDecoration(
              labelText: "Employee Name",
            ),
            enabled: false,
          ),
          TextField(
            controller: _PassportRetentionState.passportNoController,
            decoration: InputDecoration(
              labelText: "Passport Number",
            ),
            enabled: _PassportRetentionState.textFieldEnableStatus,
          ),
          Padding(padding: EdgeInsets.all(5)),
          Row(
            children: <Widget>[
              Text(
                "Receving Emp ID. : ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IgnorePointer(
                child: DropdownButton(
                  value: _PassportRetentionState.selectedReceEmpId,
                  items: _PassportRetentionState.empNo.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    debugPrint("Comment: " + newValue);
                    setState(() {
                      _PassportRetentionState.selectedReceEmpId = newValue;
                      _PassportRetentionState.receEmpNameController.text =
                          _PassportRetentionState.empName[
                              _PassportRetentionState.empNo.indexOf(
                                  _PassportRetentionState.selectedReceEmpId)];
                    });
                  },
                ),
                ignoring: !_PassportRetentionState.textFieldEnableStatus,
              )
            ],
          ),
          TextField(
            controller: _PassportRetentionState.receEmpNameController,
            decoration: InputDecoration(
              labelText: "Receiving Emp Name",
            ),
            enabled: false,
          ),
          TextField(
            controller: _PassportRetentionState.expCollectionDateController,
            decoration: InputDecoration(
              labelText: "Expected Collection Date",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectExpCollectionDate(context);
            },
            enabled: _PassportRetentionState.textFieldEnableStatus,
          ),
          TextField(
            controller: _PassportRetentionState.receivingTimeController,
            decoration: InputDecoration(
              labelText: "Receiving Time",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectReceivingTime(context);
            },
            enabled: _PassportRetentionState.textFieldEnableStatus,
          ),
          TextField(
            controller: _PassportRetentionState.commentRemarkController,
            decoration: InputDecoration(
              labelText: "Comment/Remarks",
            ),
            enabled: _PassportRetentionState.textFieldEnableStatus,
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
                  value: _PassportRetentionState.selectedStatus,
                  items: _passportRetentionState.statusList.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _PassportRetentionState.selectedStatus = newValue;
                    });
                  },
                ),
                ignoring: true,
              )
            ],
          ),
          TextField(
            controller: _PassportRetentionState.userIdController,
            decoration: InputDecoration(
              labelText: "User ID",
            ),
            enabled: false,
          ),
          TextField(
            controller: _PassportRetentionState.expReturnDateController,
            decoration: InputDecoration(
              labelText: "Expected Return Date",
            ),
            enableInteractiveSelection: false,
            focusNode: NoKeyboardEditableTextFocusNode(),
            onTap: () {
              _selectExpReturnDate(context);
            },
            enabled: _PassportRetentionState.textFieldEnableStatus,
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

class MyBlinkingText extends StatefulWidget {
  @override
  _MyBlinkingTextState createState() => _MyBlinkingTextState();
}

class _MyBlinkingTextState extends State<MyBlinkingText>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Text(
        "emp not valid for retention",
        style: TextStyle(
          fontSize: 11,
          color: Colors.red,
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
