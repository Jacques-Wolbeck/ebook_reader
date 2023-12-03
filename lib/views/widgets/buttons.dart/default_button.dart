import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;
  const DefaultButton(
      {super.key,
      required this.title,
      required this.icon,
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
          minimumSize: Size(MediaQuery.of(context).size.width * .2, 40.0)),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8.0),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
