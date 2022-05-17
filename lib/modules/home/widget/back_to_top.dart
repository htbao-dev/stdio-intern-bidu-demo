import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/common/strings.dart';
import 'package:flutter/material.dart';

class BackTopTop extends StatelessWidget {
  final VoidCallback onPressed;
  const BackTopTop({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.85)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
          overlayColor: MaterialStateProperty.all<Color>(Colors.grey.shade300)),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_upward_outlined, color: kPrimaryPinkColor),
          Text(Strings.backToTop, style: Theme.of(context).textTheme.bodyText2!)
        ],
      ),
      // style: ,
    );
  }
}
