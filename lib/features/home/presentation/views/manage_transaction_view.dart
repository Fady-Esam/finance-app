import 'package:finance_flutter_app/features/home/data/enums/transaction_type_enum.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ManageTransactionView extends StatefulWidget {
  const ManageTransactionView({
    super.key,
    required this.transactionTypeEnum,
    this.financeItemModel,
  });
  final TransactionTypeEnum transactionTypeEnum;
  final FinanceItemModel? financeItemModel;
  static const routeName = 'manageTransaction';
  @override
  State<ManageTransactionView> createState() => _ManageTransactionViewState();
}

class _ManageTransactionViewState extends State<ManageTransactionView> {
  late TextEditingController amountController;

  String get appBarTitle {
    switch (widget.transactionTypeEnum) {
      case TransactionTypeEnum.plus:
        return 'Plus';
      case TransactionTypeEnum.minus:
        return 'Minus';
      default:
        return 'Edit';
    }
  }

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                hintText: S.of(context).details,
                color: const Color.fromARGB(255, 175, 105, 188),
                hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                color: Colors.greenAccent,
                hintText: "0.0",
                prefixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: MediaQuery.sizeOf(context).width * 0.4,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 67, 117, 68),
                  ),
                ),
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 67, 117, 68),
                ),
                controller: amountController,
                textLabelStyle: TextStyle(
                  color: Color.fromARGB(255, 67, 117, 68),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 4 items per row
                  crossAxisSpacing: 10, // Horizontal space between items
                  mainAxisSpacing: 10, // Vertical space between items
                  childAspectRatio: 1.3,
                ),
                itemCount: 12, // Total number of buttons (0-9, ., <)
                itemBuilder: (context, index) {
                  String digit = getButtonNumber(index);
                  return GestureDetector(
                    onTap: () {
                      String numData = "";
                      if (digit != '<') {
                        for (int i = 0; i < amountController.text.length; i++) {
                          if (amountController.text[i] != '.') {
                            numData += amountController.text[i];
                          }
                        }
                        setState(() {
                          if (numData.isNotEmpty &&
                              numData.length % 3 == 0 &&
                              amountController
                                      .text[amountController.text.length - 1] !=
                                  '.') {
                            amountController.text += '.';
                          }
                          if (digit != '.') {
                            amountController.text += digit;
                          }
                          amountController
                              .selection = TextSelection.fromPosition(
                            TextPosition(offset: amountController.text.length),
                          ); // Keep the cursor at the end
                        });
                      } else {
                        setState(() {
                          if (amountController.text.isNotEmpty) {
                            amountController.text = amountController.text
                                .substring(0, amountController.text.length - 1);
                            amountController
                                .selection = TextSelection.fromPosition(
                              TextPosition(
                                offset: amountController.text.length,
                              ),
                            ); // Keep the cursor at the end
                          }
                        });
                      }
                    },
                    child: CustomKeyBoardItem(textNum: digit),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    text: S.of(context).done,
                    color: const Color.fromARGB(255, 244, 119, 161),
                  ),
                  CustomButton(
                    text: S.of(context).cancel,
                    color: const Color.fromARGB(255, 109, 189, 254),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

String getButtonNumber(int num) {
  if (num >= 0 && num <= 2) {
    return (num + 7).toString();
  }
  if (num >= 3 && num <= 5) {
    return (num + 1).toString();
  }
  if (num >= 6 && num <= 8) {
    return (num - 5).toString();
  }
  if (num == 9) {
    return '.';
  }
  if (num == 10) {
    return '0';
  }
  if (num == 11) {
    return '<';
  }
  return '';
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.color,
    this.prefixIcon,
    this.hintStyle,
    this.controller,
    this.textLabelStyle,
  });
  final String hintText;
  final Color color;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextStyle? textLabelStyle;

  // Creating a FocusNode
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: textLabelStyle,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: color,
        hintStyle: hintStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsetsDirectional.only(
          top: 24,
          bottom: 24,
          start: 32,
          end: 16,
        ),
      ),
    );
  }
}

class CustomKeyBoardItem extends StatelessWidget {
  const CustomKeyBoardItem({super.key, required this.textNum});
  final String textNum;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 175, 105, 188),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          textNum,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Your action here
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 18),
        backgroundColor: color, // Subtle background
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 43, 75, 44),
          ),
        ),
      ),
    );
  }
}
