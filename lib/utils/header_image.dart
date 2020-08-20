import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    @required this.imageURL,
    @required this.text,
  });

  final String imageURL;
  final String text;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            child: Image(
              image: NetworkImage(imageURL),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: height * 0.06),
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black87],
                  stops: [0.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: 'ProductSans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
