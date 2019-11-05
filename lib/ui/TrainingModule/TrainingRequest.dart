import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/TrainingReqSubformDataSource.dart';
import 'package:hrpayroll/DataSource/TrainingRequestDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/TrainingApprovalRequest.dart';
import 'package:hrpayroll/request_model/TrainingReqRequest.dart';
import 'package:hrpayroll/request_model/TrainingReqSubformRequest.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:hrpayroll/response_model/RequisitionNoResponse.dart';
import 'package:hrpayroll/response_model/TrainingReqResponse.dart';
import 'package:hrpayroll/response_model/TrainingReqSubformResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainingRequest extends StatefulWidget {
  @override
  _TrainingRequestState createState() => _TrainingRequestState();
}

class _TrainingRequestState extends State<TrainingRequest> {

  final List<String> statusList = [
    "Created",
    "Send for Approval",
    "Approved",
    "Rejected",
    "Cancelled"];
  final List<String> requestType = ["Internal", "External"];

  static List<String> empNo;
  static List<String> empName;
  static List<String> empDepartment;
  static List<String> trainingCourse;
  static List<String> trainingCourseTitle;

  static var selectedEmp = "", selectedStatus = "", selectedRequestType = "", selectedTrainingCourse = "", selectedSubformEmp = "";

  static TextEditingController requestNoController = TextEditingController();
  static TextEditingController departmentController = TextEditingController();
  static TextEditingController contactNoController = TextEditingController();
  static TextEditingController contactNameController = TextEditingController();
  static TextEditingController trainingCourseTitleController = TextEditingController();
  static TextEditingController commentsController = TextEditingController();
  static TextEditingController cancelCommentController = TextEditingController();


  Future<TrainingReqResponse> updateTableResponse;
  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();
  ApiInterface _apiInterface3 = ApiInterface();

  ApiInterface _apiInterface6 = ApiInterface();
  ApiInterface _apiInterface7 = ApiInterface();
  ApiInterface _apiInterface8 = ApiInterface();

  static List<TrainingRequestModel> data = List();
  TrainingRequestDataSource _trainingRequestDataSource = TrainingRequestDataSource(data);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  static bool textFieldEnableStatus = true;
  static bool editClicked = false;

  static List<TrainingReqSubformModel> dataSubform = List();
  static List<TrainingReqSubformModel> deleteEntries = List();

