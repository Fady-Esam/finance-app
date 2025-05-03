import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/change_theme_cubit/change_theme_cubit.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_body.dart';
import 'widgets/home_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = 'home-view';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ThemeMode themeMode = ThemeMode.system;
  Future<void> getSavedTheme() async {
    themeMode =
        await BlocProvider.of<ChangeThemeCubit>(context).getSavedTheme();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSavedTheme();
  }

  void _toggleTheme() async {
    await getSavedTheme();
    ThemeMode newMode =
        themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await BlocProvider.of<ChangeThemeCubit>(context).changeTheme(newMode);
    setState(() {
      themeMode = newMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: HomeAppBar(themeMode: themeMode, onThemeChanged: _toggleTheme),
      drawer: HomeDrawer(themeMode: themeMode, onThemeChanged: _toggleTheme),
      body: HomeBody(),
    );
  }
}
