import 'package:flutter/material.dart';
import 'package:myboba/ui/customer/theme/main_theme.dart';

class ErrorAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF2a76c9),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img/error_illustration.png'),
              Text(
                'Ooops...Something Went Wrong! Please contact the developer about this issue.',
                style:
                    themeData.textTheme.headline6.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
