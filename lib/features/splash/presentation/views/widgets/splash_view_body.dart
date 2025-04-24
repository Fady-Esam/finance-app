import 'package:finance_flutter_app/core/helper/app_images.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.logo),
          const SizedBox(height: 20),
          Text(
            S.of(context).splash_screen_title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: const Color.fromARGB(255, 52, 156, 105),
            ),
          ),
        ],
      ),
    );
  }
}