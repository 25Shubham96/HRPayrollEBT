import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/AssessmentApprovalDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/AssessmentApprovalRequest.dart';
import 'package:hrpayroll/response_model/AssessmentApprovalResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:hrpayroll/ui/MyDrawer.dart';

class AssessmentApproval extends StatefulWidget {
  @override
  _AssessmentApprovalState createState() => _AssessmentApprovalState();
}

class _AssessmentApprovalState extends State<AssessmentApproval> {
  static List<AssessmentApprovalModel> newdata = new List();

  AssessmentApprovalDataSource _assessmentApprovalDataSource =
  AssessmentApprovalDataSource(newdata);

  Future<AssessmentApprovalResponse> updateResponse;

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ApiInterface _apiInterface = ApiInterface();

  String empNo = "";

  TextEditingController rejectionCommentControler = TextEditingController();

  @override
  void initState() {
    super.initState();

    AssessmentApprovalRequest assessmentApprovalRequest =
    AssessmentApprovalRequest(
            action: "1", empApproverId: MyDrawer.EmpNo, status: "1");

    updateResponse =
            _apiInterface.assessmentApprovalResponseData(assessmentApprovalRequest);
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
                      "Pending Assessment List",
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
                      AsyncSnapshot<AssessmentApprovalResponse> snapshot) {
                if (snapshot.hasData) {
                  AssessmentApprovalResponse _myResponseData = snapshot.data;
                  _assessmentApprovalDataSource =
                          AssessmentApprovalDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 && _myResponseData.data.length > 0) ? _myResponseData.data.length : _rowsPerPage,
                    onSelectAll: _assessmentApprovalDataSource.selectAll,
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
                          "Document Type",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Requisition No",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Requisition Date",
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
                    ],
                    source: _assessmentApprovalDataSource,
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
                              "Document Type",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Requisition No",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Requisition Date",
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
                        ],
                        source: _assessmentApprovalDataSource,
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
    if (_assessmentApprovalDataSource.rowSelect) {
      var alert = AlertDialog(
        content: Text("Are you sure you want to Approve the document?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              Navigator.pop(context);
              AssessmentApprovalResponse assessmentApprovalResponse =
              await _apiInterface.assessmentApprovalResponseData(
                      AssessmentApprovalRequest(
                        action: "3",
                        status: "2",
                        requisitionDate: AssessmentApprovalDataSource
                                .selectedRowData.requisitionDate,
                        requisitionNo:
                        AssessmentApprovalDataSource.selectedRowData.requisitionNo,
                        modifiedBy: MyDrawer.EmpNo,
                        senderId: AssessmentApprovalDataSource.selectedRowData.senderId,
                        empApproverId: AssessmentApprovalDataSource
                                .selectedRowData.employeeApproverId,
                        approverId:
                        AssessmentApprovalDataSource.selectedRowData.approverId,
                        entryNo: AssessmentApprovalDataSource.selectedRowData.entryNo
                                .toString(),
                        tableName:
                        AssessmentApprovalDataSource.selectedRowData.tableName,
                        documentType:
                        AssessmentApprovalDataSource.selectedRowData.documentType,
                        documentNo: "",
                        sequenceNo: AssessmentApprovalDataSource
                                .selectedRowData.sequenceNo
                                .toString(),
                        rejectionComment: AssessmentApprovalDataSource
                                .selectedRowData.commentRejection,
                        cancellationComment: AssessmentApprovalDataSource
                                .selectedRowData.commentCancellation,
                      ));

              if (assessmentApprovalResponse.status) {
                Fluttertoast.showToast(
                  msg: "${assessmentApprovalResponse.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
                /*var alert = AlertDialog(
                  content: Text(assessmentApprovalResponse.message),
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  },
                );*/
                setState(() {
                  AssessmentApprovalRequest assessmentApprovalRequest =
                  AssessmentApprovalRequest(
                          action: "1",
                          empApproverId: MyDrawer.EmpNo,
                          status: "1");

                  updateResponse = _apiInterface.assessmentApprovalResponseData(
                          assessmentApprovalRequest);
                });
              } else {
                Fluttertoast.showToast(
                  msg: "${assessmentApprovalResponse.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
                /*var alert = AlertDialog(
                  content: Text(assessmentApprovalResponse.message),
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
    if (_assessmentApprovalDataSource.rowSelect) {
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
                RejCanPostResponse leaveRejCanResp =
                await _apiInterface.assessmentRejCanResponseData(
                        AssessmentApprovalRequest(
                          action: "4",
                          status: "3",
                          requisitionDate: AssessmentApprovalDataSource
                                  .selectedRowData.requisitionDate,
                          requisitionNo: AssessmentApprovalDataSource
                                  .selectedRowData.requisitionNo,
                          modifiedBy: MyDrawer.EmpNo,
                          senderId:
                          AssessmentApprovalDataSource.selectedRowData.senderId,
                          empApproverId: AssessmentApprovalDataSource
                                  .selectedRowData.employeeApproverId,
                          entryNo: AssessmentApprovalDataSource.selectedRowData.entryNo
                                  .toString(),
                          tableName:
                          AssessmentApprovalDataSource.selectedRowData.tableName,
                          documentType:
                          AssessmentApprovalDataSource.selectedRowData.documentType,
                          documentNo: "",
                          sequenceNo: AssessmentApprovalDataSource
                                  .selectedRowData.sequenceNo
                                  .toString(),
                          approverId:
                          AssessmentApprovalDataSource.selectedRowData.approverId,
                          rejectionComment: rejectionCommentControler.text,
                          cancellationComment: AssessmentApprovalDataSource
                                  .selectedRowData.commentCancellation,
                        ));

                if (leaveRejCanResp.status) {
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
                  setState(() {
                    AssessmentApprovalRequest assessmentApprovalRequest =
                    AssessmentApprovalRequest(
                            action: "1",
                            empApproverId: MyDrawer.EmpNo,
                            status: "1");

                    updateResponse =
                            _apiInterface.assessmentApprovalResponseData(
                                    assessmentApprovalRequest);
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
