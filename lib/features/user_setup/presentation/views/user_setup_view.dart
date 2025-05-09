
import 'package:finance_flutter_app/bottom_nav_bar_view.dart';
import 'package:finance_flutter_app/features/user_setup/presentation/manager/cubits/manage_user_setup_cubit/manage_user_setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../home/presentation/views/widgets/amount_input_formatter.dart';
import '../../data/models/user_setup_model.dart';

class UserSetupView extends StatefulWidget {
  const UserSetupView({super.key});
  static const String routeName = 'user-setup-view';

  @override
  State<UserSetupView> createState() => _UserSetupViewState();
}

class _UserSetupViewState extends State<UserSetupView> {
  late TextEditingController nameController;
  late TextEditingController balanceController;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    balanceController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).welcome_title,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomUserSetUpTextField(
                controller: nameController,
                hintText: S.of(context).enter_name,
                label: S.of(context).name,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return S.of(context).please_enter_name;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 22),
              CustomUserSetUpTextField(
                controller: balanceController,
                keyBoardType: TextInputType.number,
                label: S.of(context).initial_balance,
                hintText: "0.0",
                validator: (val) {
                  if (val != null &&
                      val.trim().isNotEmpty &&
                      double.tryParse(val) == null) {
                    return S.of(context).pleaseEnterValidAmount;
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    double balance =
                        double.tryParse(balanceController.text) ?? 0.0;
                    await BlocProvider.of<ManageUserSetupCubit>(
                      context,
                    ).saveUserSetupModel(
                      UserSetupModel(
                        name: nameController.text,
                        balance: balance,
                      ),
                    );
                    Navigator.pushReplacementNamed(context, BottomNavBarView.routeName);
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF4A148C,
                  ), // Deep purple (rich & neutral)
                  foregroundColor: Colors.white, // Text/icon color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: MediaQuery.sizeOf(context).width * 0.2,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: Text(S.of(context).save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomUserSetUpTextField extends StatelessWidget {
  const CustomUserSetUpTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.label,
    this.keyBoardType = TextInputType.text,
    this.validator,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final TextInputType keyBoardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters:
          keyBoardType == TextInputType.number
              ? [AmountInputFormatter()]
              : null,
      validator: validator,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        label:
            label == null
                ? null
                : Text(label!, style: TextStyle(color: Colors.white)),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsetsDirectional.all(14),
      ),
    );
  }
}
