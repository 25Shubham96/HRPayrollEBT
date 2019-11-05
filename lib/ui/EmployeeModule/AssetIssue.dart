import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/AssetIssueDataSource.dart';
import 'package:hrpayroll/DataSource/AssetIssueSubformDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/AssetIssueRequest.dart';
import 'package:hrpayroll/request_model/AssetIssueSubformRequest.dart';
import 'package:hrpayroll/request_model/IssueReturnLedgerRequest.dart';
import 'package:hrpayroll/request_model/TrainingProviderCourseRequest.dart';
import 'package:hrpayroll/response_model/AssetIssueResponse.dart';
import 'package:hrpayroll/response_model/AssetIssueSubformResponse.dart';
import 'package:hrpayroll/response_model/FixedAssetResponse.dart';
import 'package:hrpayroll/response_model/IssueReturnLedgerResponse.dart';
import 'package:hrpayroll/response_model/RequisitionNoResponse.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetIssue extends StatefulWidget {
  @override
  _AssetIssueState createState() => _AssetIssueState();
}

class _AssetIssueState extends State<AssetIssue> {

  static final List<String> ownerValue = ["Company", "Third Party"];

  static List<String> empNo;
  static List<String> empName;
  static List<String> empDepartment;

  static List<String> assetNo;
  static List<String> assetName;
  static List<String> assetType;
  static List<String> owner;
  static List<String> ownerName;
  static List<String> manufacturar;
  static List<String> model;
  static List<String> currAssetLoc;

  static List<String> assetIssueStatus;

  static var selectedEmp = "", selectedIssuedBy = "", selectedAssetNo = "";

  static TextEditingController issueNoController = TextEditingController();
  static TextEditingController issueDateController = TextEditingController();
  static TextEditingController empNameController = TextEditingController();
  static TextEditingController issuedByNameController = TextEditingController();
  static TextEditingController cancelCommentController = TextEditingController();

  static TextEditingController assetNameController = TextEditingController();
  static TextEditingController assetTypeController = TextEditingController();
  static TextEditingController ownerController = TextEditingController();
  static TextEditingController valueController = TextEditingController();
  static TextEditingController manufacturerController = TextEditingController();
  static TextEditingController modelController = TextEditingController();
  static TextEditingController ownerNameController = TextEditingController();
  static TextEditingController currAssetLocController = TextEditingController();
  static TextEditingController postedPurOrderNoController = TextEditingController();

  Future<AssetIssueResponse> updateTableResponse;
  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();
  ApiInterface _apiInterface3 = ApiInterface();

  ApiInterface _apiInterface6 = ApiInterface();
  ApiInterface _apiInterface7 = ApiInterface();
  ApiInterface _apiInterface8 = ApiInterface();

  static List<AssetIssueModel> data = List();
  AssetIssueDataSource _assetIssueDataSource = AssetIssueDataSource(data);

  static List<AssetIssueSubformModel> dataSubform = List();
  static List<AssetIssueSubformModel> deleteEntries = List();

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  static bool textFieldEnableStatus = true;
  static bool editClicked = false;

  static int postCheck = 0;

  void getSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getStringList("empNo");
    empName = sharedPreferences.getStringList("empName");
    empDepartment = sharedPreferences.getStringList("empDepartment");

    assetNo = sharedPreferences.getStringList("assetNo");
    assetName = sharedPreferences.getStringList("assetName");
    assetType = sharedPreferences.getStringList("assetType");
    owner = sharedPreferences.getStringList("owner");
    ownerName = sharedPreferences.getStringList("ownerName");
    manufacturar = sharedPreferences.getStringList("manufacturar");
    model = sharedPreferences.getStringList("model");
    currAssetLoc = sharedPreferences.getStringList("currAssetLoc");

