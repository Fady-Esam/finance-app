// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Finance`
  String get splash_screen_title {
    return Intl.message(
      'Finance',
      name: 'splash_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Get Started`
  String get start {
    return Intl.message('Get Started', name: 'start', desc: '', args: []);
  }

  /// `Track Your Spending`
  String get onBoarding_title_1 {
    return Intl.message(
      'Track Your Spending',
      name: 'onBoarding_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Set Budgets Easily`
  String get onBoarding_title_2 {
    return Intl.message(
      'Set Budgets Easily',
      name: 'onBoarding_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Achieve Your Goals`
  String get onBoarding_title_3 {
    return Intl.message(
      'Achieve Your Goals',
      name: 'onBoarding_title_3',
      desc: '',
      args: [],
    );
  }

  /// `Get a clear view of where your money goes every month`
  String get onBoarding_subTitle_1 {
    return Intl.message(
      'Get a clear view of where your money goes every month',
      name: 'onBoarding_subTitle_1',
      desc: '',
      args: [],
    );
  }

  /// `Control your finances by creating monthly budgets`
  String get onBoarding_subTitle_2 {
    return Intl.message(
      'Control your finances by creating monthly budgets',
      name: 'onBoarding_subTitle_2',
      desc: '',
      args: [],
    );
  }

  /// `Save money and reach your financial goals faster`
  String get onBoarding_subTitle_3 {
    return Intl.message(
      'Save money and reach your financial goals faster',
      name: 'onBoarding_subTitle_3',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome_title {
    return Intl.message('Welcome', name: 'welcome_title', desc: '', args: []);
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message('Dark Mode', name: 'dark_mode', desc: '', args: []);
  }

  /// `All Activities`
  String get all_activities {
    return Intl.message(
      'All Activities',
      name: 'all_activities',
      desc: '',
      args: [],
    );
  }

  /// `Plus`
  String get plus {
    return Intl.message('Plus', name: 'plus', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Minus`
  String get minus {
    return Intl.message('Minus', name: 'minus', desc: '', args: []);
  }

  /// `Details here....`
  String get details {
    return Intl.message(
      'Details here....',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `My Balance`
  String get my_balance {
    return Intl.message('My Balance', name: 'my_balance', desc: '', args: []);
  }

  /// `Today Total Balance`
  String get today_total_balance {
    return Intl.message(
      'Today Total Balance',
      name: 'today_total_balance',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message('Activity', name: 'activity', desc: '', args: []);
  }

  /// `See All`
  String get see_all {
    return Intl.message('See All', name: 'see_all', desc: '', args: []);
  }

  /// `Something went wrong, Please try again`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong, Please try again',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid amount greater than 0`
  String get pleaseEnterValidAmount {
    return Intl.message(
      'Please enter a valid amount greater than 0',
      name: 'pleaseEnterValidAmount',
      desc: '',
      args: [],
    );
  }

  /// `Close Drawer`
  String get closeDrawer {
    return Intl.message(
      'Close Drawer',
      name: 'closeDrawer',
      desc: '',
      args: [],
    );
  }

  /// `Exit App`
  String get closeApp {
    return Intl.message('Exit App', name: 'closeApp', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
