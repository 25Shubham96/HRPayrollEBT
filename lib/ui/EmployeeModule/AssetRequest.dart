import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/EmpAssetReqDataSource.dart';
import 'package:hrpayroll/DataSource/EmpAssetReqSubformDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/Network/Utils.dart';
import 'package:hrpayroll/request_model/AssessmentApprovalRequest.dart';
import 'package:hrpayroll/request_model/AssetReqRequest.dart';
import 'package:hrpayroll/request_model/AssetReqSubformRequest.dart';
import 'package:hrpayroll/response_model/AssetReqResponse.dart';
import 'package:hrpayroll/response_model/AssetReqSubformResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:hrpayroll/response_model/RequisitionNoResponse.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetRequest extends StatefulWidget {
  @override
  _AssetRequestState createState() => _AssetRequestState();
}

class _AssetRequestState extends State<AssetRequest> {
  final List<String> statusList = [
    "Created",
    "Send For Approval",
    "Approved",
    "Rejected",
    "Cancelled"
  ];

  static List<String> empNo;
  static List<String> empName;
  static List<String> empDepartment;
  static List<String> assetType;

  static String userId;

  static var selectedEmp = "",
      selectedReqBy = "",
      selectedStatus = "",
      selectedAssetType = "";

  static TextEditingController requisitionNoController =
      TextEditingController();
  static TextEditingController empNameController = TextEditingController();
  static TextEditingController reqByNameController = TextEditingController();
  static TextEditingController departmentController = TextEditingController();
  static TextEditingController requisitionDateController =
      TextEditingController();
  static TextEditingController userIdController = TextEditingController();
  static TextEditingController cancelCommentController =
      TextEditingController();
  static TextEditingController quantityController = TextEditingController();

  Future<AssetReqResponse> updateTableResponse;
  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();
  ApiInterface _apiInterface3 = ApiInterface();

  ApiInterface _apiInterface6 = ApiInterface();
  ApiInterface _apiInterface7 = ApiInterface();
  ApiInterface _apiInterface8 = ApiInterface();

  static List<AssetReqModel> data = List();
  EmpAssetReqDataSource _assetReqDataSource = EmpAssetReqDataSource(data);

  static List<AssetReqSubformModel> dataSubform = List();
  static List<AssetReqSubformModel> deleteEntries = List();

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  static bool textFieldEnableStatus = true;
  static bool editClicked = false;

  void getSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getStringList("empNo");
    empName = sharedPreferences.getStringList("empName");
    empDepartment = sharedPreferences.getStringList("empDepartment");

