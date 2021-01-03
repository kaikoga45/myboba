import 'package:flutter/material.dart';

class ExperimentOnly extends StatefulWidget {
  static const String id = '/experiment_only';

  @override
  _ExperimentOnlyState createState() => _ExperimentOnlyState();
}

class _ExperimentOnlyState extends State<ExperimentOnly> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suprise Madafaka'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(),
      ),
    );
  }
}
