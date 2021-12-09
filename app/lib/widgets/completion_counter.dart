import 'package:flutter/material.dart';

class CompletionCounter extends StatelessWidget {
  final int completedCount;
  final int totalCount;

  const CompletionCounter(
      {Key? key, required this.completedCount, required this.totalCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(40),
      child: Text(
        "$completedCount/$totalCount",
        style: TextStyle(
            fontSize: 60,
            color: completedCount == totalCount ? Colors.green : Colors.black),
      ),
    );
  }
}
