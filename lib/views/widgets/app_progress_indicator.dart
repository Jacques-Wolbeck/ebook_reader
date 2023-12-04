import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.0,
      width: 25.0,
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).colorScheme.primary,
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
