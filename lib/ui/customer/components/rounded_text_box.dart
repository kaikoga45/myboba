import 'package:flutter/material.dart';

class RoundedTextBox extends StatelessWidget {
  final String _title;

  RoundedTextBox({@required String title}) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: Container(
        height: 28,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            color: Color(0xFFEDE2CF)),
        child: Center(
          child: Text(
            _title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}
