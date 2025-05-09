import 'package:finance_flutter_app/features/notification/presentation/views/notification_view.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/change_language_cubit/change_language_cubit.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
    this.userName,
  });

  final ThemeMode themeMode;
  final VoidCallback onThemeChanged;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        userName != null ? S.of(context).welcome_name(userName!) : S.of(context).welcome_title,
        style: const TextStyle(fontSize: 20),
      ),
      actions: [
                IconButton(
          icon: Icon(
            Icons.notifications,
          ),
          onPressed: (){
            Navigator.pushNamed(context, NotificationView.routeName);
          },
        ),
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
          onPressed: onThemeChanged,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
