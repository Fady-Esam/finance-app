import 'package:flutter/material.dart';
import '../../../data/enums/transaction_type_enum.dart';
import '../../../data/models/finance_item_model.dart';
import 'amount_field.dart';
import 'title_field.dart';
import 'custom_number_keyboard.dart';
import 'manage_transaction_row.dart';

class ManageTransactionBody extends StatelessWidget {
  const ManageTransactionBody({
    super.key,
    required this.transactionTypeEnum,
    required this.amountController,
    required this.titleController,
    this.financeItemModel,
  });

  final TransactionTypeEnum transactionTypeEnum;
  final TextEditingController amountController;
  final TextEditingController titleController;
  final FinanceItemModel? financeItemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TitleField(titleController: titleController),
            const SizedBox(height: 20),
            AmountField(
              transactionTypeEnum: transactionTypeEnum,
              amountController: amountController,
            ),
            const SizedBox(height: 30),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomNumberKeyboard(amountController: amountController),
            ),
            const SizedBox(height: 15),
            ManageTransactionRow(
              transactionTypeEnum: transactionTypeEnum,
              amountController: amountController,
              titleController: titleController,
              financeItemModel: financeItemModel,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
