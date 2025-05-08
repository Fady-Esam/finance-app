import 'package:finance_flutter_app/core/funcs/get_recurrence_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/funcs/get_next_monthly_date.dart';
import '../../../../../core/widgets/drop_down_button_form_field_category_items.dart';
import '../../../../../generated/l10n.dart';
import '../../../../category/data/models/category_model.dart';
import '../../../../category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import '../../../../category/presentation/manager/cubits/manage_category_cubit/manage_category_state.dart';
import '../../../data/enums/recurrence_type_enum.dart';
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
    this.isFromHomePage = true,
    this.isAmountPositive,
    this.categoryFilteredId,
    this.dateTimeRange,
  });

  final TransactionTypeEnum transactionTypeEnum;
  final TextEditingController amountController;
  final TextEditingController titleController;
  final FinanceItemModel? financeItemModel;
  final DateTime? currentDateTime;
  final DateTime? modelDateTime;
  final bool isFromHomePage;
  final bool? isAmountPositive;
  final int? categoryFilteredId;
  final DateTimeRange? dateTimeRange;
  @override
  State<ManageTransactionBody> createState() => _ManageTransactionBodyState();
}

class _ManageTransactionBodyState extends State<ManageTransactionBody> {
  late DateTime selectedDate;
  late DateTime currentDateTime;
  DateTime endDate = getNextMonthlyDate(DateTime.now());
  CategoryModel? selectedCategory;
  var recurrenceType = RecurrenceType.none;
  int recurrenceCount = 0;
  @override
  void initState() {
    super.initState();
    selectedDate = widget.modelDateTime ?? DateTime.now();
    currentDateTime = widget.currentDateTime ?? DateTime.now();
    BlocProvider.of<ManageCategoryCubit>(context).getAllCategories();
    selectedCategory = BlocProvider.of<ManageCategoryCubit>(
      context,
    ).getCategoryById(widget.financeItemModel?.categoryId);
    setState(() {});
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
                  return DropdownButtonFormFieldCategoryItems(
                    categories: categoryList,
                    noTitle: S.of(context).none,
                    selectedCategory: selectedCategory,
                    onCategoryChanged: (value) {
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
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now().subtract(Duration(days: 15)),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              selectedDate: selectedDate,
            ),
            const SizedBox(height: 12),
            // Add these in your build() method below DatePickerField:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Recurrence", style: TextStyle(fontSize: 16)),
                //const SizedBox(height: 8),
                DropdownButtonFormField<RecurrenceType>(
                  value: recurrenceType,
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
                      RecurrenceType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(getRecurrenceText(context, type)), 
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() => recurrenceType = value!);
                  },
                ),
                const SizedBox(height: 8),
                if (recurrenceType != RecurrenceType.none)
                  DatePickerField(
                    selectedDate: endDate,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: endDate,
                        firstDate: DateTime.now().add(Duration(days: 1)),
                        lastDate: DateTime(DateTime.now().year + 5, 12, 31),
                      );
                      if (picked != null) {
                        setState(() => endDate = picked);
                      }
                    },
                  ),
              ],
            ),

            const SizedBox(height: 22),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomNumberKeyboard(
                amountController: widget.amountController,
              ),
            ),
            const SizedBox(height: 8),
            ManageFinanceButtons(
              transactionTypeEnum: widget.transactionTypeEnum,
              amountController: widget.amountController,
              titleController: widget.titleController,
              financeItemModel: widget.financeItemModel,
              modelDateTime: selectedDate,
              currentDateTime: currentDateTime,
              selectedCategory: selectedCategory,
              isFromHomePage: widget.isFromHomePage,
              categoryFilteredId: widget.categoryFilteredId,
              isAmountPositive: widget.isAmountPositive,
              dateTimeRange: widget.dateTimeRange,
              recurrenceType: recurrenceType,
              endDate: endDate,
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
