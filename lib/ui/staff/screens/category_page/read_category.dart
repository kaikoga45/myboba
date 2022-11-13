import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firestore/firestore_data_management_helper.dart';
import 'package:myboba/ui/staff/screens/category_page/create_update_category.dart';

class ReadCategory extends StatelessWidget {
  final _firestoreApi = FirestoreDataManagementHelper.firestoreApi;
  final _staffFirestoreHelper = FirestoreDataManagementHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CATEGORY',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestoreApi.collection('category').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot _category = snapshot.data!.docs[index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateUpdateCategory(categoryDoc: _category),
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
                        title: Text(_category['name']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            bool _isError;
                            _isError =
                                await _staffFirestoreHelper.deleteCategory(
                                    docId: _category.id,
                                    category: _category['name']);
                            _isError
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Failed to delete!')))
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Delete completed!')));
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
              MaterialPageRoute(builder: (context) => CreateUpdateCategory()));
        },
      ),
    );
  }
}
