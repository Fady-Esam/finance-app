import 'package:flutter/material.dart';
import '../../../data/enums/transaction_type_enum.dart';
import '../../../data/models/finance_item_model.dart';
import 'amount_field.dart';
import 'date_picker_field.dart';
import 'title_field.dart';
import 'custom_number_keyboard.dart';
import 'manage_transaction_row.dart';

class ManageTransactionBody extends StatefulWidget {
  const ManageTransactionBody({
    super.key,
    required this.transactionTypeEnum,
    required this.amountController,
    required this.titleController,
    required this.modelDateTime,
    required this.currentDateTime,
    
    this.financeItemModel,
  });

  final TransactionTypeEnum transactionTypeEnum;
  final TextEditingController amountController;
  final TextEditingController titleController;
  final FinanceItemModel? financeItemModel;
  final DateTime? currentDateTime;
  final DateTime? modelDateTime;

  @override
  State<ManageTransactionBody> createState() => _ManageTransactionBodyState();
}

class _ManageTransactionBodyState extends State<ManageTransactionBody> {
  late DateTime selectedDate;
  late DateTime currentDateTime;
  @override
  void initState() {
    super.initState();
    selectedDate = widget.modelDateTime ?? DateTime.now();
    currentDateTime = widget.currentDateTime ?? DateTime.now();
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
            const SizedBox(height: 16),
            ManageTransactionRow(
              transactionTypeEnum: widget.transactionTypeEnum,
              amountController: widget.amountController,
              titleController: widget.titleController,
              financeItemModel: widget.financeItemModel,
              modelDateTime: selectedDate,
              currentDateTime: currentDateTime,
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
