import 'package:finance_flutter_app/bottom_nav_bar_view.dart';
import 'package:finance_flutter_app/features/home/presentation/views/manage_finance_view.dart';
import 'package:finance_flutter_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:finance_flutter_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import '../../features/category/presentation/views/manage_category_view.dart';
import '../../features/user_setup/presentation/views/user_setup_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    case UserSetupView.routeName:
      return MaterialPageRoute(builder: (_) => const UserSetupView());
    case BottomNavBarView.routeName:
      return MaterialPageRoute(builder: (_) => const BottomNavBarView());

    case ManageTransactionView.routeName:
      final args = settings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder:
            (_) => ManageTransactionView(
              transactionTypeEnum: args['transactionTypeEnum'],
              financeItemModel: args['financeItemModel'],
              modelDateTime: args['modelDateTime'],
              currentDateTime: args['currentDateTime'],
              isFromHomePage: args['isFromHomePage'],
              categoryFilteredId: args['categoryFilteredId'],
              isAmountPositive: args['isAmountPositive'],
              dateTimeRange: args['dateTimeRange'],
              endDate: args['endDate'],
              recurrenceType: args['recurrenceType'],
            ),
      );

    case ManageCategoryView.routeName:
      final args = settings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder:
            (_) => ManageCategoryView(
              categoryModel: args['categoryModel'],
              categories: args['categories'],
            ),
      );

    default:
      return MaterialPageRoute(builder: (_) => const SplashView());
  }
}
