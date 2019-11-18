import 'package:flutter/material.dart';
import 'package:hrpayroll/DataSource/TrainingCourseDataSource.dart';
import 'package:hrpayroll/Network/ApiInterface.dart';
import 'package:hrpayroll/request_model/TrainingProviderCourseRequest.dart';
import 'package:hrpayroll/response_model/TrainingCourseResponse.dart';

class TrainingCourse extends StatefulWidget {
  @override
  _TrainingCourseState createState() => _TrainingCourseState();
}

class _TrainingCourseState extends State<TrainingCourse> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ApiInterface _apiInterface = ApiInterface();

  static List<TrainingCourseModel> newdata = new List();
  TrainingCourseDataSource _trainingCourseDataSource =
      TrainingCourseDataSource(newdata);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5)),
            Center(
              child: Text(
                "Training Course",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            FutureBuilder(
              future: _apiInterface
                  .trainingCourseResponseData(TrainingProviderCourseRequest(
                action: 1,
              )),
              builder: (BuildContext context,
                  AsyncSnapshot<TrainingCourseResponse> snapshot) {
                if (snapshot.hasData) {
                  TrainingCourseResponse _myResponseData = snapshot.data;
                  _trainingCourseDataSource =
                      TrainingCourseDataSource(_myResponseData.data);

                  return PaginatedDataTable(
                    columnSpacing: 15,
                    horizontalMargin: 15,
                    headingRowHeight: 35,
                    dataRowHeight: 30,
                    rowsPerPage: (_myResponseData.data.length < 10 &&
                            _myResponseData.data.length > 0)
                        ? _myResponseData.data.length
                        : _rowsPerPage,
                    header: Text(""),
                    columns: [
                      DataColumn(
                        label: Text(
                          "Course ID",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Course Name",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Training Type",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Result Type",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Result",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Duration",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Training Cost",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Course Description",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Course Description Att.",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                    source: _trainingCourseDataSource,
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
                          Text("Loading please wait..."),
                        ],
                      )),
                      PaginatedDataTable(
                        columnSpacing: 15,
                        horizontalMargin: 15,
                        headingRowHeight: 35,
                        dataRowHeight: 30,
                        rowsPerPage: _rowsPerPage,
                        header: Text(""),
                        columns: [
                          DataColumn(
                            label: Text(
                              "Course ID",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Course Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Training Type",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Result Type",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Result",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Duration",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Training Cost",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Course Description",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Course Description Att.",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        source: _trainingCourseDataSource,
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