    assetIssueStatus = sharedPreferences.getStringList("assetIssueStatus");
  }

  @override
  void initState() {
    super.initState();
    AssetIssueRequest assetIssueRequest = AssetIssueRequest(
      action: 1,
      issue: 1,
    );
    setState(() {
      updateTableResponse =
              _apiInterface1.assetIssueResponseData(assetIssueRequest);
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
                      "Asset Issue List",
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
              builder: (BuildContext context, AsyncSnapshot<AssetIssueResponse> snapshot){
                if(snapshot.hasData) {
                  AssetIssueResponse _myResponseData = snapshot.data;
                  List<AssetIssueModel> filterData = List();

                  for(AssetIssueModel assetIssueModel in _myResponseData.data) {
                    if(assetIssueModel.issue == 1)
                      filterData.add(assetIssueModel);
                  }

                  _assetIssueDataSource = AssetIssueDataSource(filterData);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (filterData.length < 10 && filterData.length > 0) ? filterData.length : _rowsPerPage,
                    onSelectAll: _assetIssueDataSource.selectAll,
                    header: Text(""),
                    columns: [
                      DataColumn(
                        label: new Text(
                          "Issue No",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Issue Date",
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
                          "Issued by ID",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Issued by Name",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                    ],
                    source: _assetIssueDataSource,
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
                        onSelectAll: _assetIssueDataSource.selectAll,
                        header: Text(""),
                        columns: [
                          DataColumn(
                            label: new Text(
                              "Issue No",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Issue Date",
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
                              "Issued by ID",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Issued by Name",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                        ],
                        source: _assetIssueDataSource,
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
              child: Text("New - Asset Issue"),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(2),
      content: DialogContent(),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            if(issueDateController.text == "") {
              Fluttertoast.showToast(
                msg: "Please enter the issue date",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            } else {
              Navigator.pop(context);
              AssetIssueResponse assetIssueResponse =
              await _apiInterface2.assetIssueResponseData(
                      AssetIssueRequest(
                        action: 2,
                        issueNo: issueNoController.text,
                        issueDate: issueDateController.text,
                        employeeId: selectedEmp,
                        employeeName: empNameController.text,
                        requestedBy: selectedIssuedBy,
                        requestedByName: issuedByNameController.text,
                        issue: 1,
                        retun: 0,
                      )
              );

              if(assetIssueResponse.status) {
                AssetIssueRequest assetIssueRequest = AssetIssueRequest(
                  action: 1,
                  issue: 1,
                );
                setState(() {
                  updateTableResponse =
                          _apiInterface1.assetIssueResponseData(assetIssueRequest);
                });
              }

              Fluttertoast.showToast(
                msg: "${assetIssueResponse.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
              /*var alert = AlertDialog(content: Text(assetIssueResponse.message));
              showDialog(
                context: context,
                builder: (context) {
                  return alert;
                },
              );*/

              for(AssetIssueSubformModel assetIssueSubformModel in dataSubform) {
                AssetIssueSubformResponse assetIssueSubformResponse =
                await _apiInterface6.assetIssueSubformResponseData(
                        AssetIssueSubformRequest(
                          action: 2,
                          issueNo: issueNoController.text,
                          assetNo: selectedAssetNo,
                          assetName: assetIssueSubformModel.assetName,
                          assetType: assetIssueSubformModel.assetType,
                          value: assetIssueSubformModel.value.toString(),
                          owner: assetIssueSubformModel.owner,
                          ownerName: assetIssueSubformModel.ownerName,
                          manufacturer: assetIssueSubformModel.manufacturar,
                          model: assetIssueSubformModel.model,
                          currentAssetLocation: assetIssueSubformModel.currentAssetLocation,
                          postedPurchaseOrder: assetIssueSubformModel.postedPurchaseOrderNo,
                        )
                );
                if(!assetIssueSubformResponse.status){
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
    showDialog(context: context, builder: (BuildContext context) {
      return alert;
    });
  }
  void onEditPress(BuildContext context) {
    editClicked = true;

    if (_assetIssueDataSource.rowSelect) {
      postCheck = 0;
      var alert = AlertDialog(
        titlePadding: EdgeInsets.all(2),
        title: Center(
          child: Text("Edit - Asset Issue"),
        ),
        contentPadding: EdgeInsets.all(2),
        content: DialogContent(),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              if (issueDateController.text == ""/* || (postCheck == 1 && (assetIssueStatus[assetNo.indexOf(selectedAssetNo)]) == "1")*/) {
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

                if(postCheck == 1){
                  AssetIssueResponse assetIssueResponse =
                  await _apiInterface2.assetIssueResponseData(
                          AssetIssueRequest(
                            action: 4,
                            issueNo: issueNoController.text,
                          ));

                  if (assetIssueResponse.status) {
                    AssetIssueRequest assetIssueRequest = AssetIssueRequest(
                      action: 1,
                      issue: 1,
                    );
                    setState(() {
                      updateTableResponse =
                              _apiInterface1.assetIssueResponseData(
                                      assetIssueRequest);
                    });
                  }
                } else {
                  AssetIssueResponse assetIssueResponse =
                  await _apiInterface2.assetIssueResponseData(
                          AssetIssueRequest(
                            action: 3,
                            issueNo: issueNoController.text,
                            issueDate: issueDateController.text,
                            employeeId: selectedEmp,
                            employeeName: empNameController.text,
                            requestedBy: selectedIssuedBy,
                            requestedByName: issuedByNameController.text,
                            issue: 1,
                            retun: 0,
                          ));

                  if (assetIssueResponse.status) {
                    AssetIssueRequest assetIssueRequest = AssetIssueRequest(
                      action: 1,
                      issue: 1,
                    );
                    setState(() {
                      updateTableResponse =
                              _apiInterface1.assetIssueResponseData(
                                      assetIssueRequest);
                    });
                  }

                  Fluttertoast.showToast(
                    msg: "${assetIssueResponse.message}",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                  );

                  /*var alert = AlertDialog(
                      content: Text(assetIssueResponse.message));
                  showDialog(
                    context: context,
                    builder: (context) {
                      return alert;
                    },
                  );*/
                }

                for(AssetIssueSubformModel assetIssueSubformModel in dataSubform) {
                  AssetIssueSubformResponse assetIssueSubformResponse =
                  await _apiInterface6.assetIssueSubformResponseData(
                          AssetIssueSubformRequest(
                            action: 2,
                            issueNo: issueNoController.text,
                            lineNo: assetIssueSubformModel.lineNo.toString(),
                            assetNo: selectedAssetNo,
                            assetName: assetIssueSubformModel.assetName,
                            assetType: assetIssueSubformModel.assetType,
                            value: assetIssueSubformModel.value.toString(),
                            owner: assetIssueSubformModel.owner,
                            ownerName: assetIssueSubformModel.ownerName,
                            manufacturer: assetIssueSubformModel.manufacturar,
                            model: assetIssueSubformModel.model,
                            currentAssetLocation: assetIssueSubformModel.currentAssetLocation,
                            postedPurchaseOrder: assetIssueSubformModel.postedPurchaseOrderNo,
                          )
                  );
                  if(postCheck == 1) {
                    IssueReturnLedgerResponse issueReturnLedgerResponse =
                    await _apiInterface3.issueReturnLedgerResponseData(
                            IssueReturnLedgerRequest(
                              action: 2,
                              issueDate: issueDateController.text,
                              issueNo: issueNoController.text,
                              lineNo: assetIssueSubformModel.lineNo,
                            )
                    );

                    FixedAssetResponse fixedAssetResponse =
                    await _apiInterface8.getAssetDetailsResponseData(
                            TrainingProviderCourseRequest(
                              action: 1,
                            )
                    );

                    if(fixedAssetResponse.status){

                      List<String> statusData = List();
                      for(int i = 0 ; i < fixedAssetResponse.data.length ; i++) {
                        statusData.add(fixedAssetResponse.data[i].issued.toString());
                      }
                      setState(() {
                        assetIssueStatus = statusData;
                      });
                    }
                  }
                }
                for(AssetIssueSubformModel trainingActSubMod in deleteEntries) {
                  AssetIssueSubformResponse trainingActSubformResponse =
                  await _apiInterface8.assetIssueSubformResponseData(
                          AssetIssueSubformRequest(
                            action: 4,
                            issueNo: issueNoController.text,
                            lineNo: trainingActSubMod.lineNo.toString(),
                          )
                  );
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
        },
      );
      setState(() {
        AssetIssueDataSource.selectedRowData.selected = false;
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
    var issueNo = AssetIssueDataSource.selectedRowData.issueNo;
    if (_assetIssueDataSource.rowSelect) {
      var alert = AlertDialog(
        content: Text("Are you sure you want to delete this entry!?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              Navigator.pop(context);
              AssetIssueResponse assetIssueResponse =
              await _apiInterface2.assetIssueResponseData(
                      AssetIssueRequest(
                        action: 4,
                        issueNo: issueNo,
                      ));

              if (assetIssueResponse.status) {
                AssetIssueRequest assetIssueRequest = AssetIssueRequest(
                  action: 1,
                  issue: 1,
                );
                setState(() {
                  updateTableResponse =
                          _apiInterface1.assetIssueResponseData(assetIssueRequest);
                });
              }

              Fluttertoast.showToast(
                msg: "${assetIssueResponse.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
              /*var alert =
              AlertDialog(content: Text(assetIssueResponse.message));
              showDialog(
                context: context,
                builder: (context) {
                  return alert;
                },
              );*/

              AssetIssueSubformResponse assetIssueSubformResponse =
              await _apiInterface7.assetIssueSubformResponseData(
                      AssetIssueSubformRequest(
                        action: 1,
                        issueNo: issueNo,
                      )
              );

              if(assetIssueSubformResponse.status){
                for(AssetIssueSubformModel assetIssueSubMod in assetIssueSubformResponse.data) {
                  AssetIssueSubformResponse assetIssueSubformResponse =
                  await _apiInterface6.assetIssueSubformResponseData(
                          AssetIssueSubformRequest(
                            action: 4,
                            issueNo: issueNo,
                            lineNo: assetIssueSubMod.lineNo.toString(),
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

  ApiInterface _apiInterface4 = ApiInterface();
  ApiInterface _apiInterface5 = ApiInterface();

  static List<AssetIssueSubformModel> dupCurrSubformData = List();
  AssetIssueSubformDataSource _assetIssueSubformDataSource = AssetIssueSubformDataSource(dupCurrSubformData);

  Widget iconWidgetDown = Icon(Icons.keyboard_arrow_down);
  Widget iconWidgetUp = Icon(Icons.keyboard_arrow_up);

  bool generalClick = false, subformClick = false;
  static bool subformEditClicked = false;

  List<AssetIssueSubformModel> currSubformData = List();
  List<AssetIssueSubformModel> currDeleteEntry = List();

  int _rowsPerPage = 2;

  void getIssueNo() async{
    NoSeriesResponse issueNoResponse = await _apiInterface5.issueNoReasponseData();

    _AssetIssueState.issueNoController.text = issueNoResponse.message;
  }

  void getSubformData() async{
    AssetIssueSubformResponse _mySubformResponse =
    await _apiInterface4.assetIssueSubformResponseData(
            AssetIssueSubformRequest(
              action: 1,
              issueNo: _AssetIssueState.editClicked ? AssetIssueDataSource.selectedRowData.issueNo : "",
            )
    );
    _assetIssueSubformDataSource = AssetIssueSubformDataSource(_mySubformResponse.data);
    _rowsPerPage = _mySubformResponse.data.length + 2;

    _AssetIssueState.dataSubform = _mySubformResponse.data;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if(_AssetIssueState.editClicked)
        _AssetIssueState.issueNoController.text = AssetIssueDataSource.selectedRowData.issueNo;
      else
        getIssueNo();

      _AssetIssueState.issueDateController.text = _AssetIssueState.editClicked ? AssetIssueDataSource.selectedRowData.issueDate : "";
      _AssetIssueState.selectedEmp = _AssetIssueState.editClicked ? AssetIssueDataSource.selectedRowData.employeeNo : _AssetIssueState.empNo[0];
      _AssetIssueState.empNameController.text = _AssetIssueState.editClicked ? AssetIssueDataSource.selectedRowData.employeeName : _AssetIssueState.empName[_AssetIssueState.empNo.indexOf(_AssetIssueState.selectedEmp)];
      _AssetIssueState.selectedIssuedBy = _AssetIssueState.editClicked ? AssetIssueDataSource.selectedRowData.issuedBy : _AssetIssueState.empNo[0];
      _AssetIssueState.issuedByNameController.text = _AssetIssueState.editClicked ? AssetIssueDataSource.selectedRowData.issuedByName : _AssetIssueState.empName[_AssetIssueState.empNo.indexOf(_AssetIssueState.selectedIssuedBy)];

      getSubformData();
    });
  }

  var formatter = new DateFormat('MM/dd/yyyy');

  DateTime issueDate = DateTime.now();

  Future<Null> _selectIssueDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: issueDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        issueDate = picked;
        _AssetIssueState.issueDateController.text = formatter.format(issueDate);
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
                      content:
                      Text("Are you sure you want to post the document for issuing asset?"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              if(_AssetIssueState.postCheck == 0 && _AssetIssueState.dataSubform.length > 0) {
                                _AssetIssueState.postCheck = 1;
                              } else {
                                if(_AssetIssueState.dataSubform.length <= 0) {
                                  Fluttertoast.showToast(
                                    msg: "Please select the asset to be issued, using Subform",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Already selected for posting",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                  );
                                }
                              }

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
                      Icon(Icons.add, color: Colors.green,),
                      Text("Post")
                    ],
                  ),
                ),
              ],
            ),
            visible: _AssetIssueState.editClicked,
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
                    controller: _AssetIssueState.issueNoController,
                    decoration: InputDecoration(
                      labelText: "Issue No",
                    ),
                    enabled: false,
                  ),
                  TextField(
                    controller: _AssetIssueState.issueDateController,
                    decoration: InputDecoration(
                      labelText: "Issue Date",
                    ),
                    enableInteractiveSelection: false,
                    focusNode: NoKeyboardEditableTextFocusNode(),
                    onTap: () {
                      _selectIssueDate(context);
                    },
                    enabled: _AssetIssueState.textFieldEnableStatus,
                  ),

                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: <Widget>[
                      Text(
                        "Employee ID : ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IgnorePointer(
                        child: DropdownButton(
                          value: _AssetIssueState.selectedEmp,
                          items: _AssetIssueState.empNo.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            debugPrint("Comment: " + newValue);
                            setState(() {
                              _AssetIssueState.selectedEmp = newValue;
                              _AssetIssueState.empNameController.text =
                              _AssetIssueState.empName[_AssetIssueState.empNo
                                      .indexOf(_AssetIssueState.selectedEmp)];
                            });
                          },
                        ),
                        ignoring: _DialogContentState.subformEditClicked,
                      )
                    ],
                  ),

                  TextField(
                    controller: _AssetIssueState.empNameController,
                    decoration: InputDecoration(
                      labelText: "Employee Name",
                    ),
                    enabled: false,
                  ),

                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: <Widget>[
                      Text(
                        "Issued By : ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IgnorePointer(
                        child: DropdownButton(
                          value: _AssetIssueState.selectedIssuedBy,
                          items: _AssetIssueState.empNo.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            debugPrint("Comment: " + newValue);
                            setState(() {
                              _AssetIssueState.selectedIssuedBy = newValue;
                              _AssetIssueState.empNameController.text =
                              _AssetIssueState.empName[_AssetIssueState.empNo
                                      .indexOf(_AssetIssueState.selectedIssuedBy)];
                            });
                          },
                        ),
                        ignoring: _DialogContentState.subformEditClicked,
                      )
                    ],
                  ),

                  TextField(
                    controller: _AssetIssueState.issuedByNameController,
                    decoration: InputDecoration(
                      labelText: "Issued by Name",
                    ),
                    enabled: false,
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
                generalClick ? generalClick = !generalClick : generalClick = generalClick;
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
                              new Padding(padding: new EdgeInsets.only(left: 5)),
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
                      onSelectAll: _assetIssueSubformDataSource.selectAll,
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
                            "Asset No.",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Asset Name",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Owner",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Value",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Manufacturer",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Model",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Owner Name",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Current Asset Location",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Posted Pur Order No.",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                      ],
                      source: _assetIssueSubformDataSource,
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
              child: Text("New - Subform"),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(2),
      content: SubformDialogContent(),
      actions: <Widget>[
        FlatButton(
          onPressed: () async{
            if(_AssetIssueState.valueController.text != "" || _AssetIssueState.postedPurOrderNoController.text != "" || _AssetIssueState.assetTypeController.text != "") {
              currSubformData = _AssetIssueState.dataSubform;

              if(currSubformData.length > 0) {

                int duplicateCheck = 0;

                for(AssetIssueSubformModel subformModel in currSubformData) {

                  if(subformModel.assetNo == _AssetIssueState.selectedAssetNo) {
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
                  currSubformData.add(AssetIssueSubformModel(
                    issueNo: _AssetIssueState.issueNoController.text,
                    assetNo: _AssetIssueState.selectedAssetNo,
                    assetName: _AssetIssueState.assetNameController.text,
                    assetType: _AssetIssueState.assetTypeController.text,
                    value: double.parse(_AssetIssueState.valueController.text),
                    owner: _AssetIssueState.ownerController.text,
                    ownerName: _AssetIssueState.ownerNameController.text,
                    manufacturar: _AssetIssueState.manufacturerController.text,
                    model: _AssetIssueState.modelController.text,
                    currentAssetLocation: _AssetIssueState.currAssetLocController.text,
                    postedPurchaseOrderNo: _AssetIssueState.postedPurOrderNoController.text,
                  ));
                  setState(() {
                    _AssetIssueState.dataSubform = currSubformData;
                    _assetIssueSubformDataSource = AssetIssueSubformDataSource(currSubformData);
                    _rowsPerPage = _AssetIssueState.dataSubform.length + 2;
                  });
                  Navigator.pop(context);
                }

              } else {
                Navigator.pop(context);
                currSubformData.add(AssetIssueSubformModel(
                  issueNo: _AssetIssueState.issueNoController.text,
                  assetNo: _AssetIssueState.selectedAssetNo,
                  assetName: _AssetIssueState.assetNameController.text,
                  assetType: _AssetIssueState.assetTypeController.text,
                  value: double.parse(_AssetIssueState.valueController.text),
                  owner: _AssetIssueState.ownerController.text,
                  ownerName: _AssetIssueState.ownerNameController.text,
                  manufacturar: _AssetIssueState.manufacturerController.text,
                  model: _AssetIssueState.modelController.text,
                  currentAssetLocation: _AssetIssueState.currAssetLocController.text,
                  postedPurchaseOrderNo: _AssetIssueState.postedPurOrderNoController.text,
                ));
                setState(() {
                  _AssetIssueState.dataSubform = currSubformData;
                  _assetIssueSubformDataSource = AssetIssueSubformDataSource(currSubformData);
                });
              }
            } else {
              Fluttertoast.showToast(
                msg: "Please enter the correct entries",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            }

          },
          child: Text("Done"),
        ),FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    );
    showDialog(context: context, builder: (BuildContext context) {
      return alert;
    });
  }
  void onSubformEditPress(BuildContext context) {
    subformEditClicked = true;

    if(_assetIssueSubformDataSource.rowSelect) {

      var alert = AlertDialog(
        titlePadding: EdgeInsets.all(2),
        title: Center(
          child: Text("Edit - Subform"),
        ),
        contentPadding: EdgeInsets.all(2),
        content: SubformDialogContent(),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if (_AssetIssueState.valueController.text != "" || _AssetIssueState.postedPurOrderNoController.text != "" || _AssetIssueState.assetTypeController.text != "") {
                Fluttertoast.showToast(
                  msg: "Please enter the correct details",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
              }
              else {
                Navigator.pop(context);
                setState(() {
                  _AssetIssueState
                          .dataSubform[_assetIssueSubformDataSource.selectedRow]
                          .value = double.parse(_AssetIssueState.valueController.text);
                  _AssetIssueState
                          .dataSubform[_assetIssueSubformDataSource.selectedRow]
                          .postedPurchaseOrderNo = _AssetIssueState.postedPurOrderNoController.text;
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
    if(_assetIssueSubformDataSource.rowSelect) {
      setState(() {
        _AssetIssueState.dataSubform.removeAt(_assetIssueSubformDataSource.selectedRow);
        _assetIssueSubformDataSource = AssetIssueSubformDataSource(_AssetIssueState.dataSubform);

        currDeleteEntry.add(
                AssetIssueSubformModel(
                  issueNo: AssetIssueSubformDataSource.selectedRowData.issueNo,
                  lineNo: AssetIssueSubformDataSource.selectedRowData.lineNo,
                  assetNo: AssetIssueSubformDataSource.selectedRowData.assetNo,
                  assetName: AssetIssueSubformDataSource.selectedRowData.assetName,
                  assetType: AssetIssueSubformDataSource.selectedRowData.assetType,
                  owner: AssetIssueSubformDataSource.selectedRowData.owner,
                  ownerName: AssetIssueSubformDataSource.selectedRowData.ownerName,
                  value: AssetIssueSubformDataSource.selectedRowData.value,
                  manufacturar: AssetIssueSubformDataSource.selectedRowData.manufacturar,
                  model: AssetIssueSubformDataSource.selectedRowData.model,
                  currentAssetLocation: AssetIssueSubformDataSource.selectedRowData.currentAssetLocation,
                  postedPurchaseOrderNo: AssetIssueSubformDataSource.selectedRowData.postedPurchaseOrderNo,
                )
        );

        _AssetIssueState.deleteEntries = currDeleteEntry;

      });
    } else {
      var alert = AlertDialog(
        content: Text("Please select a row first!"),
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
      _AssetIssueState.selectedAssetNo = _AssetIssueState.editClicked ? AssetIssueSubformDataSource.selectedRowData.assetNo : _AssetIssueState.assetNo[0];
      _AssetIssueState.assetNameController.text = _AssetIssueState.editClicked ? AssetIssueSubformDataSource.selectedRowData.assetName : _AssetIssueState.assetName[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
      _AssetIssueState.assetTypeController.text = _AssetIssueState.editClicked ? AssetIssueSubformDataSource.selectedRowData.assetType : _AssetIssueState.assetType[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
      _AssetIssueState.ownerController.text = _AssetIssueState.editClicked ? AssetIssueSubformDataSource.selectedRowData.owner : _AssetIssueState.ownerValue[int.parse(_AssetIssueState.owner[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)])];
      _AssetIssueState.valueController.text = _AssetIssueState.editClicked ? AssetIssueSubformDataSource.selectedRowData.value : "";
      _AssetIssueState.manufacturerController.text = _AssetIssueState.editClicked ? AssetIssueSubformDataSource.selectedRowData.manufacturar : _AssetIssueState.manufacturar[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
      _AssetIssueState.modelController.text = _AssetIssueState.editClicked ? AssetIssueSubformDataSource.selectedRowData.model : _AssetIssueState.model[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
      _AssetIssueState.ownerNameController.text = _AssetIssueState.editClicked ? AssetIssueSubformDataSource.selectedRowData.ownerName : _AssetIssueState.ownerName[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
      _AssetIssueState.currAssetLocController.text = _AssetIssueState.editClicked ? AssetIssueSubformDataSource.selectedRowData.currentAssetLocation : _AssetIssueState.currAssetLoc[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
      _AssetIssueState.postedPurOrderNoController.text = _AssetIssueState.editClicked ? AssetIssueSubformDataSource.selectedRowData.postedPurchaseOrderNo : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Asset No. : ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IgnorePointer(
                  child: DropdownButton(
                    value: _AssetIssueState.selectedAssetNo,
                    items: _AssetIssueState.assetNo.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      debugPrint("Comment: " + newValue);
                      setState(() {
                        _AssetIssueState.selectedAssetNo = newValue;

                        for(int i = 0 ; i < _AssetIssueState.assetNo.length ; i ++) {
                          if(_AssetIssueState.assetNo[i] == _AssetIssueState.selectedAssetNo) {
                            if(_AssetIssueState.assetIssueStatus[i] == "0") {
                              _AssetIssueState.assetNameController.text = _AssetIssueState.assetName[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
                              _AssetIssueState.assetTypeController.text = _AssetIssueState.assetType[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
                              _AssetIssueState.ownerController.text = _AssetIssueState.ownerValue[int.parse(_AssetIssueState.owner[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)])];
                              _AssetIssueState.manufacturerController.text = _AssetIssueState.manufacturar[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
                              _AssetIssueState.modelController.text = _AssetIssueState.model[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
                              _AssetIssueState.ownerNameController.text = _AssetIssueState.ownerName[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
                              _AssetIssueState.currAssetLocController.text = _AssetIssueState.currAssetLoc[_AssetIssueState.assetNo.indexOf(_AssetIssueState.selectedAssetNo)];
                            } else {
                              Fluttertoast.showToast(
                                msg: "Asset is already issued, select other",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                              );
                              _AssetIssueState.assetNameController.text = "";
                              _AssetIssueState.assetTypeController.text = "";
                              _AssetIssueState.ownerController.text = "";
                              _AssetIssueState.manufacturerController.text = "";
                              _AssetIssueState.modelController.text = "";
                              _AssetIssueState.ownerNameController.text = "";
                              _AssetIssueState.currAssetLocController.text = "";
                            }
                            break;
                          }
                        }

                      });
                    },
                  ),
                  ignoring: _DialogContentState.subformEditClicked,
                )
              ],
            ),
            TextField(
              controller: _AssetIssueState.assetNameController,
              decoration: InputDecoration(
                labelText: "Asset Name",
              ),
              enabled: false,
            ),
            TextField(
              controller: _AssetIssueState.assetTypeController,
              decoration: InputDecoration(
                labelText: "Asset Type",
              ),
              enabled: false,
            ),
            TextField(
              controller: _AssetIssueState.ownerController,
              decoration: InputDecoration(
                labelText: "Owner",
              ),
              enabled: false,
            ),
            TextField(
              controller: _AssetIssueState.valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Value",
              ),
              enabled: _AssetIssueState.textFieldEnableStatus,
            ),
            TextField(
              controller: _AssetIssueState.manufacturerController,
              decoration: InputDecoration(
                labelText: "Manufacturer",
              ),
              enabled: false,
            ),
            TextField(
              controller: _AssetIssueState.modelController,
              decoration: InputDecoration(
                labelText: "Model",
              ),
              enabled: false,
            ),
            TextField(
              controller: _AssetIssueState.ownerNameController,
              decoration: InputDecoration(
                labelText: "Owner Name",
              ),
              enabled: false,
            ),
            TextField(
              controller: _AssetIssueState.currAssetLocController,
              decoration: InputDecoration(
                labelText: "Current Asset Location",
              ),
              enabled: false,
            ),
            TextField(
              controller: _AssetIssueState.postedPurOrderNoController,
              decoration: InputDecoration(
                labelText: "Posted Purchase Order No.",
              ),
              enabled: _AssetIssueState.textFieldEnableStatus,
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
