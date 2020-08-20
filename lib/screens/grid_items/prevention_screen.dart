import 'package:aws_covid_care/utils/custom_scroll_config.dart';
import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

class PreventionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10.0,
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        label: Text(
          "Go back",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: ScrollConfiguration(
            behavior: const CustomScrollBehaviour(),
            child: SingleChildScrollView(
                child: ImageFade(
              image: CacheImage('http://boilerplate.in/covid19/COVID-19-Prevention-Dos-and-Donts.jpg'),
              placeholder: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ))),
      ),
    );
  }
}
