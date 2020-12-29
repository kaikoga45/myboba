import 'package:flutter/material.dart';
import 'package:myboba/ui/customer/components/stream_menu_grid_view_builder.dart';

class DisplayAllMenu extends StatelessWidget {
  static const String id = '/see_all_menu';

  final String _title;
  final String _description;
  final String _field;
  final String _value;

  DisplayAllMenu({String title, String description, String field, String value})
      : _title = title,
        _description = description,
        _field = field,
        _value = value;

  @override
  Widget build(BuildContext context) {
    final DisplayAllMenu _data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _data._title.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          children: [
            _data._description != null
                ? Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      _data._description.toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Padding(padding: EdgeInsets.all(20)),
            StreamMenuGridViewBuilder(
              field: _data._field,
              value: _data._value,
            ),
          ],
        ),
      ),
    );
  }
}
