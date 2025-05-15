import 'package:finance_flutter_app/features/user_setup/data/models/user_setup_model.dart';
import 'package:finance_flutter_app/features/user_setup/presentation/manager/cubits/manage_user_setup_cubit/manage_user_setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_body.dart';

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
  UserSetupModel? userSetupModel;

  Future<void> getUserSetupModelData() async {
    userSetupModel =
        await BlocProvider.of<ManageUserSetupCubit>(
          context,
        ).getUserSetupModel();
    setState(() {});
  }

  void getFinancesByDay() {
    BlocProvider.of<ManageFinanceCubit>(
      context,
    ).getFinancesByDate(DateTime.now());
  }

  Future<void> refresh() async {
    getFinancesByDay();
    getUserSetupModelData();
  }

  @override
  void initState() {
    super.initState();
    getUserSetupModelData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFinancesByDay();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: HomeAppBar(userName: userSetupModel?.name),
      // drawer: HomeDrawer(themeMode: themeMode, onThemeChanged: _toggleTheme),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: HomeBody(userSetupModel: userSetupModel),
      ),
    );
  }
}
