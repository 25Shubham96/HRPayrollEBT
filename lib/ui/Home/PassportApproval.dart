import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/PassportApprovalDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/PassportApprovalRequest.dart';
import 'package:hrpayroll/response_model/PassportApprovalResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:hrpayroll/ui/MyDrawer.dart';

class PassportApproval extends StatefulWidget {
  @override
  _PassportApprovalState createState() => _PassportApprovalState();
}

class _PassportApprovalState extends State<PassportApproval> {
  static List<PassportApprovalModel> newdata = new List();

  PassportApprovalDataSource _passportApprovalDataSource =
      PassportApprovalDataSource(newdata);

  Future<PassportApprovalResponse> updateResponse;

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ApiInterface _apiInterface = ApiInterface();

  String empNo = "";

  TextEditingController rejectionCommentControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    PassportApprovalRequest passportApprovalRequest = PassportApprovalRequest(
        action: "1",
        empApproverId: MyDrawer.empNo,
        status: "1",
        entryNo: "0000",
        sequenceNo: "0");

    updateResponse =
        _apiInterface.passportApprovalResponseData(passportApprovalRequest);
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
                      "Pending Passport List",
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
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: updateResponse,
              builder: (BuildContext context,
                  AsyncSnapshot<PassportApprovalResponse> snapshot) {
                if (snapshot.hasData) {
                  PassportApprovalResponse _myResponseData = snapshot.data;
                  _passportApprovalDataSource =
                      PassportApprovalDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 &&
                            _myResponseData.data.length > 0)
                        ? _myResponseData.data.length
                        : _rowsPerPage,
                    onSelectAll: _passportApprovalDataSource.selectAll,
                    header: new Text(""),
                    columns: [
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
                          "Transaction Id",
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
                    source: _passportApprovalDataSource,
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
                              "Transaction Id",
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
                        source: _passportApprovalDataSource,
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
    if (_passportApprovalDataSource.rowSelect) {
      var alert = AlertDialog(
        content: Text("Are you sure you want to Approve the document?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              Navigator.pop(context);
              PassportApprovalResponse passportApprovalResponse =
                  await _apiInterface.passportApprovalResponseData(
                PassportApprovalRequest(
                  action: "3",
                  status: "2",
                  modifiedBy: MyDrawer.empNo,
                  senderId: PassportApprovalDataSource.selectedRowData.senderId,
                  empApproverId: PassportApprovalDataSource
                      .selectedRowData.employeeApproverId,
                  entryNo: PassportApprovalDataSource.selectedRowData.entryNo
                      .toString(),
                  tableName:
                      PassportApprovalDataSource.selectedRowData.tableName,
                  documentType:
                      PassportApprovalDataSource.selectedRowData.documentType,
                  transactionId:
                      PassportApprovalDataSource.selectedRowData.transactionId,
                  sequenceNo: PassportApprovalDataSource
                      .selectedRowData.sequenceNo
                      .toString(),
                  approverId:
                      PassportApprovalDataSource.selectedRowData.approverId,
                  rejectionComment: PassportApprovalDataSource
                      .selectedRowData.commentRejection,
                  cancellationComment: PassportApprovalDataSource
                      .selectedRowData.commentCancellation,
                ),
              );

              if (passportApprovalResponse.status) {
                var alert = AlertDialog(
                  content: Text(passportApprovalResponse.message),
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
                  PassportApprovalRequest passportApprovalRequest =
                      PassportApprovalRequest(
                          action: "1",
                          empApproverId: MyDrawer.empNo,
                          status: "1",
                          entryNo: "0000",
                          sequenceNo: "0");

                  updateResponse = _apiInterface
                      .passportApprovalResponseData(passportApprovalRequest);
                });
              } else {
                Fluttertoast.showToast(
                  msg: "${passportApprovalResponse.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
                /*var alert = AlertDialog(
                  content: Text(passportApprovalResponse.message),
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
    if (_passportApprovalDataSource.rowSelect) {
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
                RejCanPostResponse RejCanResp =
                    await _apiInterface.passportRejCanResponseData(
                  PassportApprovalRequest(
                    action: "4",
                    status: "3",
                    modifiedBy: MyDrawer.empNo,
                    senderId:
                        PassportApprovalDataSource.selectedRowData.senderId,
                    empApproverId: PassportApprovalDataSource
                        .selectedRowData.employeeApproverId,
                    entryNo: PassportApprovalDataSource.selectedRowData.entryNo
                        .toString(),
                    tableName:
                        PassportApprovalDataSource.selectedRowData.tableName,
                    documentType:
                        PassportApprovalDataSource.selectedRowData.documentType,
                    transactionId: PassportApprovalDataSource
                        .selectedRowData.transactionId,
                    sequenceNo: PassportApprovalDataSource
                        .selectedRowData.sequenceNo
                        .toString(),
                    approverId:
                        PassportApprovalDataSource.selectedRowData.approverId,
                    rejectionComment: rejectionCommentControler.text,
                    cancellationComment: PassportApprovalDataSource
                        .selectedRowData.commentCancellation,
                  ),
                );

                if (RejCanResp.status) {
                  var alert = AlertDialog(
                    content: Text(RejCanResp.message),
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
                    PassportApprovalRequest passportApprovalRequest =
                        PassportApprovalRequest(
                            action: "1",
                            empApproverId: MyDrawer.empNo,
                            status: "1",
                            entryNo: "0000",
                            sequenceNo: "0");

                    updateResponse = _apiInterface
                        .passportApprovalResponseData(passportApprovalRequest);
                  });
                } else {
                  Fluttertoast.showToast(
                    msg: "${RejCanResp.message}",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                  );
                  /*var alert = AlertDialog(
                    content: Text(RejCanResp.message),
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
