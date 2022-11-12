import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myboba/services/firestore/order_firestore_helper.dart';
import 'package:myboba/ui/customer/screens/display_all_menu.dart';
import 'package:myboba/ui/customer/screens/order.dart';
import 'package:myboba/ui/customer/theme/color_palettes.dart';

class StreamMenuListViewBuilder extends StatelessWidget {
  final String _value;
  final String _description;
  final String _field;
  final double _containerHeight;
  final double _imageHeight;
  final double _imageWidth;
  final String _title;
  final double _imageBorderRadius;

  StreamMenuListViewBuilder(
      {@required double containerHeight,
      @required String title,
      String description,
      @required String value,
      @required String field,
      @required double imageHeight,
      @required double imageWidth,
      @required double imageBorderRadius})
      : _containerHeight = containerHeight,
        _title = title,
        _description = description,
        _value = value,
        _field = field,
        _imageHeight = imageHeight,
        _imageWidth = imageWidth,
        _imageBorderRadius = imageBorderRadius;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: OrderFirestoreHelper.firestoreApi
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
            return Container(
              height: _containerHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    ColorPalettes.golderBrown.withOpacity(0.2),
                              ),
                            ),
                            Positioned(
                              left: 9,
                              bottom: 1,
                              child: Text(
                                _title,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DisplayAllMenu.id,
                            arguments: DisplayAllMenu(
                              title: _title,
                              description: _description,
                              field: _field,
                              value: _value,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              'See All ${snapshot.data.docs.length}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 19.0,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Flexible(
                    fit: FlexFit.loose,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot _menu = snapshot.data.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: GestureDetector(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      child: Hero(
                                        child: FadeInImage.assetNetwork(
                                          fit: BoxFit.cover,
                                          height: _imageHeight,
                                          width: _imageWidth,
                                          fadeInCurve: Curves.bounceIn,
                                          placeholder:
                                              'assets/img/fade_placeholder.png',
                                          image: _menu['img'],
                                        ),
                                        tag: '${_menu.id}',
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _imageBorderRadius),
                                    ),
                                    height: _imageHeight,
                                    width: _imageWidth,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _menu['name'],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Order.id,
                                arguments: Order(
                                  menu: _menu,
                                  title: _title,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(color: Color(0xFFC99543).withOpacity(0.2)),
                ],
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
