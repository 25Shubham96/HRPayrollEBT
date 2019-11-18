import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/LeaveApprovalDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/Network/Utils.dart';
import 'package:hrpayroll/request_model/LeaveApprovalRequest.dart';
import 'package:hrpayroll/response_model/LeaveApprovalResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:hrpayroll/ui/MyDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveApproval extends StatefulWidget {
  @override
  _LeaveApprovalState createState() => _LeaveApprovalState();
}

class _LeaveApprovalState extends State<LeaveApproval> {
  static List<LeaveApprovalModel> newdata = new List();

  LeaveApprovalDataSource _leaveApprovalDataSource =
      LeaveApprovalDataSource(newdata);

  Future<LeaveApprovalResponse> updateResponse;

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ApiInterface _apiInterface = ApiInterface();

  String empNo = "";

  List<String> docType = [
    "",
    "Leave Application",
    "Compensatory Off",
    "Out of Office",
    "Business Trip"
  ];

  TextEditingController rejectionCommentControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    /*SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getString(Util.userName);*/

    LeaveApprovalRequest leaveApprovalRequest = LeaveApprovalRequest(
        action: "1", empApproverId: MyDrawer.empNo, status: "1");

    updateResponse =
        _apiInterface.leaveApprovalResponseData(leaveApprovalRequest);
  }

  void getEmployeeNo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getString(Util.userName);
  }

  @override
  Widget build(BuildContext context) {
    /*getEmployeeNo();
    LeaveApprovalRequest leaveApprovalRequest = LeaveApprovalRequest(
        action: "1", empApproverId: MyDrawer.EmpNo, status: "1");*/

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
                      "Pending Leave List",
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
                              onApprove(context);
                            },
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                                new Text(
                                  "Approve",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            color: Colors.green,
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.only(left: 10)),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              onReject(context);
                            },
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                                new Text(
                                  "Reject",
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
              future: updateResponse,
              builder: (BuildContext context,
                  AsyncSnapshot<LeaveApprovalResponse> snapshot) {
                if (snapshot.hasData) {
                  LeaveApprovalResponse _myResponseData = snapshot.data;
                  _leaveApprovalDataSource =
                      LeaveApprovalDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 &&
                            _myResponseData.data.length > 0)
                        ? _myResponseData.data.length
                        : _rowsPerPage,
                    onSelectAll: _leaveApprovalDataSource.selectAll,
                    header: new Text(""),
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
                          "Entry No",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Table Name",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Document Type",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Document Code",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Sequence",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Sender Id",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Emp Appr Id",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Appr Id",
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
                          "Modified By",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Rejection Comment",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Cancellation Comment",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                    source: _leaveApprovalDataSource,
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
                        header: new Text(""),
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
                              "Entry No",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Table Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Document Type",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Document Code",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Sequence",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Sender Id",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Emp Appr Id",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Appr Id",
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
                              "Modified By",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Rejection Comment",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Cancellation Comment",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        source: _leaveApprovalDataSource,
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

  void onApprove(BuildContext context) {
    if (_leaveApprovalDataSource.rowSelect) {
      var alert = AlertDialog(
        content: Text("Are you sure you want to Approve the document?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              Navigator.pop(context);
              LeaveApprovalResponse leaveApprovalResponse = await _apiInterface
                  .leaveApprovalResponseData(LeaveApprovalRequest(
                action: "3",
                status: "2",
                modifiedBy: MyDrawer.empNo,
                senderId: LeaveApprovalDataSource.selectedRowData.senderId,
                empApproverId:
                    LeaveApprovalDataSource.selectedRowData.employeeApproverId,
                entryNo:
                    LeaveApprovalDataSource.selectedRowData.entryNo.toString(),
                tableName: LeaveApprovalDataSource.selectedRowData.tableName,
                documentType:
                    "${docType.indexOf(LeaveApprovalDataSource.selectedRowData.documentType)}",
                documentNo: LeaveApprovalDataSource.selectedRowData.documentNo
                    .toString(),
                sequenceNo: LeaveApprovalDataSource.selectedRowData.sequenceNo
                    .toString(),
                approverId: LeaveApprovalDataSource.selectedRowData.approverId,
                fromDate: LeaveApprovalDataSource.selectedRowData.fromDate,
                toDate: LeaveApprovalDataSource.selectedRowData.toDate,
                rejectionComment:
                    LeaveApprovalDataSource.selectedRowData.commentRejection,
                cancellationComment:
                    LeaveApprovalDataSource.selectedRowData.commentCancellation,
              ));

              if (leaveApprovalResponse.status) {
                Fluttertoast.showToast(
                  msg: "${leaveApprovalResponse.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
                /*var alert = AlertDialog(
                  content: Text(leaveApprovalResponse.message),
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  },
                );*/
                setState(() {
                  LeaveApprovalRequest leaveApprovalRequest =
                      LeaveApprovalRequest(
                          action: "1",
                          empApproverId: MyDrawer.empNo,
                          status: "1");

                  updateResponse = _apiInterface
                      .leaveApprovalResponseData(leaveApprovalRequest);
                });
              } else {
                Fluttertoast.showToast(
                  msg: "${leaveApprovalResponse.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
                /*var alert = AlertDialog(
                  content: Text(leaveApprovalResponse.message),
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  },
                );*/
              }
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

  void onReject(BuildContext context) {
    if (_leaveApprovalDataSource.rowSelect) {
      rejectionCommentControler.text = "";
      var alert = AlertDialog(
        title: Text("Please enter the rejection comment"),
        content: Container(
          padding: EdgeInsets.all(5),
          child: TextField(
            controller: rejectionCommentControler,
            decoration: InputDecoration(
              hintText: "comment is compulsory",
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              if (rejectionCommentControler.text.isEmpty ||
                  rejectionCommentControler.text == " ") {
                var alert = AlertDialog(
                  content: Text("Please enter rejection comment..."),
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
              } else {
                Navigator.pop(context);
                RejCanPostResponse leaveRejCanResp = await _apiInterface
                    .leaveRejCanResponseData(LeaveApprovalRequest(
                  action: "4",
                  status: "3",
                  modifiedBy: MyDrawer.empNo,
                  senderId: LeaveApprovalDataSource.selectedRowData.senderId,
                  empApproverId: LeaveApprovalDataSource
                      .selectedRowData.employeeApproverId,
                  entryNo: LeaveApprovalDataSource.selectedRowData.entryNo
                      .toString(),
                  tableName: LeaveApprovalDataSource.selectedRowData.tableName,
                  documentType:
                      "${docType.indexOf(LeaveApprovalDataSource.selectedRowData.documentType)}",
                  documentNo: LeaveApprovalDataSource.selectedRowData.documentNo
                      .toString(),
                  sequenceNo: LeaveApprovalDataSource.selectedRowData.sequenceNo
                      .toString(),
                  approverId:
                      LeaveApprovalDataSource.selectedRowData.approverId,
                  fromDate: LeaveApprovalDataSource.selectedRowData.fromDate,
                  toDate: LeaveApprovalDataSource.selectedRowData.toDate,
                  rejectionComment: rejectionCommentControler.text,
                  cancellationComment: LeaveApprovalDataSource
                      .selectedRowData.commentCancellation,
                ));

                if (leaveRejCanResp.status) {
                  var alert = AlertDialog(
                    content: Text(leaveRejCanResp.message),
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
                  setState(() {
                    LeaveApprovalRequest leaveApprovalRequest =
                        LeaveApprovalRequest(
                            action: "1",
                            empApproverId: MyDrawer.empNo,
                            status: "1");

                    updateResponse = _apiInterface
                        .leaveApprovalResponseData(leaveApprovalRequest);
                  });
                } else {
                  Fluttertoast.showToast(
                    msg: "${leaveRejCanResp.message}",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                  );
                  /*var alert = AlertDialog(
                    content: Text(leaveRejCanResp.message),
                  );
                  showDialog(
                    context: context,
                    builder: (context) {
                      return alert;
                    },
                  );*/
                }
                debugPrint("onApproveYes");
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
        },
      );
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
