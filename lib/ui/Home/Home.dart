import 'package:flutter/material.dart';
import 'package:hrpayroll/ui/Home/PassportApproval.dart';

import './AssessmentApproval.dart';
import './EmployeeMaster.dart';
import './LeaveApproval.dart';
import '../MyDrawer.dart';
import 'TrainingApproval.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3600000), () {
      setState(() {
        Navigator.pop(context);
      });
    });

    return DefaultTabController(
      length: 5,
      child: new Scaffold(
        drawer: new MyDrawer(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Employee Master",
              ),
              Tab(
                text: "Leave Approval",
              ),
              Tab(
                text: "Training Approval",
              ),
              Tab(
                text: "Assesment Approval",
              ),
              Tab(
                text: "Passport Approval",
              ),
            ],
            isScrollable: true,
          ),
          title: new Text("Home"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: TabBarView(children: [
          new EmployeeMaster(),
          new LeaveApproval(),
          new TrainingApproval(),
          new AssessmentApproval(),
          new PassportApproval(),
        ]),
      ),
    );
  }
}
