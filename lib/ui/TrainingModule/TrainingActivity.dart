import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrpayroll/DataSource/TrainingActivityDataSource.dart';
import 'package:hrpayroll/DataSource/TrainingActivitySubformDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/TrainingActivityRequest.dart';
import 'package:hrpayroll/request_model/TrainingActivitySubformRequest.dart';
import 'package:hrpayroll/response_model/RequisitionNoResponse.dart';
import 'package:hrpayroll/response_model/TrainingActivityResponse.dart';
import 'package:hrpayroll/response_model/TrainingActivitySubformResponse.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainingActivity extends StatefulWidget {
  @override
  _TrainingActivityState createState() => _TrainingActivityState();
}

class _TrainingActivityState extends State<TrainingActivity> {

  final List<String> statusList = [
    "In-Progress",
    "Closed"
  ];

  static List<String> empNo;
  static List<String> empName;
  static List<String> empDepartment;
  static List<String> location;
  static List<String> trainingProvider;
  static List<String> trainingProviderName;
  static List<String> trainingCourse;
  static List<String> trainingCourseTitle;

  static var selectedLocation = "",
          selectedProvider = "",
          selectedCourseID = "",
          selectedStatus = "",
          selectedSubformEmp = "",
          planned = false,
          attended = false,
          certificateIssued = false,
          assessmentFilled = false;

  static TextEditingController activityNoController = TextEditingController();
  static TextEditingController courseStartDateController = TextEditingController();
  static TextEditingController courseStartTimeController = TextEditingController();
  static TextEditingController courseEndDateController = TextEditingController();
  static TextEditingController courseEndTimeController = TextEditingController();
  static TextEditingController providerNameController = TextEditingController();
  static TextEditingController courseDescriptionController = TextEditingController();

  static TextEditingController empNameController = TextEditingController();
  static TextEditingController departmentController = TextEditingController();
  static TextEditingController commentsController = TextEditingController();

  static TextEditingController cancelCommentController = TextEditingController();


  Future<TrainingActivityResponse> updateTableResponse;
  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();

  ApiInterface _apiInterface6 = ApiInterface();
  ApiInterface _apiInterface7 = ApiInterface();
  ApiInterface _apiInterface8 = ApiInterface();

  static List<TrainingActivityModel> data = List();
  TrainingActivityDataSource _trainingActivityDataSource = TrainingActivityDataSource(data);

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  static bool textFieldEnableStatus = true;
  static bool editClicked = false;

  static List<TrainingActivitySubformModel> dataSubform = List();
  static List<TrainingActivitySubformModel> deleteEntries = List();

