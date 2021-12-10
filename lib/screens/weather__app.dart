import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:weather_app/model/weather_locatiuons.dart';
import 'package:weather_app/widgets/buildin_transformer.dart';
import 'package:weather_app/widgets/single_weather.dart';
import 'package:weather_app/widgets/slider.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  String bgImg;

  _inPageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationList[_currentPage].weatherType == 'Sunny') {
      bgImg = 'assets/sunny.jpg';
    } else if (locationList[_currentPage].weatherType == 'Night') {
      bgImg = 'assets/night.jpg';
    } else if (locationList[_currentPage].weatherType == 'Rainy') {
      bgImg = 'assets/rain.jpg';
    } else if (locationList[_currentPage].weatherType == 'Cloudy') {
      bgImg = 'assets/cloudy.jpg';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "",
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            print("search");
          },
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () {
                print("menu");
              },
              child: SvgPicture.asset(
                "assets/list.svg",
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              bgImg,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 140,
                left: 15,
              ),
              child: Row(
                children: [
                  for (int i = 0; i < locationList.length; i++)
                    if (i == _currentPage) SliderDot(true) else SliderDot(false)
                ],
              ),
            ),
            TransformerPageView(
              onPageChanged: _inPageChange,
              transformer: ScaleAndFadeTransformer(),
              viewportFraction: 0.8,
              scrollDirection: Axis.horizontal,
              itemCount: locationList.length,
              itemBuilder: (ctx, i) => SingleWeather(i),
            )
          ],
        ),
      ),
    );
  }
}
