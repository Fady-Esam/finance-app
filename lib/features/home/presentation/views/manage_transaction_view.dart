import 'package:finance_flutter_app/features/home/data/enums/transaction_type_enum.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:flutter/material.dart';

class ManageTransactionView extends StatefulWidget {
  const ManageTransactionView({super.key, required this.transactionTypeEnum, this.financeItemModel});
  final TransactionTypeEnum transactionTypeEnum;
  final FinanceItemModel? financeItemModel;
  static const routeName = 'manageTransaction';
  @override
  State<ManageTransactionView> createState() => _ManageTransactionViewState();
}

class _ManageTransactionViewState extends State<ManageTransactionView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar());
  }
}
