import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';
import 'package:aws_covid_care/screens/each_country_detail_screen.dart';
import 'package:aws_covid_care/utils/each_country.dart';
import 'package:aws_covid_care/utils/tile_section.dart';
import 'package:dart_numerics/dart_numerics.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

// import 'package:aws_covid_care/core/parsing/network_service.dart';
import 'package:aws_covid_care/core/repository/api/current_data.dart';
import 'package:aws_covid_care/models/cases/cases.dart';
import 'package:aws_covid_care/models/cases/cases_chart_type.dart';
import 'package:aws_covid_care/screens/more_stats_screen.dart';
import 'package:aws_covid_care/utils/stats_card.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CountriesData {
  String country;
  String countryCode;
  String slug;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  String date;

  CountriesData({
    this.country,
    this.countryCode,
    this.slug,
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.date,
  });

  CountriesData.fromJson(Map<String, dynamic> json) {
    country = json['Country'];
    countryCode = json['CountryCode'];
    slug = json['Slug'];
    newConfirmed = json['NewConfirmed'];
    totalConfirmed = json['TotalConfirmed'];
    newDeaths = json['NewDeaths'];
    totalDeaths = json['TotalDeaths'];
    newRecovered = json['NewRecovered'];
    totalRecovered = json['TotalRecovered'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Country'] = this.country;
    data['CountryCode'] = this.countryCode;
    data['Slug'] = this.slug;
    data['NewConfirmed'] = this.newConfirmed;
    data['TotalConfirmed'] = this.totalConfirmed;
    data['NewDeaths'] = this.newDeaths;
    data['TotalDeaths'] = this.totalDeaths;
    data['NewRecovered'] = this.newRecovered;
    data['TotalRecovered'] = this.totalRecovered;
    data['Date'] = this.date;
    return data;
  }
}

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  Cases cases;
  bool isLoading = true;
  List<CountriesData> countriesData;
  String gTotalConfirmed;
  String gTotalRecovered;
  String gTotalDeadth;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    cases = await CurrentData.refresh();
    var response = await http.get('https://api.covid19api.com/summary');
    var decodedRes = json.decode(response.body);

    gTotalConfirmed = decodedRes['Global']['TotalConfirmed'].toString();
    gTotalRecovered = decodedRes['Global']['TotalRecovered'].toString();
    gTotalDeadth = decodedRes['Global']['TotalDeaths'].toString();

    countriesData = (decodedRes['Countries'] as List).map((e) => CountriesData.fromJson(e)).toList();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> refreshPage() async {
    isLoading = true;
    setState(() {});
    cases = await CurrentData.refresh();
    var response = await http.get('https://api.covid19api.com/summary');
    var decodedRes = json.decode(response.body);

    gTotalConfirmed = decodedRes['Global']['TotalConfirmed'].toString();
    gTotalRecovered = decodedRes['Global']['TotalRecovered'].toString();
    gTotalDeadth = decodedRes['Global']['TotalDeaths'].toString();

    countriesData = (decodedRes['Countries'] as List).map((e) => CountriesData.fromJson(e)).toList();

    setState(() {
      isLoading = false;
    });
    setState(() {});
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
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
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
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MoreStatsScreen(
                                      cases: cases,
                                      isLoading: this.isLoading,
                                    )));
                          },
                          child: StatsCard(
                            isloading: this.isLoading,
                            title: ['CONFIRMED', 'RECOVERED', 'DECEASED'],
                            totalCount: isLoading ? ['0', '0', '0'] : [gTotalConfirmed, gTotalRecovered, gTotalDeadth],
                            // totalCount: isLoading ? ['0', '0', '0'] : [cases.confirmed, cases.recovered, cases.deceased],
                            // todayCount: isLoading ? '0' : cases.todayRecoveredCount,
                            // yesterdayCount: isLoading ? '0' : cases.yesterdayRecoveredCount,
                            todayCount: isLoading
                                ? ['0', '0', '0']
                                : [cases.todayTotalCount, cases.todayRecoveredCount, cases.todayDeceasedCount],
                            yesterdayCount: isLoading
                                ? ['0', '0', '0']
                                : [
                                    cases.yesterdatTotalCount,
                                    cases.yesterdayRecoveredCount,
                                    cases.yesterdayDeceasedCount
                                  ],
                            showChartType: [
                              CaseChartType.dailyconfirmed,
                              CaseChartType.dailyrecovered,
                              CaseChartType.dailydeceased
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Align(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => EachCountryDetailScreen(
                                      data: countriesData,
                                      // cases: cases,
                                      // isLoading: this.isLoading,
                                    )));
                          },
                          child: Text(
                            "Click here for details.",
                            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  )),
              Divider(
                thickness: 4.0,
                color: Colors.blueGrey.shade100,
              ),
              Expanded(child: ByCountryWidget())
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
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

class ByCountryWidget extends StatefulWidget {
  @override
  _ByCountryWidgetState createState() => _ByCountryWidgetState();
}

class _ByCountryWidgetState extends State<ByCountryWidget> with TickerProviderStateMixin {
  List<TileSection> _briefTilesSections;
  List<CountryData> _dataList;
  static const String baseURL = 'https://api.covid19api.com/total/country/';
  String countryName = "Canada"; // Initial Data.
  bool isLoading = true;
  TabController _tabController;
  int maxConfirmed;
  int maxRecovery;
  int maxActive;
  int maxDeadth;

  refreshData() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.get(baseURL + countryName);
    _dataList = (json.decode(response.body) as List).map((e) => CountryData.fromJson(e)).toList();
    int _dataLen = _dataList.length;
    log("Date length is + " + _dataLen.toString());
    _briefTilesSections[0].numbers = _dataList[_dataLen - 1].confirmed;
    _briefTilesSections[1].numbers = _dataList[_dataLen - 1].recovered;
    _briefTilesSections[2].numbers = _dataList[_dataLen - 1].active;
    _briefTilesSections[3].numbers = _dataList[_dataLen - 1].deaths;

