import 'dart:async';

import 'package:flutter/material.dart';

import '../../config/routes/routes.dart';
import '../../core/utiles/assets_manager.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _startDelay() {
    _timer = Timer(
      const Duration(milliseconds: 2000),
      () => Navigator.of(context).pushReplacementNamed(Routes.onBoardingScreen),
    );
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImgAssets.splashImage),
      ),
    );
  }
}
