import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cubits/change_language_cubit/change_language_cubit.dart';
import '../../../../core/cubits/change_theme_cubit/change_theme_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../user_setup/data/models/user_setup_model.dart';
import '../../../user_setup/presentation/manager/cubits/manage_user_setup_cubit/manage_user_setup_cubit.dart';
import 'funcs/show_name_dialoge.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  ThemeMode themeMode = ThemeMode.system;
  String langCode =
      PlatformDispatcher.instance.locale.languageCode == "ar" ||
              PlatformDispatcher.instance.locale.languageCode == "en"
          ? PlatformDispatcher.instance.locale.languageCode
          : "en";
  UserSetupModel? userSetupModel;
  var formKey = GlobalKey<FormState>();
  late TextEditingController controller;

  var autovalidateMode = AutovalidateMode.disabled;
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
    controller = TextEditingController(text: userSetupModel?.name);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserSetupModelData();
    getSavedTheme();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void toggleTheme() async {
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
      appBar: AppBar(title: Text(S.of(context).settings)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Name Editor
            ListTile(
              title: Text(S.of(context).name),
              subtitle: Text(userSetupModel?.name ?? ''),
              trailing: Icon(Icons.edit),
              onTap: () async {
                final String oldText = controller.text;
                showNameDialog(
                  context,
                  controller,
                  () async {
                    if (formKey.currentState!.validate()) {
                      await BlocProvider.of<ManageUserSetupCubit>(
                        context,
                      ).saveUserSetupModel(
                        UserSetupModel(
                          name: controller.text,
                          balance: userSetupModel?.balance,
                          startDateTime: userSetupModel?.startDateTime,
                        ),
                      );
                      await getUserSetupModelData();
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  formKey,
                  autovalidateMode,
                  (val) {
                    if (val == null || val.trim().isEmpty) {
                      return S.of(context).please_enter_name;
                    }
                    return null;
                  },
                  () {
                    controller.text = oldText;
                    Navigator.pop(context);
                  },
                );
              },
            ),
            // Language Switcher
            SwitchListTile(
              title: Text(S.of(context).language),
              subtitle: Text(S.of(context).english),
              value: langCode == "en",
              onChanged: (value) async {
                String loadedLang =
                    await BlocProvider.of<ChangeLanguageCubit>(
                      context,
                    ).getSavedLanguage();
                langCode = loadedLang == "ar" ? "en" : "ar";
                await BlocProvider.of<ChangeLanguageCubit>(
                  context,
                ).changeLanguage(langCode);
              },
              activeColor:
                  Colors.green, // The color of the switch thumb when ON
              activeTrackColor: Colors.green[200], // The track color when ON
              inactiveThumbColor: Colors.grey, // Thumb color when OFF
              inactiveTrackColor: Colors.grey[300], // Track color when OFF
            ),
            // Theme Switcher
            SwitchListTile(
              title: Text(S.of(context).theme),
              subtitle: Text(S.of(context).dark_mode),
              value: themeMode == ThemeMode.dark,
              onChanged: (value) => toggleTheme(),
              activeColor:
                  Colors.green, // The color of the switch thumb when ON
              activeTrackColor: Colors.green[200], // The track color when ON
              inactiveThumbColor: Colors.grey, // Thumb color when OFF
              inactiveTrackColor: Colors.grey[300], // Track color when OFF
            ),
            const SizedBox(height: 20),

            // About Section
            const Divider(),
            ListTile(
              title: Text(S.of(context).about),
              subtitle: Text(S.of(context).about_text),
            ),
            ListTile(
              title: Text(S.of(context).app_version),
              subtitle: Text("1.0.0"),
            ),
          ],
        ),
      ),
    );
  }

  // Future<String> _getAppVersion() async {
  //   final info = await PackageInfo.fromPlatform();
  //   return info.version;
  // }
}
