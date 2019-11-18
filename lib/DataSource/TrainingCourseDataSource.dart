import 'package:flutter/material.dart';
import 'package:hrpayroll/response_model/TrainingCourseResponse.dart';

class TrainingCourseDataSource extends DataTableSource {
  List<TrainingCourseModel> data = new List();

  TrainingCourseDataSource(this.data);

  int selectedCount = 0;

  @override
  DataRow getRow(int index) {
    TrainingCourseModel trainingCourseModel = data[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(trainingCourseModel.courseId)),
        DataCell(Text(trainingCourseModel.courseName)),
        DataCell(Text(trainingCourseModel.category)),
        DataCell(Text(trainingCourseModel.trainingType)),
        DataCell(Text(trainingCourseModel.resultType)),
        DataCell(Text(trainingCourseModel.result)),
        DataCell(Text(trainingCourseModel.duration.toString())),
        DataCell(Text(trainingCourseModel.trainingCost.toString())),
        DataCell(Text(trainingCourseModel.courseDescription)),
        DataCell(Text(trainingCourseModel.courseDocumentAttachment)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => selectedCount;
}
