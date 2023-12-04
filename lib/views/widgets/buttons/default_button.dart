import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final Widget leading;
  final Function() onPressed;
  const DefaultButton(
      {super.key,
      required this.title,
      required this.leading,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: Size(MediaQuery.of(context).size.width * .3, 40.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          leading,
          const SizedBox(width: 8.0),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
