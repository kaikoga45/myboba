import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const String id = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SETTINGS',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: Colors.pinkAccent,
                  height: 100,
                ),
              ),
              Expanded(
                flex: 0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {},
                  child: Text(
                    'LOGOUT',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
