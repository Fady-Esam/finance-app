import 'package:finance_flutter_app/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../generated/l10n.dart';
import '../../../data/on_boarding_list.dart';
import 'on_boarding_item.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
    late PageController _pageController;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children:
                    onboardingList.map((item) {
                      return OnBoardingItem(onBoardingModel: item);
                    }).toList(),
              ),
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return InkWell(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.all(5),
                        height: 10,
                        width: _currentPage == index ? 20 : 10,
                        decoration: BoxDecoration(
                          color:
                              _currentPage == index ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  }),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    if (_currentPage == 2) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('onboarding_seen', true);
                      Navigator.pushReplacementNamed(context, HomeView.routeName);
                    } else {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == 2
                        ? S.of(context).start
                        : S.of(context).next,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}