import 'package:finance_flutter_app/features/home/data/repos/home_repo_impl.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
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

class _HomeViewState extends State<HomeView> {
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
    return BlocProvider(
      create: (context) => ManageFinanceCubit(homeRepo: HomeRepoImpl()),
      child: Scaffold(
        appBar: HomeAppBar(themeMode: themeMode, onThemeChanged: _toggleTheme),
        drawer: HomeDrawer(themeMode: themeMode, onThemeChanged: _toggleTheme),
        body: HomeBody(),
      ),
    );
  }
}
