import 'package:flutter/material.dart';

import '../utils/theme.dart' as Theme;
import '../utils/localization.dart' show Localization;
import '../utils/general.dart';

class Carousel extends StatefulWidget {
  final currentPage;
  final List<String> imgUrls;
  final double height;
  final double viewportFraction;

  Carousel({
    @required this.imgUrls,
    this.currentPage = 0,
    this.height = 256.0,
    this.viewportFraction = 1.0,
  });

  @override
  _CarouselState createState() => _CarouselState(imgUrls,
    currentPage: this.currentPage,
    height: this.height,
    viewportFraction: this.viewportFraction,
  );
}

class _CarouselState extends State<Carousel> {
  final List<String> imgUrls;
  final double height;
  final double viewportFraction;
  int currentPage;

  _CarouselState(this.imgUrls, {
    this.currentPage,
    this.height,
    this.viewportFraction,
  });

  PageController _controller;

  @override
  initState() {
    super.initState();
    _controller = PageController(
      initialPage: this.currentPage,
      keepPage: false,
      viewportFraction: this.viewportFraction, /// width percentage
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      child: PageView.builder(
        itemCount: imgUrls.length,
        onPageChanged: (value) {
          setState(() {
            this.currentPage = value;
          });
        },
        controller: _controller,
        itemBuilder: (context, index) {
          return builder(index);
        },
        pageSnapping: true,
      ),
    );
  }

  builder(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = 1.0;
        if (_controller.position.haveDimensions) {
          value = _controller.page - index;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 256,
            width: Curves.easeOut.transform(value) * screenWidth,
            child: child,
          ),
        );
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                  imgUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: 72.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Center(
                  child: Text(
                    '${index + 1} / ${imgUrls.length}',
                    style: TextStyle(
                      color:  const Color(0xffffffff),
                      fontWeight: FontWeight.w100,
                      fontFamily: "AppleSDGothicNeo",
                      fontStyle:  FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}