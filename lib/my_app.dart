import 'package:ebook_reader/utils/custom/custom_text_theme.dart';
import 'package:ebook_reader/views/splash_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ebook Reader',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          textTheme: CustomTextTheme(),
        ),
        home: const SplashView());
  }
}