    maxConfirmed = int64MinValue;
    maxRecovery = int64MinValue;
    maxActive = int64MinValue;
    maxDeadth = int64MinValue;

    // Want to get the simpler solution, it's now O(N)
    for (int i = 0; i < _dataLen; ++i) {
      maxConfirmed = math.max(maxConfirmed, _dataList[i].confirmed);
      maxRecovery = math.max(maxRecovery, _dataList[i].recovered);
      maxActive = math.max(maxActive, _dataList[i].active);
      maxDeadth = math.max(maxDeadth, _dataList[i].deaths);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _briefTilesSections = [
      TileSection("Total cases", Colors.blue, Icons.text_rotation_angledown, 0),
      TileSection("Recovered", Colors.green, Icons.text_rotation_angledown, 0),
      TileSection("Active", Colors.pinkAccent, Icons.text_rotation_angledown, 0),
      TileSection("Deaths", Colors.red.shade700, Icons.text_rotation_angledown, 0),
    ];
    _tabController = TabController(length: 4, vsync: this);
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    var numberFormatter = new NumberFormat("#,##,##,###");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "By Country",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700),
              ),
              CountryListPick(
                isShowFlag: true,
                isShowTitle: true,
                isShowCode: false,
                isDownIcon: true,
                showEnglishName: true,
                initialSelection: '+1',
                onChanged: (CountryCode code) {
                  print(code.dialCode);
                  countryName = code.name;
                  refreshData();
                },
              ),
            ],
          ),
        ),
        Container(
          child: Container(
              height: screenHeight * 0.16,
              child: Row(
                  children: List.generate(
                      _briefTilesSections.length,
                      (index) => Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0), color: Colors.blueGrey.shade100),
                              child: isLoading
                                  ? Center(
                                      child: SpinKitWave(
                                        color: Colors.blue,
                                        size: 20.0,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          _briefTilesSections[index].icon,
                                          color: _briefTilesSections[index].color,
                                        ),
                                        Text(
                                          _briefTilesSections[index].title,
                                          style: TextStyle(color: _briefTilesSections[index].color),
                                        ),
                                        Text(
                                          numberFormatter.format(_briefTilesSections[index].numbers),
                                          style: TextStyle(color: _briefTilesSections[index].color),
                                        ),
                                      ],
                                    ),
                            ),
                          )))),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: 'Confirmed',
                  ),
                  Tab(
                    text: 'Recovery',
                  ),
                  Tab(
                    text: 'Active',
                  ),
                  Tab(
                    text: 'Deadth',
                  )
                ]),
          ),
        ),
        Container(
          height: screenHeight * 0.35,
          child: TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: List.generate(
                  _briefTilesSections.length,
                  (index) => Container(
                      padding: EdgeInsets.only(bottom: 6.0),
                      height: screenHeight * 0.3,
                      margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0, top: 8.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0xFF6190E8), Color(0xFFA7BFE8)]),
                          borderRadius: BorderRadius.circular(8.0)),
                      width: double.maxFinite,
                      child: isLoading
                          ? Center(
                              child: SpinKitCubeGrid(
                                color: Colors.black,
                                size: 20.0,
                              ),
                            )
                          : LineChart(LineChartData(
                              // lineTouchData: LineTouchData(enabled: true),
                              lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                                ),
                                touchCallback: (LineTouchResponse touchResponse) {},
                                handleBuiltInTouches: true,
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: SideTitles(
                                  showTitles: false,
                                  reservedSize: 22,
                                  textStyle:
                                      const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                                  getTitles: (value) {
                                    switch (value.toInt()) {
                                      case 2:
                                        return 'MAR';
                                      case 5:
                                        return 'JUN';
                                      case 8:
                                        return 'SEP';
                                    }
                                    return '';
                                  },
                                ),
                                leftTitles: SideTitles(
                                  showTitles: true,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  getTitles: (value) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return '0';
                                      case 10:
                                        return '10k';
                                      case 30:
                                        return '30k';
                                      case 50:
                                        return '50k';
                                      case 80:
                                        return '80k';
                                      case 100:
                                        return '1M';
                                      case 290:
                                        return '29M';
                                    }
                                    return '';
                                  },
                                  reservedSize: 28,
                                  margin: 12,
                                ),
                              ),
                              borderData: FlBorderData(
                                  show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
                              minX: 0,
                              maxX: _dataList.length.toDouble(),
                              minY: 0,
                              maxY: (((index == 0)
                                          ? (maxConfirmed.toDouble())
                                          : (index == 1)
                                              ? (maxRecovery.toDouble())
                                              : (index == 2) ? (maxActive.toDouble()) : (maxDeadth.toDouble())) /
                                      10000) *
                                  1.2,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                      _dataList.length,
                                      (index2) => FlSpot(
                                          index2.toDouble(),
                                          ((index == 0)
                                                  ? _dataList[index2].confirmed.toDouble()
                                                  : (index == 1)
                                                      ? _dataList[index2].recovered.toDouble()
                                                      : (index == 2)
                                                          ? _dataList[index2].active.toDouble()
                                                          : _dataList[index2].deaths.toDouble()) /
                                              10000)),
                                  isCurved: false,
                                  colors: [Colors.white, Colors.orange],
                                  barWidth: 2.0,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    colors:
                                        [Colors.black, Colors.orange].map((color) => color.withOpacity(0.3)).toList(),
                                  ),
                                ),
                              ],
                            ))))),
        ),
      ],
    );
  }
}
