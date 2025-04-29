import 'package:finance_flutter_app/features/home/presentation/views/manage_transaction_view.dart';
import 'package:finance_flutter_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:finance_flutter_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import '../../features/home/presentation/views/all_activities_view.dart';
import '../../features/home/presentation/views/home_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case SplashView.routeName:
    //   return MaterialPageRoute(builder: (context) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case ManageTransactionView.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder:
            (context) => ManageTransactionView(
              transactionTypeEnum: args['transactionTypeEnum'],
              financeItemModel: args['financeItemModel'],
              modelDateTime: args['modelDateTime'],
              currentDateTime: args['currentDateTime'],
            ),
      );
    case AllActivitiesView.routeName:
      return MaterialPageRoute(builder: (context) => const AllActivitiesView());
    default:
      return MaterialPageRoute(builder: (context) => const SplashView());
  }
}
