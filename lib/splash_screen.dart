import 'package:flutter/material.dart';
import 'package:flutter_learning_app/controllers/local_storage_controller.dart';
import 'package:flutter_learning_app/login.dart';
import 'package:flutter_learning_app/main.dart';
import 'package:flutter_learning_app/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  startAnimation() async {
    Provider.of<UserProvider>(context, listen: false).init();
    await Future.delayed(const Duration(milliseconds: 400));
    _truckAnimationState = AnimationState.CenterTruck;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 600));
    _truckAnimationState = AnimationState.EndTruck;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 400));
    _truckAnimationState = AnimationState.ShowShreemFleet;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 600));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LocalStorageUtils().isUserLoggedIn()
                ? HomePage()
                : LoginScreen()));
  }

  AnimationState _truckAnimationState = AnimationState.RotatedTruck;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _truckAnimationState == AnimationState.ShowShreemFleet
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: Transform.rotate(
                          angle: 50,
                          child: Image.asset(
                            "assets/Truck Icon.png",
                            height: 150,
                            width: 150,
                            scale: 0.1,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        child: Text(
                          "Shreem Fleet",
                          style: GoogleFonts.sofia(
                              fontSize: 25,
                              color: Theme.of(context).accentColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          : Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  bottom: getBottomPos(),
                  left: getLeftPos(),
                  child: Transform.rotate(
                      origin: Offset(0, 0),
                      angle: getTransformAngle(),
                      child: Image.asset("assets/Truck Icon.png")),
                )
              ],
            ),
    );
  }

  double getLeftPos() {
    if (_truckAnimationState == AnimationState.RotatedTruck) {
      return -20;
    } else if (_truckAnimationState == AnimationState.CenterTruck) {
      return (MediaQuery.of(context).size.width / 2) - 50;
    } else if (_truckAnimationState == AnimationState.EndTruck) {
      return (MediaQuery.of(context).size.width + 100);
    } else {
      return 0;
    }
  }

  double getBottomPos() {
    if (_truckAnimationState == AnimationState.RotatedTruck) {
      return MediaQuery.of(context).size.height / 2 - 100;
    } else if (_truckAnimationState == AnimationState.CenterTruck) {
      return MediaQuery.of(context).size.height / 2;
    } else if (_truckAnimationState == AnimationState.EndTruck) {
      return MediaQuery.of(context).size.height / 2;
    } else {
      return 0;
    }
  }

  double getTransformAngle() {
    if (_truckAnimationState == AnimationState.RotatedTruck ||
        _truckAnimationState == AnimationState.CenterTruck) {
      return 50;
    }
    return 0;
  }
}

enum AnimationState { RotatedTruck, CenterTruck, EndTruck, ShowShreemFleet }