  void getSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getStringList("empNo");
    empName = sharedPreferences.getStringList("empName");
    empDepartment = sharedPreferences.getStringList("empDepartment");
    trainingCourse = sharedPreferences.getStringList("trainingCourse");
    trainingCourseTitle = sharedPreferences.getStringList("trainingCourseTitle");
  }

  @override
  void initState() {
    super.initState();
    TrainingReqRequest trainingReqRequest = TrainingReqRequest(
      action: 1,
      status: 0,
    );
    setState(() {
      updateTableResponse =
              _apiInterface1.trainingRequestResponseData(trainingReqRequest);
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
                      "Training Request",
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
              builder: (BuildContext context, AsyncSnapshot<TrainingReqResponse> snapshot) {
                if(snapshot.hasData) {
                  TrainingReqResponse _myResponseData = snapshot.data;
                  _trainingRequestDataSource = TrainingRequestDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 && _myResponseData.data.length > 0) ? _myResponseData.data.length : _rowsPerPage,
                    onSelectAll: _trainingRequestDataSource.selectAll,
                    header: Text(""),
                    columns: [
                      DataColumn(
                        label: new Text(
                          "Request No",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Requested By",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Contact No",
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
                          "Training Course Title",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Comments",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Contact Name",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Training Course",
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
                          "Department",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                    ],
                    source: _trainingRequestDataSource,
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
                        onSelectAll: _trainingRequestDataSource.selectAll,
                        header: Text(""),
                        columns: [
                          DataColumn(
                            label: new Text(
                              "Request No",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Requested By",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Contact No",
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
                              "Training Course Title",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Comments",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Contact Name",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Training Course",
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
                              "Department",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                        ],
                        source: _trainingRequestDataSource,
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
              child: Text("New - Training Request"),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(2),
      content: DialogContent(),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            if (contactNoController.text.isEmpty ||
                    contactNameController.text.isEmpty ||
                    commentsController.text.isEmpty) {
              Fluttertoast.showToast(
                msg: "One or more blank entries",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            } else {
              Navigator.pop(context);
              TrainingReqResponse trainingReqResponse =
              await _apiInterface2.trainingRequestResponseData(
                      TrainingReqRequest(
                        action: 2,
                        requestNo: requestNoController.text,
                        requestedBy: selectedEmp,
                        department: departmentController.text,
                        contactNo: contactNoController.text,
                        contactName: contactNameController.text,
                        requestType: requestType.indexOf(selectedRequestType).toString(),
                        trainingCourse: selectedTrainingCourse,
                        trainingCourseTitle: selectedTrainingCourse,
                        comment: selectedTrainingCourse,
                        status: statusList.indexOf(selectedStatus),
                      ));

              if (trainingReqResponse.status) {
                TrainingReqRequest trainingReqRequest = TrainingReqRequest(
                  action: 1,
                  status: 0,
                );
                setState(() {
                  updateTableResponse =
                          _apiInterface1.trainingRequestResponseData(trainingReqRequest);
                });
              }
              Fluttertoast.showToast(
                msg: "${trainingReqResponse.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
              /*var alert =
              AlertDialog(content: Text(trainingReqResponse.message));
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

    if (_trainingRequestDataSource.rowSelect) {
      if (TrainingRequestDataSource.selectedRowData.status == statusList[0] ||
              TrainingRequestDataSource.selectedRowData.status == statusList[1]) {
        if (TrainingRequestDataSource.selectedRowData.status == statusList[1]) {
          textFieldEnableStatus = false;
          Fluttertoast.showToast(
            msg:
            "Document is ${TrainingRequestDataSource.selectedRowData.status} status and cannot be edited",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
        }

        var alert = AlertDialog(
          titlePadding: EdgeInsets.all(2),
          title: Center(
            child: Text("Edit - Training Request"),
          ),
          contentPadding: EdgeInsets.all(2),
          content: DialogContent(),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                if (contactNoController.text.isEmpty ||
                        contactNameController.text.isEmpty ||
                        commentsController.text.isEmpty) {
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
                    await _apiInterface3.trainingRejCanResponseData(
                            TrainingApprovalRequest(
                              action: "5",
                              sequenceNo: "0",
                              senderId: selectedEmp,
                              status: "4",
                              requestNo: requestNoController.text,
                              cancellationComment: cancelCommentController.text,
                            ));

                    if (rejCanResponse.status) {
                      TrainingReqRequest trainingReqRequest = TrainingReqRequest(
                        action: 1,
                        status: 0,
                      );
                      setState(() {
                        updateTableResponse =
                                _apiInterface1.trainingRequestResponseData(trainingReqRequest);
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
                    TrainingReqResponse trainingReqResponse =
                    await _apiInterface2.trainingRequestResponseData(
                            TrainingReqRequest(
                              action: 3,
                              requestNo: requestNoController.text,
                              requestedBy: selectedEmp,
                              department: departmentController.text,
                              contactNo: contactNoController.text,
                              contactName: contactNameController.text,
                              requestType: requestType.indexOf(selectedRequestType).toString(),
                              trainingCourse: selectedTrainingCourse,
                              trainingCourseTitle: selectedTrainingCourse,
                              comment: selectedTrainingCourse,
                              status: statusList.indexOf(selectedStatus),
                            ));

                    if (trainingReqResponse.status) {
                      TrainingReqRequest trainingReqRequest = TrainingReqRequest(
                        action: 1,
                        status: 0,
                      );
                      setState(() {
                        updateTableResponse =
                                _apiInterface1.trainingRequestResponseData(trainingReqRequest);
                      });
                    }
                    Fluttertoast.showToast(
                      msg: "${trainingReqResponse.message}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                    /*var alert = AlertDialog(
                        content: Text(trainingReqResponse.message));
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );*/

                    /*List<TrainingReqSubformModel> entriesToInsert = List();
                    List<TrainingReqSubformModel> entriesToDelete = List();

                    List<String> NewLineNo = List();
                    for (TrainingReqSubformModel trainingReqSubMod in _TrainingRequestState.dataSubform)
                    {
                      NewLineNo.add(trainingReqSubMod.lineNo.toString());
                      debugPrint("new entry : " + trainingReqSubMod.lineNo.toString());
                    }

                    List<String> ExistingLineNo = List();
                    for (TrainingReqSubformModel trainingReqSubMod in _TrainingRequestState.duplicateDataSubform)
                    {
                      ExistingLineNo.add(trainingReqSubMod.lineNo.toString());
                      debugPrint("old entry : " + trainingReqSubMod.lineNo.toString());

                      if (!NewLineNo.contains(trainingReqSubMod.lineNo.toString()))
                      {
                        entriesToDelete.add(trainingReqSubMod);
                        debugPrint("delete entry" + trainingReqSubMod.lineNo.toString() + "/" + trainingReqSubMod.employeeNo + "/" + trainingReqSubMod.employeeName.toString());
                      }
                    }

                    for (TrainingReqSubformModel trainingReqSubMod in _TrainingRequestState.dataSubform)
                    {
                      if (!ExistingLineNo.contains(trainingReqSubMod.lineNo.toString()))
                      {
                        entriesToInsert.add(trainingReqSubMod);
                        debugPrint("insert entry" + trainingReqSubMod.lineNo.toString() + "/" + trainingReqSubMod.employeeNo + "/" + trainingReqSubMod.employeeName.toString());
                      }
                    }*/

                    for(TrainingReqSubformModel trainingReqSubMod in dataSubform) {
                      TrainingReqSubformResponse trainingReqSubformResponse =
                      await _apiInterface6.trainingReqSubformResponseData(
                              TrainingReqSubformRequest(
                                action: "2",
                                requestNo: requestNoController.text,
                                employeeNo: trainingReqSubMod.employeeNo,
                                employeeName: trainingReqSubMod.employeeName,
                                lineNo: trainingReqSubMod.lineNo.toString(),
                              )
                      );
                    }
                    for(TrainingReqSubformModel trainingReqSubMod in deleteEntries) {
                      TrainingReqSubformResponse trainingReqSubformResponse =
                      await _apiInterface8.trainingReqSubformResponseData(
                              TrainingReqSubformRequest(
                                action: "4",
                                requestNo: requestNoController.text,
                                lineNo: trainingReqSubMod.lineNo.toString(),
                              )
                      );
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
                  "Document is ${TrainingRequestDataSource.selectedRowData.status} status and cannot be edited"),
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
        TrainingRequestDataSource.selectedRowData.selected = false;
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
    var requestNo = TrainingRequestDataSource.selectedRowData.requestNo;
    if (_trainingRequestDataSource.rowSelect) {
      if (TrainingRequestDataSource.selectedRowData.status == statusList[0] ||
              TrainingRequestDataSource.selectedRowData.status == statusList[1]) {
        var alert = AlertDialog(
          content: Text("Are you sure you want to delete this entry!?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
                TrainingReqResponse trainingReqResponse =
                await _apiInterface2.trainingRequestResponseData(
                        TrainingReqRequest(
                          action: 4,
                          requestNo: requestNo,
                        ));

                if (trainingReqResponse.status) {
                  TrainingReqRequest trainingReqRequest = TrainingReqRequest(
                    action: 1,
                    status: 0,
                  );
                  setState(() {
                    updateTableResponse =
                            _apiInterface1.trainingRequestResponseData(trainingReqRequest);
                  });
                }
                Fluttertoast.showToast(
                  msg: "${trainingReqResponse.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
                /*var alert =
                AlertDialog(content: Text(trainingReqResponse.message));
                showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  },
                );*/

                TrainingReqSubformResponse trainingReqSubformResponse =
                await _apiInterface7.trainingReqSubformResponseData(
                        TrainingReqSubformRequest(
                          action: "1",
                          requestNo: requestNo,
                        )
                );

                if(trainingReqSubformResponse.status){
                  for(TrainingReqSubformModel trainingReqSubMod in trainingReqSubformResponse.data) {
                    TrainingReqSubformResponse currAssetReqSubformResponse =
                    await _apiInterface6.trainingReqSubformResponseData(
                            TrainingReqSubformRequest(
                              action: "4",
                              requestNo: requestNo,
                              lineNo: trainingReqSubMod.lineNo.toString(),
                            )
                    );
                  }
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
          content: Text(
                  "Document is ${TrainingRequestDataSource.selectedRowData.status} status and cannot be deleted"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"),
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

  _TrainingRequestState _trainingRequestState = _TrainingRequestState();

  ApiInterface _apiInterface4 = ApiInterface();
  ApiInterface _apiInterface5 = ApiInterface();

  static List<TrainingReqSubformModel> dupCurrSubformData = List();
  TrainingReqSubformDataSource _trainingReqSubformDataSource = TrainingReqSubformDataSource(dupCurrSubformData);

  Widget iconWidgetDown = Icon(Icons.keyboard_arrow_down);
  Widget iconWidgetUp = Icon(Icons.keyboard_arrow_up);

  bool generalClick = false, subformClick = false;

  int _rowsPerPage = 2;

  List<TrainingReqSubformModel> currSubformData = List();
  List<TrainingReqSubformModel> currDeleteEntry = List();

  void getRequestNo() async{
    NoSeriesResponse requestNoResponse = await _apiInterface5.requestNoReasponseData();

    _TrainingRequestState.requestNoController.text = requestNoResponse.message;
  }

  void getSubformData() async{
    TrainingReqSubformResponse _mySubformResponse = await _apiInterface4.trainingReqSubformResponseData(
            TrainingReqSubformRequest(
              action: "1",
              requestNo: _TrainingRequestState.editClicked ? TrainingRequestDataSource.selectedRowData.requestNo : "",
            )
    );
    _trainingReqSubformDataSource = TrainingReqSubformDataSource(_mySubformResponse.data);
    _rowsPerPage = _mySubformResponse.data.length + 2;

    _TrainingRequestState.dataSubform = _mySubformResponse.data;
//    _TrainingRequestState.duplicateDataSubform = _mySubformResponse.data;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if(_TrainingRequestState.editClicked)
        _TrainingRequestState.requestNoController.text = TrainingRequestDataSource.selectedRowData.requestNo;
      else
        getRequestNo();

      _TrainingRequestState.selectedEmp = _TrainingRequestState.editClicked ? TrainingRequestDataSource.selectedRowData.requestedBy : _TrainingRequestState.empNo[0];

      _TrainingRequestState.departmentController.text = _TrainingRequestState.editClicked ? TrainingRequestDataSource.selectedRowData.department : _TrainingRequestState.empDepartment[_TrainingRequestState.empNo.indexOf(_TrainingRequestState.selectedEmp)];

      _TrainingRequestState.contactNoController.text = _TrainingRequestState.editClicked ? TrainingRequestDataSource.selectedRowData.contactNo : "";

      _TrainingRequestState.contactNameController.text = _TrainingRequestState.editClicked ? TrainingRequestDataSource.selectedRowData.contactName : "";

      _TrainingRequestState.selectedRequestType = _TrainingRequestState.editClicked ? TrainingRequestDataSource.selectedRowData.requestType : _trainingRequestState.requestType[0];

      _TrainingRequestState.selectedTrainingCourse = _TrainingRequestState.editClicked ? TrainingRequestDataSource.selectedRowData.trainingCourse : _TrainingRequestState.trainingCourse[0];

      _TrainingRequestState.trainingCourseTitleController.text = _TrainingRequestState.editClicked ? TrainingRequestDataSource.selectedRowData.trainingCourseTitle : _TrainingRequestState.trainingCourseTitle[_TrainingRequestState.trainingCourse.indexOf(_TrainingRequestState.selectedTrainingCourse)];

      _TrainingRequestState.commentsController.text = _TrainingRequestState.editClicked ? TrainingRequestDataSource.selectedRowData.comments : "";

      _TrainingRequestState.selectedStatus = _TrainingRequestState.editClicked ? TrainingRequestDataSource.selectedRowData.status : _trainingRequestState.statusList[0];

      getSubformData();
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
                        controller: _TrainingRequestState.cancelCommentController,
                        decoration: InputDecoration(
                                labelText: "Enter the cancellation comment"),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            if (_TrainingRequestState
                                    .cancelCommentController.text.isNotEmpty) {
                              Navigator.pop(context);
                              setState(() {
                                _TrainingRequestState.selectedStatus =
                                _trainingRequestState.statusList[4];
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
                              _TrainingRequestState.selectedStatus =
                              _trainingRequestState.statusList[1];
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
            visible: _TrainingRequestState.editClicked,
          ),

          ListTile(
            title: Text("General"),
            trailing: generalClick ? iconWidgetUp : iconWidgetDown,
            onTap: () {
              setState(() {
                generalClick = !generalClick;
                subformClick ? subformClick = !subformClick : subformClick = subformClick;
              });
            },
          ),

          Visibility(
            child: Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _TrainingRequestState.requestNoController,
                    decoration: InputDecoration(
                      labelText: "Request No",
                    ),
                    enabled: false,
                  ),

                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: <Widget>[
                      Text(
                        "Requested By : ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IgnorePointer(
                        child: DropdownButton(
                          value: _TrainingRequestState.selectedEmp,
                          items: _TrainingRequestState.empNo.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            debugPrint("Comment: " + newValue);
                            setState(() {
                              _TrainingRequestState.selectedEmp = newValue;
                              _TrainingRequestState.departmentController.text =
                              _TrainingRequestState
                                      .empDepartment[_TrainingRequestState
                                      .empNo
                                      .indexOf(_TrainingRequestState.selectedEmp)];
                            });
                          },
                        ),
                        ignoring: !_TrainingRequestState.textFieldEnableStatus,
                      ),

                    ],
                  ),

                  TextField(
                    controller: _TrainingRequestState.departmentController,
                    decoration: InputDecoration(
                      labelText: "Department",
                    ),
                    enabled: false,
                  ),

                  TextField(
                    controller: _TrainingRequestState.contactNoController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Contact No.",
                    ),
                    enabled: _TrainingRequestState.textFieldEnableStatus,
                  ),

                  TextField(
                    controller: _TrainingRequestState.contactNameController,
                    decoration: InputDecoration(
                      labelText: "Contact Name.",
                    ),
                    enabled: _TrainingRequestState.textFieldEnableStatus,
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
                          value: _TrainingRequestState.selectedRequestType,
                          items: _trainingRequestState.requestType.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              _TrainingRequestState.selectedRequestType = newValue;
                            });
                          },
                        ),
                        ignoring: !_TrainingRequestState.textFieldEnableStatus,
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: <Widget>[
                      Text(
                        "Training Course : ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IgnorePointer(
                        child: DropdownButton(
                          value: _TrainingRequestState.selectedTrainingCourse,
                          items: _TrainingRequestState.trainingCourse.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              _TrainingRequestState.selectedTrainingCourse = newValue;
                              _TrainingRequestState.trainingCourseTitleController.text =
                              _TrainingRequestState
                                      .trainingCourseTitle[_TrainingRequestState
                                      .trainingCourse
                                      .indexOf(_TrainingRequestState.selectedTrainingCourse)];
                            });
                          },
                        ),
                        ignoring: !_TrainingRequestState.textFieldEnableStatus,
                      )
                    ],
                  ),

                  TextField(
                    controller: _TrainingRequestState.trainingCourseTitleController,
                    decoration: InputDecoration(
                      labelText: "Training Course Title",
                    ),
                    enabled: false,
                  ),

                  TextField(
                    controller: _TrainingRequestState.commentsController,
                    decoration: InputDecoration(
                      labelText: "Comments.",
                    ),
                    enabled: _TrainingRequestState.textFieldEnableStatus,
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
                          value: _TrainingRequestState.selectedStatus,
                          items: _trainingRequestState.statusList.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              _TrainingRequestState.selectedStatus = newValue;
                            });
                          },
                        ),
                        ignoring: true,
                      )
                    ],
                  ),
                ],
              ),
            ),
            visible: generalClick,
          ),

          ListTile(
            title: Text("Attendees"),
            trailing: subformClick ? iconWidgetUp : iconWidgetDown,
            onTap: () {
              setState(() {
                subformClick = !subformClick;
                generalClick ? generalClick = !generalClick : generalClick = generalClick;
              });
            },
          ),

          Visibility(
            child: Container(
              margin: new EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Container(
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                                child: PopupMenuButton(
                                  child: Container(
                                    height: 35,
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.menu, color: Colors.white,),
                                        Text("Add", style: TextStyle(color: Colors.white, fontSize: 15),),
                                      ],
                                    ),
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return _TrainingRequestState.empNo.map((String value) {
                                      return PopupMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (String newValue) {
                                    _TrainingRequestState.selectedSubformEmp = newValue;

                                    Random random = new Random();

                                    int lineNo = 1000000 + random.nextInt(1000000);

                                    currSubformData = _TrainingRequestState.dataSubform;

                                    if(currSubformData.length > 0) {

                                      int duplicateCheck = 0;

                                      for(TrainingReqSubformModel subformModel in currSubformData) {

                                        if(subformModel.employeeNo == _TrainingRequestState.selectedSubformEmp) {
                                          Fluttertoast.showToast(
                                            msg: "Duplicate entry not allowed",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                          );
                                          duplicateCheck = 1;
                                          break;
                                        }
                                      }

                                      if(duplicateCheck == 0) {
                                        currSubformData.add(TrainingReqSubformModel(
                                          employeeNo: _TrainingRequestState.selectedSubformEmp,
                                          employeeName: _TrainingRequestState.empName[_TrainingRequestState.empNo.indexOf(_TrainingRequestState.selectedSubformEmp)],
                                          lineNo: lineNo,
                                        ));
                                        setState(() {
                                          _TrainingRequestState.dataSubform = currSubformData;
                                          _trainingReqSubformDataSource = TrainingReqSubformDataSource(currSubformData);
                                          _rowsPerPage = _TrainingRequestState.dataSubform.length + 2;
                                        });
//                                  Navigator.pop(context);
                                      }

                                    } else {
//                                Navigator.pop(context);
                                      currSubformData.add(TrainingReqSubformModel(
                                        employeeNo: _TrainingRequestState.selectedSubformEmp,
                                        employeeName: _TrainingRequestState.empName[_TrainingRequestState.empNo.indexOf(_TrainingRequestState.selectedSubformEmp)],
                                        lineNo: lineNo,
                                      ));
                                      setState(() {
                                        _TrainingRequestState.dataSubform = currSubformData;
                                        _trainingReqSubformDataSource = TrainingReqSubformDataSource(currSubformData);
                                      });
                                    }
                                  },
                                )
                        ),
                        new Padding(padding: new EdgeInsets.only(left: 5)),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              onSubformRemovePress(context);
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
                  Center(
                    child: PaginatedDataTable(
                      columnSpacing: 15,
                      horizontalMargin: 15,
                      headingRowHeight: 35,
                      dataRowHeight: 30,
                      rowsPerPage: _rowsPerPage,
                      onSelectAll: _trainingReqSubformDataSource.selectAll,
                      header: Text(""),
                      columns: [
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
                      ],
                      source: _trainingReqSubformDataSource,
                    ),
                  ),
                ],
              ),
            ),
            visible: subformClick,
          ),
        ],
      ),
    );
  }

  void onSubformRemovePress(BuildContext context) {
    if(_trainingReqSubformDataSource.rowSelect) {
      setState(() {
        _TrainingRequestState.dataSubform.removeAt(_trainingReqSubformDataSource.selectedRow);
        _trainingReqSubformDataSource = TrainingReqSubformDataSource(_TrainingRequestState.dataSubform);

        currDeleteEntry.add(
                TrainingReqSubformModel(
                  requestNo: TrainingReqSubformDataSource.selectedRowData.requestNo,
                  employeeNo: TrainingReqSubformDataSource.selectedRowData.employeeNo,
                  employeeName: TrainingReqSubformDataSource.selectedRowData.employeeName,
                  lineNo: TrainingReqSubformDataSource.selectedRowData.lineNo,
                )
        );

        _TrainingRequestState.deleteEntries = currDeleteEntry;

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
}
