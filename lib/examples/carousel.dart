import 'package:flutter/material.dart';

import '../utils/theme.dart' as Theme;
import '../utils/localization.dart' show Localization;
import '../utils/general.dart';

class Carousel extends StatefulWidget {
  Carousel({Key key}) : super(key: key);

  @override
  CarouselState createState() => new CarouselState();
}

class CarouselState extends State<Carousel> {
  _navigate() {
    General.instance.navigateScreenNamed(context, '/Carousel', reset: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Carousel'),
      ),
    );
  }
}
