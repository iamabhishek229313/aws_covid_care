import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Bar {
  final String x_axis;
  final double y_value;

  Bar(this.x_axis, this.y_value);
}

class AnalysisScreen extends StatefulWidget {
  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  List<charts.Series> _riskList;
  List<charts.Series> _homeAndOutside;
  List<charts.Series> _riskAndPrecautions;
  List<charts.Series> _covidExposure;
  List<charts.Series> _precautionOverMonth;

  @override
  void initState() {
    super.initState();
    _riskList = _createRiskAssociated();
    _homeAndOutside = _createHomeAndOutside();
    _riskAndPrecautions = _createRiskAndPrecautions();
    _covidExposure = _createCovidExposure();
    _precautionOverMonth = _createPrecautionOverMonth();
  }

  List<charts.Series<Bar, String>> _createRiskAssociated() {
    var riskAssociated = [
      Bar('Home', 0.0),
      Bar('Zone 1', 25.0),
      Bar('Zone 2', 45.0),
      Bar('Zone 3', 60.0),
    ];
    return [
      charts.Series<Bar, String>(
        id: 'risk',
        domainFn: (Bar sales, _) => sales.x_axis,
        measureFn: (Bar sales, _) => sales.y_value,
        data: riskAssociated,
        fillColorFn: (Bar sales, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },
      )
    ];
  }

  List<charts.Series<Bar, String>> _createHomeAndOutside() {
    var riskAssociated = [
      Bar('Home', 60.0),
      Bar('Outside', 70.0),
    ];
    return [
      charts.Series<Bar, String>(
        id: 'homeAndOutisde',
        domainFn: (Bar sales, _) => sales.x_axis,
        measureFn: (Bar sales, _) => sales.y_value,
        data: riskAssociated,
        fillColorFn: (Bar sales, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      )
    ];
  }

  List<charts.Series<Bar, String>> _createRiskAndPrecautions() {
    var riskAssociated = [
      Bar('General Risk', 12.0),
      Bar('Risk with Mask', 5.0),
      Bar('Risk without Mask', 28.0),
    ];
    return [
      charts.Series<Bar, String>(
        id: 'riskAndPrecautions',
        domainFn: (Bar sales, _) => sales.x_axis,
        measureFn: (Bar sales, _) => sales.y_value,
        data: riskAssociated,
        fillColorFn: (Bar sales, _) {
          return charts.MaterialPalette.deepOrange.shadeDefault;
        },
      )
    ];
  }

  List<charts.Series<Bar, String>> _createCovidExposure() {
    var riskAssociated = List.generate(21, (index) => Bar('${index + 1}', 1.0 * Random().nextInt(55)));
    return [
      charts.Series<Bar, String>(
        id: 'covidExposure',
        domainFn: (Bar sales, _) => sales.x_axis,
        measureFn: (Bar sales, _) => sales.y_value,
        data: riskAssociated,
        fillColorFn: (Bar sales, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },
      )
    ];
  }

  List<charts.Series<Bar, String>> _createPrecautionOverMonth() {
    var riskAssociated = [
      Bar('General Risk', 56.0),
      Bar('Risk with Mask', 33.0),
      Bar('Risk without Mask', 74.0),
    ];
    return [
      charts.Series<Bar, String>(
        id: 'precautionOverMonth',
        domainFn: (Bar sales, _) => sales.x_axis,
        measureFn: (Bar sales, _) => sales.y_value,
        data: riskAssociated,
        fillColorFn: (Bar sales, _) {
          return charts.MaterialPalette.pink.shadeDefault;
        },
      )
    ];
  }

  Future<dynamic> _fakeLoading() async {
    await Future.delayed(Duration(milliseconds: 1800), () {});
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Analysis"),
        ),
        body: FutureBuilder(
          future: _fakeLoading(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: SpinKitFadingGrid(
                  color: Colors.pink,
                ),
              );
            return ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Based on area you are classified at ',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Zone 2',
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                      ],
                    ),
                  ),
                ),
                GraphWidget(
                  seriesList: _riskList,
                  x_axis_name: 'Zone',
                  y_axis_name: 'Rate %',
                  title: 'Risks level associated with every level',
                ),
                GraphWidget(
                  seriesList: _homeAndOutside,
                  x_axis_name: 'Place',
                  y_axis_name: 'Time Spent',
                  title: 'Time spent Home vs Outside',
                ),
                GraphWidget(
                  seriesList: _riskAndPrecautions,
                  x_axis_name: 'Categories',
                  y_axis_name: 'Risk %',
                  title: 'Different types of risk with precautions',
                ),
                GraphWidget(
                  seriesList: _covidExposure,
                  x_axis_name: 'Day',
                  y_axis_name: 'Risk %',
                  title: 'Your COVID exposure period',
                ),
                GraphWidget(
                  seriesList: _precautionOverMonth,
                  x_axis_name: 'Categories',
                  y_axis_name: 'Risk %',
                  title: 'Different types of risks with precautions over the 21 days',
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Based on these statistics there is a resonable chance for contracting  ',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'COVID-19 ',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red.shade900)),
                        TextSpan(
                            text: 'please take proper precautions.',
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

class GraphWidget extends StatelessWidget {
  const GraphWidget({
    Key key,
    @required List<charts.Series> seriesList,
    this.title,
    this.x_axis_name,
    this.y_axis_name,
  })  : _seriesList = seriesList,
        super(key: key);

  final List<charts.Series> _seriesList;
  final String title;
  final String x_axis_name;
  final String y_axis_name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          this.title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0).copyWith(top: 8.0, bottom: 16.0),
          child: Material(
            borderRadius: BorderRadius.circular(10.0),
            elevation: 10.0,
            child: SizedBox(
              height: 300.0,
              child: charts.BarChart(
                _seriesList,
                animate: true,
                vertical: true,
                behaviors: [
                  new charts.ChartTitle(this.x_axis_name,
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleStyleSpec: charts.TextStyleSpec(fontSize: 14),
                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                  new charts.ChartTitle(this.y_axis_name,
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleStyleSpec: charts.TextStyleSpec(fontSize: 14),
                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea)
                ],
                animationDuration: Duration(milliseconds: 800),
              ),
            ),
          ),
        ),
        Divider(
          thickness: 3.0,
          color: Colors.blueGrey.shade50,
        )
      ],
    );
  }
}
