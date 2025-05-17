import 'package:flutter/material.dart';

import '../../../data/enums/transaction_type_enum.dart';
import 'custom_text_field.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.transactionTypeEnum,
    required this.amountController,
  });

  final TransactionTypeEnum transactionTypeEnum;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      color: const Color.fromARGB(255, 161, 254, 209),
      hintText: "0.0",
      prefixIcon:
          Directionality.of(context) == TextDirection.ltr
              ? buildIconWidget(
                context,
                EdgeInsetsDirectional.only(
                  start: MediaQuery.sizeOf(context).width * 0.4,
                ),
              )
              : null,
      suffixIcon:
          Directionality.of(context) == TextDirection.rtl
              ? buildIconWidget(
                context,
                EdgeInsetsDirectional.only(
                  end: MediaQuery.sizeOf(context).width * 0.4,
                ),
              )
              : null,
      hintStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 67, 117, 68),
      ),
      controller: amountController,
      textLabelStyle: TextStyle(color: Colors.black, fontSize: 18),
    );
  }

  Widget buildIconWidget(BuildContext context, EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: Icon(
        transactionTypeEnum == TransactionTypeEnum.plus ||
                transactionTypeEnum == TransactionTypeEnum.editPlus
            ? Icons.add
            : Icons.remove,
        color: Color.fromARGB(255, 60, 104, 61),
      ),
    );
  }
}
