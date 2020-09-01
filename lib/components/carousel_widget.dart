import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  final String imageUrl;
  final String text;

  const CarouselWidget({
    Key key,
    this.imageUrl,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.shade50,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1.5), // changes position of shadow
                  ),
                ],
                image: DecorationImage(image: AssetImage(this.imageUrl), fit: BoxFit.cover),
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(
            height: 24.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 2,
                  blurRadius: 5.0,
                  offset: Offset(1.0, 1.2), // changes position of shadow
                ),
              ],
              color: Colors.grey[200],
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            // height: screenHeight * 0.03,
            width: screenWidth,
            child: Center(
                child: Text(
              this.text,
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )),
          ),
        ],
      ),
    );
  }
}
