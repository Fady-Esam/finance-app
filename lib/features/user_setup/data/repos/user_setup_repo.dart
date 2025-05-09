
import 'package:finance_flutter_app/features/user_setup/data/models/user_setup_model.dart';

abstract class UserSetupRepo {
  Future<UserSetupModel> getUserSetupModel();
  Future<void> saveUserSetupModel(UserSetupModel userSetupModel);
}

