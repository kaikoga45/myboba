import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/authentication.dart';
import 'package:myboba/services/firebase/firestore_helper.dart';
import 'package:myboba/ui/customer/screens/cart.dart';

class OrderTool extends StatelessWidget {
  final _authHelper = AuthHelper.instance;
  final Widget _floatingActionButton;

  OrderTool({Widget floatingActionButton})
      : _floatingActionButton = floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper.firestore
          .collection('order')
          .where('customer_id', isEqualTo: _authHelper.customerId)
          .where('checkout', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          int _totalOrderInCart = snapshot.data.docs.length;
          int _totalPriceInCart = 0;
          snapshot.data.docs.forEach((element) {
            _totalPriceInCart += element['total_price'];
          });
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment(0.79, 0.74),
                  child: _floatingActionButton != null
                      ? Container(
                          padding: EdgeInsets.only(
                              bottom: snapshot.data.docs.isEmpty ? 20 : 0),
                          child: _floatingActionButton)
                      : Container(),
                ),
                snapshot.data.docs.isEmpty
                    ? Container()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            width: 330,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Color(0xFF621C0D),
                                      size: 30,
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(
                                                color: Color(0xFF621C0D),
                                              ),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            '$_totalOrderInCart Qty - Rp $_totalPriceInCart',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                .copyWith(
                                                  color: Color(0xFF621C0D),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    width: 150,
                                  ),
                                  Spacer(),
                                  VerticalDivider(
                                    color: Theme.of(context).buttonColor,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: 91,
                                      height: 29,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).buttonColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'CHECKOUT',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Cart(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          );
        }
      },
    );
  }
}
