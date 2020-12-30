import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firebase/order_firestore_helper.dart';
import 'package:myboba/ui/customer/components/order_tool.dart';
import 'package:myboba/ui/customer/components/customization_dropdown_button.dart';
import 'package:myboba/ui/customer/components/rounded_text_box.dart';
import 'package:myboba/ui/customer/components/topping_list.dart';
import 'package:myboba/utils/customer/order_helper.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Order extends StatefulWidget {
  static const String id = '/ordering';

  final DocumentSnapshot _menu;
  final String _title;

  Order({DocumentSnapshot menu, String title})
      : _menu = menu,
        _title = title;

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final _firestoreHelper = OrderFirestoreHelper.instance;
  bool _isLoading = false;

  //Customization
  String _size = 'Small';
  String _iceAmount = 'Little';
  String _sugarAmount = 'Little';

  int _totalPriceSize = 0;
  int _totalPriceIce = 0;
  int _totalPriceSugar = 0;

  //Topping
  int _grassJelly = 0;
  int _redBean = 0;
  int _rainbowJelly = 0;
  int _mousse = 0;
  int _pearl = 0;
  int _aloeVera = 0;

  int _totalPriceTopping = 0;

  @override
  Widget build(BuildContext context) {
    final Order data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF1F0EC),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Color(0xFF621C0D),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          data._title.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFF1F0EC),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
              top: 80,
              left: 100,
              child: Container(
                child: ClipRRect(
                  child: Hero(
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      height: 190,
                      width: 190,
                      fadeInCurve: Curves.bounceIn,
                      placeholder: 'assets/img/fade_placeholder.png',
                      image: data._menu['img'],
                    ),
                    tag: data._menu.id,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 190,
                width: 190,
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                maxChildSize: 1.0,
                minChildSize: 0.5,
                builder: (context, controller) {
                  return Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: ListView(
                      controller: controller,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFf9D521E),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          data._menu['name'],
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(data._menu['description'],
                              style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Rp ${data._menu['price'] + (_totalPriceTopping + _totalPriceIce + _totalPriceSize + _totalPriceSugar)}',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Divider(color: Color(0xFFC99543)),
                        SizedBox(height: 10),
                        RoundedTextBox(title: 'Customization'),
                        CustomizationDropdownButton(
                          title: 'Size',
                          value: _size,
                          items: <String>['Small', 'Medium', 'Large']
                              .map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(
                              () {
                                if (value == 'Small') {
                                  _totalPriceSize = 0;
                                } else if (value == 'Medium') {
                                  _totalPriceSize = 3000;
                                } else {
                                  _totalPriceSize = 5000;
                                }
                                _size = value;
                              },
                            );
                          },
                        ),
                        CustomizationDropdownButton(
                          title: 'Sugar Amount',
                          value: _sugarAmount,
                          items: <String>['Little', 'Medium', 'Large']
                              .map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(
                              () {
                                if (value == 'Little') {
                                  _totalPriceSugar = 0;
                                } else if (value == 'Medium') {
                                  _totalPriceSugar = 3000;
                                } else {
                                  _totalPriceSugar = 5000;
                                }
                                _sugarAmount = value;
                              },
                            );
                          },
                        ),
                        CustomizationDropdownButton(
                          title: 'Ice Amount',
                          value: _iceAmount,
                          items: <String>['Little', 'Medium', 'Large']
                              .map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(
                              () {
                                if (value == 'Little') {
                                  _totalPriceIce = 0;
                                } else if (value == 'Medium') {
                                  _totalPriceIce = 3000;
                                } else {
                                  _totalPriceIce = 5000;
                                }
                                _iceAmount = value;
                              },
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        RoundedTextBox(title: 'Topping'),
                        SizedBox(height: 20),
                        ToppingList(
                          title: 'Grass Jelly',
                          value: _grassJelly,
                          onTapMinus: () {
                            setState(() {
                              if (_grassJelly != 0 && _totalPriceTopping != 0) {
                                _totalPriceTopping -= 3000;
                                _grassJelly--;
                              }
                            });
                          },
                          onTapPlus: () {
                            setState(() {
                              _grassJelly++;
                              _totalPriceTopping += 3000;
                            });
                          },
                        ),
                        ToppingList(
                          title: 'Red Bean',
                          value: _redBean,
                          onTapMinus: () {
                            setState(() {
                              if (_redBean != 0 && _totalPriceTopping != 0) {
                                _totalPriceTopping -= 3000;
                                _redBean--;
                              }
                            });
                          },
                          onTapPlus: () {
                            setState(() {
                              _redBean++;
                              _totalPriceTopping += 3000;
                            });
                          },
                        ),
                        ToppingList(
                          title: 'Rainbow Jelly',
                          value: _rainbowJelly,
                          onTapMinus: () {
                            setState(() {
                              if (_rainbowJelly != 0 &&
                                  _totalPriceTopping != 0) {
                                _totalPriceTopping -= 3000;
                                _rainbowJelly--;
                              }
                            });
                          },
                          onTapPlus: () {
                            setState(() {
                              _rainbowJelly++;
                              _totalPriceTopping += 3000;
                            });
                          },
                        ),
                        ToppingList(
                          title: 'Mousse',
                          value: _mousse,
                          onTapMinus: () {
                            setState(() {
                              if (_mousse != 0 && _totalPriceTopping != 0) {
                                _totalPriceTopping -= 3000;

                                _mousse--;
                              }
                            });
                          },
                          onTapPlus: () {
                            setState(() {
                              _mousse++;
                              _totalPriceTopping += 3000;
                            });
                          },
                        ),
                        ToppingList(
                          title: 'Pearl',
                          value: _pearl,
                          onTapMinus: () {
                            setState(() {
                              if (_pearl != 0 && _totalPriceTopping != 0) {
                                _totalPriceTopping -= 3000;

                                _pearl--;
                              }
                            });
                          },
                          onTapPlus: () {
                            setState(() {
                              _pearl++;
                              _totalPriceTopping += 3000;
                            });
                          },
                        ),
                        ToppingList(
                          title: 'Aloe Vera',
                          value: _aloeVera,
                          onTapMinus: () {
                            setState(() {
                              if (_aloeVera != 0 && _totalPriceTopping != 0) {
                                _aloeVera--;
                                _totalPriceTopping -= 3000;
                              }
                            });
                          },
                          onTapPlus: () {
                            setState(() {
                              _aloeVera++;
                              _totalPriceTopping += 3000;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            OrderTool(
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).buttonColor,
                onPressed: () async {
                  setState(() {
                    _isLoading = !_isLoading;
                  });

                  bool _isError;
                  QuerySnapshot _orderSnapshot;

                  String _description = OrderHelper.createDescription(
                    size: _size,
                    iceAmount: _iceAmount,
                    sugarAmount: _sugarAmount,
                    grassJelly: _grassJelly,
                    redBean: _redBean,
                    rainbowJelly: _rainbowJelly,
                    mousse: _mousse,
                    pearl: _pearl,
                    aloeVera: _aloeVera,
                  );

                  int _newTotalPrice = OrderHelper.calculateTotalPrice(
                    menu: data._menu['price'],
                    size: _totalPriceSize,
                    ice: _totalPriceIce,
                    sugar: _totalPriceSugar,
                    topping: _totalPriceTopping,
                  );

                  _orderSnapshot =
                      await _firestoreHelper.getExistingOrderInCart(
                          menuId: data._menu.id, description: _description);

                  if (_orderSnapshot != null) {
                    DocumentSnapshot _orderDoc = _orderSnapshot.docs[0];
                    _isError = await _firestoreHelper.updateOrderInCart(
                        docId: _orderDoc.id,
                        currentQuantity: _orderDoc['quantity'],
                        currentTotalPrice: _orderDoc['total_price'],
                        newTotalPrice: _newTotalPrice);
                  } else {
                    _isError = await _firestoreHelper.createNewOrderInCart(
                      menuId: data._menu.id,
                      menuName: data._menu['name'],
                      menuImg: data._menu['img'],
                      description: _description,
                      totalPrice: _newTotalPrice,
                    );
                  }

                  setState(() {
                    _isLoading = !_isLoading;
                  });

                  _isError
                      ? Navigator.pop(context)
                      : _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                                'Order has been successfully added to cart!'),
                          ),
                        );
                },
                label: _isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.5),
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        'ADD ITEM',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
