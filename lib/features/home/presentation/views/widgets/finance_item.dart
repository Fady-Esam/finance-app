import 'package:finance_flutter_app/core/utils/icon_utils.dart';
import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:finance_flutter_app/features/home/data/enums/recurrence_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../../../../../core/funcs/get_recurrence_text.dart';
import '../../../../../core/utils/color_utils.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/finance_item_model.dart';

class FinanceItem extends StatelessWidget {
  const FinanceItem({
    super.key,
    required this.financeItemModel,
    this.categoryItem,
  });
  final FinanceItemModel financeItemModel;
  final CategoryModel? categoryItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      dense: true, // reduces default height
      visualDensity: const VisualDensity(
        vertical: 1,
      ), // tighten vertical spacing
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: getColorfromHex(categoryItem?.colorHex),
        child: Icon(
          getIconFromName(categoryItem?.icon),
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(
        financeItemModel.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        "${DateFormat('yyyy/MM/dd hh:mm a').format(financeItemModel.dateTime)}${financeItemModel.recurrence != RecurrenceType.none && financeItemModel.recurrenceCount != 0 ? '${S.of(context).recurrence(getRecurrenceText(context, financeItemModel.recurrence))}${S.of(context).occurrence(financeItemModel.recurrenceCount)}' : ''}",
      ),
      trailing: Directionality(
        textDirection: TextDirection.ltr, // Force LTR for the number
        child: Text(
          financeItemModel.amount < 0
              ? '-${financeItemModel.amount.abs()}'
              : '+${financeItemModel.amount}',
          style: const TextStyle(
            fontSize: 16,
          ), // Optional: adjust style if needed
        ),
      ),
    );
  }
}
