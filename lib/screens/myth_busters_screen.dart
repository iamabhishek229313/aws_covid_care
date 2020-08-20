import 'package:aws_covid_care/core/repository/static/myth_busters.dart';
import 'package:aws_covid_care/core/repository/static/symptoms_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MythBusterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Myth Busters"),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: mythBusterData.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 44.0,
                child: FadeInAnimation(
                    child: ExpansionTile(
                  title: Text(mythBusterData[index].myth),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, right: 8.0),
                      child: Text(
                        mythBusterData[index].fact,
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                )),
              ),
            );
          },
        ),
      ),
    );
  }
}
