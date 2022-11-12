import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firestore/order_firestore_helper.dart';
import 'package:myboba/ui/customer/components/stream_menu_grid_view_builder.dart';
import 'package:myboba/ui/customer/components/stream_menu_list_view_builder.dart';

import '../theme/color_palettes.dart';

class Menu extends StatefulWidget {
  static const String id = '/menu';

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool _isDisplayAllProduct = true;
  int _indexButtonPressed;
  String _categorySelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MENU',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<QuerySnapshot>(
          stream: OrderFirestoreHelper.firestoreApi
              .collection('category')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  children: [
                    Container(
                      height: 37,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot _category =
                                    snapshot.data.docs[index];
                                final String _categoryName = _category['name'];
                                return GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Container(
                                      width: 119,
                                      decoration: BoxDecoration(
                                        color: _isDisplayAllProduct == false &&
                                                _indexButtonPressed == index
                                            ? ColorPalettes.button
                                            : Theme.of(context).primaryColor,
                                        border: Border.all(
                                            color: ColorPalettes.button),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          _categoryName.toUpperCase(),
                                          style: _isDisplayAllProduct ==
                                                      false &&
                                                  _indexButtonPressed == index
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .button
                                              : Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(
                                                    color: Color(0xFF9D521E),
                                                  ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        _isDisplayAllProduct =
                                            !_isDisplayAllProduct;
                                        _indexButtonPressed = index;
                                        _categorySelected = _category['name'];
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _isDisplayAllProduct
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot _category =
                                    snapshot.data.docs[index];
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      StreamMenuListViewBuilder(
                                          field: 'category',
                                          value: _category['name'],
                                          containerHeight:
                                              index != 0 ? 240.0 : 280.0,
                                          title: _category['name'],
                                          imageHeight: index != 0 ? 140 : 182.0,
                                          imageWidth: index != 0 ? 140 : 160.0,
                                          imageBorderRadius:
                                              index != 0 ? 70 : 20),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : StreamMenuGridViewBuilder(
                            field: 'category', value: _categorySelected),
                  ],
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
