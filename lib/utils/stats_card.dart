import 'package:aws_covid_care/models/cases/cases_chart_type.dart';
import 'package:aws_covid_care/utils/case_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class StatsCard extends StatelessWidget {
  final List<String> title;
  final List<String> totalCount;
  final List<String> todayCount;
  final List<String> yesterdayCount;
  final bool isloading;
  final List<CaseChartType> showChartType;

  StatsCard({
    this.title,
    this.todayCount,
    this.totalCount,
    this.isloading = true,
    this.showChartType,
    this.yesterdayCount,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors: const [
            Color(0xff2c274c),
            Color(0xff46426c),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: isloading
          ? Center(
              child: SpinKitDoubleBounce(
                color: Colors.blue,
              ),
            )
          : showStats(height, width),
    );
  }

  Widget showStats(height, width) {
    NumberFormat formatter = NumberFormat('#,##,000');
    return Container(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                title.length,
                (index) => Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title[index],
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          formatter.format(int.parse(totalCount[index])),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ))),
          ),
          Expanded(
            child: Stack(
                children:
                    List.generate(showChartType.length, (index) => CaseChart(caseChartType: showChartType[index]))),
          ),
        ],
      ),
    );
  }

  Icon statsIconBuilder(value, compareToValue) {
    Icon icon;
    if (int.parse(value) > int.parse(compareToValue)) {
      icon = Icon(
        Icons.arrow_upward,
        color: Colors.redAccent,
      );
    } else if (int.parse(value) < int.parse(compareToValue)) {
      icon = Icon(
        Icons.arrow_downward,
        color: Colors.greenAccent,
      );
    }
    return icon;
  }

  Column buildExtraInfoStat({Icon icon, String count, String text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            icon == null ? SizedBox() : icon,
            Text(
              (int.parse(count) > 0) ? '+$count' : '$count',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFFAFB8BE),
          ),
        ),
      ],
    );
  }
}
