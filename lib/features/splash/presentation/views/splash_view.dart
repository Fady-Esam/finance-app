import 'package:finance_flutter_app/features/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const routeName = 'splash';
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      bool isOnboardingSeen = prefs.getBool('onboarding_seen') ?? false;
      if (isOnboardingSeen) {
        Navigator.pushReplacementNamed(context, 'home');
        // Navigator.pushReplacementNamed(context, 'onBoarding');
      } else {
        Navigator.pushReplacementNamed(context, 'onBoarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashViewBody());
  }
}
