import 'package:finance_flutter_app/cubits/change_language_cubit/change_language_cubit.dart';
import 'package:finance_flutter_app/cubits/change_theme_cubit/change_theme_cubit.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/l10n.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = 'home';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ThemeMode themeMode = ThemeMode.system;
  Future<void> getSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString("theme") ?? "system";
    themeMode =
        savedTheme == "dark"
            ? ThemeMode.dark
            : savedTheme == "light"
            ? ThemeMode.light
            : ThemeMode.system;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSavedTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).welcome_title,
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () async {
              String loadedLang =
                  await BlocProvider.of<ChangeLanguageCubit>(
                    context,
                  ).getSavedLanguage();
              final String langCode = loadedLang == "ar" ? "en" : "ar";
              await BlocProvider.of<ChangeLanguageCubit>(
                context,
              ).changeLanguage(langCode);
            },
          ),
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () async {
              ThemeMode mode =
                  await BlocProvider.of<ChangeThemeCubit>(
                    context,
                  ).getSavedTheme();
              themeMode =
                  mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
              await BlocProvider.of<ChangeThemeCubit>(
                context,
              ).changeTheme(themeMode);
              setState(() {});
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              // decoration: BoxDecoration(
              //color: Colors.blue,
              // ),
              child: Container(),
            ),
            ListTile(
              title: Text(S.of(context).dark_mode),
              trailing: Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) async {
                  ThemeMode mode =
                      await BlocProvider.of<ChangeThemeCubit>(
                        context,
                      ).getSavedTheme();
                  themeMode =
                      mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                  await BlocProvider.of<ChangeThemeCubit>(
                    context,
                  ).changeTheme(themeMode);
                  setState(() {});
                },
              ),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: Text(S.of(context).all_activities),
              trailing: Icon(Icons.local_activity),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomContainer(
                title: S.of(context).my_balance,
                balance: "698",
                color: Colors.pink,
              ),
              const SizedBox(height: 10),
              CustomContainer(
                title: S.of(context).today_total_balance,
                balance: "000",
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TransactionButton(
                    title: S.of(context).plus,
                    icon: const Icon(Icons.add),
                    color: Colors.green,
                  ),
                  TransactionButton(
                    title: S.of(context).minus,
                    icon: const Icon(Icons.remove),
                    color: Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).activity, style: TextStyle(fontSize: 22)),
                    GestureDetector(
                      onTap: () {
                        // Handle tap
                      },
                      child: Text(
                        S.of(context).see_all,
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return FinanceItem(
                    financeItemModel: FinanceItemModel(
                      title: "Salary",
                      amount: 1000,
                      dateTime: DateTime.now(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.title,
    required this.balance,
    required this.color,
  });
  final String title;
  final String balance;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 135,
      width: screenWidth * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // To match outer container
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        title,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Text(
                        balance,
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 2, child: Container(color: color)),
          ],
        ),
      ),
    );
  }
}

class TransactionButton extends StatelessWidget {
  const TransactionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });
  final String title;
  final Widget icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsetsDirectional.only(start: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class FinanceItem extends StatelessWidget {
  const FinanceItem({super.key, required this.financeItemModel});
  final FinanceItemModel financeItemModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(radius: 30, backgroundColor: Colors.greenAccent),
      title: Text(financeItemModel.title),
      subtitle: Text(financeItemModel.dateTime.toString()),
      trailing: Text(
        financeItemModel.amount.toString(),
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
