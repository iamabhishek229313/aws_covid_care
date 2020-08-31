import 'package:carousel_slider/carousel_slider.dart';

class CarouselItem {
  final String imageUrl;
  final String text;

  CarouselItem(this.imageUrl, this.text);
}

List<CarouselItem> carouselItemList = <CarouselItem>[
  CarouselItem('assets/images/doc2.png', "Stay Home"),
  CarouselItem('assets/images/family3.png', "Stay Home"),
  CarouselItem('assets/images/Temp.png', "Stay Home"),
];
