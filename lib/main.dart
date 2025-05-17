import 'dart:ui';
import 'package:finance_flutter_app/core/helper/on_generate_routes.dart';
import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:finance_flutter_app/features/home/data/repos/home_repo_impl.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'package:finance_flutter_app/features/user_setup/data/repos/user_setup_repo_impl.dart';
import 'package:finance_flutter_app/features/user_setup/presentation/manager/cubits/manage_user_setup_cubit/manage_user_setup_cubit.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:finance_flutter_app/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/cubits/change_language_cubit/change_language_cubit.dart';
import 'core/cubits/change_language_cubit/change_language_state.dart';
import 'core/cubits/change_theme_cubit/change_theme_cubit.dart';
import 'core/cubits/change_theme_cubit/change_theme_state.dart';
import 'features/category/data/repos/category_repo_impl.dart';
import 'features/category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import 'features/home/data/enums/recurrence_type_enum.dart';
import 'features/home/data/models/finance_item_model.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver(); // assign it globally

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FinanceItemModelAdapter());
  Hive.registerAdapter(RecurrenceTypeAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  await Hive.openBox<FinanceItemModel>('finance');
  await Hive.openBox<CategoryModel>('category');

  final prefs = await SharedPreferences.getInstance();

  final deviceLang = PlatformDispatcher.instance.locale.languageCode;
  final defaultLangCode =
      (deviceLang == "ar" || deviceLang == "en") ? deviceLang : "en";

  final savedLanguage = prefs.getString("language") ?? defaultLangCode;
  final savedTheme = prefs.getString("theme") ?? "system";

  runApp(MyApp(savedLanguage: savedLanguage, savedTheme: savedTheme));
}

class MyApp extends StatelessWidget {
  final String savedLanguage;
  final String savedTheme;

  const MyApp({
    super.key,
    required this.savedLanguage,
    required this.savedTheme,
  });

  @override
  Widget build(BuildContext context) {
    final initialLocale = Locale(savedLanguage);

    final initialThemeMode = _resolveThemeMode(savedTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ChangeLanguageCubit(initialLocale: initialLocale),
        ),
        BlocProvider(
          create: (_) => ChangeThemeCubit(initialTheme: initialThemeMode),
        ),
        BlocProvider(
          create: (_) => ManageFinanceCubit(homeRepo: HomeRepoImpl()),
        ),
        BlocProvider(
          create: (_) => ManageCategoryCubit(homeRepo: CategoryRepoImpl()),
        ),
        BlocProvider(
          create:
              (_) => ManageUserSetupCubit(userSetupRepo: UserSetupRepoImpl()),
        ),
      ],
      child: BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
        builder: (context, themeState) {
          final themeMode =
              themeState is ChangeThemeDone
                  ? themeState.theme
                  : initialThemeMode;

          return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
            builder: (context, langState) {
              final locale =
                  langState is ChangeLanguageDone
                      ? langState.language
                      : initialLocale;

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: locale,
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                themeMode: themeMode,
                theme: _buildThemeData(Brightness.light),
                darkTheme: _buildThemeData(Brightness.dark),
                onGenerateRoute: onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }

  static ThemeMode _resolveThemeMode(String theme) {
    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
      default:
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  static ThemeData _buildThemeData(Brightness brightness) {
    return ThemeData(brightness: brightness, useMaterial3: true);
  }
}
