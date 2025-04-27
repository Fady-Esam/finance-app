import 'package:flutter/material.dart';

class TransactionButton extends StatelessWidget {
  const TransactionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });
  final String title;
  final Widget icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsetsDirectional.only(start: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }
}
