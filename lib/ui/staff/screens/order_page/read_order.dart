import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/firestore_data_management_helper.dart';

class ReadOrder extends StatelessWidget {
  final _firestore = FirestoreDataManagementHelper.firestore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ORDER TRANSACTION',
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
            stream: _firestore
                .collection('order')
                .where('pickup', isEqualTo: true)
                .where('checkout', isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot _order = snapshot.data.docs[index];
                    return Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        leading: CircleAvatar(
                          radius: 50.0,
                          child: FittedBox(
                            child: Text(
                              '${index + 1}',
                            ),
                          ),
                        ),
                        title: Text(_order['menu_name']),
                        subtitle: Text(
                            '${_order['description']} - Rp ${_order['total_price']}'),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
