import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/enums/transaction_type_enum.dart';
import '../../../data/models/finance_item_model.dart';
import '../../manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'custom_manage_transaction_button.dart';

class ManageTransactionRow extends StatelessWidget {
  const ManageTransactionRow({
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomManageTransactionButton(
            text: S.of(context).done,
            color: const Color.fromARGB(255, 159, 210, 252),
            onPressed: () async {
              String text = amountController.text.trim();
              // Validation Step
              if (text.isEmpty || double.tryParse(text) == 0.0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      S.of(context).pleaseEnterValidAmount,
                    ),
                    //backgroundColor: Colors.red,
                  ),
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
                await BlocProvider.of<ManageFinanceCubit>(
                  context,
                ).updateFinance(financeItemModel!);
                return;
              }
              await BlocProvider.of<ManageFinanceCubit>(context).addFinance(
                FinanceItemModel(
                  title: titleController.text,
                  dateTime: DateTime.now(),
                  amount: amount,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomManageTransactionButton(
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
