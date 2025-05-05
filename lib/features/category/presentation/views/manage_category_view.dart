import 'dart:developer';

import 'package:finance_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_utils.dart';
import '../../../../core/utils/icon_utils.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/category_model.dart';
import '../manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import '../manager/cubits/manage_category_cubit/manage_category_state.dart';

class ManageCategoryView extends StatefulWidget {
  const ManageCategoryView({super.key, this.categoryModel});
  static const routeName = 'manage-category-view';
  final CategoryModel? categoryModel;
  @override
  State<ManageCategoryView> createState() => _ManageCategoryViewState();
}

class _ManageCategoryViewState extends State<ManageCategoryView> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late TextEditingController _nameController;
  String? selectedIcon;
  String? selectedColorHex;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.categoryModel?.name ?? '',
    );
    selectedIcon = widget.categoryModel?.icon;
    selectedColorHex = widget.categoryModel?.colorHex;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).add_category)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                hintText: S.of(context).category,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(
                      0xFFB0BEC5,
                    ), // Blue-grey 100: good neutral tone
                    width: 1.2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF6200EE),
                    width: 1.2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.greenAccent, // Deep purple: primary highlight
                    width: 1.8,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.of(context).required_field;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),
              Text(S.of(context).select_icon, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: iconList.length,
                  itemBuilder: (context, index) {
                    String iconData = iconList[index];
                    return GestureDetector(
                      onTap: () {
                        if (selectedIcon == iconData) {
                          setState(() {
                            selectedIcon = null;
                          });
                        } else {
                          setState(() {
                            selectedIcon = iconData;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  selectedIcon == iconData
                                      ? Colors.blue
                                      : Color(0xFF262626),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 22,
                            ),
                            child: Icon(
                              iconsMap[iconData],
                              size: 25,
                              color: Colors.grey[300],
                            ),
                          ),
                          Text(
                            getIconLabel(iconData, context),
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(S.of(context).select_color, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.12,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colorList.length,
                  itemBuilder: (context, index) {
                    Color color = colorList[index];
                    return GestureDetector(
                      onTap: () {
                        if (selectedColorHex ==
                            color.toARGB32().toRadixString(16)) {
                          setState(() {
                            selectedColorHex = null;
                          });
                        } else {
                          setState(() {
                            selectedColorHex = color.toARGB32().toRadixString(
                              16,
                            );
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border:
                              selectedColorHex ==
                                      color.toARGB32().toRadixString(16)
                                  ? Border.all(
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                    width: 2,
                                  )
                                  : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              BlocListener<ManageCategoryCubit, ManageCategoryState>(
                listener: (context, state) {
                  if (state is AddCategorySuccessState) {
                    Navigator.pop(context);
                  } else if (state is AddCategoryFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context).somethingWentWrong)),
                    );
                    log(state.failureMessage.toString());
                  }
                },
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final category = CategoryModel(
                        name: _nameController.text,
                        icon: selectedIcon,
                        colorHex: selectedColorHex,
                      );
                      if (widget.categoryModel != null) {
                        widget.categoryModel!.name = _nameController.text;
                        widget.categoryModel!.icon = selectedIcon;
                        widget.categoryModel!.colorHex = selectedColorHex;
                        widget.categoryModel!.save();
                        BlocProvider.of<ManageCategoryCubit>(
                          context,
                        ).getAllCategories();
                        Navigator.pop(context);
                        return;
                      }
                      await BlocProvider.of<ManageCategoryCubit>(
                        context,
                      ).addCategory(category);
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.onUserInteraction;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF4A148C,
                    ), // Deep purple (rich & neutral)
                    foregroundColor: Colors.white, // Text/icon color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text(S.of(context).save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
