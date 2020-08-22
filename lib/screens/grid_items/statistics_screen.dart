import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';
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

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  Cases cases;
  bool isLoading = true;

  @override
  void initState() {
    getData();
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

class CountryData {
  String country;
  String countryCode;
  String province;
  String city;
  String cityCode;
  String lat;
  String lon;
  int confirmed;
  int deaths;
  int recovered;
  int active;
  String date;

  CountryData(
      {this.country,
      this.countryCode,
      this.province,
      this.city,
      this.cityCode,
      this.lat,
      this.lon,
      this.confirmed,
      this.deaths,
      this.recovered,
      this.active,
      this.date});

  CountryData.fromJson(Map<String, dynamic> json) {
    country = json['Country'];
    countryCode = json['CountryCode'];
    province = json['Province'];
    city = json['City'];
    cityCode = json['CityCode'];
    lat = json['Lat'];
    lon = json['Lon'];
    confirmed = json['Confirmed'];
    deaths = json['Deaths'];
    recovered = json['Recovered'];
    active = json['Active'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Country'] = this.country;
    data['CountryCode'] = this.countryCode;
    data['Province'] = this.province;
    data['City'] = this.city;
    data['CityCode'] = this.cityCode;
    data['Lat'] = this.lat;
    data['Lon'] = this.lon;
    data['Confirmed'] = this.confirmed;
    data['Deaths'] = this.deaths;
    data['Recovered'] = this.recovered;
    data['Active'] = this.active;
    data['Date'] = this.date;
    return data;
  }
}

class TileSection {
  String title;
  Color color;
  IconData icon;
  int numbers;

  TileSection(this.title, this.color, this.icon, this.numbers);
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
                  print(code.name);
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
                                  dotData: FlDotData(
                                    show: false,
                                  ),
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

// import 'dart:async';
// import 'dart:convert';
// import 'package:covid19/ui/statistics/global_countries_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:covid19/constants/app_theme.dart';
// import 'package:covid19/constants/colors.dart';
// import 'package:covid19/constants/dimens.dart';
// import 'package:covid19/constants/strings.dart';
// import 'package:covid19/constants/text_styles.dart';
// import 'package:covid19/icons/covid19_icons.dart';
// import 'package:covid19/models/statistics/countries_list_model.dart';
// import 'package:covid19/res/asset_images.dart';
// import 'package:covid19/stores/statistics/statistics_notifier.dart';
// import 'package:covid19/ui/static/static_error_screen.dart';
// import 'package:covid19/ui/statistics//widgets/statistics_loading_widget.dart';
// import 'package:covid19/ui/statistics/widgets/info_graph_widgert.dart';
// import 'package:covid19/ui/statistics/widgets/info_card_widget.dart';
// import 'package:covid19/utils/bloc/application_bloc.dart';
// import 'package:covid19/utils/bloc/application_state.dart';
// import 'package:covid19/utils/custom_scroll_behaviour.dart';
// import 'package:covid19/utils/device/device_utils.dart';
// import 'package:covid19/utils/emoji_flags.dart';
// import 'package:covid19/widgets/country_picker/country_picker_dialog.dart';
// import 'package:covid19/widgets/progress_indicator_widget.dart';
// import 'package:covid19/widgets/sized_box_height_widget.dart';
// import 'package:covid19/widgets/sized_box_width_widget.dart';

// /// Displays the country Information and country statistics
// /// Handles the various states of the [HomeChangeNotifier] to perform
// /// the appropriate action
// class StatisticsScreen extends StatefulWidget {
//   @override
//   _StatisticsScreenState createState() => _StatisticsScreenState();
// }

// class _StatisticsScreenState extends State<StatisticsScreen> {
//   bool isOffline = false;

//   List<Countries> countriesList;
//   DateTime today = DateTime.now();
//   List<Countries> countrySearchItems = [];
//   String selectedCountry = '', selectedCountryISO2 = '';

//   @override
//   void initState() {
//     super.initState();

//     // Setting the value of [selectedCountry] and [selectedCountryISO2] which
//     // used to display the current selected country and to fetch the flag flat icon
//     // of the Country respectively
//     //
//     // Using [Futre.delayed] act as an additional secutiry layer to perform the requested
//     // tasks before the UI is painted
//     Future.delayed(
//       const Duration(milliseconds: 10),
//       () {
//         // Using [Bloc] to obtain the state which contains the [selectedCountry], [selectedCountryISO2]
//         // and [countriesList]
//         final ApplicationState state = BlocProvider.of<ApplicationBloc>(context).state;
//         if (state is ApplicationInitialized) {
//           setState(
//             () {
//               selectedCountryISO2 = state.userCountryInformation.country;
//               countriesList = state.countriesList;
//               selectedCountry = countriesList.firstWhere((item) => item.iso2 == selectedCountryISO2).name;
//               // Adding all the items of the [countriesList] to [countrySearchItems]
//               for (final item in countriesList) {
//                 countrySearchItems.add(
//                   Countries(
//                     iso2: item.iso2,
//                     name: item.name,
//                   ),
//                 );
//               }

//               // Makign the Network Call to fetch the summary information for the selected country
//               _fetchHomeData(iso2: selectedCountryISO2);
//             },
//           );
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   // Fetching Global Information and about selected countri/Home Country
//   Future<void> _fetchHomeData({@required String iso2}) async {
//     Provider.of<StatisticsChangeNotifier>(context, listen: false).fetchHomeData(
//       iso2: iso2,
//     );
//     setState(() {
//       // Setting today's date value
//       today = DateTime.now();
//     });
//   }

//   // Building the row item for the Searchable Country Dialog
//   Widget _buildDialogItem(Countries country) {
//     return Row(
//       children: <Widget>[
//         Text(
//           Emoji.byISOCode('flag_${country.iso2.toLowerCase()}').char,
//           style: const TextStyle(
//             fontSize: 30,
//           ),
//         ),
//         const SizedBoxWidthWidget(15),
//         Flexible(
//           child: Text(
//             country.name,
//             style: TextStyles.statisticsHeadingTextStlye.copyWith(
//               fontSize: 16,
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   // Method used to open the Searchable Country Dialog
//   void _openCountryPickerDialog() => showDialog(
//         context: context,
//         builder: (context) => Theme(
//           data: themeData,
//           child: CountryPickerDialog(
//             isDividerEnabled: true,
//             // Passing sort Comparator to sort the items of the list in ascending order
//             sortComparator: (a, b) => a.name.compareTo(b.name),
//             titlePadding: const EdgeInsets.all(8.0),
//             searchCursorColor: AppColors.offBlackColor,
//             countriesList: countrySearchItems,
//             isSearchable: true,
//             onValuePicked: (Countries country) {
//               setState(
//                 () {
//                   // Setting the values of [selectedCountry] and [selectedCountryISO2]
//                   // after selecting a country.
//                   // This data is used to fetch the Information and Statistics about
//                   // the selectec country.
//                   selectedCountry = country.name;
//                   selectedCountryISO2 = country.iso2;
//                   _fetchHomeData(iso2: selectedCountryISO2);
//                 },
//               );
//             },
//             itemBuilder: _buildDialogItem,
//           ),
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     // Wrapping the contents in [SafeArea] to avoid the Notch (When avaiable) and the bottom
//     // navigation bar (Mostly comes in use for iOS Devices)
//     return SafeArea(
//       child: Scaffold(
//         body: Consumer<StatisticsChangeNotifier>(
//           builder: (
//             BuildContext context,
//             StatisticsChangeNotifier notifier,
//             Widget child,
//           ) {
//             switch (notifier.state) {
//               // Switch Case which signfiies that [StatisticsState] is Loading
//               case StatisticsState.loading:
//                 return Stack(
//                   children: <Widget>[
//                     HomeLoadingWidget(
//                       today: today,
//                       selectedCountry: selectedCountry,
//                       selectedCountryISO2: selectedCountryISO2,
//                     ),
//                     const CustomProgressIndicatorWidget(),
//                   ],
//                 );

//               // Switch Case which signfiies that [StatisticsState] has some content
//               case StatisticsState.hasData:
//                 final StatisticseData data = notifier.data;
//                 // Fetching the index of the selected country
//                 // TODO :- Change this post summary API being available country-wise
//                 int currentCountryIndex = data.statisticsInformationData.countries.indexWhere(
//                   (item) => item.countryCode == selectedCountryISO2,
//                 );
//                 // Adding negative checker clause (Not Found) if the data is not initialised yet
//                 if (currentCountryIndex < 0) {
//                   currentCountryIndex = 0;
//                 }

//                 return RefreshIndicator(
//                   onRefresh: () => _fetchHomeData(
//                     iso2: selectedCountryISO2,
//                   ),
//                   color: AppColors.accentColor,
//                   child: ScrollConfiguration(
//                     behavior: const CustomScrollBehaviour(),
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(
//                           Dimens.horizontalPadding,
//                           Dimens.verticalPadding / 0.75,
//                           0,
//                           0,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             // Back Icon
//                             GestureDetector(
//                               onTap: () => Navigator.of(context).pop(),
//                               child: Icon(
//                                 Covid19Icons.keyboardArrowLeft,
//                                 size: screenHeight / 45,
//                                 color: AppColors.blackColor,
//                               ),
//                             ),

//                             // Vertical Spacing
//                             SizedBoxHeightWidget(screenHeight / 50),

//                             // Page Title
//                             Text(
//                               Strings.outbreakTitle,
//                               style: TextStyles.statisticsHeadingTextStlye.copyWith(
//                                 fontSize: screenHeight / 45,
//                               ),
//                             ),

//                             // Current Date
//                             Text(
//                               todayDateFormatter(today),
//                               style: TextStyles.statisticsSubHeadingTextStlye.copyWith(
//                                 fontSize: screenHeight / 60,
//                               ),
//                             ),

//                             // Vertical Spacing
//                             SizedBoxHeightWidget(screenHeight / 100),

//                             // Global Title
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                     right: screenWidth / 50,
//                                   ),
//                                   child: Text(
//                                     Strings.globalTitle,
//                                     softWrap: true,
//                                     style: TextStyles.hightlightText.copyWith(
//                                       fontSize: screenHeight / 30,
//                                     ),
//                                   ),
//                                 ),
//                                 Icon(
//                                   Covid19Icons.globe,
//                                   size: screenHeight / 35,
//                                   color: AppColors.blackColor,
//                                 ),
//                               ],
//                             ),

//                             // Vertical Spacing
//                             SizedBoxHeightWidget(screenHeight / 100),

//                             // Last Updated On Information
//                             Wrap(
//                               crossAxisAlignment: WrapCrossAlignment.center,
//                               direction: Axis.horizontal,
//                               // Last Updated Date & Time
//                               children: <Widget>[
//                                 Text(
//                                   lastUpdateDateFormatter(
//                                     data.statisticsInformationData.date,
//                                   ),
//                                   maxLines: 2,
//                                   softWrap: true,
//                                   style: TextStyles.statisticsSubHeadingTextStlye.copyWith(
//                                     fontSize: screenHeight / 70,
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () => _fetchHomeData(
//                                     iso2: selectedCountry,
//                                   ),
//                                   child: Icon(
//                                     Covid19Icons.autorenew,
//                                     size: screenHeight / 65,
//                                     color: AppColors.offBlackColor,
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             // Vertical Spacing
//                             SizedBoxHeightWidget(screenHeight / 50),

//                             // Details Button
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 GestureDetector(
//                                   onTap: () => Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => GlobalCountriesDetails(
//                                         globalCountriesList: data.statisticsInformationData.countries,
//                                       ),
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                       right: Dimens.horizontalPadding / 0.75,
//                                     ),
//                                     child: Text(
//                                       Strings.details,
//                                       maxLines: 2,
//                                       softWrap: true,
//                                       style: TextStyles.statisticsAccentTextStyle.copyWith(
//                                         fontSize: screenHeight / 50,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             // Vertical Spacing
//                             SizedBoxHeightWidget(screenHeight / 75),

//                             // Information Cards
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 right: Dimens.horizontalPadding,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   // Global Confirmed Cases
//                                   Expanded(
//                                     flex: 1,
//                                     child: InfoCardWidget(
//                                       infoColor: AppColors.confirmedColor,
//                                       infoIcon: Covid19Icons.add,
//                                       infoValueNew: data.statisticsInformationData.global.newConfirmed,
//                                       infoValue: data.statisticsInformationData.global.totalConfirmed,
//                                       infoLabel: Strings.infectedLabel,
//                                     ),
//                                   ),

//                                   // Horizontal Spacing
//                                   SizedBoxWidthWidget(screenWidth / 75),

//                                   // Global Recovered Cases
//                                   Expanded(
//                                     flex: 1,
//                                     child: InfoCardWidget(
//                                       infoColor: AppColors.recoveredColor,
//                                       infoIcon: Covid19Icons.favorite,
//                                       infoValueNew: data.statisticsInformationData.global.newRecovered,
//                                       infoValue: data.statisticsInformationData.global.totalRecovered,
//                                       infoLabel: Strings.recoveredLabel,
//                                     ),
//                                   ),

//                                   // Horizontal Spacing˝
//                                   SizedBoxWidthWidget(screenWidth / 75),

//                                   // Global Active Cases
//                                   Expanded(
//                                     flex: 1,
//                                     child: InfoCardWidget(
//                                       infoColor: AppColors.activeColor,
//                                       infoIcon: Icons.text_format,
//                                       infoValueNew: data.statisticsInformationData.global.newConfirmed -
//                                           (data.statisticsInformationData.global.newRecovered +
//                                               data.statisticsInformationData.global.newDeaths),
//                                       infoValue: data.statisticsInformationData.global.totalConfirmed -
//                                           (data.statisticsInformationData.global.totalRecovered +
//                                               data.statisticsInformationData.global.totalDeaths),
//                                       infoLabel: Strings.activeLabel,
//                                     ),
//                                   ),

//                                   // Horizontal Spacing
//                                   SizedBoxWidthWidget(screenWidth / 75),

//                                   // Global Deaths
//                                   Expanded(
//                                     flex: 1,
//                                     child: InfoCardWidget(
//                                       infoColor: AppColors.deadColor,
//                                       infoIcon: Covid19Icons.close,
//                                       infoValueNew: data.statisticsInformationData.global.newDeaths,
//                                       infoValue: data.statisticsInformationData.global.totalDeaths,
//                                       infoLabel: Strings.deathsLabel,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // Vertical Spacing
//                             SizedBoxHeightWidget(screenHeight / 35),

//                             const Padding(
//                               padding: EdgeInsets.only(
//                                 right: Dimens.horizontalPadding,
//                               ),
//                               child: Divider(
//                                 color: AppColors.offBlackColor,
//                                 height: 1,
//                               ),
//                             ),

//                             // Vertical Spacing
//                             SizedBoxHeightWidget(screenHeight / 75),

//                             // Country Title
//                             // Gesture Detector is used to eliminate the ripple effect
//                             GestureDetector(
//                               onTap: () {
//                                 _openCountryPickerDialog();
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   Flexible(
//                                     flex: 5,
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                         right: screenWidth / 50,
//                                       ),
//                                       child: Text(
//                                         selectedCountry,
//                                         softWrap: true,
//                                         style: TextStyles.hightlightText.copyWith(
//                                           fontSize: screenHeight / 30,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Flexible(
//                                     flex: 1,
//                                     child: Text(
//                                       // Adding null checker clause if the data is not initialised yet
//                                       selectedCountryISO2 != ''
//                                           ? Emoji.byISOCode('flag_${selectedCountryISO2.toLowerCase()}').char
//                                           : '',
//                                       style: TextStyle(
//                                         fontSize: screenHeight / 35,
//                                       ),
//                                     ),
//                                   ),
//                                   Flexible(
//                                     flex: 1,
//                                     child: Icon(
//                                       Covid19Icons.arrowDropDown,
//                                       size: screenHeight / 30,
//                                       color: AppColors.offBlackColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // Vertical Spacing
//                             SizedBoxHeightWidget(screenHeight / 200),

//                             // Details Button
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     right: Dimens.horizontalPadding / 0.75,
//                                   ),
//                                   child: Text(
//                                     Strings.details,
//                                     maxLines: 2,
//                                     softWrap: true,
//                                     style: TextStyles.statisticsAccentTextStyle.copyWith(
//                                       fontSize: screenHeight / 50,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             // Vertical Spacing
//                             SizedBoxHeightWidget(screenHeight / 75),

//                             // Information Cards
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 right: Dimens.horizontalPadding,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   // Country Speicific Confirmed Cases
//                                   Expanded(
//                                     flex: 1,
//                                     child: InfoCardWidget(
//                                       infoColor: AppColors.confirmedColor,
//                                       infoIcon: Covid19Icons.add,
//                                       infoValueNew:
//                                           data.statisticsInformationData.countries[currentCountryIndex].newConfirmed,
//                                       infoValue:
//                                           data.statisticsInformationData.countries[currentCountryIndex].totalConfirmed,
//                                       infoLabel: Strings.infectedLabel,
//                                     ),
//                                   ),

//                                   // Horizontal Spacing
//                                   SizedBoxWidthWidget(screenWidth / 75),

//                                   // Country Speicific Recovered Cases
//                                   Expanded(
//                                     flex: 1,
//                                     child: InfoCardWidget(
//                                       infoColor: AppColors.recoveredColor,
//                                       infoIcon: Covid19Icons.favorite,
//                                       infoValueNew:
//                                           data.statisticsInformationData.countries[currentCountryIndex].newRecovered,
//                                       infoValue:
//                                           data.statisticsInformationData.countries[currentCountryIndex].totalRecovered,
//                                       infoLabel: Strings.recoveredLabel,
//                                     ),
//                                   ),

//                                   // Horizontal Spacing
//                                   SizedBoxWidthWidget(screenWidth / 75),

//                                   // Country Speicific Active Cases
//                                   Expanded(
//                                     flex: 1,
//                                     child: InfoCardWidget(
//                                       infoColor: AppColors.activeColor,
//                                       infoIcon: Icons.text_format,
//                                       infoValueNew: data
//                                               .statisticsInformationData.countries[currentCountryIndex].newConfirmed -
//                                           (data.statisticsInformationData.countries[currentCountryIndex].newRecovered +
//                                               data.statisticsInformationData.countries[currentCountryIndex].newDeaths),
//                                       infoValue:
//                                           data.statisticsInformationData.countries[currentCountryIndex].totalConfirmed -
//                                               (data.statisticsInformationData.countries[currentCountryIndex]
//                                                       .totalRecovered +
//                                                   data.statisticsInformationData.countries[currentCountryIndex]
//                                                       .totalDeaths),
//                                       infoLabel: Strings.activeLabel,
//                                     ),
//                                   ),

//                                   // Horizontal Spacing
//                                   SizedBoxWidthWidget(screenWidth / 75),

//                                   // Country Speicific Deaths
//                                   Expanded(
//                                     flex: 1,
//                                     child: InfoCardWidget(
//                                       infoColor: AppColors.deadColor,
//                                       infoIcon: Covid19Icons.close,
//                                       infoValueNew:
//                                           data.statisticsInformationData.countries[currentCountryIndex].newDeaths,
//                                       infoValue:
//                                           data.statisticsInformationData.countries[currentCountryIndex].totalDeaths,
//                                       infoLabel: Strings.deathsLabel,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // Vertical Spacing
//                             SizedBoxHeightWidget(screenHeight / 25),

//                             // Confirmed Cases Label
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(
//                                   "ConfirmedXXXXXX",
//                                   maxLines: 2,
//                                   softWrap: true,
//                                 ),
//                               ],
//                             ),

//                             // Vertical Spacing
//                             // SizedBoxHeightWidget(screenHeight / 75),

//                             // Information Tab
//                             InfoGraphWidget(
//                               countryStatisticsConfirmedList: data.countryStatisticsConfirmedList,
//                               countryStatisticsRecoveredList: data.countryStatisticsRecoveredList,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               // Switch Case which signfiies that [StatisticsState] has some Generic error
//               case StatisticsState.hasError:
//                 final error = notifier.error;
//                 return Scaffold(
//                   body: Center(
//                     child: StaticErrorScreen(
//                       image: const AssetImage(AssetImages.genericError),
//                       title: error,
//                       desc: Strings.genericErrorDesc,
//                       actionText: Strings.retryButton,
//                       onRetry: () => notifier.fetchHomeData(iso2: selectedCountryISO2),
//                     ),
//                   ),
//                 );

//               // Switch Case which signfiies that [StatisticsState] has Network error
//               case StatisticsState.hasNetworkError:
//                 final error = notifier.error;
//                 return Scaffold(
//                   body: Center(
//                     child: StaticErrorScreen(
//                       image: const AssetImage(AssetImages.noInternet),
//                       title: error,
//                       desc: Strings.noInternetErrorDesc,
//                       actionText: Strings.retryButton,
//                       onRetry: () => notifier.fetchHomeData(iso2: selectedCountryISO2),
//                     ),
//                   ),
//                 );

//               // Switch Case which signfiies that [StatisticsState] is Unitlialised
//               // which is the default state for [StatisticsState]
//               case StatisticsState.unInit:
//                 return const Center(
//                   child: CustomProgressIndicatorWidget(),
//                 );
//             }
//             // If the state of [StatisticsState] is none of the switched states,
//             // returning an empty container to catch it if it ever occurs
//             // This should never happen.
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }

// String todayDateFormatter(DateTime date) {
//   const dayData = '{ "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" }';

//   const monthData =
//       '{ "1" : "Jan", "2" : "Feb", "3" : "Mar", "4" : "Apr", "5" : "May", "6" : "June", "7" : "Jul", "8" : "Aug", "9" : "Sep", "10" : "Oct", "11" : "Nov", "12" : "Dec" }';

//   return '${json.decode(dayData)['${date.weekday}']}, ${date.day.toString()} ${json.decode(monthData)['${date.month}']} ${date.year.toString()}';
// }

// String lastUpdateDateFormatter(String date) {
//   final parsedDateTime = DateTime.parse(date);

//   return 'Information Last Updated : ${todayDateFormatter(parsedDateTime.toLocal())} ${parsedDateTime.toLocal().hour.toString()}:${parsedDateTime.toLocal().minute.toString()} ${parsedDateTime.toLocal().timeZoneName}';
// }

// class FadeRoute extends PageRouteBuilder {
//   final Widget page;
//   FadeRoute({this.page})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               FadeTransition(
//             opacity: animation,
//             child: child,
//           ),
//         );
// }