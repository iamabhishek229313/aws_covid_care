import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis"),
      ),
      body: Container(
        color: Colors.green,
        child: Center(
            child: Text(
          "WORKING STAGE ...",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
