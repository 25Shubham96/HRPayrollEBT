import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/PassportApproveListDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/Network/Utils.dart';
import 'package:hrpayroll/request_model/ApproveListRequest.dart';
import 'package:hrpayroll/request_model/PassportApprovalRequest.dart';
import 'package:hrpayroll/response_model/PassportApproveListResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassportApproveList extends StatefulWidget {
  @override
  _PassportApproveListState createState() => _PassportApproveListState();
}

class _PassportApproveListState extends State<PassportApproveList> {

  Future<PassportApproveListResponse> updateTableResponse;
  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();

  static List<PassportApproveListModel> data = List();
  PassportApproveListDataSource _passportApproveListDataSource =
  PassportApproveListDataSource(data);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  static String empNo = "";

  var selectedStatus = "";
  final List<String> statusList = ["", "Approved", "Rejected", "Cancelled"];

  TextEditingController cancelCommentController = TextEditingController();

  bool approveClick = false;

  void getSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getString(Util.userName);
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();

    selectedStatus = statusList[0];

    setState(() {
      updateTableResponse =
              _apiInterface1.passportApproveListResponseData(ApproveListRequest(
                action: 2,
                senderId: empNo,
                status: 5,
              ));
    });
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
                      "Passport Approve List",
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
                        Text(
                          "Status : ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton(
                          value: selectedStatus,
                          items: statusList.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              selectedStatus = newValue;
                              if (statusList.indexOf(selectedStatus) == 1) {
                                setState(() {
                                  approveClick = true;
                                });
                              } else {
                                setState(() {
                                  approveClick = false;
                                });
                              }
                              if (statusList.indexOf(selectedStatus) != 0) {
                                updateTableResponse =
                                        _apiInterface1.passportApproveListResponseData(
                                                ApproveListRequest(
                                                  action: 2,
                                                  senderId: empNo,
                                                  status:
                                                  statusList.indexOf(selectedStatus) + 1,
                                                ));
                              } else {
                                updateTableResponse =
                                        _apiInterface1.passportApproveListResponseData(ApproveListRequest(
                                          action: 2,
                                          senderId: empNo,
                                          status: 5,
                                        ));
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Visibility(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: FlatButton(
                              onPressed: () async {
                                if (_passportApproveListDataSource.rowSelect) {
                                  var alert = AlertDialog(
                                    content: TextField(
                                      controller: cancelCommentController,
                                      decoration: InputDecoration(
                                              labelText:
                                              "Enter the cancellation comment"),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () async {
                                          if (cancelCommentController
                                                  .text.isEmpty) {
                                            Fluttertoast.showToast(
                                              msg:
                                              "Cancellation comment is compulsory",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                            );
                                          } else {
                                            Navigator.pop(context);
                                            RejCanPostResponse rejCanResponse =
                                            await _apiInterface2
                                                    .passportRejCanResponseData(
                                                    PassportApprovalRequest(
                                                      action: "5",
                                                      sequenceNo: "0",
                                                      senderId:
                                                      PassportApproveListDataSource
                                                              .selectedRowData.senderId,
                                                      status: "4",
                                                      transactionId: PassportApproveListDataSource
                                                              .selectedRowData.transactionId,
                                                      cancellationComment:
                                                      cancelCommentController.text,
                                                    ));

                                            if (rejCanResponse.status) {
                                              setState(() {
                                                updateTableResponse = _apiInterface1
                                                        .passportApproveListResponseData(
                                                        ApproveListRequest(
                                                          action: 2,
                                                          senderId: empNo,
                                                          status: statusList.indexOf(
                                                                  selectedStatus) +
                                                                  1,
                                                        ));
                                              });
                                            }
                                            Fluttertoast.showToast(
                                              msg: "${rejCanResponse.message}",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                            );
                                            /*var alert = AlertDialog(
                                                content: Text(
                                                    rejCanResponse.message));
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
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  new Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              color: Colors.red,
                            ),
                          ),
                          visible: approveClick,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: updateTableResponse,
              builder: (BuildContext context, AsyncSnapshot<PassportApproveListResponse> snapshot) {
                if(snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                  PassportApproveListResponse _myResponseData = snapshot.data;
                  _passportApproveListDataSource = PassportApproveListDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 && _myResponseData.data.length > 0) ? _myResponseData.data.length : _rowsPerPage,
                    onSelectAll: _passportApproveListDataSource.selectAll,
                    header: Text(""),
                    columns: [
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
                          "Document Code",
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
                          "Sender ID",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Emp Approver ID",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Approver ID",
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
                          "Modified by",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Comment Rejection",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Comment Cancellation",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                    ],
                    source: _passportApproveListDataSource,
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
                        onSelectAll: _passportApproveListDataSource.selectAll,
                        header: Text(""),
                        columns: [
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
                              "Document Code",
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
                              "Sender ID",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Emp Approver ID",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Approver ID",
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
                              "Modified by",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Comment Rejection",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Comment Cancellation",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                        ],
                        source: _passportApproveListDataSource,
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
}
