import 'package:flutter/material.dart';
import 'package:hrpayroll/ui/EmployeeModule/AssetApproveList.dart';
import 'package:hrpayroll/ui/EmployeeModule/AssetIssue.dart';
import 'package:hrpayroll/ui/EmployeeModule/IssueReturnLedger.dart';

import '../MyDrawer.dart';
import 'AssetRequest.dart';
import 'AssetReturn.dart';

class Employee extends StatefulWidget {
  @override
  _EmployeeState createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
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
                text: "Emp Asset Req",
              ),
              Tab(
                text: "Asset Issue List",
              ),
              Tab(
                text: "Asset Return List",
              ),
              Tab(
                text: "Issue Return Ledger",
              ),
              Tab(
                text: "Asset Approve List",
              ),
            ],
            isScrollable: true,
          ),
          title: new Text("Employee Asset"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: TabBarView(children: [
          AssetRequest(),
          AssetIssue(),
          AssetReturn(),
          IssueReturnLedger(),
          AssetApproveList(),
        ]),
      ),
    );
  }
}
