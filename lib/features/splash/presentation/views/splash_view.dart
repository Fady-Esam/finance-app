import 'package:finance_flutter_app/bottom_nav_bar_view.dart';
import 'package:finance_flutter_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:finance_flutter_app/features/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const routeName = 'splash-view';
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();
      bool isOnboardingSeen = prefs.getBool('onboarding_seen') ?? false;
      if (isOnboardingSeen) {
        Navigator.pushReplacementNamed(context, BottomNavBarView.routeName);
        // Navigator.pushReplacementNamed(context, 'onBoarding');
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashViewBody());
  }
}
