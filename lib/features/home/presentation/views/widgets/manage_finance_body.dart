import 'package:finance_flutter_app/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/icon_utils.dart';
import '../../../../../generated/l10n.dart';
import '../../../../category/data/models/category_model.dart';
import '../../../../category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import '../../../../category/presentation/manager/cubits/manage_category_cubit/manage_category_state.dart';
import '../../../data/enums/transaction_type_enum.dart';
import '../../../data/models/finance_item_model.dart';
import 'amount_field.dart';
import 'date_picker_field.dart';
import 'title_field.dart';
import 'custom_number_keyboard.dart';
import 'manage_finance_buttons.dart';

class ManageTransactionBody extends StatefulWidget {
  const ManageTransactionBody({
    super.key,
    required this.transactionTypeEnum,
    required this.amountController,
    required this.titleController,
    required this.modelDateTime,
    required this.currentDateTime,
    this.financeItemModel,
    this.categoryId,
  });

  final TransactionTypeEnum transactionTypeEnum;
  final TextEditingController amountController;
  final TextEditingController titleController;
  final FinanceItemModel? financeItemModel;
  final DateTime? currentDateTime;
  final DateTime? modelDateTime;
  final int? categoryId;

  @override
  State<ManageTransactionBody> createState() => _ManageTransactionBodyState();
}

class _ManageTransactionBodyState extends State<ManageTransactionBody> {
  late DateTime selectedDate;
  late DateTime currentDateTime;
  CategoryModel? selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedDate = widget.modelDateTime ?? DateTime.now();
    currentDateTime = widget.currentDateTime ?? DateTime.now();
    // setState(() {
    //   categoryList = BlocProvider.of<ManageCategoryCubit>(context)
    //       .getAllCategories();
    // });
    BlocProvider.of<ManageCategoryCubit>(context).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TitleField(titleController: widget.titleController),
            const SizedBox(height: 16),
            AmountField(
              transactionTypeEnum: widget.transactionTypeEnum,
              amountController: widget.amountController,
            ),
            const SizedBox(height: 16),
            BlocBuilder<ManageCategoryCubit, ManageCategoryState>(
              builder: (context, state) {
                if (state is GetAllCategorySuccessState) {
                  final categoryList = state.categoryItems;
                  return DropdownButtonFormField<CategoryModel>(
                    value:
                        widget.categoryId != null
                            ? categoryList.firstWhere(
                              (category) => category.key == widget.categoryId,
                              //orElse: () => null,
                            )
                            : selectedCategory,
                    hint: Text(S.of(context).select_category),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    items:
                        categoryList.map((category) {
                          return DropdownMenuItem<CategoryModel>(
                            value: category,
                            child: Row(
                              children: [
                                Icon(
                                  getIconFromName(category.icon ?? ''),
                                  color: getColorfromHex(
                                    category.colorHex ?? "#000000",
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(category.name),
                              ],
                            ),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(height: 16),
            DatePickerField(
              onTap: () async {
                DateTime now = DateTime.now();
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: now.subtract(Duration(days: 10)),
                  lastDate: now.add(Duration(days: 2)),
                  // lastDate: now,
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              selectedDate: selectedDate,
            ),
            const SizedBox(height: 22),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomNumberKeyboard(
                amountController: widget.amountController,
              ),
            ),
            //const SizedBox(height: 8),
            ManageFinanceButtons(
              transactionTypeEnum: widget.transactionTypeEnum,
              amountController: widget.amountController,
              titleController: widget.titleController,
              financeItemModel: widget.financeItemModel,
              modelDateTime: selectedDate,
              currentDateTime: currentDateTime,
              selectedCategory: selectedCategory,
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
