import 'package:finance_flutter_app/features/home/presentation/views/home_view.dart';
import 'package:finance_flutter_app/features/transaction/presentation/views/transaction_view.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'features/category/presentation/views/category_view.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});
  static const routeName = 'bottom-nav-bar-view';
  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _screens = const [
    HomeView(),
    TransactionView(),
    CategoryView(),
    //Placeholder(),
    Placeholder(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(), // Optional: for smoother UX
        children: _screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0), // You can change this value
          topRight: Radius.circular(30.0), // You can change this value
        ),

        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          backgroundColor:
              isDark ? Colors.black : Colors.white, // Background color
          selectedItemColor: Colors.blue,
          unselectedItemColor:
              isDark ? Colors.grey[500] : Colors.grey[700], // Inactive
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 24),
          selectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long),
              label: S.of(context).transactions,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: S.of(context).categories,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: S.of(context).settings,
            ),
          ],
        ),
      ),
    );
  }
}
