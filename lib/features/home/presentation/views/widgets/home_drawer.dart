import 'package:finance_flutter_app/core/helper/app_images.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../all_activities_view.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  final ThemeMode themeMode;
  final VoidCallback onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(AppImages.financeDrawerImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(S.of(context).dark_mode),
            trailing: Switch(
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                onThemeChanged();
              },
            ),
            onTap: () => onThemeChanged(),
          ),
          ListTile(
            title: Text(S.of(context).all_activities),
            trailing: const Icon(Icons.local_activity),
            onTap: () {
              Navigator.pushNamed(context, AllActivitiesView.routeName);
            },
          ),
          ListTile(
            title: Text(S.of(context).closeDrawer), // Fetch localized string
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
            },
            trailing: const Icon(Icons.close), // Add a close icon
          ),
          // Close App ListTile
          ListTile(
            title: Text(S.of(context).closeApp), // Fetch localized string
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer first
              SystemNavigator.pop(); // Then close the app
            },
            trailing: const Icon(Icons.exit_to_app), // Add an exit icon
          ),
        ],
      ),
    );
  }
}
