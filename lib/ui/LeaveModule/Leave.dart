import 'package:flutter/material.dart';
import 'package:hrpayroll/ui/LeaveModule/BusinessTrip.dart';
import 'package:hrpayroll/ui/LeaveModule/LeaveMaster.dart';
import 'package:hrpayroll/ui/LeaveModule/OutOfOffice.dart';

import '../MyDrawer.dart';
import 'CompOff.dart';
import 'LeaveApplication.dart';
import 'LeaveApproveList.dart';

class Leave extends StatefulWidget {
  @override
  _LeaveState createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 6,
      child: new Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Leave Master",
              ),
              Tab(
                text: "Leave Application",
              ),
              Tab(
                text: "Compensatory Off",
              ),
              Tab(
                text: "Out of Office",
              ),
              Tab(
                text: "Business Trip",
              ),
              Tab(
                text: "Approve List",
              ),
            ],
            isScrollable: true,
          ),
          title: new Text("Leave Request"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: TabBarView(children: [
          LeaveMaster(),
          LeaveApplication(),
          CompOff(),
          OutOfOffice(),
          BusinessTrip(),
          LeaveApproveList(),
        ]),
      ),
    );
  }
}
