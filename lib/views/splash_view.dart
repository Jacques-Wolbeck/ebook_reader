import 'package:ebook_reader/shared/database/database_controller.dart';
import 'package:ebook_reader/views/widgets/app_progress_indicator.dart';
import 'package:ebook_reader/views/widgets/app_title.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    /*DatabaseController.dbInstance.database
        .then((_) => Navigator.pushReplacementNamed(context, '/home_view'));*/
    Future.delayed(const Duration(seconds: 2))
        .then((_) => Navigator.pushReplacementNamed(context, '/home_view'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTitle(),
            SizedBox(width: 16.0),
            AppProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
