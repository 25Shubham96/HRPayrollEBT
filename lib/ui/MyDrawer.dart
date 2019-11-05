import 'package:flutter/material.dart';
import 'package:hrpayroll/Network/Utils.dart';
import 'package:hrpayroll/ui/Home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard.dart';
import 'EmployeeModule/Employee.dart';
import 'LeaveModule/Leave.dart';
import 'PassportModule/Passport.dart';
import 'TrainingModule/Training.dart';

class MyDrawer extends StatelessWidget {
  static String EmpNo = "";

  void GetEmployeeNo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    EmpNo = sharedPreferences.getString(Util.userName);
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
              GetEmployeeNo();

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
            onTap: () => debugPrint("Log Out"),
          ),
        ],
      ),
    );
  }
}
