import 'package:flutter/material.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/Network/Utils.dart';
import 'package:hrpayroll/request_model/LogOffRequest.dart';
import 'package:hrpayroll/response_model/ForgotPasswordResponse.dart';
import 'package:hrpayroll/ui/Home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard.dart';
import 'EmployeeModule/Employee.dart';
import 'LeaveModule/Leave.dart';
import 'PassportModule/Passport.dart';
import 'TrainingModule/Training.dart';

class MyDrawer extends StatelessWidget {
  static String empNo = "";
  static String password = "";

  ApiInterface _apiInterface = ApiInterface();

  static void getEmployeeNo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    empNo = sharedPreferences.getString(Util.userName);
    password = sharedPreferences.getString(Util.password);
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            child: new Text(
              "HR Payroll",
              style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
            decoration: new BoxDecoration(color: Colors.redAccent),
          ),
          new ListTile(
            title: new Text("Dashboard"),
            leading: new Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);

              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return Dashboard();
              }));
            },
          ),
          new ListTile(
            title: new Text("Home"),
            leading: new Icon(Icons.format_list_bulleted),
            onTap: () {
              getEmployeeNo();

              Navigator.pop(context);
              Navigator.pop(context);

              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new Home();
              }));
            },
          ),
          new ListTile(
            title: new Text("Leaves"),
            leading: new Icon(Icons.transfer_within_a_station),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);

              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new Leave();
              }));
            },
          ),
          new ListTile(
            title: new Text("Training"),
            leading: new Icon(Icons.work),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);

              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return Training();
              }));
            },
          ),
          new ListTile(
            title: new Text("Employee Asset"),
            leading: new Icon(Icons.person),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);

              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return Employee();
              }));
            },
          ),
          new ListTile(
            title: new Text("Passport"),
            leading: new Icon(Icons.flight_takeoff),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);

              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return Passport();
              }));
            },
          ),
          new ListTile(
            title: new Text("Info"),
            leading: new Icon(Icons.info_outline),
            onTap: () => debugPrint("Info"),
          ),
          new ListTile(
            title: new Text("Help"),
            leading: new Icon(Icons.help_outline),
            onTap: () => debugPrint("Help"),
          ),
          new ListTile(
            title: new Text("Log Out"),
            leading: new Icon(Icons.exit_to_app),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Log Out"),
                      content: Text("Are you sure you want to Log Out?"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Row(
                                    children: <Widget>[
                                      CircularProgressIndicator(),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text("Logging off please wait...")
                                    ],
                                  ),
                                );
                              },
                            );

                            ForgotPasswordResponse _forgotPasswordResponse =
                                await _apiInterface.logOff(
                              LogOffRequest(
                                username: empNo,
                                password: password,
                              ),
                            );

                            if (_forgotPasswordResponse.status) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Text("YES"),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("NO"),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
