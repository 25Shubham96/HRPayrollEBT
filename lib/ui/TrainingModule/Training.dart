import 'package:flutter/material.dart';
import 'package:hrpayroll/ui/TrainingModule/ClosedTrainingList.dart';
import 'package:hrpayroll/ui/TrainingModule/TrainingActivity.dart';
import 'package:hrpayroll/ui/TrainingModule/TrainingApproveList.dart';
import 'package:hrpayroll/ui/TrainingModule/TrainingCourse.dart';
import 'package:hrpayroll/ui/TrainingModule/TrainingRequest.dart';

import '../MyDrawer.dart';
import 'TrainingProvider.dart';

class Training extends StatefulWidget {
  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3600000), () {
      setState(() {
        Navigator.pop(context);
      });
    });

    return DefaultTabController(
      length: 6,
      child: new Scaffold(
        drawer: new MyDrawer(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Training Course",
              ),
              Tab(
                text: "Training Provider",
              ),
              Tab(
                text: "Training Request",
              ),
              Tab(
                text: "Training Activity",
              ),
              Tab(
                text: "Closed Training List",
              ),
              Tab(
                text: "Approve List",
              ),
            ],
            isScrollable: true,
          ),
          title: new Text("Training"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: TabBarView(children: [
          TrainingCourse(),
          TrainingProvider(),
          TrainingRequest(),
          TrainingActivity(),
          ClosedTrainingList(),
          TrainingApproveList(),
        ]),
      ),
    );
  }
}
