import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/firestore.dart';
import 'package:myboba/ui/components/stream_menu_list_view_builder.dart';
import 'package:myboba/utils/time.dart';

class HomePage extends StatelessWidget {
  static const String id = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MYBOBA',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            children: [
              Container(
                height: 24,
                width: 136,
                child: Text(
                  Time.getGreetingMessages(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFE4DFD7),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ],
          ),
          SizedBox(width: 20),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreHelper.firestore
              .collection('status')
              .orderBy('time_added', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot _status = snapshot.data.docs[index];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        StreamMenuListViewBuilder(
                            field: 'status',
                            value: _status['name'],
                            description: _status['description'],
                            containerHeight: index != 0 ? 240.0 : 280.0,
                            title: _status['name'],
                            imageHeight: index != 0 ? 140 : 182.0,
                            imageWidth: index != 0 ? 140 : 160.0,
                            imageBorderRadius: index != 0 ? 70 : 20),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      /*
        INFORMATION!
        The FAB is for experiment only to add a menu data in firestore.
       */
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     FirestoreHelper.firestore.collection('menu').add({
      //       'name': 'Milkshake',
      //       'description': 'Combination milk with tea',
      //       'price': 20000,
      //       'status': '',
      //       'category': 'fruit',
      //       'img':
      //           'https://images.unsplash.com/photo-1551782450-40537687757d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1534&q=80'
      //     });
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
