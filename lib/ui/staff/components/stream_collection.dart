import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamCollection extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  final String _collection;
  final String _title;
  final Color _color;

  StreamCollection({String collection, String title, Color color})
      : _collection = collection,
        _title = title,
        _color = color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                _firestore.collection(_collection.toLowerCase()).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Text(
                  '${snapshot.data.docs.length} Total',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black38),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