    assetType = sharedPreferences.getStringList("assetType");
    userId = sharedPreferences.getString(Util.userName);
  }

  @override
  void initState() {
    super.initState();
    AssetReqRequest assetReqRequest = AssetReqRequest(
      action: 1,
    );
    setState(() {
      updateTableResponse =
          _apiInterface1.empAssetReqResponseData(assetReqRequest);
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
                      "Employee Asset Request",
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
                  AsyncSnapshot<AssetReqResponse> snapshot) {
                if (snapshot.hasData) {
                  AssetReqResponse _myResponseData = snapshot.data;
                  _assetReqDataSource =
                      EmpAssetReqDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 &&
                            _myResponseData.data.length > 0)
                        ? _myResponseData.data.length
                        : _rowsPerPage,
                    onSelectAll: _assetReqDataSource.selectAll,
                    header: Text(""),
                    columns: [
                      DataColumn(
                        label: new Text(
                          "Requistion No",
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
                          "Requisition Date",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Req by ID",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Req by Name",
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
                      DataColumn(
                        label: new Text(
                          "User ID",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                    source: _assetReqDataSource,
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
                        onSelectAll: _assetReqDataSource.selectAll,
                        header: Text(""),
                        columns: [
                          DataColumn(
                            label: new Text(
                              "Requistion No",
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
                              "Requisition Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Req by ID",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Req by Name",
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
                          DataColumn(
                            label: new Text(
                              "User ID",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        source: _assetReqDataSource,
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
              child: Text("New - Emp Req"),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(2),
      content: DialogContent(),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            if (requisitionDateController.text.isEmpty) {
              Fluttertoast.showToast(
                msg: "Please select requisition date",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            } else {
              Navigator.pop(context);
              AssetReqResponse assetReqResponse =
                  await _apiInterface2.empAssetReqResponseData(AssetReqRequest(
                action: 2,
                requisitionNo: requisitionNoController.text,
                employeeId: selectedEmp,
                employeeName: empNameController.text,
                department: departmentController.text,
                requisitionDate: requisitionDateController.text,
                requestedBy: selectedReqBy,
                requestedByName: reqByNameController.text,
                userId: userIdController.text,
                status: statusList.indexOf(selectedStatus),
              ));

              if (assetReqResponse.status) {
                AssetReqRequest assetReqRequest = AssetReqRequest(
                  action: 1,
                );
                setState(() {
                  updateTableResponse =
                      _apiInterface1.empAssetReqResponseData(assetReqRequest);
                });
              }
              Fluttertoast.showToast(
                msg: "${assetReqResponse.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
              /*var alert = AlertDialog(content: Text(assetReqResponse.message));
              showDialog(
                context: context,
                builder: (context) {
                  return alert;
                },
              );*/

              for (AssetReqSubformModel assetReqSubformModel in dataSubform) {
                AssetReqSubformResponse assetReqSubformResponse =
                    await _apiInterface6
                        .empAssetReqSubformResponseData(AssetReqSubformRequest(
                  action: "2",
                  requisitionNo: requisitionNoController.text,
                  quantity: assetReqSubformModel.quantity,
                  assetType: assetReqSubformModel.assetType,
                ));
                if (!assetReqSubformResponse.status) {
                  Fluttertoast.showToast(
                    msg: "Subform insertion failed",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                  );
                }
              }
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
        });
  }

  void onEditPress(BuildContext context) {
    editClicked = true;

    if (_assetReqDataSource.rowSelect) {
      if (EmpAssetReqDataSource.selectedRowData.status == statusList[0] ||
          EmpAssetReqDataSource.selectedRowData.status == statusList[1]) {
        if (EmpAssetReqDataSource.selectedRowData.status == statusList[1]) {
          textFieldEnableStatus = false;
          Fluttertoast.showToast(
            msg:
                "Document is ${EmpAssetReqDataSource.selectedRowData.status} status and cannot be edited",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
        }

        var alert = AlertDialog(
          titlePadding: EdgeInsets.all(2),
          title: Center(
            child: Text("Edit - Emp Asset Request"),
          ),
          contentPadding: EdgeInsets.all(2),
          content: DialogContent(),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                if (requisitionDateController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please select requisition date",
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
                        .assetReqRejCanResponseData(AssessmentApprovalRequest(
                      action: "5",
                      sequenceNo: "0",
                      senderId: selectedEmp,
                      status: "4",
                      requisitionNo: requisitionNoController.text,
                      cancellationComment: cancelCommentController.text,
                    ));

                    if (rejCanResponse.status) {
                      AssetReqRequest assetReqRequest = AssetReqRequest(
                        action: 1,
                      );
                      setState(() {
                        updateTableResponse = _apiInterface1
                            .empAssetReqResponseData(assetReqRequest);
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
                    AssetReqResponse assetReqResponse = await _apiInterface2
                        .empAssetReqResponseData(AssetReqRequest(
                      action: 3,
                      requisitionNo: requisitionNoController.text,
                      employeeId: selectedEmp,
                      employeeName: empNameController.text,
                      department: departmentController.text,
                      requisitionDate: requisitionDateController.text,
                      requestedBy: selectedReqBy,
                      requestedByName: reqByNameController.text,
                      userId: userIdController.text,
                      status: statusList.indexOf(selectedStatus),
                    ));

                    if (assetReqResponse.status) {
                      AssetReqRequest assetReqRequest = AssetReqRequest(
                        action: 1,
                      );
                      setState(() {
                        updateTableResponse = _apiInterface1
                            .empAssetReqResponseData(assetReqRequest);
                      });
                    }
                    Fluttertoast.showToast(
                      msg: "${assetReqResponse.message}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                    /*var alert = AlertDialog(
                        content: Text(assetReqResponse.message));
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      },
                    );*/

                    for (AssetReqSubformModel assetReqSubMod in dataSubform) {
                      AssetReqSubformResponse assetReqSubformResponse =
                          await _apiInterface6.empAssetReqSubformResponseData(
                              AssetReqSubformRequest(
                        action: "2",
                        requisitionNo: requisitionNoController.text,
                        quantity: assetReqSubMod.quantity,
                        assetType: assetReqSubMod.assetType,
                        lineNo: assetReqSubMod.lineNo.toString(),
                      ));
                    }
                    for (AssetReqSubformModel assetReqSubMod in deleteEntries) {
                      AssetReqSubformResponse assetReqSubformResponse =
                          await _apiInterface8.empAssetReqSubformResponseData(
                              AssetReqSubformRequest(
                        action: "4",
                        requisitionNo: requisitionNoController.text,
                        lineNo: assetReqSubMod.lineNo.toString(),
                      ));
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
              "Document is ${EmpAssetReqDataSource.selectedRowData.status} status and cannot be edited"),
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
        EmpAssetReqDataSource.selectedRowData.selected = false;
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
    var requisitionNo = EmpAssetReqDataSource.selectedRowData.requisitionNo;
    if (_assetReqDataSource.rowSelect) {
      if (EmpAssetReqDataSource.selectedRowData.status == statusList[0] ||
          EmpAssetReqDataSource.selectedRowData.status == statusList[1]) {
        var alert = AlertDialog(
          content: Text("Are you sure you want to delete this entry!?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
                AssetReqResponse assetReqResponse = await _apiInterface2
                    .empAssetReqResponseData(AssetReqRequest(
                  action: 4,
                  requisitionNo: requisitionNo,
                ));

                if (assetReqResponse.status) {
                  AssetReqRequest assetReqRequest = AssetReqRequest(
                    action: 1,
                  );
                  setState(() {
                    updateTableResponse =
                        _apiInterface1.empAssetReqResponseData(assetReqRequest);
                  });
                }
                Fluttertoast.showToast(
                  msg: "${assetReqResponse.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
                /*var alert =
                AlertDialog(content: Text(assetReqResponse.message));
                showDialog(
                  context: context,
                  builder: (context) {
                    return alert;
                  },
                );*/

                AssetReqSubformResponse assetReqSubformResponse =
                    await _apiInterface7
                        .empAssetReqSubformResponseData(AssetReqSubformRequest(
                  action: "1",
                  requisitionNo: requisitionNo,
                ));

                if (assetReqSubformResponse.status) {
                  for (AssetReqSubformModel assetReqSubMod
                      in assetReqSubformResponse.data) {
                    AssetReqSubformResponse currAssetReqSubformResponse =
                        await _apiInterface6.empAssetReqSubformResponseData(
                            AssetReqSubformRequest(
                      action: "4",
                      requisitionNo: requisitionNo,
                      lineNo: assetReqSubMod.lineNo.toString(),
                    ));
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
              "Document is ${EmpAssetReqDataSource.selectedRowData.status} status and cannot be deleted"),
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
  _AssetRequestState _assetRequestState = _AssetRequestState();

  ApiInterface _apiInterface4 = ApiInterface();
  ApiInterface _apiInterface5 = ApiInterface();

  static List<AssetReqSubformModel> dupCurrSubformData = List();
  EmpAssetReqSubformDataSource _assetReqSubformDataSource =
      EmpAssetReqSubformDataSource(dupCurrSubformData);

  Widget iconWidgetDown = Icon(Icons.keyboard_arrow_down);
  Widget iconWidgetUp = Icon(Icons.keyboard_arrow_up);

  bool generalClick = false, subformClick = false;
  static bool subformEditClicked = false;

  List<AssetReqSubformModel> currSubformData = List();
  List<AssetReqSubformModel> currDeleteEntry = List();

  int _rowsPerPage = 2;

  var formatter = new DateFormat('MM/dd/yyyy');

  DateTime requisitionDate = DateTime.now();

  void getRequisitionNo() async {
    NoSeriesResponse requisitionNoResponse =
        await _apiInterface5.requisitionNoReasponseData();

    _AssetRequestState.requisitionNoController.text =
        requisitionNoResponse.message;
  }

  void getSubformData() async {
    AssetReqSubformResponse _mySubformResponse = await _apiInterface4
        .empAssetReqSubformResponseData(AssetReqSubformRequest(
      action: "1",
      requisitionNo: _AssetRequestState.editClicked
          ? EmpAssetReqDataSource.selectedRowData.requisitionNo
          : "",
    ));
    _assetReqSubformDataSource =
        EmpAssetReqSubformDataSource(_mySubformResponse.data);
    _rowsPerPage = _mySubformResponse.data.length + 2;

    _AssetRequestState.dataSubform = _mySubformResponse.data;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (_AssetRequestState.editClicked)
        _AssetRequestState.requisitionNoController.text =
            EmpAssetReqDataSource.selectedRowData.requisitionNo;
      else
        getRequisitionNo();

      _AssetRequestState.selectedEmp = _AssetRequestState.editClicked
          ? EmpAssetReqDataSource.selectedRowData.employeeNo
          : _AssetRequestState.empNo[0];
      _AssetRequestState.empNameController.text = _AssetRequestState.editClicked
          ? EmpAssetReqDataSource.selectedRowData.employeeName
          : _AssetRequestState.empName[
              _AssetRequestState.empNo.indexOf(_AssetRequestState.selectedEmp)];
      _AssetRequestState.departmentController.text = _AssetRequestState
              .editClicked
          ? EmpAssetReqDataSource.selectedRowData.department
          : _AssetRequestState.empDepartment[
              _AssetRequestState.empNo.indexOf(_AssetRequestState.selectedEmp)];

      _AssetRequestState.requisitionDateController.text =
          _AssetRequestState.editClicked
              ? EmpAssetReqDataSource.selectedRowData.requisionDate
              : "";

      _AssetRequestState.selectedReqBy = _AssetRequestState.editClicked
          ? EmpAssetReqDataSource.selectedRowData.requestedBy
          : _AssetRequestState.empNo[0];
      _AssetRequestState.reqByNameController.text = _AssetRequestState
              .editClicked
          ? EmpAssetReqDataSource.selectedRowData.requestedByName
          : _AssetRequestState.empName[
              _AssetRequestState.empNo.indexOf(_AssetRequestState.selectedEmp)];

      _AssetRequestState.userIdController.text = _AssetRequestState.editClicked
          ? EmpAssetReqDataSource.selectedRowData.userId
          : _AssetRequestState.userId;

      _AssetRequestState.selectedStatus = _AssetRequestState.editClicked
          ? EmpAssetReqDataSource.selectedRowData.status
          : _assetRequestState.statusList[0];

      if(_AssetRequestState.editClicked)
        requisitionDate = DateFormat("yyyy-MM-dd").parse(_AssetRequestState.requisitionDateController.text);

      getSubformData();
    });
  }

  Future<Null> _selectRequisitionDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: requisitionDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        requisitionDate = picked;
        _AssetRequestState.requisitionDateController.text =
            formatter.format(requisitionDate);
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
                        controller: _AssetRequestState.cancelCommentController,
                        decoration: InputDecoration(
                            labelText: "Enter the cancellation comment"),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            if (_AssetRequestState
                                .cancelCommentController.text.isNotEmpty) {
                              Navigator.pop(context);
                              setState(() {
                                _AssetRequestState.selectedStatus =
                                    _assetRequestState.statusList[4];
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
                              _AssetRequestState.selectedStatus =
                                  _assetRequestState.statusList[1];
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
            visible: _AssetRequestState.editClicked,
          ),
          ListTile(
            title: Text("General"),
            trailing: generalClick ? iconWidgetUp : iconWidgetDown,
            onTap: () {
              setState(() {
                generalClick = !generalClick;
                subformClick
                    ? subformClick = !subformClick
                    : subformClick = subformClick;
              });
            },
          ),
          Visibility(
            child: Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _AssetRequestState.requisitionNoController,
                    decoration: InputDecoration(
                      labelText: "Requisition No",
                    ),
                    enabled: false,
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
                          value: _AssetRequestState.selectedEmp,
                          items: _AssetRequestState.empNo.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            debugPrint("Comment: " + newValue);
                            setState(() {
                              _AssetRequestState.selectedEmp = newValue;
                              _AssetRequestState.empNameController.text =
                                  _AssetRequestState.empName[_AssetRequestState
                                      .empNo
                                      .indexOf(_AssetRequestState.selectedEmp)];
                              _AssetRequestState.departmentController.text =
                                  _AssetRequestState.empDepartment[
                                      _AssetRequestState.empNo.indexOf(
                                          _AssetRequestState.selectedEmp)];
                            });
                          },
                        ),
                        ignoring: !_AssetRequestState.textFieldEnableStatus,
                      )
                    ],
                  ),
                  TextField(
                    controller: _AssetRequestState.empNameController,
                    decoration: InputDecoration(
                      labelText: "Employee Name",
                    ),
                    enabled: false,
                  ),
                  TextField(
                    controller: _AssetRequestState.departmentController,
                    decoration: InputDecoration(
                      labelText: "Department",
                    ),
                    enabled: false,
                  ),
                  TextField(
                    controller: _AssetRequestState.requisitionDateController,
                    decoration: InputDecoration(
                      labelText: "Requisition Date",
                    ),
                    enableInteractiveSelection: false,
                    focusNode: NoKeyboardEditableTextFocusNode(),
                    onTap: () {
                      _selectRequisitionDate(context);
                    },
                    enabled: _AssetRequestState.textFieldEnableStatus,
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: <Widget>[
                      Text(
                        "Requested By. : ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IgnorePointer(
                        child: DropdownButton(
                          value: _AssetRequestState.selectedReqBy,
                          items: _AssetRequestState.empNo.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            debugPrint("Comment: " + newValue);
                            setState(() {
                              _AssetRequestState.selectedReqBy = newValue;
                              _AssetRequestState.reqByNameController.text =
                                  _AssetRequestState.empName[
                                      _AssetRequestState.empNo.indexOf(
                                          _AssetRequestState.selectedReqBy)];
                            });
                          },
                        ),
                        ignoring: !_AssetRequestState.textFieldEnableStatus,
                      )
                    ],
                  ),
                  TextField(
                    controller: _AssetRequestState.reqByNameController,
                    decoration: InputDecoration(
                      labelText: "Requested by Name",
                    ),
                    enabled: false,
                  ),
                  TextField(
                    controller: _AssetRequestState.userIdController,
                    decoration: InputDecoration(
                      labelText: "User ID",
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
                          value: _AssetRequestState.selectedStatus,
                          items:
                              _assetRequestState.statusList.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              _AssetRequestState.selectedStatus = newValue;
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
            title: Text("Subform"),
            trailing: subformClick ? iconWidgetUp : iconWidgetDown,
            onTap: () {
              setState(() {
                subformClick = !subformClick;
                generalClick
                    ? generalClick = !generalClick
                    : generalClick = generalClick;
              });
            },
          ),
          Visibility(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: new EdgeInsets.all(5),
                    child: new Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 5)),
                        new Container(
                          child: new Row(
                            children: <Widget>[
                              Expanded(
                                child: FlatButton(
                                  onPressed: () {
                                    onSubformNewPress(context);
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
                              new Padding(
                                  padding: new EdgeInsets.only(left: 5)),
                              Expanded(
                                child: FlatButton(
                                  onPressed: () {
                                    onSubformEditPress(context);
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
                              new Padding(
                                  padding: new EdgeInsets.only(left: 5)),
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
                      onSelectAll: _assetReqSubformDataSource.selectAll,
                      header: Text(""),
                      columns: [
                        DataColumn(
                          label: new Text(
                            "Asset Type",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Quantity",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                      source: _assetReqSubformDataSource,
                    ),
                  )
                ],
              ),
            ),
            visible: subformClick,
          ),
        ],
      ),
    );
  }

  void onSubformNewPress(BuildContext context) {
    var alert = AlertDialog(
      titlePadding: EdgeInsets.all(2),
      title: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Text("New - Emp Req Subform"),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(2),
      content: SubformDialogContent(),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            Random random = new Random();

            int lineNo = 1000000 + random.nextInt(1000000);

            if (_AssetRequestState.quantityController.text.isNotEmpty) {
              currSubformData = _AssetRequestState.dataSubform;

              if (currSubformData.length > 0) {
                int duplicateCheck = 0;

                for (AssetReqSubformModel subformModel in currSubformData) {
                  if (subformModel.assetType ==
                      _AssetRequestState.selectedAssetType) {
                    Fluttertoast.showToast(
                      msg: "Duplicate entry not allowed",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                    duplicateCheck = 1;
                    break;
                  }
                }

                if (duplicateCheck == 0) {
                  currSubformData.add(AssetReqSubformModel(
                    assetType: _AssetRequestState.selectedAssetType,
                    quantity: double.parse(
                        _AssetRequestState.quantityController.text),
                    lineNo: lineNo,
                  ));
                  setState(() {
                    _AssetRequestState.dataSubform = currSubformData;
                    _assetReqSubformDataSource =
                        EmpAssetReqSubformDataSource(currSubformData);
                    _rowsPerPage = _AssetRequestState.dataSubform.length + 2;
                  });
                  Navigator.pop(context);
                }
              } else {
                Navigator.pop(context);
                currSubformData.add(AssetReqSubformModel(
                  assetType: _AssetRequestState.selectedAssetType,
                  quantity:
                      double.parse(_AssetRequestState.quantityController.text),
                  lineNo: lineNo,
                ));
                setState(() {
                  _AssetRequestState.dataSubform = currSubformData;
                  _assetReqSubformDataSource =
                      EmpAssetReqSubformDataSource(currSubformData);
                });
              }
            } else {
              Fluttertoast.showToast(
                msg: "Please enter the correct quantity",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            }
          },
          child: Text("Done"),
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
        });
  }

  void onSubformEditPress(BuildContext context) {
    subformEditClicked = true;

    if (_assetReqSubformDataSource.rowSelect) {
      var alert = AlertDialog(
        titlePadding: EdgeInsets.all(2),
        title: Center(
          child: Text("Edit - Emp Req Subform"),
        ),
        contentPadding: EdgeInsets.all(2),
        content: SubformDialogContent(),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if (_AssetRequestState.quantityController.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: "Please enter the correct quantity",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
              } else {
                Navigator.pop(context);
                setState(() {
                  _AssetRequestState
                          .dataSubform[_assetReqSubformDataSource.selectedRow]
                          .quantity =
                      double.parse(_AssetRequestState.quantityController.text);
                  _assetReqSubformDataSource = EmpAssetReqSubformDataSource(
                      _AssetRequestState.dataSubform);
                  subformEditClicked = false;
                });
              }
            },
            child: Text("done"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                subformEditClicked = false;
              });
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
    }
  }

  void onSubformRemovePress(BuildContext context) {
    if (_assetReqSubformDataSource.rowSelect) {
      setState(() {
        _AssetRequestState.dataSubform
            .removeAt(_assetReqSubformDataSource.selectedRow);
        _assetReqSubformDataSource =
            EmpAssetReqSubformDataSource(_AssetRequestState.dataSubform);

        currDeleteEntry.add(AssetReqSubformModel(
          requisitionNo:
              EmpAssetReqSubformDataSource.selectedRowData.requisitionNo,
          assetType: EmpAssetReqSubformDataSource.selectedRowData.assetType,
          quantity: EmpAssetReqSubformDataSource.selectedRowData.quantity,
          lineNo: EmpAssetReqSubformDataSource.selectedRowData.lineNo,
        ));

        _AssetRequestState.deleteEntries = currDeleteEntry;
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

class SubformDialogContent extends StatefulWidget {
  @override
  _SubformDialogContentState createState() => _SubformDialogContentState();
}

class _SubformDialogContentState extends State<SubformDialogContent> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _AssetRequestState.selectedAssetType =
          _DialogContentState.subformEditClicked
              ? EmpAssetReqSubformDataSource.selectedRowData.assetType
              : _AssetRequestState.assetType[0];

      _AssetRequestState.quantityController.text =
          _DialogContentState.subformEditClicked
              ? EmpAssetReqSubformDataSource.selectedRowData.quantity.toString()
              : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Asset Type : ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IgnorePointer(
                  child: DropdownButton(
                    value: _AssetRequestState.selectedAssetType,
                    items: _AssetRequestState.assetType.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        _AssetRequestState.selectedAssetType = newValue;
                      });
                    },
                  ),
                  ignoring: _DialogContentState.subformEditClicked,
                )
              ],
            ),
            TextField(
              controller: _AssetRequestState.quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantity",
              ),
              enabled: _AssetRequestState.textFieldEnableStatus,
            ),
          ],
        ),
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
