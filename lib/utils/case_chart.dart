import 'package:aws_covid_care/core/repository/api/current_data.dart';
import 'package:aws_covid_care/models/cases/cases_chart_type.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CaseChart extends StatelessWidget {
  final CaseChartType caseChartType;

  CaseChart({@required this.caseChartType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: LineChart(
        lineChartData(),
        swapAnimationDuration: const Duration(milliseconds: 1800),
      ),
    );
  }

  LineChartData lineChartData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 30,
      maxY: double.parse(CurrentData.cases.getMinMaxValues(caseChartType)['max']),
      minY: double.parse(CurrentData.cases.getMinMaxValues(caseChartType)['min']),
      lineBarsData: linesBarData((caseChartType == CaseChartType.dailyconfirmed)
          ? [
              Colors.white70,
            ]
          : (caseChartType == CaseChartType.dailyrecovered) ? [Colors.green.shade200] : [Colors.red]),
      titlesData: FlTitlesData(
        show: false,
      ),
    );
  }

  List<LineChartBarData> linesBarData(List<Color> color) {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      curveSmoothness: 0.5,
      isStrokeCapRound: true,
      spots: populateChartData(),
      isCurved: true,
      colors: color,
      barWidth: 2.0,
      dotData: FlDotData(
        show: false,
      ),
      // belowBarData: BarAreaData(
      //   show: true,
      //   colors: [const Color(0x22FF8BAF), const Color(0x22FF8BAF), const Color(0x11FF8BAF)],
      //   gradientFrom: Offset(0.4, 0.4),
      //   gradientTo: Offset(0.4, 0.8),
      //   gradientColorStops: [0.1, 0.4, 0.9],
      //   // gradientFrom: Offset(0.4, 0.4),
      //   // gradientTo: Offset(0.6, 0.8),
      //   // gradientColorStops: [0.1, 0.4, 0.9],
      // ),
    );
    return [
      lineChartBarData1,
    ];
  }

  List<FlSpot> populateChartData() {
    List<FlSpot> chartData = [];
    if (caseChartType == CaseChartType.dailyconfirmed) {
      double xAxis = 0;
      CurrentData.cases.dateWiseConfirmedCases.forEach(
        (key, value) {
          xAxis++;
          chartData.add(FlSpot(xAxis, double.parse(value)));
        },
      );
    } else if (caseChartType == CaseChartType.dailyrecovered) {
      double xAxis = 0;
      CurrentData.cases.dateWiseRecoveredCases.forEach(
        (key, value) {
          xAxis++;
          chartData.add(FlSpot(xAxis, double.parse(value)));
        },
      );
    } else if (caseChartType == CaseChartType.dailydeceased) {
      double xAxis = 0;
      CurrentData.cases.dateWiseDeceasedCases.forEach(
        (key, value) {
          xAxis++;
          chartData.add(FlSpot(xAxis, double.parse(value)));
        },
      );
    }
    return chartData;
  }
}
