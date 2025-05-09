import 'package:finance_flutter_app/features/user_setup/data/models/user_setup_model.dart';
import 'package:finance_flutter_app/features/user_setup/data/repos/user_setup_repo.dart';
import 'package:finance_flutter_app/features/user_setup/presentation/manager/cubits/manage_user_setup_cubit/manage_user_setup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageUserSetupCubit extends Cubit<ManageUserSetupState> {
  ManageUserSetupCubit({required this.userSetupRepo})
    : super(ManageUserSetupInitialState());
  final UserSetupRepo userSetupRepo;
  Future<UserSetupModel> getUserSetupModel() async {
    return await userSetupRepo.getUserSetupModel();
  }

  Future<void> saveUserSetupModel(UserSetupModel userSetupModel) async {
    await userSetupRepo.saveUserSetupModel(userSetupModel);
  }
}
