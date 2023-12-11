// ignore: file_names
import 'package:flutter/material.dart';
import 'package:practica_1/models/task_model.dart';

// ignore: must_be_immutable
class CardTaskWidget extends StatelessWidget {
  CardTaskWidget(
    {super.key,required this.taskModel}
  );

  TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(taskModel.nameTask!),
            Text(taskModel.dscTask!)
          ],
        )
      ],
    );
  }
}