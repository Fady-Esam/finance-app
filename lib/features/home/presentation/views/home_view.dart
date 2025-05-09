import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'package:finance_flutter_app/features/user_setup/data/models/user_setup_model.dart';
import 'package:finance_flutter_app/features/user_setup/presentation/manager/cubits/manage_user_setup_cubit/manage_user_setup_cubit.dart';
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
  UserSetupModel? userSetupModel;
  Future<void> getSavedTheme() async {
    themeMode =
        await BlocProvider.of<ChangeThemeCubit>(context).getSavedTheme();
    setState(() {});
  }
    
  Future<void> getUserSetupModelData() async {
    userSetupModel =
        await BlocProvider.of<ManageUserSetupCubit>(
          context,
        ).getUserSetupModel();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserSetupModelData();
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
      appBar: HomeAppBar(themeMode: themeMode, onThemeChanged: _toggleTheme, userName: userSetupModel?.name,),
      drawer: HomeDrawer(themeMode: themeMode, onThemeChanged: _toggleTheme),
      body: HomeBody(),
    );
  }
}
