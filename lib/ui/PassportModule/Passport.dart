import 'package:flutter/material.dart';
import 'package:hrpayroll/ui/PassportModule/PassportApproveList.dart';
import 'package:hrpayroll/ui/PassportModule/PassportRetention.dart';
import 'package:hrpayroll/ui/PassportModule/PassportRetentionLedger.dart';
import '../MyDrawer.dart';

class Passport extends StatefulWidget {
  @override
  _PassportState createState() => _PassportState();
}

class _PassportState extends State<Passport> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: new Scaffold(
        drawer: new MyDrawer(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Passport Retention",
              ),
              Tab(
                text: "Passport Retention Ledger",
              ),
              Tab(
                text: "Approve List",
              ),
            ],
            isScrollable: true,
          ),
          title: new Text("Passport"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: TabBarView(children: [
          PassportRetention(),
          PassportRetentionLedger(),
          PassportApproveList(),
        ]),
      ),
    );
  }
}
