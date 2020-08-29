import 'package:aws_covid_care/core/repository/static/symptoms_data.dart';
import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_fade/image_fade.dart';

class SymptomsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Symptoms"),
      ),
      body: ListView.builder(
          itemCount: symptomsData.length,
          itemBuilder: (context, index) {
            return Container(
              height: screenHeight * 0.2,
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Container(
                            constraints: BoxConstraints.expand(),
                            child: Center(child: VerticalDivider(thickness: 3.0, color: Colors.grey.shade800)),
                          ),
                          Align(
                            child: Material(
                              elevation: 10.0,
                              shape: CircleBorder(),
                              child: Container(
                                height: screenHeight * 0.1,
                                width: screenHeight * 0.1,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade200),
                                child: ImageFade(
                                  image: CacheImage(
                                    symptomsData[index].imageURL,
                                  ),
                                  placeholder: Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: Center(
                                      child: SpinKitFadingCircle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          Divider(
                            height: 0.0,
                            thickness: 2.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    symptomsData[index].title,
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    symptomsData[index].description,
                                    style: TextStyle(fontSize: 15.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            );
          }),
    );
  }
}
