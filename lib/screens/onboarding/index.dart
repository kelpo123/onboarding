import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding/utilities/styles.dart';

class MyHomePage extends StatefulWidget {
  @override
  _OnboardingScreen createState() => _OnboardingScreen();
}

class _OnboardingScreen extends State<MyHomePage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Color(0xFF7B51D3),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  Padding _ContentComponent(String image, String title, String description) {
    return Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Image(
                    image: AssetImage(image), height: 300.0, width: 300.0)),
            SizedBox(height: 30.0),
            Text(title, style: kTitleStyle),
            SizedBox(height: 15.0),
            Text(
              description,
              style: kSubtitleStyle,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.1,
                  0.4,
                  0.7,
                  0.9
                ],
                    colors: [
                  Color(0xFF3594DD),
                  Color(0xFF4563DB),
                  Color(0xFF5036D5),
                  Color(0xFF5B16D0),
                ])),
            child: (Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () => print("Skip"),
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          )),
                      Container(
                        height: 600.0,
                        child: PageView(
                            physics: ClampingScrollPhysics(),
                            controller: _pageController,
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            children: <Widget>[
                              _ContentComponent(
                                  'assets/images/onboarding0.png',
                                  'Connect people\narround the world',
                                  'Lorem ipsum dolor sit amet, conset bambangos js'),
                              _ContentComponent(
                                  'assets/images/onboarding1.png',
                                  'Get a new experience\nof imagination',
                                  'Lorem ipsum dolor sit amet, conset bambangos js'),
                              _ContentComponent(
                                  'assets/images/onboarding2.png',
                                  'Save the day\nfor direction',
                                  'Lorem ipsum dolor sit amet, conset bambangos js')
                            ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                      _currentPage != _numPages - 1
                          ? Expanded(
                              child: Align(
                                alignment: FractionalOffset.bottomRight,
                                child: FlatButton(
                                    onPressed: () => {
                                          _pageController.nextPage(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease)
                                        },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text('Next',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22.0)),
                                        SizedBox(width: 10.0),
                                        Icon(Icons.arrow_forward,
                                            color: Colors.white, size: 30.0)
                                      ],
                                    )),
                              ),
                            )
                          : Text('')
                    ])))),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => print("Get Started"),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: Color(0xFF5B16D0),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
