


import 'package:finance_flutter_app/features/on_boarding/presentation/views/widgets/on_boarding_view_body.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});
  static const routeName = "onBoarding";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('onboarding_seen', true);
              Navigator.pushNamed(context, 'home');
            },
            child: Text(S.of(context).skip),
          ),
        ],
      ),
      body: OnBoardingViewBody(),
    );
  }
}
