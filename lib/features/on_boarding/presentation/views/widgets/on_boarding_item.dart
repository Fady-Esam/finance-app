import 'package:flutter/material.dart';

import '../../../data/models/on_boarding_model.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({super.key, required this.onBoardingModel});
  final OnBoardingModel onBoardingModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(onBoardingModel.image),
        SizedBox(height: 20),
        Text(
          onBoardingModel.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          onBoardingModel.subTitle,
          style: TextStyle(
            fontSize: 16,
            color: const Color.fromARGB(255, 109, 108, 108),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
