import 'package:aws_covid_care/core/repository/static/faq_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Frequently asked questions"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: List.generate(
            faqData.length,
            (index) => ExpansionTile(
                  title: Text(faqData[index].title),
                  leading: Icon(FontAwesomeIcons.questionCircle),
                  children: [
                    Padding(padding: EdgeInsets.only(left: 16.0), child: Text(faqData[index].description)),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "#StayHomeStaySafe",
                          style: TextStyle(color: Colors.red.shade600),
                        ))
                  ],
                )),
      ),
    );
  }
}
