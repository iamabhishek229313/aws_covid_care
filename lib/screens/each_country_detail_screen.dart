import 'package:aws_covid_care/screens/grid_items/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EachCountryDetailScreen extends StatelessWidget {
  final List<CountriesData> data;

  const EachCountryDetailScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat _format = NumberFormat("##,##,###,###,###");
    return Scaffold(
      appBar: AppBar(
        title: Text("All details"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Country',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Infected',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Recovered',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Active',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Deaths',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: data.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: (index % 2 == 0) ? Colors.blue.shade50 : Colors.blueGrey.shade50),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          data[index].country,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                        )),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.amber,
                                  size: 16.0,
                                ),
                                Text(
                                  _format.format(data[index].newConfirmed),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _format.format(data[index].totalConfirmed),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 16.0,
                                ),
                                Text(
                                  _format.format(data[index].newRecovered),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _format.format(data[index].totalRecovered),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.pinkAccent,
                                  size: 16.0,
                                ),
                                Text(
                                  _format.format((data[index].newConfirmed - data[index].newRecovered).abs()),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _format.format((data[index].totalConfirmed - data[index].newConfirmed).abs()),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.red,
                                  size: 16.0,
                                ),
                                Text(
                                  _format.format(data[index].newDeaths),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _format.format(data[index].totalDeaths),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
