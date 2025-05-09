import 'package:finance_flutter_app/features/user_setup/data/models/user_setup_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_setup_repo.dart';

class UserSetupRepoImpl implements UserSetupRepo {
  @override
  Future<UserSetupModel> getUserSetupModel() async{
    final pref = await SharedPreferences.getInstance();
    final name = pref.getString('userName')!;
    final balance = pref.getDouble('initialBalance');
    final datTime = pref.getString('startDateTime')!;
    return UserSetupModel(name: name, balance: balance, startDateTime: DateTime.parse(datTime));
  }

  @override
  Future<void> saveUserSetupModel(UserSetupModel userSetupModel) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("userName", userSetupModel.name);
    await pref.setDouble("initialBalance", userSetupModel.balance ?? 0.0);
    await pref.setString("startDateTime", userSetupModel.startDateTime.toString());
    await pref.setBool("user_setup_seen", true);
  }

}

