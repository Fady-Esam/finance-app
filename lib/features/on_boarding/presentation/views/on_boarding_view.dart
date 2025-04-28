import 'package:finance_flutter_app/features/home/presentation/views/home_view.dart';
import 'package:finance_flutter_app/features/on_boarding/presentation/views/widgets/on_boarding_view_body.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});
  static const routeName = "onboarding-view";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('onboarding_seen', true);
              Navigator.pushNamed(context, HomeView.routeName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(S.of(context).skip),
          ),
        ],
      ),
      body: OnBoardingViewBody(),
    );
  }
}
