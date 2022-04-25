import 'package:flutter/material.dart';

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({Key? key}) : super(key: key);

  final String deliveryInfoText = 'Thông tin giao hàng';
  final String deliveryTimeText = 'Thời gian vận chuyển';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                deliveryInfoText,
                style: const TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                deliveryTimeText,
                // style: TextStyle(fontSize: 12),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
