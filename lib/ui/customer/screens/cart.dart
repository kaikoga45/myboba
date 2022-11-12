import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase_authentication/authentication.dart';
import 'package:myboba/services/firestore/order_firestore_helper.dart';
import 'package:myboba/ui/customer/theme/color_palettes.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _firestoreApi = OrderFirestoreHelper.firestoreApi;
  final _firestoreHelper = OrderFirestoreHelper();
  final _authHelper = AuthHelper.instance;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MY CART',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Color(0xFF621C0D),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestoreApi
              .collection('order')
              .where('customer_id', isEqualTo: _authHelper.getUserID())
              .where('checkout', isEqualTo: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              int _totalPriceInCart = 0;
              snapshot.data.docs.forEach((element) {
                _totalPriceInCart += element['total_price'];
              });
              num _totalPriceAfterTax = _totalPriceInCart * 0.05;
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot _cart =
                                  snapshot.data.docs[index];
                              return Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Container(
                                              child: ClipRRect(
                                                child: FadeInImage.assetNetwork(
                                                  fit: BoxFit.cover,
                                                  height: 80,
                                                  width: 80,
                                                  fadeInCurve: Curves.bounceIn,
                                                  placeholder:
                                                      'assets/img/fade_placeholder.png',
                                                  image: _cart['menuImg'],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(70),
                                              ),
                                              height: 80,
                                              width: 80,
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  _cart['menu_name'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      .copyWith(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                Text(
                                                  _cart['description'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                  maxLines: 10,
                                                ),
                                                Text(
                                                  'Rp ${_cart['total_price']}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorPalettes
                                                            .golderBrown,
                                                      ),
                                                ),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                            width: 210,
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                child: Icon(Icons.close),
                                                onTap: () async {
                                                  bool isError =
                                                      await _firestoreHelper
                                                          .deleteOrderInCart(
                                                              docId: _cart.id);
                                                  if (isError) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Delete order has been failed!'),
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Delete order has been completed!'),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                              SizedBox(height: 70),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3, right: 3),
                                                  child: Text(
                                                    '${_cart['quantity']}x',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(
                                                            color: Color(
                                                                0xFF621C0D)),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFEDE2CF),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: ColorPalettes.button,
                                    height: 0.5,
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Order'),
                                    Text(
                                      'Rp $_totalPriceInCart',
                                      style:
                                          TextStyle(color: Color(0xFF9D521E)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Tax'),
                                    Text('5%',
                                        style: TextStyle(
                                            color: Color(0xFF9D521E))),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total'),
                                    Text(
                                        'Rp ${_totalPriceAfterTax.toInt() + _totalPriceInCart}',
                                        style: TextStyle(
                                            color: Color(0xFF9D521E))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    _totalPriceInCart != 0
                        ? Expanded(
                            flex: 0,
                            child: Container(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'PROCESS TO CHECKOUT',
                                  style: Theme.of(context).textTheme.button,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = !_isLoading;
                                  });
                                  bool isError =
                                      await _firestoreHelper.setCheckout();
                                  if (isError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Checkout Failed! Please try again'),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Checkout Completed! See the receipt in receipt order menu'),
                                      ),
                                    );
                                  }
                                  setState(() {
                                    _isLoading = !_isLoading;
                                  });
                                },
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
