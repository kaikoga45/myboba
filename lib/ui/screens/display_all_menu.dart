import 'package:flutter/material.dart';
import 'package:myboba/ui/components/stream_menu_grid_view_builder.dart';
import 'package:myboba/utils/list_of_string.dart';

class DisplayAllMenu extends StatelessWidget {
  static const String id = '/see_all_menu';

  final String _title;
  final String _field;
  final String _value;

  DisplayAllMenu({String title, String field, String value})
      : _title = title,
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
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                shortCommentAboutMenu[_data._value.toLowerCase()].toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
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
