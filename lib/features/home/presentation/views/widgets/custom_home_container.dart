import 'package:flutter/material.dart';

class CustomHomeContainer extends StatelessWidget {
  const CustomHomeContainer({
    super.key,
    required this.title,
    required this.balance,
    required this.color,
  });
  final String title;
  final String balance;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 110,
      width: screenWidth * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // To match outer container
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                color: Color(0xFF262626),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        title,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: AnimatedSwitcher(
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            balance,
                            key: ValueKey(balance),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 2, child: Container(color: color)),
          ],
        ),
      ),
    );
  }
}
