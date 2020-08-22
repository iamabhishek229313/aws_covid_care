import 'package:aws_covid_care/models/cases/cases.dart';
import 'package:aws_covid_care/models/cases/cases_chart_type.dart';
import 'package:aws_covid_care/utils/stats_card.dart';
import 'package:flutter/material.dart';

class MoreStatsScreen extends StatelessWidget {
  final bool isLoading;
  final Cases cases;

  const MoreStatsScreen({Key key, this.isLoading, this.cases}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Worldwide statistics'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: StatsCard(
                  isloading: this.isLoading,
                  title: ['CONFIRMED'],
                  totalCount: isLoading
                      ? ['0']
                      : [
                          cases.confirmed,
                        ],
                  todayCount: isLoading ? ['0'] : [cases.todayTotalCount],
                  yesterdayCount: isLoading
                      ? ['0']
                      : [
                          cases.yesterdatTotalCount,
                        ],
                  showChartType: [
                    CaseChartType.dailyconfirmed,
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: StatsCard(
                  isloading: this.isLoading,
                  title: ['RECOVERED'],
                  totalCount: isLoading
                      ? ['0']
                      : [
                          cases.recovered,
                        ],
                  todayCount: isLoading ? ['0'] : [cases.todayDeceasedCount],
                  yesterdayCount: isLoading
                      ? ['0']
                      : [
                          cases.yesterdayRecoveredCount,
                        ],
                  showChartType: [
                    CaseChartType.dailyrecovered,
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: StatsCard(
                  isloading: this.isLoading,
                  title: ['DECEASED'],
                  totalCount: isLoading ? ['0'] : [cases.deceased],
                  todayCount: isLoading ? ['0'] : [cases.todayDeceasedCount],
                  yesterdayCount: isLoading ? ['0'] : [cases.yesterdayDeceasedCount],
                  showChartType: [CaseChartType.dailydeceased],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
