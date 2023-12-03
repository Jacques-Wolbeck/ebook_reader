import 'package:ebook_reader/routes.dart';
import 'package:ebook_reader/utils/custom/custom_color_scheme.dart';
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
          colorScheme: lightColorScheme,
          textTheme: CustomTextTheme(),
        ),
        onGenerateRoute: (route) => onGenerateRoute(route),
        home: const SplashView());
  }
}
