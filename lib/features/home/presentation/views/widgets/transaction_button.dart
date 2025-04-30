import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';

class TransactionButton extends StatelessWidget {
  const TransactionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.width,
  });
  final String title;
  final Widget icon;
  final Color color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      padding: EdgeInsetsDirectional.only(start: 10, end: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: title == S.of(context).add ? 12 : 14,
                  color: Colors.white,
                ),
                // maxLines: 2,
                // overflow: TextOverflow.ellipsis,
              ),
              if (title == S.of(context).add && width == null)
                Text(
                  S.of(context).category,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
            ],
          ),
          // ConstrainedBox(
          //   constraints: BoxConstraints(maxWidth: 60),
          //   child: Text(
          //     title,
          //     style: TextStyle(fontSize: 12, color: Colors.white),
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,
          //   ),
          // ),
        ],
      ),
    );
  }
}
