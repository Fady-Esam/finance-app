import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/helper/app_images.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const routeName = '/';
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: SvgPicture.asset(AppImages.logo)));
  }
}
