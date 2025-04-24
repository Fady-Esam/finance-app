import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});
  static const routeName = "onBoardingView";
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("OnBoardingView"));
  }
}
