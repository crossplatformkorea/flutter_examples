import 'package:flutter/material.dart';

import '../shared_widgets/carousel.dart' show Carousel;
import '../utils/theme.dart' as Theme;
import '../utils/localization.dart' show Localization;
import '../utils/general.dart';

class ExCarousel extends StatefulWidget {
  @override
  _ExCarouselState createState() => new _ExCarouselState();
}

class _ExCarouselState extends State<ExCarousel> {
  final List<String> imgUrls = [
    'http://catsatthestudios.com/wp-content/uploads/2017/12/12920541_1345368955489850_5587934409579916708_n-2-960x410.jpg',
    'http://catsatthestudios.com/wp-content/uploads/2014/11/calico.jpg',
    'http://catsatthestudios.com/wp-content/uploads/2017/12/should-feral-cats-be-tamed-10.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('CarouselEx'),
      ),
      body: ListView(
        children: <Widget>[
          Carousel(imgUrls: imgUrls),
          Container(
            margin: EdgeInsets.only(top: 12.0, left: 8.0),
            child: Text('Carousel Widget'),
          ),
        ],
      ),
    );
  }
}