  void getSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getStringList("empNo");
    empName = sharedPreferences.getStringList("empName");
    empDepartment = sharedPreferences.getStringList("empDepartment");
    location = sharedPreferences.getStringList("location");
    trainingProvider = sharedPreferences.getStringList("trainingProvider");
    trainingProviderName = sharedPreferences.getStringList("trainingProviderName");
    trainingCourse = sharedPreferences.getStringList("trainingCourse");
    trainingCourseTitle = sharedPreferences.getStringList("trainingCourseTitle");
  }

  @override
  void initState() {
    super.initState();
    TrainingActivityRequest trainingActivityRequest = TrainingActivityRequest(
      action: 1,
      status: 0,
    );
    setState(() {
      updateTableResponse =
              _apiInterface1.trainingActivityResponseData(trainingActivityRequest);
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
                      "Training Activity",
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
              builder: (BuildContext context, AsyncSnapshot<TrainingActivityResponse> snapshot) {
                if(snapshot.hasData) {
                  TrainingActivityResponse _myResponseData = snapshot.data;
                  _trainingActivityDataSource = TrainingActivityDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 && _myResponseData.data.length > 0) ? _myResponseData.data.length : _rowsPerPage,
                    onSelectAll: _trainingActivityDataSource.selectAll,
                    header: Text(""),
                    columns: [
                      DataColumn(
                        label: new Text(
                          "Activity No",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Location",
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
                          "Training Provider",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Course ID",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Start Date",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Start Time",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "End Date",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "End Time",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Joining Instruction Doc",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Provider Name",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: new Text(
                          "Course Description",
                          style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                    ],
                    source: _trainingActivityDataSource,
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
                        onSelectAll: _trainingActivityDataSource.selectAll,
                        header: Text(""),
                        columns: [
                          DataColumn(
                            label: new Text(
                              "Activity No",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Location",
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
                              "Training Provider",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Course ID",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Start Date",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Start Time",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "End Date",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "End Time",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Joining Instruction Doc",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Provider Name",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: new Text(
                              "Course Description",
                              style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ),
                          ),
                        ],
                        source: _trainingActivityDataSource,
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
              child: Text("New - Training Activity"),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(2),
      content: DialogContent(),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            if(courseStartDateController.text.isEmpty ||
                    courseStartTimeController.text.isEmpty ||
                    courseEndDateController.text.isEmpty ||
                    courseEndTimeController.text.isEmpty) {
              Fluttertoast.showToast(
                msg: "One or more blank entries",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            } else {
              Navigator.pop(context);
              TrainingActivityResponse trainingActivityResponse =
              await _apiInterface2.trainingActivityResponseData(
                      TrainingActivityRequest(
                        action: 2,
                        activityNo: activityNoController.text,
                        startDate: courseStartDateController.text,
                        startTime: courseStartTimeController.text,
                        endDate: courseEndDateController.text,
                        endTime: courseEndTimeController.text,
                        location: selectedLocation,
                        providerId: selectedProvider,
                        providerName: providerNameController.text,
                        courseId: selectedCourseID,
                        courseDescription: courseDescriptionController.text,
                        status: statusList.indexOf(selectedStatus),
                      )
              );

              if(trainingActivityResponse.status) {
                TrainingActivityRequest trainingActivityRequest = TrainingActivityRequest(
                  action: 1,
                  status: 0,
                );
                setState(() {
                  updateTableResponse =
                          _apiInterface1.trainingActivityResponseData(trainingActivityRequest);
                });
              }
              Fluttertoast.showToast(
                msg: "${trainingActivityResponse.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
              /*var alert = AlertDialog(content: Text(trainingActivityResponse.message));
              showDialog(
                context: context,
                builder: (context) {
                  return alert;
                },
              );*/

              for(TrainingActivitySubformModel trainingActivitySubformModel in dataSubform) {
                TrainingActivitySubformResponse trainingActivitySubformResponse =
                await _apiInterface6.trainingActivitySubformResponseData(
                        TrainingActivitySubformRequest(
                          action: 2,
                          activityNo: activityNoController.text,
                          employeeNo: trainingActivitySubformModel.employeeNo,
                          employeeName: trainingActivitySubformModel.employeeName,
                          planned: trainingActivitySubformModel.planned == 1 ? 1 : 0,
                          attended: trainingActivitySubformModel.attended == 1 ? 1 : 0,
                          certificateIssued: trainingActivitySubformModel.certificateIssued == 1 ? 1 : 0,
                          department: trainingActivitySubformModel.departmentCode,
                          confAssementFilled: trainingActivitySubformModel.confirmationAssessmentFilled == 1 ? 1 : 0,
                          comment: trainingActivitySubformModel.comments,
                        )
                );
                if(!trainingActivitySubformResponse.status){
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

    if (_trainingActivityDataSource.rowSelect) {
      if (TrainingActivityDataSource.selectedRowData.status == "In-Progress") {
        if (TrainingActivityDataSource.selectedRowData.status == statusList[1]) {
          textFieldEnableStatus = false;
          Fluttertoast.showToast(
            msg:
            "Document is ${TrainingActivityDataSource.selectedRowData.status} cannot be edited",
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
                if (courseStartDateController.text.isEmpty ||
                        courseStartTimeController.text.isEmpty ||
                        courseEndDateController.text.isEmpty ||
                        courseEndTimeController.text.isEmpty) {
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

//                  if (selectedStatus == statusList[4]) {
//                    RejCanPostResponse rejCanResponse =
//                    await _apiInterface3.assetReqRejCanResponseData(
//                        AssessmentApprovalRequest(
//                          action: "5",
//                          sequenceNo: "0",
//                          senderId: selectedEmp,
//                          status: "4",
//                          requisitionNo: requisitionNoController.text,
//                          cancellationComment: cancelCommentController.text,
//                        ));
//
//                    if (rejCanResponse.status) {
//                      TrainingActivityRequest trainingActivityRequest = TrainingActivityRequest(
//                        action: 1,
//                        status: 0,
//                      );
//                      setState(() {
//                        updateTableResponse =
//                            _apiInterface1.trainingActivityResponseData(trainingActivityRequest);
//                      });
//                    }
//
//                    var alert =
//                    AlertDialog(content: Text(rejCanResponse.message));
//                    showDialog(
//                      context: context,
//                      builder: (context) {
//                        return alert;
//                      },
//                    );
//                  } else {}

                  TrainingActivityResponse trainingActivityResponse =
                  await _apiInterface2.trainingActivityResponseData(
                          TrainingActivityRequest(
                            action: 3,
                            activityNo: activityNoController.text,
                            startDate: courseStartDateController.text,
                            startTime: courseStartTimeController.text,
                            endDate: courseEndDateController.text,
                            endTime: courseEndTimeController.text,
                            location: selectedLocation,
                            providerId: selectedProvider,
                            providerName: providerNameController.text,
                            courseId: selectedCourseID,
                            courseDescription: courseDescriptionController.text,
                            status: statusList.indexOf(selectedStatus),
                          ));

                  if (trainingActivityResponse.status) {
                    TrainingActivityRequest trainingActivityRequest = TrainingActivityRequest(
                      action: 1,
                      status: 0,
                    );
                    setState(() {
                      updateTableResponse =
                              _apiInterface1.trainingActivityResponseData(trainingActivityRequest);
                    });
                  }
                  Fluttertoast.showToast(
                    msg: "${trainingActivityResponse.message}",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                  );

                  /*var alert = AlertDialog(
                      content: Text(trainingActivityResponse.message));
                  showDialog(
                    context: context,
                    builder: (context) {
                      return alert;
                    },
                  );*/

                  for(TrainingActivitySubformModel trainingActSubMod in dataSubform) {
                    TrainingActivitySubformResponse trainingActSubformResponse =
                    await _apiInterface6.trainingActivitySubformResponseData(
                            TrainingActivitySubformRequest(
                              action: 2,
                              activityNo: activityNoController.text,
                              employeeNo: trainingActSubMod.employeeNo,
                              employeeName: trainingActSubMod.employeeName,
                              planned: trainingActSubMod.planned == 1 ? 1 : 0,
                              attended: trainingActSubMod.attended == 1 ? 1 : 0,
                              certificateIssued: trainingActSubMod.certificateIssued == 1 ? 1 : 0,
                              department: trainingActSubMod.departmentCode,
                              confAssementFilled: trainingActSubMod.confirmationAssessmentFilled == 1 ? 1 : 0,
                              comment: trainingActSubMod.comments,
                            )
                    );
                  }
                  for(TrainingActivitySubformModel trainingActSubMod in deleteEntries) {
                    TrainingActivitySubformResponse trainingActSubformResponse =
                    await _apiInterface8.trainingActivitySubformResponseData(
                            TrainingActivitySubformRequest(
                              action: 4,
                              activityNo: activityNoController.text,
                              employeeNo: trainingActSubMod.employeeNo,
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
                setState(() {
                  editClicked = false;
                });
              },
              child: Text("No"),
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
                  "Document is ${TrainingActivityDataSource.selectedRowData.status} status and cannot be edited"),
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
        TrainingActivityDataSource.selectedRowData.selected = false;
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
    var activityNo = TrainingActivityDataSource.selectedRowData.activityNo;
    if (_trainingActivityDataSource.rowSelect) {
      if (TrainingActivityDataSource.selectedRowData.status == "In-Progress") {
        var alert = AlertDialog(
          content: Text("Are you sure you want to delete this entry!?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
                TrainingActivityResponse assetReqResponse =
                await _apiInterface2.trainingActivityResponseData(
                        TrainingActivityRequest(
                          action: 4,
                          activityNo: activityNo,
                        ));

                if (assetReqResponse.status) {
                  TrainingActivityRequest trainingActivityRequest = TrainingActivityRequest(
                    action: 1,
                    status: 0,
                  );
                  setState(() {
                    updateTableResponse =
                            _apiInterface1.trainingActivityResponseData(trainingActivityRequest);
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

                TrainingActivitySubformResponse trainingActSubformResponse =
                await _apiInterface7.trainingActivitySubformResponseData(
                        TrainingActivitySubformRequest(
                          action: 1,
                          activityNo: activityNo,
                          planned: 0,
                          attended: 0,
                          certificateIssued: 0,
                          confAssementFilled: 0,
                        )
                );

                if(trainingActSubformResponse.status){
                  for(TrainingActivitySubformModel trainingActSubMod in trainingActSubformResponse.data) {
                    TrainingActivitySubformResponse trainingActSubformResponse =
                    await _apiInterface6.trainingActivitySubformResponseData(
                            TrainingActivitySubformRequest(
                              action: 4,
                              activityNo: activityNo,
                              employeeNo: trainingActSubMod.employeeNo,
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
                  "Document is ${TrainingActivityDataSource.selectedRowData.status} status and cannot be deleted"),
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
  _TrainingActivityState _trainingActivityState = _TrainingActivityState();

  ApiInterface _apiInterface4 = ApiInterface();
  ApiInterface _apiInterface5 = ApiInterface();

  static List<TrainingActivitySubformModel> dupCurrSubformData = List();
  TrainingActivitySubformDataSource _trainingActivitySubformDataSource = TrainingActivitySubformDataSource(dupCurrSubformData);

  Widget iconWidgetDown = Icon(Icons.keyboard_arrow_down);
  Widget iconWidgetUp = Icon(Icons.keyboard_arrow_up);

  bool generalClick = false, subformClick = false;
  static bool subformEditClicked = false;

  List<TrainingActivitySubformModel> currSubformData = List();
  List<TrainingActivitySubformModel> currDeleteEntry = List();

  int _rowsPerPage = 2;

  void getRequisitionNo() async{
    NoSeriesResponse activityNoResponse = await _apiInterface5.activityNoReasponseData();

    _TrainingActivityState.activityNoController.text = activityNoResponse.message;
  }

  void getSubformData() async{
    TrainingActivitySubformResponse _mySubformResponse =
    await _apiInterface4.trainingActivitySubformResponseData(
            TrainingActivitySubformRequest(
              action: 1,
              activityNo: _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.activityNo : "",
              planned: 0,
              attended: 0,
              certificateIssued: 0,
              confAssementFilled: 0,
            )
    );
    _trainingActivitySubformDataSource = TrainingActivitySubformDataSource(_mySubformResponse.data);
    _rowsPerPage = _mySubformResponse.data.length + 2;

    _TrainingActivityState.dataSubform = _mySubformResponse.data;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if(_TrainingActivityState.editClicked)
        _TrainingActivityState.activityNoController.text = TrainingActivityDataSource.selectedRowData.activityNo;
      else
        getRequisitionNo();

      _TrainingActivityState.courseStartDateController.text = _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.courseStartDate : "";
      _TrainingActivityState.courseStartTimeController.text = _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.courseStartTime : "";
      _TrainingActivityState.courseEndDateController.text = _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.courseEndDate : "";
      _TrainingActivityState.courseEndTimeController.text = _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.courseEndTime : "";

      _TrainingActivityState.selectedLocation = _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.trainingLocation : _TrainingActivityState.location[0];
      _TrainingActivityState.selectedProvider = _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.trainingProvider : _TrainingActivityState.trainingProvider[0];
      _TrainingActivityState.providerNameController.text = _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.trainingProviderName : _TrainingActivityState.trainingProviderName[_TrainingActivityState.trainingProvider.indexOf(_TrainingActivityState.selectedProvider)];
      _TrainingActivityState.selectedCourseID = _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.courseId : _TrainingActivityState.trainingCourse[0];
      _TrainingActivityState.courseDescriptionController.text = _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.courseDescription : _TrainingActivityState.trainingCourseTitle[_TrainingActivityState.trainingCourse.indexOf(_TrainingActivityState.selectedCourseID)];

      _TrainingActivityState.selectedStatus = _TrainingActivityState.editClicked ? TrainingActivityDataSource.selectedRowData.status : _trainingActivityState.statusList[0];

      getSubformData();
    });
  }

  var formatter = new DateFormat('MM/dd/yyyy');

  DateTime startDate = DateTime.now();

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        startDate = picked;
        _TrainingActivityState.courseStartDateController.text = formatter.format(startDate);
      });
  }

  DateTime endDate = DateTime.now();

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked != null)
      setState(() {
        endDate = picked;
        _TrainingActivityState.courseEndDateController.text = formatter.format(endDate);
      });
  }

  TimeOfDay startTime = TimeOfDay.now();

  Future<Null> _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null)
      setState(() {
        startTime = picked;
        _TrainingActivityState.courseStartTimeController.text =
                startTime.hour.toString() + ":" + startTime.minute.toString() + ":00";
      });
  }

  TimeOfDay endTime = TimeOfDay.now();

  Future<Null> _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null)
      setState(() {
        endTime = picked;
        _TrainingActivityState.courseEndTimeController.text =
                endTime.hour.toString() + ":" + endTime.minute.toString() + ":00";
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
                      Text("Are you sure you want to close this Training Activity?"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              _TrainingActivityState.selectedStatus =
                              _trainingActivityState.statusList[1];
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
                      Icon(Icons.close),
                      Text("Close Training")
                    ],
                  ),
                ),
              ],
            ),
            visible: _TrainingActivityState.editClicked,
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
                    controller: _TrainingActivityState.activityNoController,
                    decoration: InputDecoration(
                      labelText: "Activity No",
                    ),
                    enabled: false,
                  ),
                  TextField(
                    controller: _TrainingActivityState.courseStartDateController,
                    decoration: InputDecoration(
                      labelText: "Course Start Date",
                    ),
                    enableInteractiveSelection: false,
                    focusNode: NoKeyboardEditableTextFocusNode(),
                    onTap: () {
                      _selectStartDate(context);
                    },
                    enabled: _TrainingActivityState.textFieldEnableStatus,
                  ),
                  TextField(
                    controller: _TrainingActivityState.courseStartTimeController,
                    decoration: InputDecoration(
                      labelText: "Course Start Time",
                    ),
                    enableInteractiveSelection: false,
                    focusNode: NoKeyboardEditableTextFocusNode(),
                    onTap: () {
                      _selectStartTime(context);
                    },
                    enabled: _TrainingActivityState.textFieldEnableStatus,
                  ),
                  TextField(
                    controller: _TrainingActivityState.courseEndDateController,
                    decoration: InputDecoration(
                      labelText: "Course End Date",
                    ),
                    enableInteractiveSelection: false,
                    focusNode: NoKeyboardEditableTextFocusNode(),
                    onTap: () {
                      _selectEndDate(context);
                    },
                    enabled: _TrainingActivityState.textFieldEnableStatus,
                  ),
                  TextField(
                    controller: _TrainingActivityState.courseEndTimeController,
                    decoration: InputDecoration(
                      labelText: "Course End Time",
                    ),
                    enableInteractiveSelection: false,
                    focusNode: NoKeyboardEditableTextFocusNode(),
                    onTap: () {
                      _selectEndTime(context);
                    },
                    enabled: _TrainingActivityState.textFieldEnableStatus,
                  ),

                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: <Widget>[
                      Text(
                        "Training Location : ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IgnorePointer(
                        child: DropdownButton(
                          value: _TrainingActivityState.selectedLocation,
                          items: _TrainingActivityState.location.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            debugPrint("Comment: " + newValue);
                            setState(() {
                              _TrainingActivityState.selectedLocation = newValue;
                            });
                          },
                        ),
                        ignoring: !_TrainingActivityState.textFieldEnableStatus,
                      )
                    ],
                  ),

                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: <Widget>[
                      Text(
                        "Training Provider : ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IgnorePointer(
                        child: DropdownButton(
                          value: _TrainingActivityState.selectedProvider,
                          items: _TrainingActivityState.trainingProvider.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            debugPrint("Comment: " + newValue);
                            setState(() {
                              _TrainingActivityState.selectedProvider = newValue;
                              _TrainingActivityState.providerNameController.text =
                              _TrainingActivityState.trainingProviderName[_TrainingActivityState.trainingProvider
                                      .indexOf(_TrainingActivityState.selectedProvider)];
                            });
                          },
                        ),
                        ignoring: !_TrainingActivityState.textFieldEnableStatus,
                      )
                    ],
                  ),

                  TextField(
                    controller: _TrainingActivityState.providerNameController,
                    decoration: InputDecoration(
                      labelText: "Training Provider Name",
                    ),
                    enabled: false,
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
                          value: _TrainingActivityState.selectedCourseID,
                          items: _TrainingActivityState.trainingCourse.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            debugPrint("Comment: " + newValue);
                            setState(() {
                              _TrainingActivityState.selectedCourseID = newValue;
                              _TrainingActivityState.courseDescriptionController.text =
                              _TrainingActivityState.trainingCourseTitle[_TrainingActivityState.trainingCourse
                                      .indexOf(_TrainingActivityState.selectedCourseID)];
                            });
                          },
                        ),
                        ignoring: !_TrainingActivityState.textFieldEnableStatus,
                      )
                    ],
                  ),

                  TextField(
                    controller: _TrainingActivityState.courseDescriptionController,
                    decoration: InputDecoration(
                      labelText: "Course Description",
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
                          value: _TrainingActivityState.selectedStatus,
                          items: _trainingActivityState.statusList.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              _TrainingActivityState.selectedStatus = newValue;
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
                      onSelectAll: _trainingActivitySubformDataSource.selectAll,
                      header: Text(""),
                      columns: [
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
                            "Planned",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Attended",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Certificate Issued",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Department Code",
                            style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                        ),
                        DataColumn(
                          label: new Text(
                            "Confirmation Assesment Filled",
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
                      ],
                      source: _trainingActivitySubformDataSource,
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
            /*if(_TrainingActivityState.quantityController.text.isNotEmpty) {

            } else {
              Fluttertoast.showToast(
                msg: "please enter the correct quantity",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );
            }*/

            currSubformData = _TrainingActivityState.dataSubform;

            if(currSubformData.length > 0) {

              int duplicateCheck = 0;

              for(TrainingActivitySubformModel subformModel in currSubformData) {

                if(subformModel.employeeNo == _TrainingActivityState.selectedSubformEmp) {
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
                currSubformData.add(TrainingActivitySubformModel(
                  employeeNo: _TrainingActivityState.selectedSubformEmp,
                  employeeName: _TrainingActivityState.empNameController.text,
                  planned: _TrainingActivityState.planned ? 1 : 0,
                  attended: _TrainingActivityState.attended ? 1 : 0,
                  certificateIssued: _TrainingActivityState.certificateIssued ? 1 : 0,
                  departmentCode: _TrainingActivityState.departmentController.text,
                  confirmationAssessmentFilled: _TrainingActivityState.assessmentFilled ? 1 : 0,
                  comments: _TrainingActivityState.commentsController.text,
                ));
                setState(() {
                  _TrainingActivityState.dataSubform = currSubformData;
                  _trainingActivitySubformDataSource = TrainingActivitySubformDataSource(currSubformData);
                  _rowsPerPage = _TrainingActivityState.dataSubform.length + 2;
                });
                Navigator.pop(context);
              }

            } else {
              Navigator.pop(context);
              currSubformData.add(TrainingActivitySubformModel(
                employeeNo: _TrainingActivityState.selectedSubformEmp,
                employeeName: _TrainingActivityState.empNameController.text,
                planned: _TrainingActivityState.planned ? 1 : 0,
                attended: _TrainingActivityState.attended ? 1 : 0,
                certificateIssued: _TrainingActivityState.certificateIssued ? 1 : 0,
                departmentCode: _TrainingActivityState.departmentController.text,
                confirmationAssessmentFilled: _TrainingActivityState.assessmentFilled ? 1 : 0,
                comments: _TrainingActivityState.commentsController.text,
              ));
              setState(() {
                _TrainingActivityState.dataSubform = currSubformData;
                _trainingActivitySubformDataSource = TrainingActivitySubformDataSource(currSubformData);
              });
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

    if(_trainingActivitySubformDataSource.rowSelect) {

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
              /*if (_TrainingActivityState.quantityController.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: "please enter the correct quantity",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                );
              }
              else {

              }*/

              Navigator.pop(context);
              setState(() {
                _TrainingActivityState
                        .dataSubform[_trainingActivitySubformDataSource.selectedRow]
                        .planned = _TrainingActivityState.planned ? 1 : 0;
                _TrainingActivityState
                        .dataSubform[_trainingActivitySubformDataSource.selectedRow]
                        .attended = _TrainingActivityState.attended ? 1 : 0;
                _TrainingActivityState
                        .dataSubform[_trainingActivitySubformDataSource.selectedRow]
                        .certificateIssued =
                _TrainingActivityState.certificateIssued ? 1 : 0;
                _TrainingActivityState
                        .dataSubform[_trainingActivitySubformDataSource.selectedRow]
                        .confirmationAssessmentFilled =
                _TrainingActivityState.assessmentFilled ? 1 : 0;
                _TrainingActivityState
                        .dataSubform[_trainingActivitySubformDataSource.selectedRow]
                        .comments = _TrainingActivityState.commentsController.text;
                _trainingActivitySubformDataSource =
                        TrainingActivitySubformDataSource(
                                _TrainingActivityState.dataSubform);
                subformEditClicked = false;
              });
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
    if(_trainingActivitySubformDataSource.rowSelect) {
      setState(() {
        _TrainingActivityState.dataSubform.removeAt(_trainingActivitySubformDataSource.selectedRow);
        _trainingActivitySubformDataSource = TrainingActivitySubformDataSource(_TrainingActivityState.dataSubform);

        currDeleteEntry.add(
                TrainingActivitySubformModel(
                  activityNo: TrainingActivitySubformDataSource.selectedRowData.activityNo,
                  employeeNo: TrainingActivitySubformDataSource.selectedRowData.employeeNo,
                  employeeName: TrainingActivitySubformDataSource.selectedRowData.employeeName,
                  planned: TrainingActivitySubformDataSource.selectedRowData.planned,
                  attended: TrainingActivitySubformDataSource.selectedRowData.attended,
                  certificateIssued: TrainingActivitySubformDataSource.selectedRowData.certificateIssued,
                  departmentCode: TrainingActivitySubformDataSource.selectedRowData.departmentCode,
                  confirmationAssessmentFilled: TrainingActivitySubformDataSource.selectedRowData.confirmationAssessmentFilled,
                  comments: TrainingActivitySubformDataSource.selectedRowData.comments,
                )
        );

        _TrainingActivityState.deleteEntries = currDeleteEntry;

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
      _TrainingActivityState.selectedSubformEmp =
      _TrainingActivityState.editClicked ? TrainingActivitySubformDataSource
              .selectedRowData.employeeNo : _TrainingActivityState.empNo[0];
      _TrainingActivityState.empNameController.text =
      _TrainingActivityState.editClicked ? TrainingActivitySubformDataSource
              .selectedRowData.employeeName : _TrainingActivityState
              .empName[_TrainingActivityState.empNo.indexOf(
              _TrainingActivityState.selectedSubformEmp)];
      _TrainingActivityState.departmentController.text =
      _TrainingActivityState.editClicked ? TrainingActivitySubformDataSource
              .selectedRowData.departmentCode : _TrainingActivityState
              .empDepartment[_TrainingActivityState.empNo.indexOf(
              _TrainingActivityState.selectedSubformEmp)];

      _TrainingActivityState.planned = _TrainingActivityState.editClicked
              ? (TrainingActivitySubformDataSource.selectedRowData.planned == 1
              ? true
              : false)
              : false;

      _TrainingActivityState.attended = _TrainingActivityState.editClicked
              ? (TrainingActivitySubformDataSource.selectedRowData.attended == 1
              ? true
              : false)
              : false;

      _TrainingActivityState.certificateIssued =
      _TrainingActivityState.editClicked
              ? (TrainingActivitySubformDataSource.selectedRowData
              .certificateIssued == 1
              ? true
              : false)
              : false;

      _TrainingActivityState.assessmentFilled =
      _TrainingActivityState.editClicked
              ? (TrainingActivitySubformDataSource.selectedRowData
              .confirmationAssessmentFilled == 1
              ? true
              : false)
              : false;

      _TrainingActivityState.commentsController.text =
      _TrainingActivityState.editClicked ? TrainingActivitySubformDataSource
              .selectedRowData.departmentCode : "";
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
                  "Employee No. : ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IgnorePointer(
                  child: DropdownButton(
                    value: _TrainingActivityState.selectedSubformEmp,
                    items: _TrainingActivityState.empNo.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      debugPrint("Comment: " + newValue);
                      setState(() {
                        _TrainingActivityState.selectedSubformEmp = newValue;
                        _TrainingActivityState.empNameController.text =
                        _TrainingActivityState.empName[_TrainingActivityState.empNo
                                .indexOf(_TrainingActivityState.selectedSubformEmp)];
                        _TrainingActivityState.departmentController.text =
                        _TrainingActivityState.empDepartment[_TrainingActivityState
                                .empNo
                                .indexOf(_TrainingActivityState.selectedSubformEmp)];
                      });
                    },
                  ),
                  ignoring: _DialogContentState.subformEditClicked,
                )
              ],
            ),
            TextField(
              controller: _TrainingActivityState.empNameController,
              decoration: InputDecoration(
                labelText: "Employee Name",
              ),
              enabled: false,
            ),
            TextField(
              controller: _TrainingActivityState.departmentController,
              decoration: InputDecoration(
                labelText: "Department",
              ),
              enabled: false,
            ),

            Row(
              children: <Widget>[
                Text(
                  "Planned",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IgnorePointer(
                  child: Checkbox(
                    value: _TrainingActivityState.planned,
                    onChanged: (bool value) {
                      setState(() {
                        _TrainingActivityState.
                        planned = value;
                      });
                    },
                  ),
                  ignoring: !_TrainingActivityState.textFieldEnableStatus,
                )
              ],
            ),

            Row(
              children: <Widget>[
                Text(
                  "Attended",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IgnorePointer(
                  child: Checkbox(
                    value: _TrainingActivityState.attended,
                    onChanged: (bool value) {
                      setState(() {
                        _TrainingActivityState.attended = value;
                      });
                    },
                  ),
                  ignoring: !_TrainingActivityState.textFieldEnableStatus,
                )
              ],
            ),

            Row(
              children: <Widget>[
                Text(
                  "Certificate Issued",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IgnorePointer(
                  child: Checkbox(
                    value: _TrainingActivityState.certificateIssued,
                    onChanged: (bool value) {
                      setState(() {
                        _TrainingActivityState.certificateIssued= value;
                      });
                    },
                  ),
                  ignoring: !_TrainingActivityState.textFieldEnableStatus,
                )
              ],
            ),

            Row(
              children: <Widget>[
                Text(
                  "Conf. Assesment Filled",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IgnorePointer(
                  child: Checkbox(
                    value: _TrainingActivityState.assessmentFilled,
                    onChanged: (bool value) {
                      setState(() {
                        _TrainingActivityState.assessmentFilled = value;
                      });
                    },
                  ),
                  ignoring: !_TrainingActivityState.textFieldEnableStatus,
                )
              ],
            ),

            TextField(
              controller: _TrainingActivityState.commentsController,
              decoration: InputDecoration(
                labelText: "Comment",
              ),
              enabled: _TrainingActivityState.textFieldEnableStatus,
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
