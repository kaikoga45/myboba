import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/staff_firestore_helper.dart';
import 'package:myboba/ui/staff/screens/menu_page/create_update_menu.dart';

class ReadMenu extends StatelessWidget {
  final _firestore = StaffFirestoreHelper.firestore;
  final _staffFirestoreHelper = StaffFirestoreHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MENU',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('menu').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot _menu = snapshot.data.docs[index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateUpdateMenu(menuDoc: _menu),
                            ),
                          );
                        },
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        leading: CircleAvatar(
                          radius: 50.0,
                          child: FittedBox(
                            child: Text(
                              '${index + 1}',
                            ),
                          ),
                        ),
                        title: Text(_menu['name']),
                        subtitle: Text(
                            '${_menu['description']} - Rp ${_menu['price']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            bool _isError;
                            _isError = await _staffFirestoreHelper.deleteMenu(
                                docId: _menu.id);
                            _isError
                                ? Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Failed to delete!')))
                                : Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Data has been complete delete!')));
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateUpdateMenu()));
        },
      ),
    );
  }
}
