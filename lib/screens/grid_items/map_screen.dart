// import 'dart:developer';

// import 'package:aws_covid_care/utils/map_svg_details.dart';
// import 'package:flutter/material.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({Key key}) : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   Province _pressedProvince;

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;
//     double safeZoneHeight = MediaQuery.of(context).padding.bottom;
//     double navBarHeight = Theme.of(context).platform == TargetPlatform.android ? 56.0 : 44.0;

//     double x = (screenWidth / 2.0) - (MapSvgData.width / 2.0);
//     double y = (screenHeight / 2.0) - (MapSvgData.height / 2.0) - (safeZoneHeight / 2.0) - navBarHeight;
//     Offset offset = Offset(x, y);
//     // Offset offset = Offset(20.0, 20.0);
//     return Scaffold(
//         backgroundColor: Colors.indigo,
//         appBar: AppBar(title: Text('Map')),
//         body: SafeArea(
//             child: Transform.scale(
//                 scale: ((screenHeight / MapSvgData.height)) * 0.5,
//                 child: Transform.translate(offset: offset, child: Stack(children: _buildMap())))));
//   }

//   List<Widget> _buildMap() {
//     List<Widget> provinces = List(Province.values.length);
//     for (int i = 0; i < Province.values.length; i++) {
//       provinces[i] = _buildProvince(Province.values[i]);
//     }
//     return provinces;
//   }

//   Widget _buildProvince(Province province) {
//     return ClipPath(
//         child: Stack(children: <Widget>[
//           CustomPaint(painter: PathPainter(province)),
//           Material(
//               color: Colors.amber,
//               child: InkWell(
//                   onTap: () => _provincePressed(province),
//                   child: Container(color: _pressedProvince == province ? Color(0xFF7C7C7C) : Colors.pink)))
//         ]),
//         clipper: PathClipper(province));
//   }

//   void _provincePressed(Province province) {
//     log(province.toString());
//     setState(() {
//       _pressedProvince = province;
//     });
//   }
// }

// class PathPainter extends CustomPainter {
//   final Province _province;
//   PathPainter(this._province);

//   @override
//   void paint(Canvas canvas, Size size) {
//     Path path = getPathByProvince(_province);
//     canvas.drawPath(
//         path,
//         Paint()
//           ..style = PaintingStyle.stroke
//           ..color = Colors.black
//           ..strokeWidth = 2.0);
//   }

//   @override
//   bool shouldRepaint(PathPainter oldDelegate) => true;

//   @override
//   bool shouldRebuildSemantics(PathPainter oldDelegate) => false;
// }

// class PathClipper extends CustomClipper<Path> {
//   final Province _province;
//   PathClipper(this._province);

//   @override
//   Path getClip(Size size) {
//     return getPathByProvince(_province);
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'package:aws_covid_care/screens/article_page.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ArticlePage(
      articleUrl: "https://app.developer.here.com/coronavirus/",
      title: "Map",
    );
  }
}
