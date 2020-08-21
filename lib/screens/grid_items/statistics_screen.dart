import 'dart:ui';

import 'package:aws_covid_care/core/repository/api/current_data.dart';
import 'package:aws_covid_care/models/cases/cases.dart';
import 'package:aws_covid_care/models/cases/cases_chart_type.dart';
import 'package:aws_covid_care/screens/more_stats_screen.dart';
import 'package:aws_covid_care/utils/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  Cases cases;
  bool isLoading = true;
  ScrollController _scrollController;

  @override
  void initState() {
    getData();
    // pullToRefresh();
    super.initState();
  }

  getData() async {
    cases = await CurrentData.refresh();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> refreshPage() async {
    isLoading = true;
    setState(() {});
    cases = await CurrentData.refresh();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text(
          "Statistics",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshPage,
            tooltip: 'Refresh',
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.globe),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Worldwide",
                        style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: screenHeight * 0.3,
                    child: StatsCard(
                      isloading: this.isLoading,
                      title: ['CONFIRMED', 'RECOVERED', 'DECEASED'],
                      totalCount: isLoading ? ['0', '0', '0'] : [cases.confirmed, cases.recovered, cases.deceased],
                      // todayCount: isLoading ? '0' : cases.todayRecoveredCount,
                      // yesterdayCount: isLoading ? '0' : cases.yesterdayRecoveredCount,
                      todayCount: isLoading
                          ? ['0', '0', '0']
                          : [cases.todayTotalCount, cases.todayRecoveredCount, cases.todayDeceasedCount],
                      yesterdayCount: isLoading
                          ? ['0', '0', '0']
                          : [cases.yesterdatTotalCount, cases.yesterdayRecoveredCount, cases.yesterdayDeceasedCount],
                      showChartType: [
                        CaseChartType.dailyconfirmed,
                        CaseChartType.dailyrecovered,
                        CaseChartType.dailydeceased
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Align(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => MoreStatsScreen(
                                  cases: cases,
                                  isLoading: this.isLoading,
                                )));
                      },
                      child: Text(
                        "Click here for details.",
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Widget buildStatsScreen(double height, double width) {
  //   return RefreshIndicator(
  //     onRefresh: refreshPage,
  //     child: SingleChildScrollView(
  //       padding: EdgeInsets.only(bottom: height * 0.1),
  //       controller: _scrollController,
  //       child: ConstrainedBox(
  //         constraints: BoxConstraints(
  //           maxHeight: height + height * 0.1,
  //         ),
  //         child:
  //       ),
  //     ),
  //   );
  // }

}

// Stack(
// children: <Widget>[
// Positioned(
//   top: height * 0.06,
//   left: height * 0.16,
//   child: Visibility(
//     visible: !isLoading,
//     child: DelayedDisplay(
//       slidingCurve: Curves.easeInOutCirc,
//       fadingDuration: const Duration(milliseconds: 1000),
//       slidingBeginOffset: Offset.fromDirection(100),
//       child: SvgPicture.asset(
//         'assets/images/corona.svg',
//       ),
//     ),
//   ),
// ),
// TitleStats(
//   showShimmer: isLoading,
//   totalCount: isLoading ? '0' : cases.active,
//   updateTime: isLoading ? '0' : cases.timeStamp,
// ),
// Positioned(
//   top: height * 0.25,
//   width: width,
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       StatsCard(
//         showShimmer: isLoading,
//         title: 'CONFIRMED',
//         totalCount: isLoading ? '0' : cases.confirmed,
//         todayCount: isLoading ? '0' : cases.todayTotalCount,
//         yesterdayCount: isLoading ? '0' : cases.yesterdatTotalCount,
//         showChartType: CaseChartType.dailyconfirmed,
//       ),
// StatsCard(
//   showShimmer: isLoading,
//   title: 'RECOVERED',
//   totalCount: isLoading ? '0' : cases.recovered,
//   todayCount: isLoading ? '0' : cases.todayRecoveredCount,
//   yesterdayCount: isLoading ? '0' : cases.yesterdayRecoveredCount,
//   showChartType: CaseChartType.dailyrecovered,
// ),
//       StatsCard(
//         showShimmer: isLoading,
//         title: 'DECEASED',
//         totalCount: isLoading ? '0' : cases.deceased,
//         todayCount: isLoading ? '0' : cases.todayDeceasedCount,
//         yesterdayCount: isLoading ? '0' : cases.yesterdayDeceasedCount,
//         showChartType: CaseChartType.dailydeceased,
//       ),
//       Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: 20.0,
//           vertical: 10.0,
//         ),
//         child: Text(
//           'Requirements',
//           style: TextStyle(
//             fontSize: height * 0.025,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
// ],
// ),
