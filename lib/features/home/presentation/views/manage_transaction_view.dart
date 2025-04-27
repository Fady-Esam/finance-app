import 'dart:developer';
import 'package:finance_flutter_app/features/home/data/enums/transaction_type_enum.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'widgets/manage_transaction_body.dart';

class ManageTransactionView extends StatefulWidget {
  const ManageTransactionView({
    super.key,
    required this.transactionTypeEnum,
    this.financeItemModel,
  });
  final TransactionTypeEnum transactionTypeEnum;
  final FinanceItemModel? financeItemModel;
  static const routeName = 'manage-transaction-view';
  @override
  State<ManageTransactionView> createState() => _ManageTransactionViewState();
}

class _ManageTransactionViewState extends State<ManageTransactionView> {
  late TextEditingController amountController;
  late TextEditingController titleController;

  String get appBarTitle {
    switch (widget.transactionTypeEnum) {
      case TransactionTypeEnum.plus:
        return S.of(context).plus;
      case TransactionTypeEnum.minus:
        return S.of(context).minus;
      default:
        return S.of(context).edit;
    }
  }

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(
      text: widget.financeItemModel?.amount.abs().toString() ?? '',
    );
    titleController = TextEditingController(
      text: widget.financeItemModel?.title.toString() ?? '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageFinanceCubit, ManageFinanceState>(
      listener: (context, state) async {
        if (state is AddFinanceSuccessState) {
          Navigator.pop(context);
        } else if (state is AddFinanceFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).somethingWentWrong)),
          );
          log(state.failureMessage.toString());
        } else if (state is UpdateFinanceFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).somethingWentWrong)),
          );
          log(state.failureMessage.toString());
        } else if (state is UpdateFinanceSuccessState) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(appBarTitle)),
        body: ManageTransactionBody(
          transactionTypeEnum: widget.transactionTypeEnum,
          amountController: amountController,
          titleController: titleController,
          financeItemModel: widget.financeItemModel,
        ),
      ),
    );
  }
}
