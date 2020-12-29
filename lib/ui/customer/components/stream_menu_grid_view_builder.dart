import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/firestore_helper.dart';
import 'package:myboba/ui/customer/screens/order.dart';

class StreamMenuGridViewBuilder extends StatelessWidget {
  final String _field;
  final String _value;

  StreamMenuGridViewBuilder({@required String field, @required String value})
      : _field = field,
        _value = value;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _value == null || _field == null
          ? FirestoreHelper.firestore.collection('menu').snapshots()
          : FirestoreHelper.firestore
              .collection('menu')
              .where(_field, isEqualTo: _value)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data.docs.isEmpty) {
            return Container();
          } else {
            return Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: 30.0),
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.9),
                itemBuilder: (context, index) {
                  final DocumentSnapshot _menus = snapshot.data.docs[index];
                  return GestureDetector(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: ClipRRect(
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                height: 140,
                                width: 140,
                                fadeInCurve: Curves.bounceIn,
                                placeholder: 'assets/img/fade_placeholder.png',
                                image: _menus['img'],
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            height: 140,
                            width: 140,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _menus['name'],
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(color: Color(0xFF026242)),
                          ),
                          Text(
                            'Rp ${_menus['price']}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Order.id,
                        arguments: Order(
                          menu: _menus,
                          title: _menus['category'],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
