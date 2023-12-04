import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: 'Ebook',
              style: Theme.of(context).textTheme.headlineSmall!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Reader',
                  style: Theme.of(context).textTheme.headlineSmall!.merge(
                        TextStyle(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
