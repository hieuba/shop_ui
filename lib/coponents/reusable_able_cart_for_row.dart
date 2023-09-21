import 'package:flutter/material.dart';
import 'package:shop_ui/coponents/reusable_text.dart';

class ReusableAbleCartForRow extends StatelessWidget {
  const ReusableAbleCartForRow({
    super.key,
    required this.text,
    required this.price,
  });

  final String text;
  final double price;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: textTheme.displayMedium,
          ),
          ReuseableText(price: price)
        ],
      ),
    );
  }
}
