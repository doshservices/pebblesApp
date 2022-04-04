import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import './widgets/slide_dots.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:pebbles/constants.dart';

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<Map<String, String>> sliderItems = [
    {
      "title": "Book an apartment",
      "desc": "we have got thousands of nice apartments for you",
      "image": "assets/images/onboard1.png"
    },
    {
      "title": "Let’s plan your holiday",
      "desc": "Explore places you have never been to but wish to go",
      "image": "assets/images/onboard2.png"
    },
    {
      "title": "Ride Booking",
      "desc": "Not just our apartments, we also help you move about",
      "image": "assets/images/onboard3.png"
    },
    {
      "title": "Event enquiry",
      "desc": "You can also get your event tickets here",
      "image": "assets/images/onboard4.png"
    }
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < 3) {
        _currentPage++;
        _pageController.animateToPage(_currentPage,
            duration: Duration(microseconds: 300), curve: Curves.easeIn);
      } else {
        timer.cancel();
      }
      // else {
      //   _currentPage = 0;
      // }
    });
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                "${sliderItems[_currentPage]['title']}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Gilroy'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),

              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: _onPageChanged,
                    controller: _pageController,
                    itemCount: 4,
                    itemBuilder: (ctx, i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 80,
                                    width: MediaQuery.of(context).size.height,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(
                                          "${sliderItems[i]['desc']}",
                                          style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.asset(
                                      "${sliderItems[i]['image']}",
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Image.asset("${sliderItems[i]['image']}"),
                    //     Text(
                    //       "${sliderItems[i]['title']}",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold, fontSize: 22),
                    //       textAlign: TextAlign.center,
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.all(20.0),
                    //       child: Text("${sliderItems[i]['desc']}"),
                    //     ),
                    //   ],
                    // ),
                    ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // SizedBox(
              //   height: 20,
              // ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < 4; i++)
                          if (i == _currentPage)
                            SlideDots(true)
                          else
                            SlideDots(false)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              _currentPage == 3
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomDefaultButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(kCreateUserAccount);
                          // Navigator.of(context)
                          //     .pushReplacementNamed(kRegisterPageOne);
                        },
                        text: "Get Started",
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomDefaultButton(
                        onPressed: () {
                          _pageController.animateToPage(_currentPage + 1,
                              duration: Duration(microseconds: 300),
                              curve: Curves.easeIn);
                          // _pageController.animateToPage(2,
                          //     duration: Duration(microseconds: 300),
                          //     curve: Curves.easeIn);
                        },
                        text: "Next",
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
