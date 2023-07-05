import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/apis/location_api.dart';
import 'package:your_tours_mobile/apis/user_api.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/user_controller.dart';
import 'package:your_tours_mobile/models/responses/location_response.dart';
import 'package:your_tours_mobile/models/responses/user_response.dart';
import 'package:your_tours_mobile/screens/main_screen/main_screen.dart';
import 'package:your_tours_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:your_tours_mobile/size_config.dart';

import '../../../components/default_button.dart';
// This is the best practice
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": "Welcome , Let’s go!", "image": "assets/images/splash_1.png"},
    {
      "text":
          "We help people connect with owners \naround United State of America",
      "image": "assets/images/splash_2.png"
    },
    {
      "text":
          "We show the easy way to home. \nJust stay at search_home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  Future<void> _fetchDataUserFromApi() async {
    try {
      List<Object> response = await LoadingOverlay.of(context).during(
          future: Future.wait([
        getCurrentUserApi(),
        getCurrentLocationApi(),
      ]));

      UserInfoResponse userResponse = response.first as UserInfoResponse;
      GetCurrentLocationResponse locationResponse =
          response.last as GetCurrentLocationResponse;

      userResponse.data?.deviceLocation = locationResponse.data;

      Get.put(
          UserController(userResponse.data!.obs, locationResponse.data!.obs));

      if (!mounted) {
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MainScreen(selectedInit: 0)),
      );
    } on FormatException catch (error) {
      log(name: 'ERROR PRE START:', error.toString());
      Navigator.pushNamed(context, SignInScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        _fetchDataUserFromApi();
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
