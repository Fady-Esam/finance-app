import 'package:finance_flutter_app/core/utils/icon_utils.dart';
import 'package:finance_flutter_app/features/category/data/repos/category_repo_impl.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../category/data/models/category_model.dart';
import '../../../category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';

class AddCategoryView extends StatefulWidget {
  static const routeName = 'addCategory';

  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final formKey = GlobalKey<FormState>();
  final autovalidateMode = AutovalidateMode.disabled;
  late TextEditingController _nameController;
  String? selectedIcon;
  String? selectedColorHex;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageCategoryCubit(homeRepo: CategoryRepoImpl()),
      child: Scaffold(
        appBar: AppBar(title: Text("Add Category")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Category"),
                  validator:
                      (val) => val == null || val.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                Text(""),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,

                    itemCount: iconList.length,
                    itemBuilder: (context, index) {
                      String iconData = iconList[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIcon = iconData;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                selectedIcon == iconData
                                    ? Colors.grey[300]
                                    : Colors.transparent,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(iconsMap[iconData], size: 30),
                        ),
                      );
                    },
                  ),
                ),
                // Wrap(
                //   spacing: 12,
                //   runSpacing: 12,
                //   children:
                //       iconList.map((iconData) {
                //         return GestureDetector(
                //           onTap: () {
                //             setState(() {
                //               selectedIcon = iconData;
                //             });
                //           },
                //           child: Container(
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color:
                //                   selectedIcon == iconData
                //                       ? Colors.grey[300]
                //                       : Colors.transparent,
                //             ),
                //             padding: const EdgeInsets.all(8),
                //             child: Icon(iconsMap[iconData], size: 30),
                //           ),
                //         );
                //       }).toList(),
                // ),
                const SizedBox(height: 16),
                Text(""),
                Wrap(
                  spacing: 12,
                  children:
                      colorList.map((color) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColorHex = color.toARGB32().toRadixString(
                                16,
                              );
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border:
                                  selectedColorHex ==
                                          color.toARGB32().toRadixString(16)
                                      ? Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      )
                                      : null,
                            ),
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 24),
                BlocListener<ManageCategoryCubit, ManageCategoryState>(
                  listener: (context, state) {
                    if (state is AddCategorySuccessState) {
                      Navigator.pop(context);
                    } else if (state is AddCategoryFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).somethingWentWrong),
                        ),
                      );
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final category = CategoryModel(
                          name: _nameController.text,
                          icon: selectedIcon ?? 'category',
                          colorHex: selectedColorHex ?? '757575',
                        );
                        await BlocProvider.of<ManageCategoryCubit>(
                          context,
                        ).addCategory(category);
                      }
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
