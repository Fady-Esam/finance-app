import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/enums/transaction_type_enum.dart';
import '../../../data/models/finance_item_model.dart';
import '../../manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'custom_manage_finance_button.dart';

class ManageFinanceButtons extends StatelessWidget {
  const ManageFinanceButtons({
    super.key,
    required this.transactionTypeEnum,
    required this.amountController,
    required this.titleController,
    this.financeItemModel,
    required this.modelDateTime,
    required this.currentDateTime,
    this.selectedCategory,
    this.isFromHomePage = true,
    this.categoryFilteredId,
    this.isAmountPositive,
    this.dateTimeRange,
  });

  final TransactionTypeEnum transactionTypeEnum;
  final TextEditingController amountController;
  final TextEditingController titleController;
  final FinanceItemModel? financeItemModel;
  final DateTime modelDateTime;
  final DateTime currentDateTime;
  final CategoryModel? selectedCategory;
  final bool isFromHomePage;
  final int? categoryFilteredId;
  final bool? isAmountPositive;
  final DateTimeRange? dateTimeRange;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomManageFinanceButton(
            text: S.of(context).done,
            color: const Color.fromARGB(255, 159, 210, 252),
            onPressed: () async {
              String text = amountController.text.trim();
              // Validation Step
              if (text.isEmpty ||
                  double.tryParse(text) == 0.0 ||
                  !RegExp(r'[0-9.<]').hasMatch(text)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context).pleaseEnterValidAmount)),
                );
                return;
              }
              double amount = double.tryParse(amountController.text) ?? 0.0;
              if (transactionTypeEnum == TransactionTypeEnum.minus ||
                  transactionTypeEnum == TransactionTypeEnum.editMinus) {
                amount = -amount;
              }
              if (financeItemModel != null) {
                financeItemModel!.amount = amount;
                financeItemModel!.title = titleController.text;
                financeItemModel!.dateTime = modelDateTime;
                financeItemModel!.categoryId = selectedCategory?.key;
                await financeItemModel!.save();
                if (isFromHomePage) {
                  BlocProvider.of<ManageFinanceCubit>(
                    context,
                  ).getFinancesByDate(DateTime.now());
                } else {
                  BlocProvider.of<ManageFinanceCubit>(
                    context,
                  ).getFilteredFinances(
                    dateTimeRange!,
                    categoryId: categoryFilteredId,
                    isAmountPositive: isAmountPositive,
                  );
                }
                Navigator.pop(context);
              } else {
                await BlocProvider.of<ManageFinanceCubit>(context).addFinance(
                  FinanceItemModel(
                    title: titleController.text,
                    dateTime: modelDateTime,
                    amount: amount,
                    categoryId: selectedCategory?.key,
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomManageFinanceButton(
            text: S.of(context).cancel,
            color: const Color.fromARGB(255, 244, 119, 161),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
