import 'package:flutter/material.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/LeaveMasterRequest.dart';
import 'package:hrpayroll/request_model/TrainingProviderCourseRequest.dart';
import 'package:hrpayroll/response_model/EmployeeMasterResponse.dart';
import 'package:hrpayroll/response_model/FixedAssetResponse.dart';
import 'package:hrpayroll/response_model/LeaveMasterResponse.dart';
import 'package:hrpayroll/response_model/LookupResponse.dart';
import 'package:hrpayroll/response_model/TrainingCourseResponse.dart';
import 'package:hrpayroll/response_model/TrainingProviderResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './MyAppBar.dart';
import './MyDrawer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void enterEmpDetailsToSharedPref(
      List<String> empNo,
      List<String> empName,
      List<String> empDesignation,
      List<String> empDepartment,
      List<String> passportRetentionReq,
      List<String> passportObtained,
      List<String> passportReleased) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("empNo", empNo);
    sharedPreferences.setStringList("empName", empName);
    sharedPreferences.setStringList("empDesignation", empDesignation);
    sharedPreferences.setStringList("empDepartment", empDepartment);
    sharedPreferences.setStringList(
        "passportRetentionReq", passportRetentionReq);
    sharedPreferences.setStringList("passportObtained", passportObtained);
    sharedPreferences.setStringList("passportReleased", passportReleased);
  }

  void enterLeaveDetailsToSharedPref(
      List<String> leaveCode, List<String> leaveDescription) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("leaveCode", leaveCode);
    sharedPreferences.setStringList("leaveDescription", leaveDescription);
  }

  void enterLookupToSharedPref(String lookupNo, List<String> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (lookupNo) {
      case "13":
        {
          sharedPreferences.setStringList("assetType", data);
          break;
        }
      case "14":
        {
          sharedPreferences.setStringList("transactionType", data);
          break;
        }
      case "17":
        {
          sharedPreferences.setStringList("location", data);
          break;
        }
    }
  }

  void enterTrainingCourseDetailsToSharedPref(
      List<String> trainingCourse, List<String> trainingCourseTitle) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("trainingCourse", trainingCourse);
    sharedPreferences.setStringList("trainingCourseTitle", trainingCourseTitle);
  }

  void enterTrainingProviderDetailsToSharedPref(
      List<String> trainingProvider, List<String> trainingProviderName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("trainingProvider", trainingProvider);
    sharedPreferences.setStringList(
        "trainingProviderName", trainingProviderName);
  }

  void enterAssetDetailsToSharedPref(
      List<String> assetNo,
      List<String> assetName,
      List<String> assetType,
      List<String> owner,
      List<String> ownerName,
      List<String> manufacturar,
      List<String> model,
      List<String> currAssetLoc,
      List<String> assetIssueStatus) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("assetNo", assetNo);
    sharedPreferences.setStringList("assetName", assetName);
    sharedPreferences.setStringList("assetType", assetType);
    sharedPreferences.setStringList("owner", owner);
    sharedPreferences.setStringList("ownerName", ownerName);
    sharedPreferences.setStringList("manufacturar", manufacturar);
    sharedPreferences.setStringList("model", model);
    sharedPreferences.setStringList("currAssetLoc", currAssetLoc);
    sharedPreferences.setStringList("assetIssueStatus", assetIssueStatus);
  }

  ApiInterface _apiInterface1 = ApiInterface();
  ApiInterface _apiInterface2 = ApiInterface();
  ApiInterface _apiInterface3 = ApiInterface();
  ApiInterface _apiInterface4 = ApiInterface();
  ApiInterface _apiInterface5 = ApiInterface();
  ApiInterface _apiInterface6 = ApiInterface();
  ApiInterface _apiInterface7 = ApiInterface();
  ApiInterface _apiInterface8 = ApiInterface();

  @override
  void initState() {
    MyDrawer.getEmployeeNo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3600000), () {
      setState(() {
        Navigator.pop(context);
      });
    });

    return new Scaffold(
      appBar: MyAppBar.getAppBar("Welcome"),
      drawer: new MyDrawer(),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _apiInterface8
                .getAssetDetailsResponseData(TrainingProviderCourseRequest(
              action: 1,
            )),
            builder: (BuildContext context,
                AsyncSnapshot<FixedAssetResponse> snapshot) {
              if (snapshot.hasData) {
                if (!snapshot.data.status) {
                  var alert = new AlertDialog(
                    title: new Text("Caution!"),
                    content: new Text(snapshot.data.message),
                    actions: <Widget>[
                      new FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: new Text("ok")),
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (context) {
                        return alert;
                      });
                }
                FixedAssetResponse fixedAssetResponse = snapshot.data;
                if (fixedAssetResponse.status) {
                  List<String> assetNo = List();
                  List<String> assetName = List();
                  List<String> assetType = List();
                  List<String> owner = List();
                  List<String> ownerName = List();
                  List<String> manufacturar = List();
                  List<String> model = List();
                  List<String> currAssetLoc = List();
                  List<String> assetIssueStatus = List();

                  for (int i = 0; i < fixedAssetResponse.data.length; i++) {
                    assetNo.add(fixedAssetResponse.data[i].no);
                    assetName.add(fixedAssetResponse.data[i].description);
                    assetType.add(fixedAssetResponse.data[i].assetType);
                    owner.add(fixedAssetResponse.data[i].owner.toString());
                    ownerName.add(fixedAssetResponse.data[i].ownerName);
                    manufacturar.add(fixedAssetResponse.data[i].manufacturar);
                    model.add(fixedAssetResponse.data[i].model);
                    currAssetLoc
                        .add(fixedAssetResponse.data[i].currentAssetLocation);
                    assetIssueStatus
                        .add(fixedAssetResponse.data[i].issued.toString());
                  }
                  enterAssetDetailsToSharedPref(
                    assetNo,
                    assetName,
                    assetType,
                    owner,
                    ownerName,
                    manufacturar,
                    model,
                    currAssetLoc,
                    assetIssueStatus,
                  );
                }
                return Container();
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
                  ],
                );
              }
            },
          ),
          FutureBuilder(
            future: _apiInterface7
                .trainingProviderResponseData(TrainingProviderCourseRequest(
              action: 1,
            )),
            builder: (BuildContext context,
                AsyncSnapshot<TrainingProviderResponse> snapshot) {
              if (snapshot.hasData) {
                TrainingProviderResponse trainingProviderResponse =
                    snapshot.data;
                if (trainingProviderResponse.status) {
                  List<String> trainingProvider = List();
                  List<String> trainingProviderName = List();

                  for (int i = 0;
                      i < trainingProviderResponse.data.length;
                      i++) {
                    trainingProvider
                        .add(trainingProviderResponse.data[i].providerNo);
                    trainingProviderName
                        .add(trainingProviderResponse.data[i].providerName);
                  }
                  enterTrainingProviderDetailsToSharedPref(
                      trainingProvider, trainingProviderName);
                }
                return Container();
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
                  ],
                );
              }
            },
          ),
          FutureBuilder(
            future: _apiInterface6
                .trainingCourseResponseData(TrainingProviderCourseRequest(
              action: 1,
            )),
            builder: (BuildContext context,
                AsyncSnapshot<TrainingCourseResponse> snapshot) {
              if (snapshot.hasData) {
                TrainingCourseResponse trainingCourseResponse = snapshot.data;
                if (trainingCourseResponse.status) {
                  List<String> trainingCourse = List();
                  List<String> trainingCourseTitle = List();

                  for (int i = 0; i < trainingCourseResponse.data.length; i++) {
                    trainingCourse.add(trainingCourseResponse.data[i].courseId);
                    trainingCourseTitle
                        .add(trainingCourseResponse.data[i].courseDescription);
                  }
                  enterTrainingCourseDetailsToSharedPref(
                      trainingCourse, trainingCourseTitle);
                }
                return Container();
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
                  ],
                );
              }
            },
          ),
          FutureBuilder(
            future: _apiInterface3.lookupResponseData("13"),
            builder:
                (BuildContext context, AsyncSnapshot<LookupResponse> snapshot) {
              if (snapshot.hasData) {
                LookupResponse lookupResponse = snapshot.data;
                if (lookupResponse.status) {
                  List<String> data = List();

                  for (int i = 0; i < lookupResponse.data.length; i++) {
                    data.add(lookupResponse.data[i].lookupName);
                  }
                  enterLookupToSharedPref("13", data);
                }
                return Container();
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
                  ],
                );
              }
            },
          ),
          FutureBuilder(
            future: _apiInterface4.lookupResponseData("14"),
            builder:
                (BuildContext context, AsyncSnapshot<LookupResponse> snapshot) {
              if (snapshot.hasData) {
                LookupResponse lookupResponse = snapshot.data;
                if (lookupResponse.status) {
                  List<String> data = List();

                  for (int i = 0; i < lookupResponse.data.length; i++) {
                    data.add(lookupResponse.data[i].lookupName);
                  }
                  enterLookupToSharedPref("14", data);
                }
                return Container();
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
                  ],
                );
              }
            },
          ),
          FutureBuilder(
            future: _apiInterface5.lookupResponseData("17"),
            builder:
                (BuildContext context, AsyncSnapshot<LookupResponse> snapshot) {
              if (snapshot.hasData) {
                LookupResponse lookupResponse = snapshot.data;
                if (lookupResponse.status) {
                  List<String> data = List();

                  for (int i = 0; i < lookupResponse.data.length; i++) {
                    data.add(lookupResponse.data[i].lookupName);
                  }
                  enterLookupToSharedPref("17", data);
                }
                return Container();
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
                  ],
                );
              }
            },
          ),
          FutureBuilder(
            future: _apiInterface1.getEmpData(),
            builder: (BuildContext context,
                AsyncSnapshot<EmployeeMasterResponse> snapshot) {
              if (snapshot.hasData) {
                EmployeeMasterResponse employeeMasterResponse = snapshot.data;
                if (employeeMasterResponse.status) {
                  List<String> empNo = List();
                  List<String> empName = List();
                  List<String> empDesignation = List();
                  List<String> empDepartment = List();
                  List<String> passportRetentionReq = List();
                  List<String> passportObtained = List();
                  List<String> passportReleased = List();

                  for (int i = 0; i < employeeMasterResponse.data.length; i++) {
                    empNo.add(employeeMasterResponse.data[i].no);
                    empName.add(employeeMasterResponse.data[i].firstName +
                        " " +
                        employeeMasterResponse.data[i].lastName);
                    empDesignation
                        .add(employeeMasterResponse.data[i].designation);
                    empDepartment
                        .add(employeeMasterResponse.data[i].departmentCode);
                    passportRetentionReq.add(employeeMasterResponse
                        .data[i].passpostRetentionRequired
                        .toString());
                    passportObtained.add(employeeMasterResponse
                        .data[i].passportObtained
                        .toString());
                    passportReleased.add(employeeMasterResponse
                        .data[i].passportReleased
                        .toString());
                  }
                  enterEmpDetailsToSharedPref(
                      empNo,
                      empName,
                      empDesignation,
                      empDepartment,
                      passportRetentionReq,
                      passportObtained,
                      passportReleased);
                }
                return Container();
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
                  ],
                );
              }
            },
          ),
          FutureBuilder(
            future: _apiInterface2.leaveMasterResponseData(LeaveMasterRequest(
              action: 1,
            )),
            builder: (BuildContext context,
                AsyncSnapshot<LeaveMasterResponse> snapshot) {
              if (snapshot.hasData) {
                LeaveMasterResponse _myResponseData = snapshot.data;
                if (_myResponseData.status) {
                  List<String> leaveCode = List();
                  List<String> leaveDescription = List();

                  for (int i = 0; i < _myResponseData.data.length; i++) {
                    leaveCode.add(_myResponseData.data[i].leaveCode);
                    leaveDescription.add(_myResponseData.data[i].description);
                  }
                  enterLeaveDetailsToSharedPref(leaveCode, leaveDescription);
                }
                return Center(
                  child: Text("Welcome to Dashboard"),
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
                    Center(
                      child: Text("Welcome to Dashboard"),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
