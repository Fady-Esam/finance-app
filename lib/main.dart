import 'dart:ui';
import 'package:finance_flutter_app/bottom_nav_bar_view.dart';
import 'package:finance_flutter_app/core/helper/on_generate_routes.dart';
import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:finance_flutter_app/features/home/data/repos/home_repo_impl.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'package:finance_flutter_app/features/user_setup/data/repos/user_setup_repo_impl.dart';
import 'package:finance_flutter_app/features/user_setup/presentation/manager/cubits/manage_user_setup_cubit/manage_user_setup_cubit.dart';
import 'package:finance_flutter_app/features/user_setup/presentation/views/user_setup_view.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubits/change_language_cubit/change_language_cubit.dart';
import 'cubits/change_language_cubit/change_language_state.dart';
import 'cubits/change_theme_cubit/change_theme_cubit.dart';
import 'cubits/change_theme_cubit/change_theme_state.dart';
import 'features/category/data/repos/category_repo_impl.dart';
import 'features/category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import 'features/home/data/enums/recurrence_type_enum.dart';
import 'features/home/data/models/finance_item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //Hive.registerAdapter(FinanceItemModelAdapter());
  //Hive.registerAdapter(CategoryModelAdapter());
  // Hive.registerAdapter(RecurrenceTypeAdapter());
  // await Hive.openBox<FinanceItemModel>(
  //   'finance',
  // ).then((box) async => await box.clear());
  // await Hive.openBox<CategoryModel>(
  //   'category',
  // ).then((box) async => await box.clear());
  Hive.registerAdapter(FinanceItemModelAdapter());
  Hive.registerAdapter(RecurrenceTypeAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox<FinanceItemModel>('finance');
  await Hive.openBox<CategoryModel>('category');
  //await Hive.openBox<RecurrenceType>('recurrenceType');
  final prefs = await SharedPreferences.getInstance();
  String deviceLang = PlatformDispatcher.instance.locale.languageCode;
  String defaultLangCode =
      deviceLang == "ar" || deviceLang == "en" ? deviceLang : "en";
  final savedLanguage = prefs.getString("language") ?? defaultLangCode;
  final savedTheme = prefs.getString("theme") ?? "system";
  runApp(
    //MyApp(),
    MyApp(savedLanguage: savedLanguage, savedTheme: savedTheme),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.savedLanguage,
    required this.savedTheme,
  });
  final String savedLanguage;
  final String savedTheme;

  @override
  Widget build(BuildContext context) {
    Locale locale = Locale(savedLanguage);
    ThemeMode mode =
        savedTheme == "dark"
            ? ThemeMode.dark
            : savedTheme == "light"
            ? ThemeMode.light
            : WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;

    ThemeData setThemeData(Brightness brightness) {
      return ThemeData(brightness: brightness, useMaterial3: true);
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChangeLanguageCubit(initialLocale: locale),
        ),
        BlocProvider(create: (context) => ChangeThemeCubit(initialTheme: mode)),
        BlocProvider(
          create: (context) => ManageFinanceCubit(homeRepo: HomeRepoImpl()),
        ),
        BlocProvider(
          create:
              (context) => ManageCategoryCubit(homeRepo: CategoryRepoImpl()),
        ),
        BlocProvider(
          create:
              (context) => ManageUserSetupCubit(userSetupRepo: UserSetupRepoImpl()),
        ),
      ],
      child: BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
        builder: (context, state) {
          if (state is ChangeThemeDone) {
            mode = state.theme;
          }
          return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
            builder: (context, state) {
              if (state is ChangeLanguageDone) {
                locale = state.language;
              }
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: locale,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                themeMode: mode,
                theme: setThemeData(Brightness.light),
                darkTheme: setThemeData(Brightness.dark),
                onGenerateRoute: onGenerateRoute,
                //initialRoute: BottomNavBarView.routeName,
              );
            },
          );
        },
      ),
    );
  }
}
