import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body:ListView(
            children: [
              _sectionTitle('Profile'),
              ListTile(
                title: Text('Name'),
                subtitle: Text("UserNaem"),
                trailing: Icon(Icons.edit),
                onTap: () => _showNameDialog(context, ""),
              ),
              ListTile(
                title: Text('Currency'),
                subtitle: Text("Currency"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => _showCurrencyPicker(context),
              ),
              _sectionTitle('Notifications'),
              SwitchListTile(
                title: Text('Daily Summary'),
                value: true,
                onChanged:
                    (val) =>()
                        /*context.read<SettingsCubit>().toggleDailySummary(val),*/
              ),
              SwitchListTile(
                title: Text('Low Balance Alert'),
                value: true,
                onChanged:
                    (val) =>()/*context.read<SettingsCubit>().update(
                      settings.copyWith(lowBalanceAlert: val),
                    )*/,
              ),
              _sectionTitle('Appearance'),
              ListTile(
                title: Text('Theme'),
                subtitle: Text("Theme"),
                trailing: Icon(Icons.color_lens),
                onTap: () => _showThemeDialog(context),
              ),
              _sectionTitle('About'),
              ListTile(title: Text('App Version'), subtitle: Text('1.0.0')),
            ],
      
          )

    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );

  void _showNameDialog(BuildContext context, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Edit Name'),
            content: TextField(controller: controller),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final newName = controller.text.trim();
                  if (newName.isNotEmpty) {
                    // context.read<SettingsCubit>().update(
                    //   context.read<SettingsCubit>().state.copyWith(
                    //     userName: newName,
                    //   ),
                    // );
                  }
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    // Could be a dropdown or search dialog
  }

  void _showThemeDialog(BuildContext context) {
    // Dialog with Light / Dark / System options
  }
}
