import 'package:finance_flutter_app/bottom_nav_bar_view.dart';
import 'package:finance_flutter_app/features/home/presentation/views/manage_finance_view.dart';
import 'package:finance_flutter_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:finance_flutter_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import '../../features/category/presentation/views/manage_category_view.dart';
import '../../features/home/presentation/views/all_activities_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case BottomNavBarView.routeName:
      return MaterialPageRoute(builder: (context) => const BottomNavBarView());
    // case HomeView.routeName:
    //   return MaterialPageRoute(builder: (context) => const HomeView());
    case ManageTransactionView.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder:
            (context) => ManageTransactionView(
              transactionTypeEnum: args['transactionTypeEnum'],
              financeItemModel: args['financeItemModel'],
              modelDateTime: args['modelDateTime'],
              currentDateTime: args['currentDateTime'],
              categoryId: args['categoryId'],
            ),
      );
    case AllActivitiesView.routeName:
      return MaterialPageRoute(builder: (context) => const AllActivitiesView());
    case ManageCategoryView.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder:
            (context) =>
                ManageCategoryView(categoryModel: args['categoryModel']),
      );
    default:
      return MaterialPageRoute(builder: (context) => const SplashView());
  }
}
