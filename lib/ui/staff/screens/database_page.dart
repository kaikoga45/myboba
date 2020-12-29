import 'package:flutter/material.dart';
import 'package:myboba/ui/staff/components/stream_collection.dart';

class DatabasePage extends StatelessWidget {
  static const String id = '/database_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DATABASE',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StreamCollection(
                  collection: 'status',
                  title: 'status',
                  color: Color(0xFFF8B195),
                ),
              ),
              Expanded(
                child: StreamCollection(
                  collection: 'category',
                  title: 'category',
                  color: Color(0xFFF67280),
                ),
              ),
              Expanded(
                child: StreamCollection(
                  collection: 'menu',
                  title: 'menu',
                  color: Color(0xFFC06C84),
                ),
              ),
              Expanded(
                  child: StreamCollection(
                collection: 'order',
                title: 'order',
                color: Color(0xFF6C5B7B),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
